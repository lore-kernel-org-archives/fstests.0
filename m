Received: from mx1.redhat.com ([209.132.183.28]:45036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752875AbdKUGHQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Nov 2017 01:07:16 -0500
Date: Tue, 21 Nov 2017 14:07:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: update _require_dm_target() helper
Message-ID: <20171121060714.GM2749@eguan.usersys.redhat.com>
References: <1511236671-5835-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511236671-5835-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 21, 2017 at 11:57:51AM +0800, Xiao Yang wrote:
> 1) generic/459 should be skipped when dm_snapshot is not supported.
> 2) update _require_dm_target() to handle multiple dm targets
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/dmhugedisk            |  3 +--
>  common/rc                    | 16 ++++++++--------
>  doc/requirement-checking.txt |  6 +++---
>  tests/generic/459            |  2 +-
>  4 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/common/dmhugedisk b/common/dmhugedisk
> index 4d3b63f..1c116c2 100644
> --- a/common/dmhugedisk
> +++ b/common/dmhugedisk
> @@ -23,8 +23,7 @@
>  
>  _require_dmhugedisk()
>  {
> -	_require_dm_target zero
> -	_require_dm_target snapshot
> +	_require_dm_target zero snapshot
>  }
>  
>  _dmhugedisk_init()
> diff --git a/common/rc b/common/rc
> index 4c053a5..6fe0ce9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1782,23 +1782,23 @@ _require_sane_bdev_flush()
>  	fi
>  }
>  
> -# this test requires a specific device mapper target
> +# this test requires specific device mapper targets
>  _require_dm_target()
>  {
> -	_target=$1
> -
>  	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
>  	# behaviour
>  	_require_block_device $SCRATCH_DEV
>  	_require_sane_bdev_flush $SCRATCH_DEV
>  	_require_command "$DMSETUP_PROG" dmsetup
>  
> -	modprobe dm-$_target >/dev/null 2>&1
> +	for _target in "$@"; do
> +		modprobe dm-$_target >/dev/null 2>&1
>  
> -	$DMSETUP_PROG targets 2>&1 | grep -q ^$_target
> -	if [ $? -ne 0 ]; then
> -		_notrun "This test requires dm $_target support"
> -	fi
> +		$DMSETUP_PROG targets 2>&1 | grep -q ^$_target
> +		if [ $? -ne 0 ]; then
> +			_notrun "This test requires dm $_target support"
> +		fi
> +	done
>  }
>  
>  # this test requires the ext4 kernel support crc feature on scratch device
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index 4e01b1f..e27aacd 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -112,10 +112,10 @@ _require_statx
>  DEVICE MAPPER REQUIREMENTS
>  ==========================
>  
> -_require_dm_target <name>
> +_require_dm_target <name1> <name2> ...
>  
> -     The test requires the use of the device mapper target and will be skipped
> -     if it isn't available in the kernel.
> +     The test requires the use of the device mapper targets and will be skipped
> +     if any one isn't available in the kernel.
>  
>  _require_log_writes
>  
> diff --git a/tests/generic/459 b/tests/generic/459
> index d1ad372..e3ac374 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -61,7 +61,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_nocheck
> -_require_dm_target thin-pool
> +_require_dm_target thin-pool snapshot

Hmm, why not just add another "_require_dm_target snapshot"? That's much
simpler to do and keeps the helper simple too. (We may add parameters
support to _require_dm_target in the future, there're already patches
trying to do so, I think keeping it simple avoids future conflicts and
complexity too).

Thanks,
Eryu

>  _require_command $LVM_PROG lvm
>  _require_command "$THIN_CHECK_PROG" thin_check
>  _require_freeze
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
