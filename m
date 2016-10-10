Subject: Re: [PATCH] generic: make 17[1-4] work well when btrfs compression is
 enabled
References: <20161007070042.12258-1-wangxg.fnst@cn.fujitsu.com>
 <20161007143610.GX27872@dastard> <20161009042333.GA5609@birch.djwong.org>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <57FB0FAF.4080200@cn.fujitsu.com>
Date: Mon, 10 Oct 2016 11:49:03 +0800
MIME-Version: 1.0
In-Reply-To: <20161009042333.GA5609@birch.djwong.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hi,

On 10/10/2016 05:04 AM, Darrick J. Wong wrote:
> On Sat, Oct 08, 2016 at 01:36:10AM +1100, Dave Chinner wrote:
>> On Fri, Oct 07, 2016 at 03:00:42PM +0800, Wang Xiaoguang wrote:
>>> When enabling btrfs compression, original codes can not fill fs
>>> correctly, fix this.
>>>
>>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>>> ---
>>>   tests/generic/171 | 4 +---
>>>   tests/generic/172 | 2 +-
>>>   tests/generic/173 | 4 +---
>>>   tests/generic/174 | 4 +---
>>>   4 files changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tests/generic/171 b/tests/generic/171
>>> index f391685..d2ae8e4 100755
>>> --- a/tests/generic/171
>>> +++ b/tests/generic/171
>>> @@ -75,9 +75,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
>>>   sync
>>>   
>>>   echo "Allocate the rest of the space"
>>> -nr_free=$(stat -f -c '%f' $testdir)
>>> -touch $testdir/file0 $testdir/file1
> Why remove this line which ensures that the inode we're going to use (file1)
> later in the test has been allocated /before/ we try to eat all the space?
Sorry, I don't understand :)
In generic/171, generic/172, generic/173, generic/174, you created file0 and
file1, but I don't see test cases use them and they are empty.

>
>>> -_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
>>> +dd if=/dev/zero of=$testdir/eat_my_space >> $seqres.full 2>&1
> Uh... isn't a bunch of zeroes just as compressible as 0x61?
0x61 is also compressible.
> I suppose
> the point here is to write until write returns ENOSPC, since in btrfs
> land we can't assume that writing $nr blocks will use up at least that
> much space.
Yes.

>
> Does XFS reflink still pass this test with this patch?
Could you please give a stable xfs repotory that supports xfs reflink, 
thanks.

>
>> Please don't replace xfs_io writes using a specific data pattern
>> with dd calls that write zeros. Indeed, we don't use dd for new
>> tests anymore - xfs_io should be used.
>>
>> Write a function that fills all the remaining free space (one may
>> already exist) and call it in all these places.
> Yeah, there already are a few of these...
OK, I'll use it, thanks.

Regards,
Xiaoguang Wang
>
> --D
>
>> Cheers,
>>
>> Dave.
>> -- 
>> Dave Chinner
>> david@fromorbit.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
