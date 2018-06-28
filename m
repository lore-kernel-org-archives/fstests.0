Received: from mail.cn.fujitsu.com ([183.91.158.132]:61387 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751172AbeF1Bmp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 21:42:45 -0400
Message-ID: <5B343D10.8010005@cn.fujitsu.com>
Date: Thu, 28 Jun 2018 09:42:40 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] common: Add _dmsetup_create and _dmsetup_remove helpers
References: <20180627075435.GL13748@dastard> <1530096852-4165-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1530096852-4165-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>, david@fromorbit.com, guaneryu@gmail.com, dsterba@suse.com
List-ID: <fstests@vger.kernel.org>

On 2018/06/27 18:54, Xiao Yang wrote:
> Make sure both "$UDEV_SETTLE_PROG" and "mknodes" can always
> be run after a dm create or remove operation.
>
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/dmdelay     |  9 ++-------
>  common/dmerror     |  9 +++------
>  common/dmflakey    | 14 +++-----------
>  common/dmhugedisk  | 15 ++++++---------
>  common/dmlogwrites |  9 ++-------
>  common/dmthin      | 19 ++++++++-----------
>  common/rc          | 16 ++++++++++++++++
>  tests/generic/085  | 11 ++++-------
>  8 files changed, 44 insertions(+), 58 deletions(-)
>
> diff --git a/common/dmdelay b/common/dmdelay
> index b9e4b9b..f1e725b 100644
> --- a/common/dmdelay
> +++ b/common/dmdelay
> @@ -18,9 +18,8 @@ _init_delay()
>  	DELAY_DEV=/dev/mapper/delay-test
>  	DELAY_TABLE="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 0"
>  	DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 10000 $SCRATCH_DEV 0 0"
> -	$DMSETUP_PROG create delay-test --table "$DELAY_TABLE" || \
> +	_dmsetup_create delay-test --table "$DELAY_TABLE" || \
>  		_fatal "failed to create delay device"
> -	$DMSETUP_PROG mknodes > /dev/null 2>&1
>  }
>  
>  _mount_delay()
> @@ -41,11 +40,7 @@ _cleanup_delay()
>  	# otherwise the umount will hang
>  	$DMSETUP_PROG resume delay-test > /dev/null 2>&1
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> -	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> -	# fail due to EBUSY
> -	$UDEV_SETTLE_PROG >/dev/null 2>&1
> -	$DMSETUP_PROG remove delay-test > /dev/null 2>&1
> -	$DMSETUP_PROG mknodes > /dev/null 2>&1
> +	_dmsetup_remove delay-test
>  }
>  
>  # _load_delay_table <table> [lockfs]
> diff --git a/common/dmerror b/common/dmerror
> index 4d6b885..8c52e12 100644
> --- a/common/dmerror
> +++ b/common/dmerror
> @@ -25,8 +25,8 @@ _dmerror_setup()
>  _dmerror_init()
>  {
>  	_dmerror_setup
> -	$DMSETUP_PROG remove error-test > /dev/null 2>&1
> -	$DMSETUP_PROG create error-test --table "$DMLINEAR_TABLE" || \
> +	_dmsetup_remove error-test
> +	_dmsetup_create error-test --table "$DMLINEAR_TABLE" || \
>  		_fatal "failed to create dm linear device"
>  }
>  
> @@ -45,10 +45,7 @@ _dmerror_unmount()
>  _dmerror_cleanup()
>  {
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> -	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> -	# fail due to EBUSY
> -	$UDEV_SETTLE_PROG >/dev/null 2>&1
> -	$DMSETUP_PROG remove error-test > /dev/null 2>&1
> +	_dmsetup_remove error-test
>  }
>  
>  _dmerror_load_error_table()
> diff --git a/common/dmflakey b/common/dmflakey
> index 51eab16..2af3924 100644
> --- a/common/dmflakey
> +++ b/common/dmflakey
> @@ -20,9 +20,8 @@ _init_flakey()
>  	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
>  	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
>  	FLAKEY_TABLE_ERROR="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 error_writes"
> -	$DMSETUP_PROG create flakey-test --table "$FLAKEY_TABLE" || \
> +	_dmsetup_create flakey-test --table "$FLAKEY_TABLE" || \
>  		_fatal "failed to create flakey device"
> -	$DMSETUP_PROG mknodes > /dev/null 2>&1
>  }
>  
>  _mount_flakey()
> @@ -42,11 +41,7 @@ _cleanup_flakey()
>  	# otherwise the umount will hang
>  	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> -	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> -	# fail due to EBUSY
> -	$UDEV_SETTLE_PROG >/dev/null 2>&1
> -	$DMSETUP_PROG remove flakey-test > /dev/null 2>&1
> -	$DMSETUP_PROG mknodes > /dev/null 2>&1
> +	_dmsetup_remove flakey-test
>  }
>  
>  # _load_flakey_table <table> [lockfs]
> @@ -101,11 +96,8 @@ _require_flakey_with_error_writes()
>  	SIZE=`blockdev --getsz $SCRATCH_DEV`
>  	TABLE="0 $SIZE flakey $SCRATCH_DEV 0 0 180 1 error_writes"
>  
> -	$DMSETUP_PROG create $NAME --table "$TABLE" >/dev/null 2>&1
> -	if [ $? -ne 0 ]; then
> +	_dmsetup_create $NAME --table "$TABLE" || \
>  		_notrun "This test requires error_writes feature in dm-flakey"
> -	fi
> -	$DMSETUP_PROG mknodes >/dev/null 2>&1
>  
>  	_cleanup_flakey
>  }
> diff --git a/common/dmhugedisk b/common/dmhugedisk
> index 4d0406d..502f024 100644
> --- a/common/dmhugedisk
> +++ b/common/dmhugedisk
> @@ -20,8 +20,8 @@ _dmhugedisk_init()
>  		chunk_size=512
>  	fi
>  
> -	$DMSETUP_PROG remove huge-test > /dev/null 2>&1
> -	$DMSETUP_PROG remove huge-test-zero > /dev/null 2>&1
> +	_dmsetup_remove huge-test
> +	_dmsetup_remove huge-test-zero
>  
>  	local blk_dev_size=$1
>  
> @@ -31,18 +31,15 @@ _dmhugedisk_init()
>  	DMHUGEDISK_ZERO_TABLE="0 $blk_dev_size zero"
>  	DMHUGEDISK_DEV_TABLE="0 $blk_dev_size snapshot $DMHUGEDISK_ZERO $SCRATCH_DEV N $chunk_size"
>  
> -	$DMSETUP_PROG create huge-test-zero --table "$DMHUGEDISK_ZERO_TABLE" || \
> +	_dmsetup_create huge-test-zero --table "$DMHUGEDISK_ZERO_TABLE" || \
>  		_fatal "failed to create dm huge zero device"
> -	$DMSETUP_PROG create huge-test --table "$DMHUGEDISK_DEV_TABLE" || \
> +	_dmsetup_create huge-test --table "$DMHUGEDISK_DEV_TABLE" || \
>  		_fatal "failed to create dm huge device"
>  }
>  
>  _dmhugedisk_cleanup()
>  {
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> -	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> -	# fail due to EBUSY
> -	$UDEV_SETTLE_PROG >/dev/null 2>&1
> -	$DMSETUP_PROG remove huge-test > /dev/null 2>&1
> -	$DMSETUP_PROG remove huge-test-zero > /dev/null 2>&1
> +	_dmsetup_remove huge-test
> +	_dmsetup_remove huge-test-zero
>  }
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 9963bd9..b9cbae7 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -51,9 +51,8 @@ _log_writes_init()
>  	LOGWRITES_NAME=logwrites-test
>  	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
>  	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $SCRATCH_DEV $LOGWRITES_DEV"
> -	$DMSETUP_PROG create $LOGWRITES_NAME --table "$LOGWRITES_TABLE" || \
> +	_dmsetup_create $LOGWRITES_NAME --table "$LOGWRITES_TABLE" || \
>  		_fail "failed to create log-writes device"
> -	$DMSETUP_PROG mknodes > /dev/null 2>&1
>  }
>  
>  _log_writes_mark()
> @@ -100,16 +99,12 @@ _log_writes_replay_log()
>  
>  _log_writes_remove()
>  {
> -	$DMSETUP_PROG remove $LOGWRITES_NAME > /dev/null 2>&1
> -	$DMSETUP_PROG mknodes > /dev/null 2>&1
> +	_dmsetup_remove $LOGWRITES_NAME
>  }
>  
>  _log_writes_cleanup()
>  {
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> -	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> -	# fail due to EBUSY
> -	$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	_log_writes_remove
>  }
>  
> diff --git a/common/dmthin b/common/dmthin
> index 039d63e..7946e9a 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -29,13 +29,10 @@ fi
>  _dmthin_cleanup()
>  {
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> -	# wait for device to be fully settled so that 'dmsetup remove' doesn't
> -	# fail due to EBUSY
> -	$UDEV_SETTLE_PROG >/dev/null 2>&1
> -	$DMSETUP_PROG remove $DMTHIN_VOL_NAME> /dev/null 2>&1
> -	$DMSETUP_PROG remove $DMTHIN_POOL_NAME> /dev/null 2>&1
> -	$DMSETUP_PROG remove $DMTHIN_META_NAME> /dev/null 2>&1
> -	$DMSETUP_PROG remove $DMTHIN_DATA_NAME> /dev/null 2>&1
> +	_dmsetup_remove $DMTHIN_VOL_NAME
> +	_dmsetup_remove $DMTHIN_POOL_NAME
> +	_dmsetup_remove $DMTHIN_META_NAME
> +	_dmsetup_remove $DMTHIN_DATA_NAME
>  }
>  
>  _dmthin_check_fs()
> @@ -112,13 +109,13 @@ _dmthin_init()
>  
>  	# Metadata device
>  	DMTHIN_META_TABLE="0 $meta_dev_size linear $dm_backing_dev $meta_dev_offset"
> -	$DMSETUP_PROG create $DMTHIN_META_NAME --table "$DMTHIN_META_TABLE" || \
> +	_dmsetup_create $DMTHIN_META_NAME --table "$DMTHIN_META_TABLE" || \
>  		_fatal "failed to create dm thin meta device"
>  
>  	# Data device
>  	local data_dev_offset=$((meta_dev_offset + $meta_dev_size))
>  	DMTHIN_DATA_TABLE="0 $data_dev_size linear $dm_backing_dev $data_dev_offset"
> -	$DMSETUP_PROG create $DMTHIN_DATA_NAME --table "$DMTHIN_DATA_TABLE" || \
> +	_dmsetup_create $DMTHIN_DATA_NAME --table "$DMTHIN_DATA_TABLE" || \
>  		_fatal "failed to create dm thin data device"
>  
>  	# Zap the pool metadata dev
> @@ -127,7 +124,7 @@ _dmthin_init()
>  	# Thin pool
>  	# "start length thin-pool metadata_dev data_dev data_block_size low_water_mark"
>  	DMTHIN_POOL_TABLE="0 $data_dev_size thin-pool $DMTHIN_META_DEV $DMTHIN_DATA_DEV $cluster_size $low_water"
> -	$DMSETUP_PROG create $DMTHIN_POOL_NAME --table "$DMTHIN_POOL_TABLE" || \
> +	_dmsetup_create $DMTHIN_POOL_NAME --table "$DMTHIN_POOL_TABLE" || \
>  		_fatal "failed to create dm thin pool device"
>  
>  	# Thin volume
> @@ -136,7 +133,7 @@ _dmthin_init()
>  
>  	# start length thin pool_dev dev_id [external_origin_dev]
>  	DMTHIN_VOL_TABLE="0 $virtual_size thin $DMTHIN_POOL_DEV $pool_id"
> -	$DMSETUP_PROG create $DMTHIN_VOL_NAME --table "$DMTHIN_VOL_TABLE" || \
> +	_dmsetup_create $DMTHIN_VOL_NAME --table "$DMTHIN_VOL_TABLE" || \
>  		_fatal "failed to create dm thin volume device"
>  
>  }
> diff --git a/common/rc b/common/rc
> index 1945066..ba2126a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3794,6 +3794,22 @@ _require_label_get_max()
>  	dummy=$(_label_get_max)
>  }
>  
> +_dmsetup_remove()
> +{
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
> +	$DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
> +	$DMSETUP_PROG mknodes >/dev/null 2>&1
> +}
> +
> +_dmsetup_create()
> +{
> +	local ret=0
> +	$DMSETUP_PROG create "$@" >>$seqres.full 2>&1 || ret=1
> +	$DMSETUP_PROG mknodes >/dev/null 2>&1
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
> +	return $ret
> +}
Hi,

