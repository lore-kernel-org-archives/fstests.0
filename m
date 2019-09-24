Received: from szxga05-in.huawei.com ([45.249.212.191]:2776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436753AbfIXOTt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Sep 2019 10:19:49 -0400
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
 <CAOQ4uxhL_EZZ_ktv8RYpn-q2nDrA2v7kjv+b99a5ZKg3tmEQ8A@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b215554a-092b-fcf3-e0a3-36fab291b4ff@huawei.com>
Date: Tue, 24 Sep 2019 22:19:38 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhL_EZZ_ktv8RYpn-q2nDrA2v7kjv+b99a5ZKg3tmEQ8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>, "zhangyi (F)" <yi.zhang@huawei.com>, fstests <fstests@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

As far as I know, _require_scratch_shutdown() is called after _overay_con=
fig_override(), at this moment, FSTYP equals to base fs. According the im=
plementation of _require_scratch_shutdown:
3090 _require_scratch_shutdown()
3091 {
3092     [ -x src/godown ] || _notrun "src/godown executable not found"
3093
3094     _scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed =
on $SCRATCH_DEV"
3095     _scratch_mount
3096
3097     if [ $FSTYP =3D "overlay" ]; then                               =
             # FSTYP =3D base fs
3098         if [ -z $OVL_BASE_SCRATCH_DEV ]; then
3099             # In lagacy overlay usage, it may specify directory as
3100             # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
3101             # will be null, so check OVL_BASE_SCRATCH_DEV before
3102             # running shutdown to avoid shutting down base fs accide=
ntly.
3103             _notrun "$SCRATCH_DEV is not a block device"
3104         else
3105             src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
3106             || _notrun "Underlying filesystem does not support shutd=
own"
3107         fi
3108     else
3109         src/godown -f $SCRATCH_MNT 2>&1 \
3110             || _notrun "$FSTYP does not support shutdown"           =
           # Executes this path
3111     fi
3112
3113     _scratch_unmount
3114 }
So, we can't get output: _notrun "$SCRATCH_DEV is not a block device". In=
stead, the verbose should like:
  after _overlay_config_override FSTYP=3Dubifs    # Additional print mess=
age
  FSTYP         -- ubifs
  PLATFORM      -- Linux/x86_64
  MKFS_OPTIONS  -- /dev/ubi0_1
  MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch

  generic/042	[not run] ubifs does not support shutdown

But I'll consider describing error more concisely in v2.

=E5=9C=A8 2019/9/24 20:33, Amir Goldstein =E5=86=99=E9=81=93:
> On Tue, Sep 24, 2019 at 12:34 PM Zhihao Cheng <chengzhihao1@huawei.com>=
 wrote:
>>
>> When running overlay tests using character devices as base fs partitio=
ns,
>> all overlay usecase results become 'notrun'. Function
>> '_overay_config_override' (common/config) detects that the current bas=
e
>> fs partition is not a block device and will set FSTYP to base fs. The
>> overlay usecase will check the current FSTYP, and if it is not 'overla=
y'
>> or 'generic', it will skip the execution.
>>
>> For example, using UBIFS as base fs skips all overlay usecases:
>>
>>   FSTYP         -- ubifs       # FSTYP should be overridden as 'overla=
y'
>>   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
>>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
>>
>>   overlay/001   [not run] not suitable for this filesystem type: ubifs
>>   overlay/002   [not run] not suitable for this filesystem type: ubifs
>>   overlay/003   [not run] not suitable for this filesystem type: ubifs
>>   ...
>>
>> When checking that the base fs partition is a block/character device,
>> FSTYP is overwritten as 'overlay'. This patch allows the base fs
>> partition to be a character device that can also execute overlay
>> usecases (such as ubifs).
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>  common/config | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/config b/common/config
>> index 4c86a49..a22acdb 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -550,7 +550,7 @@ _overlay_config_override()
>>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the=
 values
>>         #    of the configured base fs and SCRATCH/TEST_DEV vars are s=
et to the
>>         #    overlayfs base and mount dirs inside base fs mount.
>> -       [ -b "$TEST_DEV" ] || return 0
>> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>>
>>         # Config file may specify base fs type, but we obay -overlay f=
lag
>>         [ "$FSTYP" =3D=3D overlay ] || export OVL_BASE_FSTYP=3D"$FSTYP=
"
>> @@ -570,7 +570,7 @@ _overlay_config_override()
>>         export TEST_DIR=3D"$OVL_BASE_TEST_DIR/$OVL_MNT"
>>         export MOUNT_OPTIONS=3D"$OVERLAY_MOUNT_OPTIONS"
>>
>> -       [ -b "$SCRATCH_DEV" ] || return 0
>> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>>
>>         # Store original base fs vars
>>         export OVL_BASE_SCRATCH_DEV=3D"$SCRATCH_DEV"
>> --
>> 2.7.4
>>
>=20
> Looks fine.
>=20
> One nit: there is a message in _require_scratch_shutdown():
> _notrun "$SCRATCH_DEV is not a block device"
> for when $OVL_BASE_SCRATCH_DEV is not defined.
>=20
> Could probably use a better describing error anyway.
>=20
> Thanks,
> Amir.
>=20
> .
>=20
