Received: from mx1.redhat.com ([209.132.183.28]:48326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbdEQLyD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 May 2017 07:54:03 -0400
Date: Wed, 17 May 2017 19:53:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] Add support for UBIFS
Message-ID: <20170517115355.GE7250@eguan.usersys.redhat.com>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
 <20170517095531.11818-2-david.oberhollenzer@sigma-star.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517095531.11818-2-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at
List-ID: <fstests@vger.kernel.org>

On Wed, May 17, 2017 at 11:55:29AM +0200, David Oberhollenzer wrote:
> This patch is mostly based on the previous attempts of Eric Biggers
> and Dongsheng Yang at adding UBIFS support to xfstests.
> 
> In addition to rebasing the previous attempts to recent xfstests,
> most of the encryption tests now also support UBIFS with this patch.
> 
> Since mkfs.ubifs doesn't support creating encryption-capable filesystems
> yet, _scratch_mkfs_encrypted() is modified to wipe the underlying UBI
> volume. The filesystem is then created when mounting the emtpy volume.
> 
> Some tests that require SCRATCH_DEV to be a block device, despite
> not using device-mapper or otherwise doing something block device
> specific have that requirement removed.
> 
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>

Thanks for the patch! I know only very little about ubifs (from previous
reviews to attempts to add ubifs support to fstests), but it's still
good to have some words to introduce ubifs briefly in commit log,
especially the fact that it uses char device not block device.

> ---
>  check             |  2 ++
>  common/config     |  7 +++++++
>  common/encrypt    |  3 +++
>  common/rc         | 24 ++++++++++++++++++++++++
>  tests/generic/076 |  1 -
>  tests/generic/409 |  1 -
>  tests/generic/410 |  1 -
>  tests/generic/411 |  1 -
>  8 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/check b/check
> index 9cef58b4..f8db3cd6 100755
> --- a/check
> +++ b/check
> @@ -70,6 +70,7 @@ check options
>      -overlay		test overlay
>      -pvfs2          test PVFS2
>      -tmpfs              test TMPFS
> +    -ubifs              test ubifs
>      -l			line mode diff
>      -udiff		show unified diff (default)
>      -n			show me, do not run tests
> @@ -267,6 +268,7 @@ while [ $# -gt 0 ]; do
>  	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
>  	-pvfs2)		FSTYP=pvfs2 ;;
>  	-tmpfs)		FSTYP=tmpfs ;;
> +	-ubifs)		FSTYP=ubifs ;;

As being pointed out in previous reviews, it'll be great if we can probe
ubifs from the char device if possible instead of adding new fs-specific
option, just as what we're doing at the end of common/config for other
local filesystems. But I'm not sure if blkid works for char device and
ubifs (probably not).

>  
>  	-g)	group=$2 ; shift ;
>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> diff --git a/common/config b/common/config
> index 59041a39..6c58e888 100644
> --- a/common/config
> +++ b/common/config
> @@ -336,6 +336,9 @@ _mount_opts()
>  		# We need to specify the size at mount, use 1G by default
>  		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
>  		;;
> +	ubifs)
> +		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
> +		;;
>  	*)
>  		;;
>  	esac
> @@ -475,6 +478,10 @@ _check_device()
>  		if [ ! -d "$dev" ]; then
>  			_fatal "common/config: $name ($dev) is not a directory for overlay"
>  		fi
> +	elif [ "$FSTYP" == "ubifs" ]; then
> +		if [ ! -c "$dev" ]; then
> +			_fatal "common/config: $name ($dev) is not a character device"
> +		fi
>  	else
>  		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"

This error message should be updated too. And turning this if-elif-fi
block to a case switch on $FSTYP seems cleaner.

And you need to setup MKFS_UBIFS_PROG and all other needed tools in
common/config too, and check if the tools are available in common/rc and
abort if the required tools are not met. e.g.

