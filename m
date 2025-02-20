Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99B1DDC14
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082963; cv=none; b=RYOmrymnbUw7DrmwX4Q58KgEiN7coZbst+lFNBmHZEwD5hxX2UJJb9qnwdvblMG47E1kAnubwSV1yIGPVm7GJzJb28DQWZaLWLCSWlUb/N33BCXjcTDiUa5xkUZGi4rIS8DMWIxVWIPTOvyfVloUqVIPHD28wMHEIyQWbxiE1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082963; c=relaxed/simple;
	bh=38wM1UmCZz1S9CX7vcCcLuqR7TYM9p7MuzXheMuF+So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQFDiuRfJ4iYKXdgSEzrTwZ31YoayoNbeSc+P9nnKu7b9X5xRNPE6ZMwFnEZZuJVx4bGPXUWlvPc/gEN3mc64ystxBu/4/shQekDDgVibUV6uRXBoMPlfK0PM1/6BFtBRX2BsTegV4GgaXRmQq/28I0HxYfg3+RLxMf8KByFjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcr7E4Rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcr7E4Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68BC4CED1;
	Thu, 20 Feb 2025 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740082962;
	bh=38wM1UmCZz1S9CX7vcCcLuqR7TYM9p7MuzXheMuF+So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcr7E4RnyxR2xHdHYYi6foXwDLQ1yrLcmUTj1w9idKJ+KdXO/CZ0H2DmafIAV8clx
	 XlM7QLQiF4wRfmKcwg7CuYVpX1caRMTtXhSpeeS2JzuW5gKnTpOssCnxq15QrF0LqX
	 WueyNEGolasdXZoE8yJ0oUaIpbleEE4W3WwbbkErCo4Ih3tnsMLJGJ0yTLr7weyFh2
	 jCy1Ipa5F4jl20Aa3fu5+FZkvBQQ7C29ecO1J5bFxehlbPcPiwNa2l18OuT07TzkiF
	 v9gW5XvVmKO8J/KfaOb5LrwG93wX2YFgj8si0tG/jzAqbShcCcPiNDkFi82/gqPRU4
	 D8KiVSZW1WTiQ==
Date: Fri, 21 Feb 2025 04:22:38 +0800
From: Zorro Lang <zlang@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250219221743.20161-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219221743.20161-1-dsterba@suse.com>

On Wed, Feb 19, 2025 at 11:17:43PM +0100, David Sterba wrote:
> The linux kernel removed Reiserfs support in 6.13 so remove it from the
> tests as well.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> Arguably reiser4 support could be removed as well as there's no recent
> upstream activity.

Thanks for doing this :) But even with this patch, I still can find more
"reiser*" related things as below. How about removing them all?

zorro@zlang-laptop:~/git/upstream/xfs/xfstests-dev$ grep -rsni reiser .
./common/config:330:export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
./common/config:390:       reiser4)
./common/config:391:            # acls & xattrs aren't supported by reiser4
./common/config:392:            echo $REISER4_MOUNT_OPTIONS
./common/config:443:       reiser4)
./common/config:444:            export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
./common/config:472:    reiser*)
./common/config:540:    reiser4)
./common/config:541:            [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
./common/rc:1227:       ext2|ext3|ext4|reiser4|ocfs2)
./common/rc:1331:       reiser4)
./common/rc:1333:               $MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \

> 
>  common/config     | 7 -------
>  common/quota      | 4 ++--
>  common/rc         | 5 +----
>  tests/generic/740 | 4 ----
>  4 files changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 77f3fc153eb731..a9a1ce6c3655cf 100644
> --- a/common/config
> +++ b/common/config
> @@ -384,10 +384,6 @@ _common_mount_opts()
>  	f2fs)
>  		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
>  		;;
> -	reiserfs)
> -		# acls & xattrs aren't turned on by default on reiserfs
> -		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
> -		;;
>         reiser4)
>  		# acls & xattrs aren't supported by reiser4
>  		echo $REISER4_MOUNT_OPTIONS
> @@ -441,9 +437,6 @@ _mkfs_opts()
>  	ceph)
>  		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
>  		;;
> -	reiserfs)
> -		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
> -		;;
>         reiser4)
>  		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
>  		;;
> diff --git a/common/quota b/common/quota
> index 8688116c6547a9..9c3d1bb4ace4bb 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -12,7 +12,7 @@ _require_quota()
>      [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
>  
>      case $FSTYP in
> -    ext2|ext3|ext4|f2fs|reiserfs)
> +    ext2|ext3|ext4|f2fs)
>  	if [ ! -d /proc/sys/fs/quota ]; then
>  	    _notrun "Installed kernel does not support quotas"
>  	fi
> @@ -347,7 +347,7 @@ _check_quota_usage()
>  
>  	VFS_QUOTA=0
>  	case $FSTYP in
> -	ext2|ext3|ext4|f2fs|reiserfs|gfs2|bcachefs)
> +	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
>  		VFS_QUOTA=1
>  		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
>  		;;
> diff --git a/common/rc b/common/rc
> index 6840bb1dfa1001..9d16df5fc0d5ae 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1163,7 +1163,7 @@ _try_scratch_mkfs_sized()
>  	btrfs)
>  		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
>  		;;
> -	ext2|ext3|ext4|reiser4|ocfs2|reiserfs)
> +	ext2|ext3|ext4|reiser4|ocfs2)
>  		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
>  		;;
>  	udf)
> @@ -1267,9 +1267,6 @@ _try_scratch_mkfs_sized()
>  	jfs)
>  		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS "$@" $SCRATCH_DEV $blocks
>  		;;
> -	reiserfs)
> -		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS -b $blocksize "$@" $SCRATCH_DEV $blocks
> -		;;
>  	reiser4)
>  		# mkfs.resier4 requires size in KB as input for creating filesystem
>  		$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \
> diff --git a/tests/generic/740 b/tests/generic/740
> index 10817521cc9342..c167dbef2ff68a 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -63,10 +63,6 @@ do
>  		# "quick" format that doesn't zero the entire device
>  		postargs="--quick"
>  		;;
> -	reiserfs|reiser4)
> -		preop="echo y |"
> -		preargs="-f"
> -		;;
>  	*)
>  		;;
>  	esac
> -- 
> 2.47.1
> 
> 
