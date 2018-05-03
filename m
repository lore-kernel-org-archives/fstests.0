Received: from mail-yw0-f194.google.com ([209.85.161.194]:45636 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbeECJWo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 May 2018 05:22:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id g9-v6so5438842ywb.12
        for <fstests@vger.kernel.org>; Thu, 03 May 2018 02:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503034340.GA20908@thunk.org>
References: <20180503034340.GA20908@thunk.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 May 2018 12:22:42 +0300
Message-ID: <CAOQ4uxjEAhDteK7iZF0KLq-oFi+nO9LbUe0F+5eLTOo59=hTLQ@mail.gmail.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 3, 2018 at 6:43 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
[...]
> From 8b40b28866dca119d0c807c31ae48f153ec2dc53 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Sat, 17 Sep 2016 19:08:18 -0400
> Subject: [PATCH] common: add support for the "local" file system type
>
> It is sometimes useful to be able to test the local file system
> provided in a restricted execution environment (such as that which is
> provided by Docker, for example) where it is not possible to mount and
> unmount the file system under test.
>
> To support this test case, add support for a new file system type
> called "local".  The TEST_DEV and SCRATCH_DEV should be have a
> non-block device format (e.g., local:/test or local:/scratch), and the
> TEST_DIR and SCRATCH_MNT directories should be pre-existing
> directories provided by the execution environment.

Ted,

This looks like a very useful feature, but I suspect that some bits of the
patch may be a bit too specific to your use case (see below) - I may be wrong.
I bet there is a large variety of out of tree xfstests patches named
"Add support for XXX fs" that could be avoided with this feature.

The ultimate proof would be to demonstrate the usefulness of the feature
to more than a single use case - how about FUSE passthrough example?
Perhaps FSTYP=user would be more descriptive in general to the use
case at hand, because 'local' is usually the counter of 'remote',
but I'm fine with FSTYP=local.

Another way to "market" the feature is FSTYP=generic, which is the
prototype of all other filesystems. Naturally, it only runs tests under
tests/generic (as FSTYP=local does) and any test that requires an
operation that has no generic implementation is notrun.


>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 9ffab7fd..d5cb0fe4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -351,6 +351,18 @@ _supports_filetype()
>         esac
>  }
>
> +_local_validate_mount_opt()
> +{
> +    case "$*" in
> +       ro|ro,*|*,ro) _notrun "ro mount option not supported" ;;
> +       *nosuid*) _notrun "nosuid mount option not supported" ;;
> +       *noatime*) _notrun "noatime mount option not supported" ;;
> +       *relatime*) _notrun "relatime mount option not supported" ;;
> +       *diratime*) _notrun "diratime mount option not supported" ;;
> +       *strictatime*) _notrun "strictatime mount option not supported" ;;
> +    esac
> +}

Why specifically these mount options? Is this really generic?

