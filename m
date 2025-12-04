Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280A2E6CA8
	for <fstests@vger.kernel.org>; Thu,  4 Dec 2025 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764885582; cv=none; b=KkyAcH0tqI3Yui3IwxeQ5XZGEQTlX3Wr3pBF0lrVmmdvgmNuCraxgMVGPUKP2vloa76pIc55tv72NcL8y9kF0/VtIKabCqv302mjKtHt+1ZvCQXUlHNGN/ODAToIOqi6UHm+j+JTE8Le2tXOFkaEoYLj8sn8oxj62ACRDmmbPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764885582; c=relaxed/simple;
	bh=BUcQWs/vguk/FMfGF4LR6FgNh7gOnALaP4H43tcWHiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtaJp8hRXejZxIgFWpf0wy/9SLoX33i5dw5sZ665K3Gj08l5z/DEpFtSqRuBA6rkEydz851Eum4r1/6uVok+Tp2kTba+mRCwHs+h5e83vgOnSZPAOgcodgguxHE//2Ia1bqXFXT2tc82gzL0i2jV5c+KHS6UD4MGqqoF19xS7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9qNF8JW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9qNF8JW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F997C4CEFB;
	Thu,  4 Dec 2025 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764885581;
	bh=BUcQWs/vguk/FMfGF4LR6FgNh7gOnALaP4H43tcWHiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9qNF8JWq7GPOc1KdDKsljVo2f+4Fv1ZaR347BDYJzVbTD9vzOt1PakXyezZkWlY5
	 2MBfTviQQrco2t57MKKWYrTKwHFJFLYRLmsWmiF1le9K1+skMzc/SdDMRdYzDowECY
	 W5IbN/HXb/EshSjJY+uUUJ8zc5uPsdU+mfXIGGJd8gTWFhFHEsTYbMFEjOXsIzvJK3
	 bfRQdzanIeh0DUqpvDwer9wXVTI9pTHtzRvAsqRPz98X7rYBL2gq/OBgTrBb83k509
	 7QU1Bsqgawy3CZrJReJ8UPRPq3mZHUH3gkVD3QXJoUmY7hSNKq1ZGYgu+yOKn3DJmM
	 a777KwSTEs8cw==
Date: Thu, 4 Dec 2025 13:59:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/quota: fix to wait for all inodes been evicted in
 _check_quota_usage()
Message-ID: <20251204215941.GF89454@frogsfrogsfrogs>
References: <20251203193147.3320893-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203193147.3320893-1-chao@kernel.org>

On Thu, Dec 04, 2025 at 03:31:47AM +0800, Chao Yu wrote:
> generic/233  3s ... - output mismatch (see /share/git/fstests/results//generic/233.out.bad)
>     --- tests/generic/233.out   2025-01-12 21:57:40.259440359 +0800
>     +++ /share/git/fstests/results//generic/233.out.bad 2025-12-04 03:02:26.000000000 +0800
>     @@ -4,4 +4,12 @@
> 
>      seed = S
>      Comparing user usage
>     +4c4
>     +< #1000     --   31476   32000   32000            994  1000  1000
>     +---
>     +> #1000     --   31476   32000   32000            944  1000  1000
>     ...
>     (Run 'diff -u /share/git/fstests/tests/generic/233.out /share/git/fstests/results//generic/233.out.bad'  to see the entire diff)
> Ran: generic/233
> Failures: generic/233
> Failed 1 of 1 tests
> 
> Sometimes, generic/233 will fail due to it founds inode count is mismatched
> in between in-memory one and on-disk one.
> 
> The reason is cgroup v2 implementation requires to increase inode reference,
> and then attach it to thread related cgroup writeback structure, once it
> needs to switch once write owner changes of target inode, a kernel thread
> will process it and then release inode reference via evict_inode().
> 
> So, sync & drop_cache may not guarantee all inodes being evicted, as cgroup
> has one more refernece on inodes during the time.
> 
> If inode has not been evicted, dquot inode reference will not be release, it
> will lead to inode quota mismatch.
> 
> Let's add a delay to wait for cgroup switching completion before quota check.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/quota | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/quota b/common/quota
> index a51386b1..de7e84e8 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -333,6 +333,9 @@ _check_quota_usage()
>  	# XXX: really need an ioctl instead of this big hammer
>  	echo 3 > /proc/sys/vm/drop_caches
>  
> +	# wait for inode_switch_wbs_wor_fn() to release inodes
> +	sleep 3

Odd -- I've never seen this problem crop up on ext4 or XFS.  What's
different about f2fs such that writeback is still in progress?

Oh, XFS cycles the mount and ext4 does ... quotaoff???

Perhaps the sleep 3 thing should only be done for f2fs?  Or do you see
it on other filesystems as well?

--D

> +
>  	VFS_QUOTA=0
>  	case $FSTYP in
>  	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
> -- 
> 2.49.0
> 
> 
