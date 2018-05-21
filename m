Received: from mail-pl0-f68.google.com ([209.85.160.68]:44581 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbeEUXzG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 May 2018 19:55:06 -0400
MIME-Version: 1.0
In-Reply-To: <2039299000.2955896.1526892639579.JavaMail.zimbra@redhat.com>
References: <1526641829-9893-1-git-send-email-xifeng@redhat.com>
 <20180521075027.GL29080@desktop.hz.ali.com> <2039299000.2955896.1526892639579.JavaMail.zimbra@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 21 May 2018 18:54:45 -0500
Message-ID: <CAH2r5mt3f61eYobvEF6pwaJ0eNCiuXuNMfRq3_wi2=O=31Y1Qg@mail.gmail.com>
Subject: Re: [PATCH] common/rc: add the function _require_noatime
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Xiaoli Feng <xifeng@redhat.com>
Cc: Eryu Guan <guaneryu@gmail.com>, CIFS <linux-cifs@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Should this be fixed by changing cifs.ko to accept the mount parm but ignor=
e it?

If this test works on NFS (the noatime mount option has no meaning for
NFS apparently) we should do the same

Quoting the NFS man page:

       In particular, the atime/noatime, diratime/nodiratime, relatime/nore=
la=E2=80=90
       time, and strictatime/nostrictatime mount options have no effect on =
NFS
       mounts.

On Mon, May 21, 2018 at 3:50 AM, Xiaoli Feng <xifeng@redhat.com> wrote:
>
> [add linux-cifs@vger.kernel.org to cc list]
>
> ----- Forwarded Message -----
> From: "Eryu Guan" <guaneryu@gmail.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org
> Sent: Monday, May 21, 2018 3:50:27 PM
> Subject: Re: [PATCH] common/rc: add the function _require_noatime
>
> [add linux-cifs@vger.kernel.org to cc list]
>
> On Fri, May 18, 2018 at 07:10:29PM +0800, Xiaoli Feng wrote:
>> From: xiaoli feng <xifeng@redhat.com>
>>
>> In the generic/120, it will make the test not-pass if the filesystem
>> mounts failed with noatime. Now change this result to norun. The
>> filesystem cifs doesn't support noatime. Just make the test norun
>> until it supports noatime.
>>
>> Signed-off-by: xiaoli feng <xifeng@redhat.com>
>> ---
>>  common/rc         | 8 +++++++-
>>  tests/generic/120 | 7 +------
>>  2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index ffe5323..9c45f1b 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3244,7 +3244,13 @@ _require_atime()
>>       _exclude_scratch_mount_option "noatime"
>>       if [ "$FSTYP" =3D=3D "nfs" ]; then
>>               _notrun "atime related mount options have no effect on NFS=
"
>> -     fi
>
> I'm not sure what's the expected behavior from CIFS on atime/noatime, so
> I added linux-cifs list for input.
>
> If CIFS behaves similarly to NFS, looks like that you could simply add
> another check for cifs in _require_atime(), as what we already do for
> nfs, so all tests that _require_atime() will _notrun on cifs.
>
>> +}
>> +
>> +_require_noatime()
>> +{
>> +     _exclude_scratch_mount_option "atime"
>> +      _try_scratch_mount -o noatime || \
>> +                _notrun "noatime not supported by the current tested fi=
lesystem"
>>  }
>>
>>  _require_relatime()
>> diff --git a/tests/generic/120 b/tests/generic/120
>> index 1180c10..ddd61b3 100755
>> --- a/tests/generic/120
>> +++ b/tests/generic/120
>> @@ -60,12 +60,7 @@ _compare_access_times()
>>
>>  }
>>
>> -if ! _try_scratch_mount "-o noatime" >$tmp.out 2>&1
>> -then
>> -    cat $tmp.out
>> -    echo "!!! mount failed"
>> -    exit
>> -fi
>> +_require_noatime
>
> Anyway, failing the test when "noatime" mount fails is one of the
> purposes of the test, and it shouldn't be removed, as we've already made
> sure current FSTYP supports atime/noatime (by _require rules), so a
> noatime mount failure indicates a bug in the filesystem.
>
> Thanks,
> Eryu
>
>>
>>  #executable file
>>  echo "*** copying file ***"
>> --
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Thanks,

Steve
