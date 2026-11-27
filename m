Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778768;
	b=iLBasfipKUaLAYeiZenvLFZL7XDN0li7VaoapCrgRUsPInTxoPADkQrKC5BLQmsJi61X
	 1laLeLeViuoyTOwFTEjkO7L7GMoG8Qs87ZkmvjmnsTWwWHEJykL+pmAFhj23S8F4iBrTG
	 PU9ElEI4qn7ST3TG2C1s4YANYcsMLX4R/0Be3RrJ8GBIeHrvwdFHE5cMZYQ0I/Q7R6WQ5
	 71giyCVmgGo6ka/ZHIMTv0A11djVBTxtL8WGTrSfG+dppY5SoMXh3nFKk9IdOZ5f80i1f
	 nmpdcrOEHhSKB7y5sH9a+V2LTJVUQPUXDRIY12s54q++q/ksIpPvSaZ/35U1X4dYAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778768;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=YW06WKoK89TiwPlf+zCnKNWkno6f1puL10q0E/OW7l8=;
	b=gNjIZXnhNDGGFg1n2Z/+/0CsVhcO/AVwyMDAtwZfJG0qLlxiSs+nuM6Q4HktLpTEPgQz
	 GK25WnjItIXG15urgJykPl4ZIOdQhuboNJNJjHDjbfWdv9zSRQHHtluh5o4lqiSwGcdhp
	 2okiOs/tJMrDSVcGWN1Vmg/2GePPgqUt0T8P3NE9ZEhIYPyOEQc8HeiLw1VEjtPQY2sgF
	 BvaBAU2SR5lrUAIuotQNVEPIHVimdpqHDT94ve5x1h7338SOI2Ro+WyA+gorr3CnwH0xt
	 1QwAabQDF9xFNUuVrRnY53ViSxZSe6bewjaH8xvCB+zC5gFSv5LSjqxBpJBTyLLjz3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z0H15JT4;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F8606A681
	for <fstests@vger.kernel.org>; Fri, 27 Nov 2026 11:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94F8606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z0H15JT4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YW06WKoK89TiwPlf+zCnKNWkno6f1puL10q0E/OW7l8=;
	b=Z0H15JT4yhqMDIe7P8mAijNuwmMBz8BDhswKGihmbvoFC1VO0aJNDh0nOU6up9
	MlyGnj9ewFzXKOBki4J6JpM9OkdALqsGqxz+c2cFpXE40pmriVycj5Drpbf4AVVn
	J7vk/iGBzKaLkNmHAaH3Zuyqw5lYZbBtcZBkbDtHAG9BY=
Received: from [IPV6:2409:8900:1fda:c14d:49cd:379b:bab1:5955] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3f+KXaAlraN7eLQ--.13998S2;
	Fri, 27 Nov 2026 19:25:14 +0800 (CST)
Message-ID: <99f7fc52-f97d-44a7-82cd-2ba60f7d28e6@163.com>
Date: Fri, 27 Nov 2026 19:25:11 +0800
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] common: add support for the ntfs driver
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
 <20261126-ntfs-reproducers-v2-1-7d5fa5a688b9@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261126-ntfs-reproducers-v2-1-7d5fa5a688b9@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+KXaAlraN7eLQ--.13998S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyxWry5uF1xKw15JF4kCrg_yoWxCr4DpF
	yfCa43KrW8GrnrX3s3ta13Xa45Cwn3tF1jgr17Ww12grZ5trn7JF42qF1F9F4jgrZ8Zr4F
	9w1kW3s7WasIyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTCJQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RtdKGsJaJs-pAAA3N



