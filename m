Received: from szxga07-in.huawei.com ([45.249.212.35]:53860 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751086AbeAWLKy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jan 2018 06:10:54 -0500
Subject: Re: [xfstests PATCH v5 1/7] overlay: add filesystem check helper
References: <20180123073452.19074-1-yi.zhang@huawei.com>
 <20180123073452.19074-2-yi.zhang@huawei.com>
 <CAOQ4uxjBw1N6jQ_Ht3YzWeM=bUTKPJP6Ei+A2Sam+gd3HPxTWg@mail.gmail.com>
From: "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <8d8c094e-cfac-2cf2-2da4-fe759b7122a4@huawei.com>
Date: Tue, 23 Jan 2018 19:10:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjBw1N6jQ_Ht3YzWeM=bUTKPJP6Ei+A2Sam+gd3HPxTWg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Eryu Guan <eguan@redhat.com>, Miao Xie <miaoxie@huawei.com>, yangerkun@huawei.com
List-ID: <fstests@vger.kernel.org>

On 2018/1/23 17:16, Amir Goldstein =E5=86=99=E9=81=93:
> On Tue, Jan 23, 2018 at 9:34 AM, zhangyi (F) <yi.zhang@huawei.com> wrot=
e:
>> Add filesystem check helpers for the upcoming fsck.overlay utility.
>> Hook these helpers to _check_test_fs and _check_scratch_fs for constan=
ts
>> underlying dirs of overlay filesystem, and introduce scratch check hel=
pers
>> for optionally lower/upper/work dirs. These helpers works only if
>> fsck.overlay exists.
>>
>> [ _check_test_fs/_check_scratch_fs part picked from Amir's patch, than=
ks ]
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> ---
>>  common/config  |   1 +
>>  common/overlay | 145 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  common/rc      |   4 +-
>>  3 files changed, 148 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/config b/common/config
>> index 5f40413..71115bd 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -236,6 +236,7 @@ case "$HOSTOS" in
>>          export MKFS_REISER4_PROG=3D"`set_prog_path mkfs.reiser4`"
>>         export E2FSCK_PROG=3D"`set_prog_path e2fsck`"
>>         export TUNE2FS_PROG=3D"`set_prog_path tune2fs`"
>> +       export FSCK_OVERLAY_PROG=3D"`set_prog_path fsck.overlay`"
>>          ;;
>>  esac
>>
>> diff --git a/common/overlay b/common/overlay
>> index 1da4ab1..c611a49 100644
>> --- a/common/overlay
>> +++ b/common/overlay
>> @@ -151,3 +151,148 @@ _require_scratch_overlay_feature()
>>                 _notrun "${FSTYP} feature '${feature}' cannot be enabl=
ed on ${SCRATCH_DEV}"
>>         _scratch_unmount
>>  }
>> +
>> +# Require the same scratch device as _require_scratch, but do not che=
ck
>> +# the constants OVL_LOWER/OVL_UPPER/OVL_WORK dirs, should use togethe=
r
>> +# with optionally lower/upper/work dirs and do check explicitly after=
 test.
