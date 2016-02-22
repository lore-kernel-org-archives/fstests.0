Received: from mx4-phx2.redhat.com ([209.132.183.25]:54603 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbcBVJk1 convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Feb 2016 04:40:27 -0500
Date: Mon, 22 Feb 2016 04:40:19 -0500 (EST)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1578053095.20705983.1456134019296.JavaMail.zimbra@redhat.com>
In-Reply-To: <CADVQ27rD6UX7eechDFxke7aE=ty3NJJJKtKGsDR2sCVR5=EP=w@mail.gmail.com>
Subject: Re: [PATCH] generic/135: fix standard error output from
 _scratch_mkfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: yangx.jy@cn.fujitsu.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


2016=E5=B9=B42=E6=9C=8822=E6=97=A5 14:12=EF=BC=8C"Xiao Yang" <yangx.jy@cn=
.fujitsu.com>=E5=86=99=E9=81=93=EF=BC=9A
>
>
>> 2016=E5=B9=B42=E6=9C=8822=E6=97=A5 11:41=EF=BC=8C"Xiao Yang" <yangx.jy=
@cn.fujitsu.com> =E5=86=99=E9=81=93=EF=BC=9A
>> >
>> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> > ---
>> >  tests/generic/135 |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/tests/generic/135 b/tests/generic/135
>> > index 52418f6..5aa880d 100755
>> > --- a/tests/generic/135
>> > +++ b/tests/generic/135
>> > @@ -41,7 +41,7 @@ _supported_os Linux IRIX
>> >
>> >  _require_odirect
>> >  _require_scratch
>> > -_scratch_mkfs >/dev/null
>> > +_scratch_mkfs &>/dev/null
>>
>> Hi,
>>
>> Although I'm not the offical reviewer, but I think that stderr output =
can help us to find mkfs failure from golden image diff. So keep the stde=
rr output maybe better.
>>
>> If you think your patch is necessary, you'd better give a appropriate =
reason to explain why we need to ignore that stderr output?
>>
>> Thanks,
>> Zorro
>
> mkfs succees with unexpected message when running generic/135, i.e.
> [root@localhost ~]# mkfs.ext4 /dev/sdb1 >/dev/null
> mke2fs 1.42.9 (28-Dec-2013)

Hi xiao,

Now I understand what you mean, and I can reproduce that problem. This
is a regression bug which bring in by commit:

4a5cda8 xfstests: do not unmount tmpfs during remount

That patch remove "2>&1". I think that is a miss, so you can simply bring
that back. After you explain the reason in your commit message clearly, I
think maintainer will glad to check it:)

Thanks,
Zorro

>
> thanks,
> xiao yang
>
>> >  _scratch_mount
>> >
>> >  cd $SCRATCH_MNT
>> > --
>> > 1.7.1
>> >
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe fstests" i=
n
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