> +
>  # mount scratch device with given options but don't check mount status
>  _try_scratch_mount()
>  {
> @@ -376,6 +388,9 @@ _scratch_unmount()
>         btrfs)
>                 $UMOUNT_PROG $SCRATCH_MNT
>                 ;;
> +       local)
> +                rm -rf $SCRATCH_MNT/*
> +                ;;

_scratch_mkfs already does that. Why does it make sense in _scratch_unmount?

>         *)
>                 $UMOUNT_PROG $SCRATCH_DEV
>                 ;;
> @@ -386,6 +401,10 @@ _scratch_remount()
>  {
>      local opts="$1"
>
> +    if [ "$FSTYP" = "local" ]; then
> +       _local_validate_mount_opt "$*"
> +       return 0;
> +    fi

It makes more sense to me to _require_scratch_remount
for tests that need to remount in the beginning of tests - yeh
that's a bit more work.

>      if test -n "$opts"; then
>         mount -o "remount,$opts" $SCRATCH_MNT
>      fi
> @@ -395,7 +414,7 @@ _scratch_cycle_mount()
>  {
>      local opts="$1"
>
> -    if [ "$FSTYP" = tmpfs ]; then
> +    if [ "$FSTYP" = "tmpfs" -o "$FSTYP" = "local" ] ; then
>         _scratch_remount "$opts"

That seems like cheating - seems better to implement
and use _require_scratch_cycle_mount

>         return
>      fi
> @@ -429,6 +448,10 @@ _test_mount()
>          _overlay_test_mount $*
>          return $?
>      fi
> +    if [ "$FSTYP" == "local" ]; then
> +        mkdir -p $TEST_DIR
> +       return $?
> +    fi

What is the desired logic here? can you add a comment?
Seems to me that we need to verify there is something mounted
at $TEST_DIR. no?

>      _test_options mount
>      _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>  }
> @@ -437,7 +460,7 @@ _test_unmount()
>  {
>         if [ "$FSTYP" == "overlay" ]; then
>                 _overlay_test_unmount
> -       else
> +       elif [ "$FSTYP" != "local" ]; then
>                 $UMOUNT_PROG $TEST_DEV
>         fi
>  }
> @@ -723,7 +746,7 @@ _scratch_mkfs()
>         local mkfs_status
>
>         case $FSTYP in
> -       nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p)
> +       nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|local)
>                 # unable to re-create this fstyp, just remove all files in
>                 # $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>                 # created in previous runs
> @@ -1465,6 +1488,10 @@ _check_mounted_on()
>         local mnt=$4
>         local type=$5
>
> +       if [ "$FSTYP" == "local" ]; then
> +               return 0
> +       fi
> +

Shouldn't we check that "something" is mounted on $mnt?

>         # find $dev as the source, and print result in "$dev $mnt" format
>         local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
>         [ -n "$mount_rec" ] || return 1 # 1 = not mounted
> @@ -1562,6 +1589,13 @@ _require_scratch_nocheck()
>                         _notrun "this test requires a valid \$SCRATCH_MNT"
>                 fi
>                 ;;
> +       local)
> +               if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
> +               then
> +                   _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
> +               fi
> +               return 0
> +               ;;
>         *)
>                  if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
>                  then
> @@ -1683,6 +1717,13 @@ _require_test()
>                         _notrun "this test requires a valid \$TEST_DIR"
>                 fi
>                 ;;
> +       local)
> +               if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
> +               then
> +                   _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
> +               fi
> +               return 0
> +               ;;
>         *)
>                  if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
>                  then
> @@ -2438,6 +2479,10 @@ _remount()
>      local device=$1
>      local mode=$2
>
> +    if [ "$FSTYP" == "local" ] ; then
> +       return 0
> +    fi
> +
>      if ! mount -o remount,$mode $device
>      then
>          echo "_remount: failed to remount filesystem on $device as $mode"
> @@ -2483,6 +2528,10 @@ _mount_or_remount_rw()
>         local device=$2
>         local mountpoint=$3
>
> +       if [ "$FSTYP" == "local" ] ; then
> +           return 0
> +       fi
> +
>         if [ $USE_REMOUNT -eq 0 ]; then
>                 if [ "$FSTYP" != "overlay" ]; then
>                         _mount -t $FSTYP $mount_opts $device $mountpoint
> @@ -2636,6 +2685,9 @@ _check_test_fs()
>      ubifs)
>         # there is no fsck program for ubifs yet
>         ;;
> +    local)
> +       # no way to check consistency for local
> +       ;;
>      *)
>         _check_generic_filesystem $TEST_DEV
>         ;;
> @@ -2691,6 +2743,9 @@ _check_scratch_fs()
>      ubifs)
>         # there is no fsck program for ubifs yet
>         ;;
> +    local)
> +       # no way to check consistency for local
> +       ;;
>      *)
>         _check_generic_filesystem $device
>         ;;
> @@ -3003,6 +3058,9 @@ _require_fio()
>  # Does freeze work on this fs?
>  _require_freeze()
>  {
> +       if [ "$FSTYP" == "local" ]; then
> +               _notrun "local does not support freeze"

When users read this warning they may be confused,
same for shutdown/dax/morecovery.
Something like "user defined fs does not support freeze"

Thanks,
Amir.
