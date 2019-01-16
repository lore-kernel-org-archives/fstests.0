Received: from mail-pl1-f196.google.com ([209.85.214.196]:35077 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbfAPMJv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jan 2019 07:09:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so2955971plo.2
        for <fstests@vger.kernel.org>; Wed, 16 Jan 2019 04:09:50 -0800 (PST)
Date: Wed, 16 Jan 2019 20:09:41 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: add support for JFFS2
Message-ID: <20190116120941.GJ2713@desktop>
References: <20190104085309.89520-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104085309.89520-1-houtao1@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 04, 2019 at 04:53:09PM +0800, Hou Tao wrote:
> Mainly based on support for UBIFS, and there are two differences
> between them.

(Sorry for the late reivew..)

> 
> The major difference is the definitions of TEST_DEV and SCRATCH_DEV
> in local.config.
> 
> For UBIFS, TEST_DEV is something like /dev/ubi0_0. It's an UBI volume
> and mount program will handle it correctly. For JFFS2, we can use
> /dev/mtdblockX or mtdX, but can not use /dev/mtdX because mount program
> will complain it is a character device and refuse to mount it.
> 
> If /dev/mtdblockX is used, test cases for blkdev will be runnable for
> jffs2, but that will go against our intention because JFFS2 is a filesystem

I'm not familiar with jffs2, could you please give more details on this?
What problems have you seen when using /dev/mtdblockX as
TEST|SCRATCH_DEV? All the tests that have _require_block_device run for
jffs2 but they shouldn't?

If that's the case, I'd suggest to update the _require_block_device rule
to filter out jffs2 explicitly, so we don't have to special-case jffs2's
config.

> used for MTD character device and is not a block filesystem. So we choose
> to use mtdX as TEST_DEV & SCRATCH_DEV and take care of that during fs
> check/mount/umount.
> 
> The minor difference is the procedures of making file-system: JFFS2 is
> formatted by flash_erase instead of ubiupdatevol which is usedfor UBIFS.
> 
> Serveral bugs have already been spotted by it, especially the one found
> by generic/097.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  check         |  2 ++
>  common/config | 13 +++++++++++++
>  common/jffs2  | 23 +++++++++++++++++++++++
>  common/rc     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 common/jffs2
> 
> diff --git a/check b/check
> index e4d76737..6beef483 100755
> --- a/check
> +++ b/check
> @@ -60,6 +60,7 @@ check options
>      -pvfs2          test PVFS2
>      -tmpfs              test TMPFS
>      -ubifs              test ubifs
> +    -jffs2              test jffs2
>      -l			line mode diff
>      -udiff		show unified diff (default)
>      -n			show me, do not run tests
> @@ -264,6 +265,7 @@ while [ $# -gt 0 ]; do
>  	-pvfs2)		FSTYP=pvfs2 ;;
>  	-tmpfs)		FSTYP=tmpfs ;;
>  	-ubifs)		FSTYP=ubifs ;;
> +	-jffs2)		FSTYP=jffs2 ;;
>  
>  	-g)	group=$2 ; shift ;
>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> diff --git a/common/config b/common/config
> index fb664cf0..f9e932f1 100644
> --- a/common/config
> +++ b/common/config
> @@ -190,6 +190,7 @@ export MAN_PROG="$(type -P man)"
>  export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
>  export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
>  export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
> +export FLASH_ERASE_PROG="$(type -P flash_erase)"
>  export THIN_CHECK_PROG="$(type -P thin_check)"
>  export PYTHON2_PROG="$(type -P python2)"
>  export SQLITE3_PROG="$(type -P sqlite3)"
> @@ -320,6 +321,9 @@ _mount_opts()
>  	ubifs)
>  		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
>  		;;
> +	jffs2)
> +		export MOUNT_OPTIONS=$JFFS2_MOUNT_OPTIONS
> +		;;
>  	*)
>  		;;
>  	esac
> @@ -472,6 +476,15 @@ _check_device()
>  			_fatal "common/config: $name ($dev) is not a directory for overlay"
>  		fi
>  		;;
> +	jffs2)
> +		if ! grep -q "${dev}:" /proc/mtd &>/dev/null ; then
> +			_fatal "common/config: $name ($dev) is not a MTD device"
> +		fi
> +		dev=/dev/$dev
> +		if [ ! -c $dev ]; then
> +			_fatal "common/config: $name ($dev) is not a character device"
> +		fi
> +		;;
>  	ubifs)
>  		if [ ! -c "$dev" ]; then
>  			_fatal "common/config: $name ($dev) is not a character device"
> diff --git a/common/jffs2 b/common/jffs2
> new file mode 100644
> index 00000000..20611195
> --- /dev/null
> +++ b/common/jffs2
> @@ -0,0 +1,23 @@
> +_jffs2_scratch_mount()
> +{
> +	_scratch_options mount
> +	_mount -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> +		$SCRATCH_DEV $SCRATCH_MNT
> +}
> +
> +_jffs2_test_mount()
> +{
> +	_test_options mount
> +	_mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS \
> +		$SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +}

