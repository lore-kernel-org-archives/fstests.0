Received: from mx1.redhat.com ([209.132.183.28]:41724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbbHRWdH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 18:33:07 -0400
Message-ID: <55D3B2A1.2020307@redhat.com>
Date: Tue, 18 Aug 2015 17:33:05 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
References: <1439918511-2859-1-git-send-email-zlang@redhat.com> <20150818222832.GF3902@dastard>
In-Reply-To: <20150818222832.GF3902@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/18/15 5:28 PM, Dave Chinner wrote:
> On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
>> The below command in "Test 4":
>>
>>     xfs_io -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512"
>>
>> will run failed on 4k sector drives. So I use min_alignment size
>> to replace the hard-code 512.
>>
>> Also I make sure the blksize won't less than min_alignment size,
>> after blksize=`expr $pgsize / 8`.
>>
>> If blksize really less than min_alignment size, I set blksize =
>> min_alignment size, and for sure the consistency of test result,
>> I repair pgsize(already not real page size) number according to
>> the new blksize.
>>
>> Because IRIX can't use _min_dio_alignment(), so remove it from
>> supported os list.
> 
> Not true - that's what the 'feature -s' branch in
> _min_dio_alignment() is supposed to be for. Just add another check
> for "$HOSTOS" == "Linux"....
> 
> 
>> At last, make the crc flag be disabled only when blksize=512.
> 
> That makes things unnecessarily complex. I'd prefer to leave it as
> it is (i.e. with -m crc=0), as CRCs do not affect what is being
> tested at all.
> 
>> Signed-off-by: Zorro Lang <zlang@redhat.com>
>> ---
>>  tests/xfs/194 | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/xfs/194 b/tests/xfs/194
>> index e11b459..4491dd4 100755
>> --- a/tests/xfs/194
>> +++ b/tests/xfs/194
>> @@ -42,7 +42,7 @@ _cleanup()
>>  
>>  # only xfs supported due to use of xfs_bmap
>>  _supported_fs xfs
>> -_supported_os IRIX Linux
>> +_supported_os Linux
>>  
>>  # real QA test starts here
>>  rm -f $seqres.full
>> @@ -50,6 +50,16 @@ rm -f $seqres.full
>>  # For this test we use block size = 1/8 page size
>>  pgsize=`$here/src/feature -s`
>>  blksize=`expr $pgsize / 8`
>> +secsize=`_min_dio_alignment $SCRATCH_DEV`
>> +
>> +# The minimal blksize can't less than sector size, So if
>> +# blksize < secsize, we should adjust blksize and pgsize number.
>> +# Of course, if we adjust pgsize, pgsize won't equal to the
>> +# real page size of system.
>> +if [ $blksize -lt $secsize ];then
>> +        blksize=$secsize
>> +        pgsize=`expr $blksize \* 8`
>> +fi
> 
> No, this is wrong. the page size stays fixed at the machine page
> size. We are testing *sub-page block sizes* here and the sector size
> must be <= page size. Increasing the "page size" to larger than the
> machine page size does not make the kernel use larger page sizes.
> 
> IOWs, if you've got sector size = page size (e.g. 4k sector device)
> then no matter what you say $pgsize is, the kernel will see a block
> size = page size test.
> 
> This whole chunk of code can simply be replaced with:
> 
> blksize=`_min_dio_alignment $SCRATCH_DEV`
> 
> Because that's what we actually need to test...

That won't work either, because we could easily get 512 from that.

and then this test:

# Now try the same thing but write a sector in the middle of that hole
# If things go badly stale data will be exposed either side.
# This is most interesting for block size > 512 (page size > 4096)

# We *should* get:
# |1100|HHHH|33HH|HHHH|2222|----|----|----|

echo "== Test 4 =="
xfs_io \
-c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
-c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
-c "truncate `expr $blksize / 2`" \
-c "truncate `expr $blksize + 1`" \
-c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
-c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
-t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full

will be impossible.

AFAICT everything works except for that explicit 512-byte IO.

All we really need here is a sub-block-size IO, but at least as
large as the logical sector size.

So we want sub-page-size blocks, an sub-block-sized IOS (here).

Can't be *that* tricky to work out the scaling for various pages
and sector sizes, I hope? :)  Famous last words!

-Eric

