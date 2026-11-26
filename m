Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661040;
	b=PFmDjJUmLtolfZYbAu52LUS0J+jh1iSo6MwYEt88QpsvsojNdFO6FmbIk62Bq9cSpKm4
	 Bkv0yvf5FozzW8D13jP4VBuxPOjfG0Y4pVZ0qqRVF0Nj4NKlhlUntk6kN1WZt28I+uyV1
	 wjGIGsIxCZv4QXs1GOyuiHPyas6nzYehgm6etf3NKCzLvWK+YA2Of4OTMtfpGF5HUKeP3
	 scFb3k5r4QF4dlFeN0lYvtzQwAXENpV+2daU5t3Ln78lloOGDqYNXJwYBH5mxeK63EcG8
	 eYnDj+8mpyATbulYJAhlVMUFMj+RJZm1EACilOvhmB1L+Ucc+9cfUrQHVVgi/ZKCrdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661040;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=lz/EWl17W4qh5Fy/0QWWvFBH7U2qWk/cW54dVvefy2I=;
	b=VcT7szv+gatnk/GfexD3S4cVK+51iuw4dDSBSoBJgZN9+wJqtd53r8nnXRwQGmOXwEAP
	 POK6q3n2xCMFDQ3Ovy46uaqjt0IyXBtcW2Exzih4zlpPdx9Y48tZURP7I8F2mwF7fpkZJ
	 7i8vEJzAUku8xRNLJewhGCukVzizcae1DEGvrd482xGzgf9azFCnsX4RoPvA8SEIVBykj
	 mmcld467dgrIousHZEF67UL/ZnWyZGs/zG717da0X3QuuwvmsUGvFuKq4DUscUjju4xXh
	 fY+Isq1KWfTFZf/Fx5yA3xRDsQ/tF8keVdELSbpM/Dend1ztb2InxYKO581yeFQWuEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Bu4G/CV/";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1C606A333
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 02:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A1C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Bu4G/CV/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lz/EWl17W4qh5Fy/0QWWvFBH7U2qWk/cW54dVvefy2I=;
	b=Bu4G/CV/DkdOln7lvl1FGujHEU9ZloA3om8ELwrphVLurpnP1o/gvOUVGK1I4/
	A3j+Bfg9giIYkNBB9M7nMHQ+6ILUBfIuwNqLoEc0fAcj3SDZ2i9STVJLKthZSln0
	0/85rMUPJfl/zmC67Lvv3y4Nj5YLnPWdqtN4ZR3XZKDB8=
Received: from [IPV6:2409:8900:1fda:c14d:483b:2970:cae3:221a] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXFzXOnAdrUO3WKw--.11047S2;
	Thu, 26 Nov 2026 10:43:27 +0800 (CST)
Message-ID: <362ec779-2133-40ff-894b-d0d96a756828@163.com>
Date: Thu, 26 Nov 2026 10:43:26 +0800
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
Subject: Re: [PATCH 1/4] common: add support for the ntfs driver
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
 <20261125-ntfs-reproducers-v1-1-0cc67533d803@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125-ntfs-reproducers-v1-1-0cc67533d803@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXFzXOnAdrUO3WKw--.11047S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyxWry5uFy3XFWfKr4Durg_yoW7tr48pF
	yfCa43Kr48GF9xu3s3tr45Xa4rCwn3Jr1UKr17Wrn2grZ5tr1fAF42qrnY9F48Wry5Zr1v
	gw1kWas7GF9Iyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq0PhUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hD3wmsHnNBpYQAA3n



