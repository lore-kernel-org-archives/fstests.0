Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:65112 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753297AbaFYKGR convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 25 Jun 2014 06:06:17 -0400
Message-ID: <53AA9ED5.5080408@cn.fujitsu.com>
Date: Wed, 25 Jun 2014 18:05:09 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfstests: add test for ext4 fallocate collapse range
 check
References: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com> <alpine.LFD.2.00.1406191105220.2182@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1406191105220.2182@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: xfstests-owner@vger.kernel.org
To: =?windows-1252?Q?Luk=E1=9A_Czerner?= <lczerner@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 06/19/2014 05:12 PM, Lukáš Czerner wrote:
> On Thu, 19 Jun 2014, Xing Gu wrote:
>
>> Date: Thu, 19 Jun 2014 13:50:04 +0800
>> From: Xing Gu <gux.fnst@cn.fujitsu.com>
>> To: fstests@vger.kernel.org
>> Cc: Xing Gu <gux.fnst@cn.fujitsu.com>
>> Subject: [PATCH] xfstests: add test for ext4 fallocate collapse range check
>>
>> +
>> +testfile=$SCRATCH_MNT/file.$seq
>> +# fcollapse/truncate continuously and simultaneously
>> +# a same file
>> +for ((i=1; i <= 100; i++))
>> +do
>> +	while true;do
>> +		$XFS_IO_PROG -f -c 'truncate 100k' $testfile 2>> $seqres.full
>> +		$XFS_IO_PROG -f -c 'fcollapse 0 16k' $testfile 2>> $seqres.full
>> +	done &
>> +	PIDS="$PIDS $!"
>> +	while true;do
>> +		$XFS_IO_PROG -f -c 'truncate 0' $testfile 2>> $seqres.full
>> +	done &
>> +	PIDS="$PIDS $!"
>
> It does not look like it's just checking whether we correctly bail
> out if collapse range ends past i_size, but rather it's checking for
> the truncate/collapse range race.
>
> Also in description you're saying that we need to make sure that
> i_size is not going to change, which is not tested here at all.
>
> So I think that you need to split it in two tests:
>
>   - test truncate/collapse range race (what is the failure
>     condition?)
>   - test whether we correctly bail out when collapse range is past
>     i_size and make sure that i_size did not change at all.


Indeed, this case is not ext4 specific, and just checks for the 
truncate/collapse range race.
If this case is needed by xfstests, I will modify the classification and 
description of this case according to your comment.

Thanks for your review!

Regards,
Xing Gu


>
> Thanks!
> -Lukas
>
>> +done
>> +# sleep for 180s, BUG_ON is triggered within 3 minutes
>> +# in most case
>> +sleep 180
>> +
>> +new_bug=`dmesg | grep -c "kernel BUG"`
>> +if [ $new_bug -ne $old_bug ]; then
>> +	echo "kernel bug detected, check dmesg for more infomation."
>> +fi
>> +
>> +kill $PIDS >/dev/null 2>&1
>> +wait
>> +status=0
>> +exit
>> diff --git a/tests/ext4/307.out b/tests/ext4/307.out
>> new file mode 100644
>> index 0000000..260c17c
>> --- /dev/null
>> +++ b/tests/ext4/307.out
>> @@ -0,0 +1 @@
>> +QA output created by 307
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index 7e66035..0f1852f 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -12,3 +12,4 @@
>>   304 aio dangerous ioctl rw stress
>>   305 auto
>>   306 auto rw resize quick
>> +307 auto
>>
> .
>
