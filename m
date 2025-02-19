Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80F25A2D6
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004750; cv=none; b=J0pwutjnobraXuS3Njn+7HYcmOLGdjxMjWo6v5N7oXf/ltUjpfkEUtqMR/pPzoI1IIVKpvKohfUCj90IxTCQrzKJAaJ9r8+HSFgq6876VL7bCHiQ/9a1jIzXCQlV0QvaRcQikbPy3OTr99c4uGVjr4291m5zuk7VYwspJ3ALjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004750; c=relaxed/simple;
	bh=YZmpKA36EgeR2asaaik61jaktdBXKMW9K1UlfCxT0tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir++fbZjgjPY1/6ZbUdpTZHdlES8U56/YpkIZ+/MtuSmVa36ovGoc5h6cPqfgAQK8vQtBp1pWeWHBkiMQGBcFuHODictl1mdLR8i6YaChNeNAc3P8OiIkzh2XWbHMELmqVWn6lAsUN2y4wB1YdzjHnJQOOwiM+AKyopG3f6IWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0cpf6j+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0cpf6j+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEC6C4CED1;
	Wed, 19 Feb 2025 22:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004749;
	bh=YZmpKA36EgeR2asaaik61jaktdBXKMW9K1UlfCxT0tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0cpf6j+X01Ti/ygVrr4pawus73HMYmrqfGfpSMIdZE31kQ1xh501YsAgAjEdU5By
	 5dl1J+71ZxYnvqUl4TK5Mk30Ha+M1mqJZuMTM7TwNsor5s8D0TX6Lhwat1LRbEe6Ju
	 y+bubqOTjfOlt1t/0gv4tc6JfnyI5TjfvVuFE+5xFufse0+J6am/NlP1TxpIFMK61f
	 fRprgjiwjcDVJoXhqZF6jGpddnak2RdFx/werTi0I0+856Yk0ATpEDY1QHvNYSxSHY
	 Jmbyo29OMDIVYBVqvHNTe1oE0yu8GciWoM9sr+DKuFyqP8YpO/1Ft5xclpqLWAsLd6
	 7MAjywZYen14A==
Date: Wed, 19 Feb 2025 14:39:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250219223909.GT21799@frogsfrogsfrogs>
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

Buhbye!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> 
> Arguably reiser4 support could be removed as well as there's no recent
> upstream activity.
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
