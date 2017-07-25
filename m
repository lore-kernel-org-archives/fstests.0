Received: from cn.fujitsu.com ([59.151.112.132]:17058 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751554AbdGYHoF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2017 03:44:05 -0400
Message-ID: <5976F6BF.1040401@cn.fujitsu.com>
Date: Tue, 25 Jul 2017 15:43:59 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/446: make sure all background processes are dead
 before umount
References: <20170724101125.13309-1-eguan@redhat.com> <5976A150.1090904@cn.fujitsu.com> <20170725063107.GL9167@eguan.usersys.redhat.com>
In-Reply-To: <20170725063107.GL9167@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/07/25 14:31, Eryu Guan wrote:
> On Tue, Jul 25, 2017 at 09:39:28AM +0800, Xiao Yang wrote:
>> On 2017/07/24 18:11, Eryu Guan wrote:
>>> The $dread_pid refers to the while-true-do loop, wait for $dread_pid
>>> doesn't mean the xfs_io direct read process is already dead,
>>> sometimes xfs_io process is still running and blocking
>>> _scratch_unmount.
>> Hi Eryu,
>>
>> Could you tell me what can i do to trigger this block?
> I don't have a reliable reproducer, I hit this in my automated tests,
> perhaps easier to hit with slow disks. You can try replace the fpunch
> operation with a pwrite, I can hit the block much easier this way.
Hi Eryu,

Thanks for your explanation.  I can hit this block easily when replacing 
the fpunch
operation with a pwrite.
>>> Fix it by making the direct read does a fixed number of loop and
>>> break out the second mmap-fpunch loop if the first loop exits. At
>> Does it break out the second mmap-fpunch loop if the first loop doesn't
>> exit?
> The second mmap-fpunch loop won't break until it finds the first loop
> exits.
got it. :-)
>>> this point we're sure that there's no unfinished background process
>>> blocking the umount.
>> The others look fine.
> Thanks!
>
> Eryu
>
>> Thanks,
>> Xiao Yang.
>>> Signed-off-by: Eryu Guan<eguan@redhat.com>
>>> ---
>>>   tests/generic/446 | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/generic/446 b/tests/generic/446
>>> index 62ae449de6b1..83ff4ac9edd3 100755
>>> --- a/tests/generic/446
>>> +++ b/tests/generic/446
>>> @@ -61,20 +61,22 @@ filesz=$((65536 * 2))
>>>   $XFS_IO_PROG -f -c "truncate $((filesz * 2))" $SCRATCH_MNT/file>>  $seqres.full
>>>
>>>   # run a background dio read to a hole in a loop
>>> -while true; do
>>> +for i in `seq 0 999`; do
>>>   	$XFS_IO_PROG -d -c "pread 0 $filesz" $SCRATCH_MNT/file>  /dev/null 2>&1
>>>   done&
>>>
>>>   dread_pid=$!
>>>
>>>   # run mapped write to the same hole as dio read
>>> -for i in `seq 0 999`; do
>>> +while true; do
>>>   	$XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" $SCRATCH_MNT/file \
>>>   		>  /dev/null
>>>   	$XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file>  /dev/null
>>> +	if ! kill -s 0 $dread_pid>/dev/null 2>&1; then
>>> +		break
>>> +	fi
>>>   done
Could we simplify this break, as below:
while kill -s 0 $dread_pid >/dev/null 2>&1; do
     $XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" 
$SCRATCH_MNT/file \
 > /dev/null
     $XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file > /dev/null
done

Thanks,
Xiao Yang.
>>>
>>> -kill -9 $dread_pid>  /dev/null 2>&1
>>>   wait $dread_pid>  /dev/null 2>&1
>>>
>>>   echo "Silence is golden"
>>
>>
>
> .
>