在 2026/11/27 04:29, Ernest Borowski via B4 Relay 写道:
> From: Ernest Borowski <ernest.borowski.git@proton.me>
> 
> Volumes for the ntfs driver (fs/ntfs) are made and checked with mkfs.ntfs
> and fsck.ntfs from ntfsprogs-plus, but FSTYP=ntfs only gets the generic
> fallbacks today. mkfs.ntfs zeroes the whole device unless it is given
> --quick and refuses a device that is not a partition unless it is given
> --force, _scratch_mkfs_sized and _scratch_mkfs_blocksized skip every test
> that calls them, and the tests that require metadata journaling run
> although the driver only checks and empties $LogFile at mount and never
> logs a change. Call mkfs.ntfs directly with --quick and --force and filter
> its warnings about the device geometry, pass the size to mkfs.ntfs in
> sectors of the size -s gives, or else of the device's, and the block size
> as the cluster size unless MKFS_OPTIONS sets one (mkfs.ntfs refuses a
> second -c), check that mkfs.ntfs and fsck.ntfs are installed, and list ntfs
> among the filesystems without metadata journaling.
> Pass -i in _mount() when FSTYP, or the base filesystem under overlayfs,
> is ntfs, so that every mount and remount uses the kernel driver and never
> a mount.ntfs helper, whatever the mount options are.
> The check keeps the generic "fsck -t ntfs -n" path, which runs ntfsck.
> 
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   common/config |  9 +++++++++
>   common/rc     | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 69e5d833..8d5c7178 100644
> --- a/common/config
> +++ b/common/config
> @@ -335,6 +335,8 @@ export MKFS_AFS_PROG="false"
>   export MKFS_CIFS_PROG="false"
>   export MKFS_OVERLAY_PROG="false"
>   export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> +# shellcheck disable=SC2155 # written like the other _PROG lines
> +export MKFS_NTFS_PROG=$(type -P mkfs.ntfs)
>   export E2FSCK_PROG=$(type -P e2fsck)
>   export TUNE2FS_PROG=$(type -P tune2fs)
>   export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
> @@ -409,6 +411,9 @@ _common_mount_opts()
>   	ubifs)
>   		echo $UBIFS_MOUNT_OPTIONS
>   		;;
> +	ntfs)
> +		echo "$NTFS_MOUNT_OPTIONS"
> +		;;
>   	*)
>   		;;
>   	esac
> @@ -550,6 +555,10 @@ _source_specific_fs()
>   		;;
>   	pvfs2)
>   		;;
> +	ntfs)
> +		[ "$MKFS_NTFS_PROG" = "" ] && _fatal "mkfs.ntfs not found"
> +		type -P fsck.ntfs >/dev/null || _fatal "fsck.ntfs not found"
> +		;;
>   	ubifs)
>   		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
>   		. ./common/ubifs
> diff --git a/common/rc b/common/rc
> index 750a8d83..891ca779 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -310,10 +310,16 @@ _has_dmesg_since_option()
>   
>   _mount()
>   {
> -	$MOUNT_PROG "$@"
> +	local opts=()
> +
> +	# mount(8) hands an ntfs mount to a mount.ntfs helper when one is
> +	# installed; -i keeps every mount and remount on the kernel driver,
> +	# including the base filesystem under overlayfs
> +	[ "$FSTYP" = "ntfs" ] || [ "$OVL_BASE_FSTYP" = "ntfs" ] && opts=(-i)
> +	$MOUNT_PROG "${opts[@]}" "$@"
>   	ret=$?
>   	if [ "$ret" -ne 0 ]; then
> -		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
> +		echo "\"$MOUNT_PROG ${opts[*]} $*\" failed at $(date)" >> "$seqres.mountfail?"
>   		if _has_dmesg_since_option; then
>   			dmesg --since '30s ago' >> "$seqres.mountfail?"
>   		else
> @@ -904,6 +910,10 @@ _test_mkfs()
>       btrfs)
>           $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>   	;;
> +    ntfs)
> +	# shellcheck disable=SC2048,SC2086 # one word may hold several options
> +	$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $* "$TEST_DEV" > /dev/null
> +	;;
>       ext2|ext3|ext4)
>   	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>   	;;
> @@ -953,6 +963,10 @@ _try_mkfs_dev()
>       btrfs)
>           $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
>   	;;
> +    ntfs)
> +	# shellcheck disable=SC2048,SC2086 # one word may hold several options
> +	$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $*
> +	;;
>       ext2|ext3|ext4)
>   	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
>   	;;
> @@ -1069,6 +1083,15 @@ _scratch_mkfs()
>   		mkfs_cmd="$MKFS_BCACHEFS_PROG"
>   		mkfs_filter="cat"
>   		;;
> +	ntfs)
> +		# --quick skips zeroing the whole device, --force formats a
> +		# device that is not a partition; drop the warnings about that
> +		# and about the boot geometry of such a device
> +		mkfs_cmd="$MKFS_NTFS_PROG --quick --force"
> +		mkfs_filter="grep -v -e \"is entire device\" -e \"forced anyway\""
> +		mkfs_filter+=" -e \"could not be obtained automatically\""
> +		mkfs_filter+=" -e \"boot from\""
> +		;;
>   	*)
>   		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>   		mkfs_filter="cat"
> @@ -1313,6 +1336,9 @@ _try_scratch_mkfs_sized()
>   		# If no block size is given by local.confg or parameter, blocksize_opt is empty.
>   		# Let MKFS_BCACHEFS_PROG decide block size on its own.
>   		;;
> +	ntfs)
> +		def_blksz=$(echo "$MKFS_OPTIONS" | sed -rn 's/(.* )?(-c|--cluster-size)[ =]?([0-9]+).*/\3/p')
> +		;;
>   	esac
>   
>   	[ -n "$def_blksz" ] && blocksize=$def_blksz
> @@ -1425,6 +1451,19 @@ _try_scratch_mkfs_sized()
>   	bcachefs)
>   		$MKFS_BCACHEFS_PROG $MKFS_OPTIONS --fs_size=$fssize $blocksize_opt "$@" $SCRATCH_DEV
>   		;;
> +	ntfs)
> +		# mkfs.ntfs refuses a second -c, and takes the size after the
> +		# device, in sectors of the size -s gives or else of the device's
> +		local cluster_opt=(-c "$blocksize")
> +		local sector_size
> +
> +		sector_size=$(echo "$MKFS_OPTIONS" | sed -rn 's/(.* )?(-s|--sector-size)[ =]?([0-9]+).*/\3/p')
> +		[ -n "$sector_size" ] || sector_size=$(blockdev --getss "$SCRATCH_DEV")
> +		[ -n "$def_blksz" ] && cluster_opt=()
> +		# shellcheck disable=SC2086 # MKFS_OPTIONS holds several options
> +		$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS "${cluster_opt[@]}" "$@" \
> +			"$SCRATCH_DEV" $((fssize / sector_size))
> +		;;
>   	*)
>   		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
>   		;;
> @@ -1517,6 +1556,13 @@ _scratch_mkfs_blocksized()
>   	udf)
>   		_scratch_mkfs -b $blocksize
>   		;;
> +	ntfs)
> +		# mkfs.ntfs refuses a second -c, so the size asked for here
> +		# replaces one in MKFS_OPTIONS
> +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | \
> +			sed -E 's/(^| )(-c|--cluster-size)[ =]?[0-9]+//') \
> +			_scratch_mkfs -c "$blocksize"
> +		;;
>   	*)
>   		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
>   		;;
> @@ -4386,7 +4432,7 @@ _has_metadata_journaling()
>   	fi
>   
>   	case "$FSTYP" in
> -	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
> +	ext2|vfat|msdos|udf|exfat|ntfs|tmpfs|hfs|hfsplus)
>   		echo "$FSTYP does not support metadata journaling"
>   		return 1
>   		;;
> 

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

