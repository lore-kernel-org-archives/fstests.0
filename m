Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A1EAC7
	for <fstests@vger.kernel.org>; Mon,  8 Dec 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213339; cv=none; b=kYSYig4nk81iWFFDbo9hsPaQWxbukj55kGyhar4e7e3l/oA75a67Ozbm1q6CCDIAFXcLIhmgckPhIN1yDOLbzs815mb4rfiiKIfnmlg6qvTQ8XqISjmtNe0zNEewjFSngSpzoWaf6/ZAL5ytY3gk8zWAUE1sXoRhWQHqzZUi8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213339; c=relaxed/simple;
	bh=oZPuXrKRkIoq5VzN5CkcVRdbw+peJK33IjgtELaMXkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csW+4IupgjrXJueqQniZsPUBV43hBbf4JkQb37GgvcYG3mrwYKqa27yQPZsns5/vQHiioGYSm6CodWWofg8B1errqcX0sj9e0U+pm81e77gErPp0yy5d5sJr0wULquyJYZQqDpJlzaAU5qewbk3VMHCNyVP3mKx/hWKjmWklsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byvtkpg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byvtkpg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817E3C4CEF1;
	Mon,  8 Dec 2025 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765213338;
	bh=oZPuXrKRkIoq5VzN5CkcVRdbw+peJK33IjgtELaMXkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byvtkpg1RkwaNnO3wX1raUnlM8h67viUmmLVv4K1G55/MJYA7YTPkUtNhWvnnArw6
	 9DxJgULeNSRUYxofKtxhAHl9odfesKgGYiDxY0IUv0pr6mTzIIXM93R3zmjlH0ASqM
	 egi7G7Te2x97o7Vv+RLwpX6sQi0w8+lx5zMC23DBEeof9Fn+g/dF9WiS3ssVri96wj
	 DErq9mnFuGOc78x9sOVsPkKJMa9jQpvc2Orw6ZGLGppq81RirarrHyIhlkaNVsI69u
	 xCetFf+MK37frqjOq1Oel1Y280OdgGB58dqnf0jYIqLBojkRAGN0yt7iz9OyEPSsO4
	 HH1RSIEJR8C2Q==
Date: Mon, 8 Dec 2025 09:02:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] common/quota: fix to wait for all inodes been evicted
 in _check_quota_usage()
Message-ID: <20251208170217.GG89454@frogsfrogsfrogs>
References: <20251206004017.4021067-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206004017.4021067-1-chao@kernel.org>

On Sat, Dec 06, 2025 at 08:40:17AM +0800, Chao Yu wrote:
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
> in between quota system and filesystem.
> 
> The reason is cgroup v2 implementation will increase inode reference first,
> and then, attach it to thread related cgroup writeback structure, once it
> needs to switch write owner of target inode, a kernel thread will process
> it, and finally release inode reference via evict_inode().
> 
> So, sync & drop_cache may not guarantee all inodes being evicted, as cgroup
> has one more referenece on inodes during the time.
> 
> If inode has not been evicted, dquot inode reference will not be release, it
> will lead to inode count mismatch.
> 
> Let's add a delay to wait for cgroup switching completion before quota check.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - sleep only for f2fs case
>  common/quota | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/common/quota b/common/quota
> index a51386b1..a7239501 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -333,6 +333,11 @@ _check_quota_usage()
>  	# XXX: really need an ioctl instead of this big hammer
>  	echo 3 > /proc/sys/vm/drop_caches
>  
> +	if [ $FSTYP == "f2fs" ]; then
> +		# wait for inode_switch_wbs_wor_fn() to release inodes
> +		sleep 3
> +	fi
> +
>  	VFS_QUOTA=0
>  	case $FSTYP in
>  	ext2|ext3|ext4|f2fs|gfs2|bcachefs)

Why not use case statement down here?

--D

> -- 
> 2.49.0
> 
> 