>> +_require_overlay_scratch_dirs()
>> +{
>> +       _require_scratch_nocheck
>> +}
>> +
>> +_overlay_fsck_dirs()
>> +{
>> +       local lowerdir=3D$1
>> +       local upperdir=3D$2
>> +       local workdir=3D$3
>> +       local options=3D$4
>> +
>> +       [[ ! -x "$FSCK_OVERLAY_PROG" ]] && return 0
>> +
>> +       $FSCK_OVERLAY_PROG -o lowerdir=3D$lowerdir -o upperdir=3D$uppe=
rdir \
>> +                          -o workdir=3D$workdir $options
>> +}
>> +
>> +_overlay_check_dirs()
>> +{
>> +       local lowerdir=3D$1
>> +       local upperdir=3D$2
>> +       local workdir=3D$3
>> +       local err=3D0
>> +
>> +       _overlay_fsck_dirs $* $FSCK_OPTIONS >>$tmp.fsck 2>&1
>> +       if [ $? -ne 0 ]; then
>> +               _log_err "_overlay_check_fs: overlayfs on $lowerdir,$u=
pperdir,$workdir is inconsistent"
>> +
>> +               echo "*** fsck.overlay output ***"      >>$seqres.full
>> +               cat $tmp.fsck                           >>$seqres.full
>> +               echo "*** end fsck.overlay output"      >>$seqres.full
>> +
>> +               echo "*** mount output ***"             >>$seqres.full
>> +               _mount                                  >>$seqres.full
>> +               echo "*** end mount output"             >>$seqres.full
>> +
>> +               err=3D1
>> +       fi
>> +       rm -f $tmp.fsck
>> +
>> +       return $err
>> +}
>> +
>> +# Check the same mnt/dev of _check_overlay_scratch_fs, but check opti=
onally
>> +# lower/upper/work dirs of overlay filesystem, should use together wi=
th
>> +# _require_overlay_scratch_dirs
>> +_overlay_check_scratch_dirs()
>> +{
>> +       local lowerdir=3D$1
>> +       local upperdir=3D$2
>> +       local workdir=3D$3
>> +
>> +       # Need to umount overlay for scratch dir check
>> +       local type=3D`_fs_type $OVL_BASE_SCRATCH_MNT`
>=20
> This test is fragile because it relies that the mount device name
> specified in mount command was OVL_BASE_SCRATCH_MNT.
> That is true for tests using _require_overlay_scratch_dirs, but not
> always true for tests using  _overlay_mount_dirs.
> For example, you did not end up calling _overlay_check_scratch_dirs
> in overlay/036, but for different reason. If you would have called
> this helper it would do the wrong thing, because device name used
> in this test in 'overlay3'.
>=20
> One way to deal with this is to check whether $SCRATCH_MNT
> is an 'overlay' type mount point (instead of checking device name).
>=20
>> +
>> +       # If type is set, overlay is mounted
>> +       [ "$type" =3D "$FSTYP" ] && $UMOUNT_PROG $SCRATCH_MNT
>=20
> This is an overlay specific helper, so I rather see [ "$type" =3D overl=
ay ]
>=20
>> +
>> +       _overlay_check_dirs $lowerdir $upperdir $workdir
>> +       local ret=3D$?
>> +
>> +       if [ $ret =3D 0 -a "$type" =3D "$FSTYP" ]; then
>=20
> more clear to read if there was an auxiliary variable ovl_mounted
>=20
>> +               # overlay was mounted...
>> +
>> +               # If overlayfs have to recover with last mount options=
,
>> +               # OVERLAY_MOUNT_OPTIONS should be clarified before las=
t
>> +               # mount
>> +               _overlay_scratch_mount_dirs $lowerdir $upperdir \
>> +                       $workdir $OVERLAY_MOUNT_OPTIONS
>=20
>=20
> This part is a bit obfuscated in check -overlay, but OVERLAY_MOUNT_OPTI=
ONS
> should already be assigned to MOUNT_OPTIONS and included from
> _overlay_mount_dirs -> _common_dev_mount_options
>=20
> If anything you should allow to pass in extra mount option variables
> and pass them into _overlay_scratch_mount_dirs in the end ($*)
> for tests that would like to continue testing on a mounted overlay afte=
r
> calling _overlay_check_scratch_dirs and have provide specialized
> mount options to _overlay_scratch_mount_dirs.
> But _check_generic_filesystem doesn't handle this case, so I don't
> think you should handle it as well.

Right, I had planned to use OVERLAY_MOUNT_OPTIONS to pass extra mount opt=
ions($*)
as overlay/044 does, but it seems not necessary because we always check a=
fter test
or subtest. For simplicity, I will remove this option.

Thanks,
Yi.

>=20
>> +               ret=3D$?
>> +       fi
>> +
>> +       return $ret
>> +}
>> +
>> +_overlay_check_fs()
>> +{
>> +       local ovl_mnt=3D$1
>> +       local base_dev=3D$4
>> +       local base_mnt=3D$5
>> +       shift 1
>> +
>> +       [ "$FSTYP" =3D overlay ] || return 0
>> +
>> +       # Base fs needs to be mounted to check overlay dirs
>> +       local mounted=3D""
>> +       [ -z "$base_dev" ] || mounted=3D`_is_mounted $base_dev`
>> +
>> +       if [ -z "$mounted" ]; then
>> +               _overlay_base_mount $*
>> +       else
>> +               # Need to umount overlay for dir check
>> +               local type=3D`_fs_type $base_mnt`
>> +
>> +               # If type is set, overlay is mounted
>> +               [ "$type" =3D "$FSTYP" ] && $UMOUNT_PROG $ovl_mnt
>=20
> Same comments as above
>=20
>> +       fi
>> +
>> +       _overlay_check_dirs $base_mnt/$OVL_LOWER $base_mnt/$OVL_UPPER =
\
>> +                           $base_mnt/$OVL_WORK
>> +       local ret=3D$?
>> +
>> +       if [ -z "$mounted" ]; then
>> +               _overlay_base_unmount "$base_dev" "$base_mnt"
>> +       elif [ $ret =3D 0 -a "$type" =3D "$FSTYP" ]; then
>> +               # overlay was mounted...
>> +
>> +               # If overlayfs have to recover with last mount options=
,
>> +               # OVERLAY_MOUNT_OPTIONS should be clarified before las=
t
>> +               # mount
>> +               _overlay_mount $base_mnt $ovl_mnt $OVERLAY_MOUNT_OPTIO=
NS
>=20
> Same comments as above
>=20
> Thanks,
> Amir.
>=20
> .
>=20

