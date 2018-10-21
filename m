Received: from mail-pg1-f195.google.com ([209.85.215.195]:39950 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJVAzu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Oct 2018 20:55:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id o14-v6so2181227pgv.7
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 09:40:57 -0700 (PDT)
Date: Mon, 22 Oct 2018 00:40:47 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: add support for fuse.ext4
Message-ID: <20181021164047.GA3876@desktop>
References: <20181011134153.722-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011134153.722-1-lczerner@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 11, 2018 at 03:41:53PM +0200, Lukas Czerner wrote:
> Add support for ext4 file system in userspace. The new file system type
> (FSTYP) is fuse.ext4 and it allows the device to be either a regular
> block device, or a regular file.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  common/config |  6 +++++
>  common/rc     | 65 ++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 1ba8d96c..37b66d31 100644
> --- a/common/config
> +++ b/common/config
> @@ -232,6 +232,7 @@ case "$HOSTOS" in
>  	export E2FSCK_PROG=$(type -P e2fsck)
>  	export TUNE2FS_PROG=$(type -P tune2fs)
>  	export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
> +	export FUSE2FS=$(type -P fuse2fs)
>          ;;
>  esac
>  
> @@ -470,6 +471,11 @@ _check_device()
>  			_fatal "common/config: $name ($dev) is not a character device"
>  		fi
>  		;;
> +	fuse.ext4)
> +		if [ ! -b "$dev" ] && [ ! -f "$dev" ]; then
> +			__fatal "common/config: $name ($dev) is not a block device nor a regular file"

Typo here, should be "_fatal".

> +		fi
> +		;;
>  	*)
>  		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
>  	esac
> diff --git a/common/rc b/common/rc
> index 90dc3002..2f5a3463 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -130,6 +130,10 @@ case "$FSTYP" in
>  
>  	 . ./common/btrfs
>  	 ;;
> +    fuse.ext4)
> +	 [ "$FUSE2FS" = "" ] && _fatal "fuse2fs not found"
> +	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> +	 ;;
>      ext4)
>  	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
>  	 ;;
> @@ -170,6 +174,22 @@ _mount()
>      $MOUNT_PROG `_mount_ops_filter $*`
>  }
>  
> +_mount_fstyp()
> +{
> +	ret=0
> +	case "$FSTYP" in
> +		fuse.ext4)
> +			$FUSE2FS `_mount_ops_filter $*` 2>&1> /dev/null

Hmm, fuse2fs expects the first argument to be the device/image file, if
we pass mount options first, /proc/mounts shows weird "device", e.g.

mount -o ro /dev/sda5 /mnt/test, then /proc/mounts shows

-o on /mnt/test type fuse.ext4 (rw,nosuid,nodev,relatime,user_id=0,group_id=0)

I think it might be better to update _mount() instead of introducing a
new _mount_fstyp() function, so that we keep the _mount() interface
unchanged and don't need to update all callers of _mount() (either in
common/rc or in tests).

