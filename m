Received: from mail-io0-f196.google.com ([209.85.223.196]:39376 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964949AbeBMOLI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Feb 2018 09:11:08 -0500
Received: by mail-io0-f196.google.com with SMTP id b198so21397909iof.6
        for <fstests@vger.kernel.org>; Tue, 13 Feb 2018 06:11:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213091203.22909-2-eguan@redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com> <20180213091203.22909-2-eguan@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 13 Feb 2018 15:11:07 +0100
Message-ID: <CAHc6FU5tmwRRCWt+6qY_Tqpr_f3=3CuvTFumhtVaoz9y_DE+MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fstests: introduce _scratch_mount_nocheck
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On 13 February 2018 at 10:12, Eryu Guan <eguan@redhat.com> wrote:
> _fail test by default if _scratch_mount failed and introduce
> _scratch_mount_nocheck for tests that need to check mount results
> themselves.
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  common/attr        |  2 +-
>  common/dmapi       |  4 ++--
>  common/dump        |  4 ++--
>  common/encrypt     |  2 +-
>  common/filestreams |  4 ++--
>  common/fuzzy       |  4 ++--
>  common/log         |  6 +++---
>  common/overlay     |  2 +-
>  common/punch       |  2 +-
>  common/quota       |  4 ++--
>  common/rc          | 38 ++++++++++++++++++++++----------------
>  common/xfs         | 12 ++++++------
>  12 files changed, 45 insertions(+), 39 deletions(-)
>
> diff --git a/common/attr b/common/attr
> index 66b0227f721e..e83aadb803f7 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -229,7 +229,7 @@ _require_noattr2()
>  {
>         _scratch_mkfs_xfs > /dev/null 2>&1 \
>                 || _fail "_scratch_mkfs_xfs failed on $SCRATCH_DEV"
> -       _scratch_mount -o noattr2 > /dev/null 2>&1 \
> +       _scratch_mount_nocheck -o noattr2 > /dev/null 2>&1 \
>                 || _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
>         _scratch_unmount
>  }
> diff --git a/common/dmapi b/common/dmapi
> index c8a463a2cac0..af0faf504a3d 100644
> --- a/common/dmapi
> +++ b/common/dmapi
> @@ -31,10 +31,10 @@ _dmapi_scratch_mount () {
>      if [ `echo "$MOUNT_OPTIONS" | grep -c dmapi` -gt 0 -o \
>          `echo "$MOUNT_OPTIONS" | grep -c dmi` -gt 0 ] ; then
>          #already got dmapi options set
> -        _scratch_mount
> +        _scratch_mount_nocheck
>          dmapi_mount_result=$?
>      else
> -        _scratch_mount "-o dmapi,mtpt=$SCRATCH_MNT"
> +        _scratch_mount_nocheck "-o dmapi,mtpt=$SCRATCH_MNT"
>          dmapi_mount_result=$?
>      fi
>
> diff --git a/common/dump b/common/dump
> index 2b3cfa0f0607..7b9c10a25414 100644
> --- a/common/dump
> +++ b/common/dump
> @@ -235,7 +235,7 @@ _wipe_fs()
>      _require_scratch
>
>      _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
> -    _scratch_mount >>$seqres.full || _fail "mount failed"
> +    _scratch_mount >>$seqres.full
>  }
>
>  #
> @@ -287,7 +287,7 @@ _stable_fs()
>  {
>      _saveddir=`pwd`; cd /
>      _scratch_unmount >>$seqres.full || _fail "unmount failed"
> -    _scratch_mount >>$seqres.full || _fail "mount failed"
> +    _scratch_mount >>$seqres.full
>      cd $_saveddir
>  }
>
> diff --git a/common/encrypt b/common/encrypt
> index 189c59ee9bbd..4c5fce75fe62 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -43,7 +43,7 @@ _require_scratch_encryption()
>         # Try to mount the filesystem.  If this fails then either the kernel
>         # isn't aware of encryption, or the mkfs options were not compatible
>         # with encryption (e.g. ext4 with block size != PAGE_SIZE).
> -       if ! _scratch_mount &>>$seqres.full; then
> +       if ! _scratch_mount_nocheck &>>$seqres.full; then
>                 _notrun "kernel is unaware of $FSTYP encryption feature," \
>                         "or mkfs options are not compatible with encryption"
>         fi
> diff --git a/common/filestreams b/common/filestreams
> index f5441f5a82e9..a06020c8b3fb 100644
> --- a/common/filestreams
> +++ b/common/filestreams
> @@ -111,11 +111,11 @@ _test_streams() {
>
>         if [ "$use_iflag" = "0" ]; then
>                 # mount using filestreams mount option
> -               _scratch_mount "-o filestreams" \
> +               _scratch_mount_nocheck "-o filestreams" \
>                         || _fail "filestreams mount failed"
>         else
>                 # test will set inode flag
> -               _scratch_mount || _fail "mount failed"
> +               _scratch_mount
>         fi
>
>         cd $SCRATCH_MNT
> diff --git a/common/fuzzy b/common/fuzzy
> index b964fd8cb0fc..f5bd3f594666 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -200,7 +200,7 @@ __scratch_xfs_fuzz_field_test() {
>
>         # Try to catch the error with scrub
>         echo "+ Try to catch the error"
> -       _scratch_mount 2>&1
> +       _scratch_mount_nocheck 2>&1
>         res=$?
>         if [ $res -eq 0 ]; then
>                 # Try an online scrub unless we're fuzzing ag 0's sb,
> @@ -245,7 +245,7 @@ __scratch_xfs_fuzz_field_test() {
>
>         # See if scrub finds a clean fs
>         echo "+ Make sure error is gone (online)"
> -       _scratch_mount 2>&1
> +       _scratch_mount_nocheck 2>&1
>         res=$?
>         if [ $res -eq 0 ]; then
>                 # Try an online scrub unless we're fuzzing ag 0's sb,
> diff --git a/common/log b/common/log
> index bdb4ed684a08..2157b2848a69 100644
> --- a/common/log
> +++ b/common/log
> @@ -370,7 +370,7 @@ _create_log()
>  {
>      # mount the FS
>      _full "mount"
> -    _scratch_mount >>$seqres.full 2>&1
> +    _scratch_mount_nocheck >>$seqres.full 2>&1
>      if [ $? -ne 0 ] ; then
>         _echofull "mount failed: $MOUNT_OPTIONS"
>         return 1
> @@ -399,7 +399,7 @@ _create_log_sync()
>  {
>      # mount the FS
>      _full " mount"
> -    _scratch_mount >>$seqres.full 2>&1
> +    _scratch_mount_nocheck >>$seqres.full 2>&1
>      if [ $? -ne 0 ] ; then
>         _echofull "mount failed: $MOUNT_OPTIONS"
>         return 1
> @@ -519,7 +519,7 @@ _require_v2log()
>
>      # test out mount to see if it mounts a v2 log fs
>      export MOUNT_OPTIONS="-o logbsize=32k"
> -    if ! _scratch_mount >>$seqres.full 2>&1; then
> +    if ! _scratch_mount_nocheck >>$seqres.full 2>&1; then
>          _notrun "mount/kernel does not support v2 logs"
>      fi
>
> diff --git a/common/overlay b/common/overlay
> index a8b0e9369c86..054b759e1ce4 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -167,7 +167,7 @@ _require_scratch_overlay_features()
>         done
>
>         _scratch_mkfs > /dev/null 2>&1
> -       _scratch_mount -o $opts || \
> +       _scratch_mount_nocheck -o $opts || \
>                 _notrun "overlay options '$opts' cannot be enabled on ${SCRATCH_DEV}"
>
>         for feature in ${features[*]}; do
> diff --git a/common/punch b/common/punch
> index c4ed26192a22..42a7e97496b7 100644
> --- a/common/punch
> +++ b/common/punch
> @@ -131,7 +131,7 @@ _test_punch() {
>                 _dmapi_scratch_mount
>         else
>                 # only unresvsp punch type is used, just do a normal mount
> -               _scratch_mount || _fail "mount failed"
> +               _scratch_mount
>         fi
>
>         cd $SCRATCH_MNT
> diff --git a/common/quota b/common/quota
> index 2611c484ee35..c1f1436458c2 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -119,7 +119,7 @@ _scratch_enable_pquota()
>         [ "$FSTYP" != "ext4" ] && return
>
>         tune2fs -O quota,project $SCRATCH_DEV >>$seqres.full 2>&1
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>                 || _notrun "kernel doesn't support project feature on $FSTYP"
>         _scratch_unmount
>  }
> @@ -202,7 +202,7 @@ _choose_prid()
>  _qmount()
>  {
>      _scratch_unmount >/dev/null 2>&1
> -    _scratch_mount || _fail "qmount failed"
> +    _scratch_mount_nocheck || _fail "qmount failed"
>      # xfs doesn't need these setups and quotacheck even fails on xfs
>      # redirect the output to $seqres.full for debug purpose and ignore results
>      if [ "$FSTYP" != "xfs" ]; then
> diff --git a/common/rc b/common/rc
> index b9dc0b9206db..ddfcbec65135 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -352,13 +352,18 @@ _supports_filetype()
>         esac
>  }
>
> +_scratch_mount_nocheck()
> +{
> +       if [ "$FSTYP" == "overlay" ]; then
> +               _overlay_scratch_mount $*
> +               return $?
> +       fi
> +       _mount -t $FSTYP `_scratch_mount_options $*`
> +}
> +
>  _scratch_mount()
>  {
> -    if [ "$FSTYP" == "overlay" ]; then
> -        _overlay_scratch_mount $*
> -        return $?
> -    fi
> -    _mount -t $FSTYP `_scratch_mount_options $*`
> +       _scratch_mount_nocheck $* || _fail "_scratch_mount failed"

I'd change that to "mount failed"; the name of the helper function
isn't very interesting.

>  }
>
>  _scratch_unmount()
> @@ -397,7 +402,7 @@ _scratch_cycle_mount()
>         opts="-o $opts"
>      fi
>      _scratch_unmount
> -    _scratch_mount "$opts"
> +    _scratch_mount_nocheck "$opts" || _fail "_scratch_cycle_mount failed"

Same here, change to "cycle mount failed" or similar.

>  }
>
>  _scratch_shutdown()
> @@ -524,7 +529,7 @@ _setup_large_ext4_fs()
>
>         # mount the filesystem and create 16TB - 4KB files until we consume
>         # all the necessary space.
> -       _scratch_mount 2>&1 >$tmp_dir/mnt.err
> +       _scratch_mount_nocheck 2>&1 >$tmp_dir/mnt.err
>         local status=$?
>         if [ $status -ne 0 ]; then
>                 echo "mount failed"
> @@ -1103,7 +1108,7 @@ _repair_scratch_fs()
>         res=$?
>         if [ "$res" -ne 0 ]; then
>                 echo "xfs_repair returns $res; replay log?"
> -               _scratch_mount
> +               _scratch_mount_nocheck
>                 res=$?
>                 if [ "$res" -gt 0 ]; then
>                         echo "mount returns $res; zap log?"
> @@ -1872,7 +1877,7 @@ _require_scratch_ext4_crc()
>  {
>         _scratch_mkfs_ext4 >/dev/null 2>&1
>         dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>            || _notrun "Kernel doesn't support metadata_csum feature"
>         _scratch_unmount
>  }
> @@ -1888,7 +1893,7 @@ _require_scratch_ext4_feature()
>      $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
>                     $SCRATCH_DEV 512m >/dev/null 2>&1 \
>         || _notrun "mkfs.ext4 doesn't support $1 feature"
> -    _scratch_mount >/dev/null 2>&1 \
> +    _scratch_mount_nocheck >/dev/null 2>&1 \
>         || _notrun "Kernel doesn't support the ext4 feature(s): $1"
>      _scratch_unmount
>  }
> @@ -2322,7 +2327,7 @@ _require_scratch_richacl_xfs()
>         _scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
>                 || _notrun "mkfs.xfs doesn't have richacl feature"
>         _scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>                 || _notrun "kernel doesn't support richacl feature on $FSTYP"
>         _scratch_unmount
>  }
> @@ -2331,7 +2336,7 @@ _require_scratch_richacl_ext4()
>  {
>         _scratch_mkfs -O richacl >/dev/null 2>&1 \
>                 || _notrun "can't mkfs $FSTYP with option -O richacl"
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>                 || _notrun "kernel doesn't support richacl feature on $FSTYP"
>         _scratch_unmount
>  }
> @@ -2993,7 +2998,7 @@ _require_scratch_shutdown()
>         [ -x src/godown ] || _notrun "src/godown executable not found"
>
>         _scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
> -       _scratch_mount || _notrun "_scratch_mount failed on $SCRATCH_MNT"
> +       _scratch_mount
>
>         if [ $FSTYP = "overlay" ]; then
>                 if [ -z $OVL_BASE_SCRATCH_DEV ]; then
> @@ -3019,7 +3024,8 @@ _require_scratch_dax()
>  {
>         _require_scratch
>         _scratch_mkfs > /dev/null 2>&1
> -       _scratch_mount -o dax
> +       _scratch_mount_nocheck -o dax || \
> +               _notrun "mount $SCRATCH_DEV with dax failed"
>         # Check options to be sure. XFS ignores dax option
>         # and goes on if dev underneath does not support dax.
>         _fs_options $SCRATCH_DEV | grep -qw "dax" || \
> @@ -3030,7 +3036,7 @@ _require_scratch_dax()
>  # Does norecovery support by this fs?
>  _require_norecovery()
>  {
> -       _scratch_mount -o ro,norecovery || \
> +       _scratch_mount_nocheck -o ro,norecovery || \
>                 _notrun "$FSTYP does not support norecovery"
>         _scratch_unmount
>  }
> @@ -3229,7 +3235,7 @@ _require_atime()
>  _require_relatime()
>  {
>          _scratch_mkfs > /dev/null 2>&1
> -        _scratch_mount -o relatime || \
> +        _scratch_mount_nocheck -o relatime || \
>                  _notrun "relatime not supported by the current kernel"
>         _scratch_unmount
>  }
> diff --git a/common/xfs b/common/xfs
> index 9b20b0380782..c6d8f0938ac9 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -18,7 +18,7 @@ _setup_large_xfs_fs()
>         file_size=$(($file_size - $SCRATCH_DEV_EMPTY_SPACE))
>
>         # mount the filesystem, create the file, unmount it
> -       _scratch_mount 2>&1 >$tmp_dir/mnt.err
> +       _scratch_mount_nocheck 2>&1 >$tmp_dir/mnt.err
>         local status=$?
>         if [ $status -ne 0 ]; then
>                 echo "mount failed"
> @@ -223,7 +223,7 @@ _require_xfs_mkfs_crc()
>  _require_xfs_crc()
>  {
>         _scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>            || _notrun "Kernel doesn't support crc feature"
>         _scratch_unmount
>  }
> @@ -233,7 +233,7 @@ _require_xfs_crc()
>  _require_scratch_xfs_crc()
>  {
>         _scratch_mkfs_xfs >/dev/null 2>&1
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>            || _notrun "Kernel doesn't support crc feature"
>         xfs_info $SCRATCH_MNT | grep -q 'crc=1' || _notrun "crc feature not supported by this filesystem"
>         _scratch_unmount
> @@ -252,7 +252,7 @@ _require_xfs_mkfs_finobt()
>  _require_xfs_finobt()
>  {
>         _scratch_mkfs_xfs -m crc=1,finobt=1 >/dev/null 2>&1
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>            || _notrun "Kernel doesn't support finobt feature"
>         _scratch_unmount
>  }
> @@ -280,7 +280,7 @@ _require_xfs_sparse_inodes()
>         _scratch_mkfs_xfs_supported -m crc=1 -i sparse > /dev/null 2>&1 \
>                 || _notrun "mkfs.xfs does not support sparse inodes"
>         _scratch_mkfs_xfs -m crc=1 -i sparse > /dev/null 2>&1
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>                 || _notrun "kernel does not support sparse inodes"
>         _scratch_unmount
>  }
> @@ -599,7 +599,7 @@ _require_meta_uuid()
>
>         _scratch_xfs_db -x -c "uuid generate" >/dev/null 2>&1
>
> -       _scratch_mount >/dev/null 2>&1 \
> +       _scratch_mount_nocheck >/dev/null 2>&1 \
>            || _notrun "Kernel doesn't support meta_uuid feature"
>         _scratch_unmount
>  }
> --
> 2.14.3

Thanks,
Andreas
