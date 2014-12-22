Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:58944 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753552AbaLVCNZ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 21 Dec 2014 21:13:25 -0500
Message-ID: <54977D72.8000604@cn.fujitsu.com>
Date: Mon, 22 Dec 2014 10:09:54 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/111: fix cp of missing file
References: <1419061802-27324-1-git-send-email-gux.fnst@cn.fujitsu.com> <20141221220939.GN15665@dastard>
In-Reply-To: <20141221220939.GN15665@dastard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 12/22/2014 06:09 AM, Dave Chinner wrote:
> On Sat, Dec 20, 2014 at 03:50:02PM +0800, Xing Gu wrote:
>> After installing the test suite, src directory only contains binary
>> programs in the final building directory. Here executing "cp src/itrash.c
>> $SCRATCH_MNT/${I}" will output "cp: cannot stat 'src/itrash.c': No
>> such file or directory" error message. Fix it.
>>
>> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
>> ---
>>   tests/xfs/111 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/xfs/111 b/tests/xfs/111
>> index bedead8..a900184 100755
>> --- a/tests/xfs/111
>> +++ b/tests/xfs/111
>> @@ -53,7 +53,7 @@ echo Create some files
>>   I=0
>>   while [ $I -lt 1000 ]
>>   do
>> -    cp src/itrash.c $SCRATCH_MNT/${I}
>> +    cp src/itrash* $SCRATCH_MNT/${I}
>>       let I=$I+1
>>   done
>>   umount $SCRATCH_DEV
>
> Just use $XFS_IO_PROG to create the files.
>

Got it. Thanks!

regards,
Xing Gu

> Cheers,
>
> Dave.
>
