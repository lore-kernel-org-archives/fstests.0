Received: from mail-pl0-f67.google.com ([209.85.160.67]:44406 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdL3EGQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Dec 2017 23:06:16 -0500
Subject: Re: [PATCH xfstest v2 3/4] overlay: add fsck.overlay redirect
 directory test
References: <20171228114933.47759-1-yi.zhang@huawei.com>
 <20171228114933.47759-4-yi.zhang@huawei.com>
 <CAOQ4uxiyAj7+UmFMW7eP+HeeZuH6pWxCLKd5WKtc53b77ZihoQ@mail.gmail.com>
From: "zhangyi (F)" <yizhang089@gmail.com>
Message-ID: <d1601184-7272-b607-ee6e-768a33623e42@gmail.com>
Date: Sat, 30 Dec 2017 12:06:13 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiyAj7+UmFMW7eP+HeeZuH6pWxCLKd5WKtc53b77ZihoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>, "zhangyi (F)" <yi.zhang@huawei.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Eryu Guan <eguan@redhat.com>, Miao Xie <miaoxie@huawei.com>, yangerkun@huawei.com
List-ID: <fstests@vger.kernel.org>

On 2017/12/28 20:37, Amir Goldstein Wrote:

>
>> +# Test valid redirect xattr with general directory cover lower origin
>> +# target, should ask user this directory is merged or not by default
>> +# and do nothing in auto mode
>> +echo "+ Valid redirect(4)"
>> +mkdir $lowerdir/origin
>> +mkdir $upperdir/origin
>> +make_redirect_dir $upperdir/testdir "origin"
>> +
>> +_overlay_fsck_dirs $lowerdir $upperdir $workdir -p >> $seqres.full 2>=
&1 || \
>> +       _fail "fsck should not fail"
>> +check_redirect "origin" $upperdir/testdir
>> +$GETFATTR_PROG --absolute-names -d -m $OVL_OPAQUE_XATTR $upperdir/tes=
tdir
>> +
>> +echo "n" > $tmp.input
> This approach seems a bit fragile to me.
> Maybe you will want to add some questions in the future.
> To me it makes better sense to check behavior of fsck -y is automated t=
est,
> because some user who does not understand the questions is surely going
> to run fsck -y to fix problems.
>
>> +_overlay_fsck_dirs $lowerdir $upperdir $workdir <$tmp.input >> $seqre=
s.full 2>&1 || \
>> +       _fail "fsck should not fail"
>> +check_redirect "origin" $upperdir/testdir
>> +check_opaque $upperdir/origin
>> +rm -rf $lowerdir/* $upperdir/*
>> +
Hi Amir=EF=BC=9A

Think about this again. IIUC, I think there is a consistency problem=20
about this case.
If we allow user to create a new directory in upper layer merge with=20
lower redirect origin target when overlay offline, we will see duplicate=20
d_ino in overlay filesystem after next mount, becasue current=20
ovl_getattr() will get the lower d_ino for both merged dir and redirect d=
ir.

eg:
mnt: =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 dira(ino=3Dx)=C2=A0=C2=A0=C2=A0 dir=
b(ino=3Dx)
upper:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *dira(ino=3Dy)=C2=A0=C2=A0 dirb(ino=3D=
z, redirect=3Ddirb)
lower:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dira(ino=3Dx)

*) User remove whiteout or opaque dir and then newly created when=20
overlayfs is offline.

Furthermore, if user rename dira again, will lead to duplicate redirect=20
xattr directly.
So I think we should forbid user do this and check by fsck.overlay. Or=20
handle by overlay filesytem?=C2=A0 thought?

Thanks=EF=BC=8C
Yi.