在 2026/11/26 03:03, Ernest Borowski via B4 Relay 写道:
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
> sectors and the block size as the cluster size unless MKFS_OPTIONS sets one
> (mkfs.ntfs refuses a second -c), check that mkfs.ntfs and fsck.ntfs are
> installed, and list ntfs among the filesystems without metadata journaling.
> Mount with -i, so that mount -t ntfs always uses the kernel driver and
> never a mount.ntfs helper.
> The check keeps the generic "fsck -t ntfs -n" path, which runs ntfsck.
> 
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   common/config |  9 +++++++++
>   common/rc     | 37 ++++++++++++++++++++++++++++++++++++-
>   2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 69e5d833..2b164c7d 100644
> --- a/common/config
> +++ b/common/config
> @@ -335,6 +335,7 @@ export MKFS_AFS_PROG="false"
>   export MKFS_CIFS_PROG="false"
>   export MKFS_OVERLAY_PROG="false"
>   export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> +export MKFS_NTFS_PROG=$(type -P mkfs.ntfs)
>   export E2FSCK_PROG=$(type -P e2fsck)
>   export TUNE2FS_PROG=$(type -P tune2fs)
>   export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
> @@ -409,6 +410,10 @@ _common_mount_opts()
>   	ubifs)
>   		echo $UBIFS_MOUNT_OPTIONS
>   		;;
> +	ntfs)
> +		# -i: always mount the kernel driver, never a mount.ntfs helper
> +		echo "-i $NTFS_MOUNT_OPTIONS"
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
> index 750a8d83..2c37bdb1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -904,6 +904,9 @@ _test_mkfs()
>       btrfs)
>           $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>   	;;
> +    ntfs)
> +	$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> +	;;
>       ext2|ext3|ext4)
>   	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>   	;;
> @@ -953,6 +956,9 @@ _try_mkfs_dev()
>       btrfs)
>           $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
>   	;;
> +    ntfs)
> +	$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $*
> +	;;
>       ext2|ext3|ext4)
>   	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
>   	;;
> @@ -1069,6 +1075,15 @@ _scratch_mkfs()
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
> @@ -1313,6 +1328,9 @@ _try_scratch_mkfs_sized()
>   		# If no block size is given by local.confg or parameter, blocksize_opt is empty.
>   		# Let MKFS_BCACHEFS_PROG decide block size on its own.
>   		;;
> +	ntfs)
> +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-c|--cluster-size)[ =]?+([0-9]+).*/\2/p'`
> +		;;
>   	esac
>   
>   	[ -n "$def_blksz" ] && blocksize=$def_blksz
> @@ -1425,6 +1443,16 @@ _try_scratch_mkfs_sized()
>   	bcachefs)
>   		$MKFS_BCACHEFS_PROG $MKFS_OPTIONS --fs_size=$fssize $blocksize_opt "$@" $SCRATCH_DEV
>   		;;
> +	ntfs)
> +		# mkfs.ntfs refuses a second -c, and takes the size in sectors
> +		# after the device
> +		local cluster_opt="-c $blocksize"
> +		local sector_size=`blockdev --getss $SCRATCH_DEV`
> +
> +		[ -n "$def_blksz" ] && cluster_opt=""
> +		$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $cluster_opt "$@" \
> +			$SCRATCH_DEV $((fssize / sector_size))
> +		;;

Hi Ernest,
    There is a mismatch here when -s/--sector-size is supplied. The 
calculation uses the device's logical sector size, while mkfs.ntfs 
interprets the sector count using the size specified by that option.
    For example, with 512-byte device sectors and MKFS_OPTIONS="-s 4096 
-c 4096", a 512 MiB request passes 1048576 sectors to mkfs, which it 
interprets as roughly 4 GiB.
    Could the calculation use the effective mkfs sector size, falling 
back to the device sector size when no override is given?

Thanks,
Baolin.

>   	*)
>   		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
>   		;;
> @@ -1517,6 +1545,13 @@ _scratch_mkfs_blocksized()
>   	udf)
>   		_scratch_mkfs -b $blocksize
>   		;;
> +	ntfs)
> +		# mkfs.ntfs refuses a second -c, so the size asked for here
> +		# replaces one in MKFS_OPTIONS
> +		MKFS_OPTIONS=$(echo $MKFS_OPTIONS | \
> +			sed -E 's/(-c|--cluster-size)[ =]?[0-9]+//') \
> +			_scratch_mkfs -c $blocksize
> +		;;
>   	*)
>   		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
>   		;;
> @@ -4386,7 +4421,7 @@ _has_metadata_journaling()
>   	fi
>   
>   	case "$FSTYP" in
> -	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
> +	ext2|vfat|msdos|udf|exfat|ntfs|tmpfs|hfs|hfsplus)
>   		echo "$FSTYP does not support metadata journaling"
>   		return 1
>   		;;
> 

