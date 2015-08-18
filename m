Received: from sandeen.net ([63.231.237.45]:40804 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbbHRXDq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 19:03:46 -0400
Message-ID: <55D3B9D1.6030609@sandeen.net>
Date: Tue, 18 Aug 2015 18:03:45 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
References: <1439918511-2859-1-git-send-email-zlang@redhat.com> <20150818222832.GF3902@dastard> <55D3B2A1.2020307@redhat.com> <20150818224351.GG3902@dastard>
In-Reply-To: <20150818224351.GG3902@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/18/15 5:43 PM, Dave Chinner wrote:
> On Tue, Aug 18, 2015 at 05:33:05PM -0500, Eric Sandeen wrote:
>> On 8/18/15 5:28 PM, Dave Chinner wrote:
>>> On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
>>>> @@ -50,6 +50,16 @@ rm -f $seqres.full
>>>>  # For this test we use block size = 1/8 page size
>>>>  pgsize=`$here/src/feature -s`
>>>>  blksize=`expr $pgsize / 8`
>>>> +secsize=`_min_dio_alignment $SCRATCH_DEV`
>>>> +
>>>> +# The minimal blksize can't less than sector size, So if
>>>> +# blksize < secsize, we should adjust blksize and pgsize number.
>>>> +# Of course, if we adjust pgsize, pgsize won't equal to the
>>>> +# real page size of system.
>>>> +if [ $blksize -lt $secsize ];then
>>>> +        blksize=$secsize
>>>> +        pgsize=`expr $blksize \* 8`
>>>> +fi
>>>
>>> No, this is wrong. the page size stays fixed at the machine page
>>> size. We are testing *sub-page block sizes* here and the sector size
>>> must be <= page size. Increasing the "page size" to larger than the
>>> machine page size does not make the kernel use larger page sizes.
>>>
>>> IOWs, if you've got sector size = page size (e.g. 4k sector device)
>>> then no matter what you say $pgsize is, the kernel will see a block
>>> size = page size test.
>>>
>>> This whole chunk of code can simply be replaced with:
>>>
>>> blksize=`_min_dio_alignment $SCRATCH_DEV`
>>>
>>> Because that's what we actually need to test...
>>
>> That won't work either, because we could easily get 512 from that.
> 
> If 'blockdev --getss $dev' returns 512, then the device supports 512
> byte IOs and so it is fine to do 512 byte IOs in the test.
> 
>> and then this test:
>>
>> # Now try the same thing but write a sector in the middle of that hole
>> # If things go badly stale data will be exposed either side.
>> # This is most interesting for block size > 512 (page size > 4096)
>>
>> # We *should* get:
>> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
>>
>> echo "== Test 4 =="
>> xfs_io \
>> -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
>> -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
>> -c "truncate `expr $blksize / 2`" \
>> -c "truncate `expr $blksize + 1`" \
>> -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
>> -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
>> -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
>>
>> will be impossible.
>>
>> AFAICT everything works except for that explicit 512-byte IO.
> 
> Right. That hard coded 512 needs to change to $blksize, because
> blksize is now equal to the sector size. I thought this would be
> obvious to the reader, so I didn't comment on it.

if that last IO is $blksize, and blocksize == sector size, then the
test won't be testing what it's designed to test here, i.e. a
sub-block direct IO write.

# We *should* get:
# |1100|HHHH|33HH|HHHH|2222|----|----|----|
             ^^
             this

-Eric