[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"

>  	fi
> diff --git a/common/encrypt b/common/encrypt
> index 723f1b11..b444c82d 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -71,6 +71,9 @@ _scratch_mkfs_encrypted()
>  	ext4|f2fs)
>  		_scratch_mkfs -O encrypt
>  		;;
> +	ubifs)
> +		ubiupdatevol ${SCRATCH_DEV} -t
> +		;;

Need a commont on this.

>  	*)
>  		_notrun "No encryption support for $FSTYP"
>  		;;
> diff --git a/common/rc b/common/rc
> index 257b1903..6191a0c0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1556,6 +1556,15 @@ _require_scratch_nocheck()
>  		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
>  		fi
>  		;;
> +	ubifs)
> +		# ubifs needs an UBI volume. This will be a char device, not a block device.
> +		if [ ! -c "$SCRATCH_DEV" ]; then
> +			_notrun "this test requires a valid UBI volume for \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	*)
>  		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
>  		 then
> @@ -1650,6 +1659,15 @@ _require_test()
>  		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
>  		fi
>  		;;
> +	ubifs)
> +		# ubifs needs an UBI volume. This will be a char device, not a block device.
> +		if [ ! -c "$TEST_DEV" ]; then
> +			_notrun "this test requires a valid UBI volume for \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	*)
>  		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
>  		 then
> @@ -2490,6 +2508,9 @@ _check_test_fs()
>      tmpfs)
>  	# no way to check consistency for tmpfs
>  	;;
> +    ubifs)
> +	# there is no fsck program for ubifs yet
> +	;;
>      *)
>  	_check_generic_filesystem $TEST_DEV
>  	;;
> @@ -2539,6 +2560,9 @@ _check_scratch_fs()
>      tmpfs)
>  	# no way to check consistency for tmpfs
>  	;;
> +    ubifs)
> +	# there is no fsck program for ubifs yet
> +	;;
>      *)
>  	_check_generic_filesystem $device
>  	;;
> diff --git a/tests/generic/076 b/tests/generic/076
> index 64e69583..53e56a69 100755
> --- a/tests/generic/076
> +++ b/tests/generic/076
> @@ -56,7 +56,6 @@ _supported_fs generic
>  _supported_os IRIX Linux
>  
>  _require_scratch
> -_require_block_device $SCRATCH_DEV

This test does "cat $SCRATCH_DEV >/dev/null &" which assumes
$SCRATCH_DEV is a local device, and test fails if it's a network device,
or an overlayfs pseudo mount device. And similarly generic/409 to
generic/411 fail if SCRATCH_DEV is a overlay pseudo mount device.

So I think what's needed here is a new helper that requires a local
device to make sure the given device resides on local host and is either
block or char device, e.g. something like

_require_local_device $SCRATCH_DEV

Thanks,
Eryu

>  
>  echo "*** init fs"
>  
> diff --git a/tests/generic/409 b/tests/generic/409
> index 4bfedf73..3be58ba5 100755
> --- a/tests/generic/409
> +++ b/tests/generic/409
> @@ -64,7 +64,6 @@ _supported_fs generic
>  _supported_os Linux
>  _require_test
>  _require_scratch
> -_require_block_device $SCRATCH_DEV
>  
>  fs_stress()
>  {
> diff --git a/tests/generic/410 b/tests/generic/410
> index f2e0d1bb..e3a933ce 100755
> --- a/tests/generic/410
> +++ b/tests/generic/410
> @@ -72,7 +72,6 @@ _supported_fs generic
>  _supported_os Linux
>  _require_test
>  _require_scratch
> -_require_block_device $SCRATCH_DEV
>  
>  fs_stress()
>  {
> diff --git a/tests/generic/411 b/tests/generic/411
> index 7b2dd33b..08b861c5 100755
> --- a/tests/generic/411
> +++ b/tests/generic/411
> @@ -53,7 +53,6 @@ _supported_fs generic
>  _supported_os Linux
>  _require_test
>  _require_scratch
> -_require_block_device $SCRATCH_DEV
>  
>  fs_stress()
>  {
> -- 
> 2.12.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