It seems that above helpers don't do anything special than the default
behavior in _test|scratch_mount() functions, they have the same commands
and options. Did I miss anything?

> +
> +_jffs2_scratch_unmount()
> +{
> +	$UMOUNT_PROG $SCRATCH_MNT
> +}
> +
> +_jffs2_test_unmount()
> +{
> +	$UMOUNT_PROG $TEST_DIR
> +}

We could just open-code $UMOUNT_PROG $TEST_DIR ($SCRATCH_MNT) in
_test|scratch_unmount(), then we could get rid of common/jffs2 file.

Thanks,
Eryu

> diff --git a/common/rc b/common/rc
> index b8ed1776..887f35ea 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -158,6 +158,10 @@ case "$FSTYP" in
>      ubifs)
>  	[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
>  	;;
> +	jffs2)
> +	[ "$FLASH_ERASE_PROG" = "" ] && _fatal "flash_erase not found"
> +	. ./common/jffs2
> +	;;
>  esac
>  
>  if [ ! -z "$REPORT_LIST" ]; then
> @@ -327,6 +331,9 @@ _try_scratch_mount()
>  	if [ "$FSTYP" == "overlay" ]; then
>  		_overlay_scratch_mount $*
>  		return $?
> +	elif [ "$FSTYP" == "jffs2" ]; then
> +		_jffs2_scratch_mount $*
> +		return $?
>  	fi
>  	_mount -t $FSTYP `_scratch_mount_options $*`
>  }
> @@ -346,6 +353,9 @@ _scratch_unmount()
>  	btrfs)
>  		$UMOUNT_PROG $SCRATCH_MNT
>  		;;
> +	jffs2)
> +		_jffs2_scratch_unmount
> +		;;
>  	*)
>  		$UMOUNT_PROG $SCRATCH_DEV
>  		;;
> @@ -398,6 +408,9 @@ _test_mount()
>      if [ "$FSTYP" == "overlay" ]; then
>          _overlay_test_mount $*
>          return $?
> +    elif [ "$FSTYP" == "jffs2" ]; then
> +        _jffs2_test_mount $*
> +        return $?
>      fi
>      _test_options mount
>      _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> @@ -407,6 +420,8 @@ _test_unmount()
>  {
>  	if [ "$FSTYP" == "overlay" ]; then
>  		_overlay_test_unmount
> +	elif [ "$FSTYP" == "jffs2" ]; then
> +		_jffs2_test_unmount
>  	else
>  		$UMOUNT_PROG $TEST_DEV
>  	fi
> @@ -709,6 +724,12 @@ _scratch_mkfs()
>  		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>  		return 0
>  		;;
> +	jffs2)
> +		# erase the whole MTD device for jffs2
> +		# it will be reformatted automatically on next mount
> +		$FLASH_ERASE_PROG -j -q /dev/${SCRATCH_DEV} 0 0
> +		return $?
> +		;;
>  	ext4)
>  		_scratch_mkfs_ext4 $*
>  		return $?
> @@ -1505,6 +1526,15 @@ _require_scratch_nocheck()
>  		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
>  		fi
>  		;;
> +	jffs2)
> +		# jffs2 needs a MTD device
> +		if [ ! -c "/dev/$SCRATCH_DEV" ]; then
> +			_notrun "this test requires a valid MTD device for \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	ubifs)
>  		# ubifs needs an UBI volume. This will be a char device, not a block device.
>  		if [ ! -c "$SCRATCH_DEV" ]; then
> @@ -1626,6 +1656,15 @@ _require_test()
>  		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
>  		fi
>  		;;
> +	jffs2)
> +		# jffs2 needs a MTD device
> +		if [ ! -c /dev/"$TEST_DEV" ]; then
> +			_notrun "this test requires a valid MTD device for \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	ubifs)
>  		# ubifs needs an UBI volume. This will be a char device, not a block device.
>  		if [ ! -c "$TEST_DEV" ]; then
> @@ -2624,6 +2663,9 @@ _check_test_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +	jffs2)
> +	# there is no fsck program for jffs2
> +	;;
>      *)
>  	_check_generic_filesystem $TEST_DEV
>  	;;
> @@ -2679,6 +2721,9 @@ _check_scratch_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    jffs2)
> +	# there is no fsck program for jffs2
> +	;;
>      *)
>  	_check_generic_filesystem $device
>  	;;
> -- 
> 2.16.2.dirty
> 
