Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520A1353E4
	for <fstests@vger.kernel.org>; Wed,  6 Mar 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739590; cv=none; b=L7AU8KqyiXqJWfyhE71vQZZcTyO4aCyAOC9u0KWO9l0ymtjzqPDXmaddRWz6L8qgky8srUWfa9xvs5+YhgHyftSejlOqBG9q84akkcr+MHNLhelbKb6vSNjGFWuZks80mBkVqvxB1ycXN/ILn/rCS0moKjdwQOKySUETdLnppNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739590; c=relaxed/simple;
	bh=XrvnNqWrnUS5IKhXPHZhgwkBZ4Rb/+QNXDgPgyeohs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmOaEh5o0P49iJY2QtvOaKyGkkKXK1u+PWgzEado+N6DUf7KPERsqcuKSGR991V9M9i75iVBtDa9QvJAqkZLqI89+m+5IS/m4tkIAsgpagH6V+dP38sDI3GwUjbKEBQwPmvmB4V+K5CwCMi9bGa0WmQd5ynkJQd6q8ULab1+7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coVsOYjw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coVsOYjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C289C433C7;
	Wed,  6 Mar 2024 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739590;
	bh=XrvnNqWrnUS5IKhXPHZhgwkBZ4Rb/+QNXDgPgyeohs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coVsOYjwbieLsFEatSoEfDCz8KwnbYxOFRlOftBums8QPjiPFaUIW0024FH84bPMr
	 CoksbhQVQNxmdWrVjd0DTQlwoNm/bSryGw967+F7juASTomx3CZCewV/YD/FUC2j1t
	 1iqowXJ1YNZDi5ldWVpnJfNwmoZ6d6v8XlyidecXTmZAxrwNqp2UYlIiSI2aw+K6Yz
	 HQ/Gm53lcRO6v8Xg8SVsYuqTZ07iBuO6EfF0ryn7XR/YE9YYwnGtY2rRzp2QPcIdoh
	 L5rZ7cepYISryk8T8QlQhnhoh0sbO7VQSAeDtoo/XFb9UOE8nifOJ5RuTkby4evlPE
	 nQynAbSqVItgw==
Date: Wed, 6 Mar 2024 07:39:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] shared/298: call fs commands on the loop device
Message-ID: <20240306153949.GY6188@frogsfrogsfrogs>
References: <20240306012246.162729-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012246.162729-1-hch@lst.de>

On Tue, Mar 05, 2024 at 06:22:46PM -0700, Christoph Hellwig wrote:
> In general calling fs tools is best done on the block device used for
> the file system and not the backing device of a loop file.  Thus switch
> shared/298 to call all fs commands on the loop device.  Also add a
> common on why the xfs_io fiemap command is called on the backing file,
> and to have a good place for the comment stop passing the backing file
> as the argument to get_holes function and just use it implicitly as
> the other helpers to with the loop device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/shared/298 | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/shared/298 b/tests/shared/298
> index a6e368143..1d4e8d943 100755
> --- a/tests/shared/298
> +++ b/tests/shared/298
> @@ -46,7 +46,11 @@ get_holes()
>  	# to established convention which requires the filesystem to be
>  	# unmounted while we probe the underlying file.
>  	$UMOUNT_PROG $loop_mnt
> -	$XFS_IO_PROG -F -c fiemap $1 | grep hole | $SED_PROG 's/.*\[\(.*\)\.\.\(.*\)\].*/\1 \2/'
> +
> +	# FIEMAP only works on regular files, so call it on the backing file
> +	# and not the loop device like everything else
> +	$XFS_IO_PROG -F -c fiemap $img_file | grep hole | \
> +		$SED_PROG 's/.*\[\(.*\)\.\.\(.*\)\].*/\1 \2/'
>  	_mount $loop_dev $loop_mnt
>  }
>  
> @@ -55,7 +59,7 @@ get_free_sectors()
>  	case $FSTYP in
>  	ext4)
>  	$UMOUNT_PROG $loop_mnt
> -	$DUMPE2FS_PROG $img_file  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
> +	$DUMPE2FS_PROG $loop_dev  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
>  		tr ',' '\n' | $SED_PROG 's/^ //' | \
>  		$AWK_PROG -v spb=$sectors_per_block 'BEGIN{FS="-"};
>  		     NF {
> @@ -77,15 +81,15 @@ get_free_sectors()
>  		local device_size=$($BTRFS_UTIL_PROG filesystem show --raw $loop_mnt 2>&1 \
>  			| sed -n "s/^.*size \([0-9]*\).*$/\1/p")
>  
> -		local nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $img_file  \
> +		local nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev \
>  			| sed -n 's/nodesize\s*\(.*\)/\1/p')
>  
>  		# Get holes within block groups
> -		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $img_file \
> +		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev \
>  			| $AWK_PROG -v sectorsize=512 -v nodesize=$nodesize -f $here/src/parse-extent-tree.awk
>  
>  		# Get holes within unallocated space on disk
> -		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $img_file \
> +		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $loop_dev \
>  			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size -f $here/src/parse-dev-tree.awk
>  
>  	;;
> @@ -159,7 +163,7 @@ done
>  
>  # Get reference fiemap, this can contain i.e. uninitialized inode table
>  sync
> -get_holes $img_file > $fiemap_ref
> +get_holes > $fiemap_ref
>  
>  # Delete some files
>  find $loop_mnt -type f -print | $AWK_PROG \
> @@ -173,7 +177,7 @@ echo "done."
>  echo -n "Detecting interesting holes in image..."
>  # Get after-trim fiemap
>  sync
> -get_holes $img_file > $fiemap_after
> +get_holes > $fiemap_after
>  echo "done."
>  
>  echo -n "Comparing holes to the reported space from FS..."
> -- 
> 2.39.2
> 
> 
