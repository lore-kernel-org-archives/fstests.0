Received: from mail-pl0-f67.google.com ([209.85.160.67]:44960 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELIm2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 May 2018 04:42:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id e6-v6so4564300plt.11
        for <fstests@vger.kernel.org>; Sat, 12 May 2018 01:42:28 -0700 (PDT)
Date: Sat, 12 May 2018 16:42:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20180512084223.GQ8373@desktop>
References: <20180503034340.GA20908@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503034340.GA20908@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Ted,

On Wed, May 02, 2018 at 11:43:40PM -0400, Theodore Y. Ts'o wrote:

[snip the background details]

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
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I tested the patch with XFS and ext4 as the mounted underlying
filesystem for multiple rounds and found some more issues (in addition
to previous review comments) that need to be addressed. I'll reply
inline.

> ---
>  common/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 3 deletions(-)

I think we need a new "-local" option in './check' to do some initial
setups, e.g. FSTYP=local, as other fs types that can't be retrieved by
running blkid on $TEST_DEV.

Also need some documentations in README to describe "local"'s use case
and mention that TEST_DEV and SCRATCH_DEV should be have a non-block
device format.

> 
> diff --git a/common/rc b/common/rc
> index 9ffab7fd..d5cb0fe4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -351,6 +351,18 @@ _supports_filetype()
>  	esac
>  }
>  
> +_local_validate_mount_opt()
> +{
> +    case "$*" in
> +	ro|ro,*|*,ro) _notrun "ro mount option not supported" ;;
> +	*nosuid*) _notrun "nosuid mount option not supported" ;;
> +	*noatime*) _notrun "noatime mount option not supported" ;;
> +	*relatime*) _notrun "relatime mount option not supported" ;;
> +	*diratime*) _notrun "diratime mount option not supported" ;;
> +	*strictatime*) _notrun "strictatime mount option not supported" ;;
> +    esac
> +}
> +
>  # mount scratch device with given options but don't check mount status
>  _try_scratch_mount()
>  {

We need to add a check for "local" in _try_scratch_mount() to let it do
nothing for "local" too, otherwise 'FSTYP=local ./check' won't run for
me, as _scratch_mount() failed and exit the test in 'check' line 629.

(Note that the exit on _scratch_mount() failure behavior was introduced
by commit 69eb6281a9d3 ("fstests: _fail test by default when
_scratch_mount fails"))

> @@ -376,6 +388,9 @@ _scratch_unmount()
>  	btrfs)
>  		$UMOUNT_PROG $SCRATCH_MNT
>  		;;
> +	local)
> +                rm -rf $SCRATCH_MNT/*
> +                ;;

As noted in previous review, we could just return for 'local' in
_scratch_unmount(), _scratch_mkfs() already removed all the files there.

>  	*)
>  		$UMOUNT_PROG $SCRATCH_DEV
>  		;;
> @@ -386,6 +401,10 @@ _scratch_remount()
>  {
>      local opts="$1"
>  
> +    if [ "$FSTYP" = "local" ]; then
> +	_local_validate_mount_opt "$*"
> +	return 0;
> +    fi

I found that there're more places that need to do
_local_validate_mount_opt, e.g. in _try_scratch_mount() and _test_mount,
otherwise tests that use _try_scratch_mount to do the remount would
fail, like generic/294.

>      if test -n "$opts"; then
>  	mount -o "remount,$opts" $SCRATCH_MNT
>      fi
> @@ -395,7 +414,7 @@ _scratch_cycle_mount()
>  {
>      local opts="$1"
>  
> -    if [ "$FSTYP" = tmpfs ]; then
> +    if [ "$FSTYP" = "tmpfs" -o "$FSTYP" = "local" ] ; then
>  	_scratch_remount "$opts"
>  	return
>      fi
> @@ -429,6 +448,10 @@ _test_mount()
>          _overlay_test_mount $*
>          return $?
>      fi
> +    if [ "$FSTYP" == "local" ]; then
> +        mkdir -p $TEST_DIR

Probably need _local_validate_mount_opt here as mentioned above.

And there're some tests or functions that call umount on $SCRATCH_MNT
directly, which would cause the underlying filesystem to be umounted if
it can be umounted (thouth this is not an intended use case for "local",
I think it's better to fix them too). e.g.

generic/034 generic/330 and generic/332 need to use _scratch_unmount
instead of a bare umount.

All the "$UMOUNT_PROG $SCRATCH_MNT"s in dm device helper functions, we
need to change them to umount the actual device, e.g. $FLAKEY_DEV

generic/108 needs to umount $SCSI_DEBUG_DEV in _cleanup()

Similarly, generic/459 needs to umount the lvm snapshot device
/dev/mapper/$vgname-$snapname

Thanks,
Eryu

> +	return $?
> +    fi
>      _test_options mount
>      _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>  }
> @@ -437,7 +460,7 @@ _test_unmount()
>  {
>  	if [ "$FSTYP" == "overlay" ]; then
>  		_overlay_test_unmount
> -	else
> +	elif [ "$FSTYP" != "local" ]; then
>  		$UMOUNT_PROG $TEST_DEV
>  	fi
>  }
> @@ -723,7 +746,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p)
> +	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|local)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -1465,6 +1488,10 @@ _check_mounted_on()
>  	local mnt=$4
>  	local type=$5
>  
> +	if [ "$FSTYP" == "local" ]; then
> +		return 0
> +	fi
> +
>  	# find $dev as the source, and print result in "$dev $mnt" format
>  	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
>  	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
> @@ -1562,6 +1589,13 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	local)
> +		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
> +		then
> +		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
> +		fi
> +		return 0
> +		;;
>  	*)
>  		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
>  		 then
> @@ -1683,6 +1717,13 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	local)
> +		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
> +		then
> +		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
> +		fi
> +		return 0
> +		;;
>  	*)
>  		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
>  		 then
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
>  	local device=$2
>  	local mountpoint=$3
>  
> +	if [ "$FSTYP" == "local" ] ; then
> +	    return 0
> +	fi
> +
>  	if [ $USE_REMOUNT -eq 0 ]; then
>  		if [ "$FSTYP" != "overlay" ]; then
>  			_mount -t $FSTYP $mount_opts $device $mountpoint
> @@ -2636,6 +2685,9 @@ _check_test_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    local)
> +	# no way to check consistency for local
> +	;;
>      *)
>  	_check_generic_filesystem $TEST_DEV
>  	;;
> @@ -2691,6 +2743,9 @@ _check_scratch_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    local)
> +	# no way to check consistency for local
> +	;;
>      *)
>  	_check_generic_filesystem $device
>  	;;
> @@ -3003,6 +3058,9 @@ _require_fio()
>  # Does freeze work on this fs?
>  _require_freeze()
>  {
> +	if [ "$FSTYP" == "local" ]; then
> +		_notrun "local does not support freeze"
> +	fi
>  	xfs_freeze -f "$TEST_DIR" >/dev/null 2>&1
>  	local result=$?
>  	xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> @@ -3024,6 +3082,9 @@ _require_scratch_shutdown()
>  {
>  	[ -x src/godown ] || _notrun "src/godown executable not found"
>  
> +	if [ "$FSTYP" == "local" ]; then
> +		_notrun "local does not support shutdown"
> +	fi
>  	_scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
>  	_scratch_mount
>  
> @@ -3049,6 +3110,9 @@ _require_scratch_shutdown()
>  # Does dax mount option work on this dev/fs?
>  _require_scratch_dax()
>  {
> +	if [ "$FSTYP" == "local" ]; then
> +		_notrun "local does not support dax"
> +	fi
>  	_require_scratch
>  	_scratch_mkfs > /dev/null 2>&1
>  	_try_scratch_mount -o dax || \
> @@ -3063,6 +3127,9 @@ _require_scratch_dax()
>  # Does norecovery support by this fs?
>  _require_norecovery()
>  {
> +	if [ "$FSTYP" == "local" ]; then
> +		_notrun "local does not support norecovery"
> +	fi
>  	_try_scratch_mount -o ro,norecovery || \
>  		_notrun "$FSTYP does not support norecovery"
>  	_scratch_unmount
> -- 
> 2.16.1.72.g5be1f00a9a
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