Sorry, it is unnecessary to call "$UDEV_SETTLE_PROG" and "mknodes" if
dm device failed to be created. I will send v3 patch soon.

Thanks,
Xiao Yang
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/085 b/tests/generic/085
> index bed1e0d..31226c8 100755
> --- a/tests/generic/085
> +++ b/tests/generic/085
> @@ -31,9 +31,7 @@ cleanup_dmdev()
>  	# in case it's still suspended and/or mounted
>  	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
>  	$UMOUNT_PROG $lvdev >/dev/null 2>&1
> -
> -	$DMSETUP_PROG remove $node >>$seqres.full 2>&1
> -	$DMSETUP_PROG mknodes >/dev/null 2>&1
> +	_dmsetup_remove $node
>  }
>  
>  # get standard environment, filters and checks
> @@ -51,9 +49,8 @@ _require_freeze
>  setup_dmdev()
>  {
>  	table="0 $size_in_sector linear $SCRATCH_DEV 0"
> -	$DMSETUP_PROG create $node --table "$table" >>$seqres.full 2>&1 && \
> -	$DMSETUP_PROG mknodes >/dev/null 2>&1
> -	return $?
> +	_dmsetup_create $node --table "$table" || \
> +		_fail "setup dm device failed"
>  }
>  
>  rm -f $seqres.full
> @@ -65,7 +62,7 @@ _scratch_mkfs_sized $size >>$seqres.full 2>&1
>  
>  node=$seq-test
>  lvdev=/dev/mapper/$node
> -setup_dmdev || _fail "setup dm device failed"
> +setup_dmdev
>  
>  # take use of dmsetup suspend to freeze the fs.
>  # xfs_freeze/fsfreeze cannot be used in this test, because it can possibly