> +			ret=$?
> +			;;
> +		*)
> +			_mount -t $FSTYP $*
> +			ret=$?
> +			;;
> +	esac
> +	return $ret
> +}
> +
>  # Call _mount to do mount operation but also save mountpoint to
>  # MOUNTED_POINT_STACK. Note that the mount point must be the last parameter
>  _get_mount()
> @@ -305,7 +325,7 @@ _supports_filetype()
>  	xfs)
>  		$XFS_INFO_PROG $dir | grep -q "ftype=1"
>  		;;
> -	ext2|ext3|ext4)
> +	ext2|ext3|ext4|fuse.ext4)
>  		local dev=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`
>  		tune2fs -l $dev | grep -q filetype
>  		;;
> @@ -328,7 +348,7 @@ _try_scratch_mount()
>  		_overlay_scratch_mount $*
>  		return $?
>  	fi
> -	_mount -t $FSTYP `_scratch_mount_options $*`
> +	_mount_fstyp `_scratch_mount_options $*`
>  }
>  
>  # mount scratch device with given options and _fail if mount fails
> @@ -400,7 +420,7 @@ _test_mount()
>          return $?
>      fi
>      _test_options mount
> -    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +    _mount_fstyp $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>  }
>  
>  _test_unmount()
> @@ -610,6 +630,9 @@ _test_mkfs()
>      btrfs)
>          $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
> +    fuse.ext4)
> +	$MKFS_PROG -t ext4 -- -F $MKFS_OPTIONS $* $TEST_DEV
> +	;;
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> @@ -641,7 +664,7 @@ _mkfs_dev()
>      btrfs)
>          $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
>  	;;
> -    ext2|ext3|ext4)
> +    ext2|ext3|ext4|fuse.ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* \

Introduce a new "fuse.ext4" case as in _test_mkfs(), otherwise we'll do
"mkfs -t fuse.ext4 ..." here.

>  		2>$tmp.mkfserr 1>$tmp.mkfsstd
>  	;;
> @@ -709,7 +732,7 @@ _scratch_mkfs()
>  		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>  		return 0
>  		;;
> -	ext4)
> +	ext4|fuse.ext4)
>  		_scratch_mkfs_ext4 $*
>  		return $?
>  		;;
> @@ -906,7 +929,7 @@ _scratch_mkfs_sized()
>      xfs)
>  	def_blksz=`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
>  	;;
> -    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2|reiserfs)
> +    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2|reiserfs|fuse.ext4)
>  	def_blksz=`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
>  	;;
>      jfs)
> @@ -943,6 +966,9 @@ _scratch_mkfs_sized()
>  		_scratch_mkfs_xfs -d size=$fssize -b size=$blocksize
>  	fi
>  	;;
> +    fuse.ext4)
> +	${MKFS_PROG}.ext4 -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
> +	;;
>      ext2|ext3|ext4|ext4dev)
>  	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
>  	;;
> @@ -1020,7 +1046,7 @@ _scratch_mkfs_geom()
>      xfs)
>  	MKFS_OPTIONS+=" -b size=$blocksize, -d su=$sunit_bytes,sw=$swidth_mult"
>  	;;
> -    ext4|ext4dev)
> +    ext4|ext4dev|fuse.ext4)
>  	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
>  	;;
>      *)
> @@ -1045,6 +1071,9 @@ _scratch_mkfs_blocksized()
>      xfs)
>  	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
>  	;;
> +    fuse.ext4)
> +	${MKFS_PROG}.ext4 -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
> +	;;
>      ext2|ext3|ext4)
>  	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
>  	;;
> @@ -1514,6 +1543,15 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	fuse.ext4)
> +		if [ ! -b "$SCRATCH_DEV" ] && [ ! -f "$SCRATCH_DEV" ]; then
> +		     _notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]
> +		then

Make "if" and "then" in the same line as in above if check.

> +		     _notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		 ;;
>  	*)
>  		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
>  		 then
> @@ -1635,6 +1673,15 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	fuse.ext4)
> +		if [ ! -b "$TEST_DEV" ] && [ ! -f "$TEST_DEV" ]; then
> +		     _notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]
> +		then

Same here.

> +		     _notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		 ;;
>  	*)
>  		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
>  		 then
> @@ -1961,7 +2008,7 @@ _filesystem_timestamp_range()
>  {
>  	local device=${1:-$TEST_DEV}
>  	case $FSTYP in
> -	ext4)
> +	ext4|fuse.ext4)
>  		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
>  			echo "-2147483648 15032385535"
>  		else
> @@ -2458,7 +2505,7 @@ _mount_or_remount_rw()
>  
>  	if [ $USE_REMOUNT -eq 0 ]; then
>  		if [ "$FSTYP" != "overlay" ]; then
> -			_mount -t $FSTYP $mount_opts $device $mountpoint
> +			_mount_fstyp $mount_opts $device $mountpoint

This (fuse2fs) won't remount the filesystem, mount command is still
needed here.

Thanks,
Eryu

>  		else
>  			_overlay_mount $device $mountpoint
>  		fi
> -- 
> 2.17.1
> 
