Received: from cn.fujitsu.com ([59.151.112.132]:36164 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751666AbcBVKIo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Feb 2016 05:08:44 -0500
Message-ID: <56CADE23.1070702@cn.fujitsu.com>
Date: Mon, 22 Feb 2016 18:08:35 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/135: fix standard error output from _scratch_mkfs
References: <1578053095.20705983.1456134019296.JavaMail.zimbra@redhat.com>
In-Reply-To: <1578053095.20705983.1456134019296.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

=E4=BA=8E 2016/02/22 17:40, Zirong Lang =E5=86=99=E9=81=93:
> 2016=E5=B9=B42=E6=9C=8822=E6=97=A5 14:12=EF=BC=8C"Xiao Yang"<yangx.jy@c=
n.fujitsu.com>=E5=86=99=E9=81=93=EF=BC=9A
>>
>>> 2016=E5=B9=B42=E6=9C=8822=E6=97=A5 11:41=EF=BC=8C"Xiao Yang"<yangx.jy=
@cn.fujitsu.com>  =E5=86=99=E9=81=93=EF=BC=9A
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>> ---
>>>>   tests/generic/135 |    2 +-
>>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/tests/generic/135 b/tests/generic/135
>>>> index 52418f6..5aa880d 100755
>>>> --- a/tests/generic/135
>>>> +++ b/tests/generic/135
>>>> @@ -41,7 +41,7 @@ _supported_os Linux IRIX
>>>>
>>>>   _require_odirect
>>>>   _require_scratch
>>>> -_scratch_mkfs>/dev/null
>>>> +_scratch_mkfs&>/dev/null
>>> Hi,
>>>
>>> Although I'm not the offical reviewer, but I think that stderr output=
 can help us to find mkfs failure from golden image diff. So keep the std=
err output maybe better.
>>>
>>> If you think your patch is necessary, you'd better give a appropriate=
 reason to explain why we need to ignore that stderr output?
>>>
>>> Thanks,
>>> Zorro
>> mkfs succees with unexpected message when running generic/135, i.e.
>> [root@localhost ~]# mkfs.ext4 /dev/sdb1>/dev/null
>> mke2fs 1.42.9 (28-Dec-2013)
> Hi xiao,
>
> Now I understand what you mean, and I can reproduce that problem. This
> is a regression bug which bring in by commit:
>
> 4a5cda8 xfstests: do not unmount tmpfs during remount
>
> That patch remove "2>&1". I think that is a miss, so you can simply bri=
ng
> that back. After you explain the reason in your commit message clearly,=
 I
> think maintainer will glad to check it:)
>
> Thanks,
> Zorro
>
thanks for your suggestion, I will expalin the reason in my commit=20
message clearly.
thanks,
xiao yang
>> thanks,
>> xiao yang
>>
>>>>   _scratch_mount
>>>>
>>>>   cd $SCRATCH_MNT
>>>> --
>>>> 1.7.1
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe fstests" i=
n
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> .
>



