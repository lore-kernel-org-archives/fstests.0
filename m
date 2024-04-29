Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97974400
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406637; cv=none; b=VefB3wiatTCxHAw14U4CXRwghOLGJRxR+kQdVQUrbckc9GYtBMiRvY0teOxyI1Po+5HpNZtTWP5Lp/m6F4id2i9o3Gx2TAoa6/6PyDSLVfRlVOkxjtsDKoqHmatZzqP7kqHlOLqWcEZMfaoNMd1NrW/LRtzUI9InrAluhJDi1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406637; c=relaxed/simple;
	bh=P6DoGKKLD79A75S/Vn41s9SzZRUUGZv+U45zooQ4PtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3x+Hr7F3zEyYTaBpMHMMWrUjmvqY7m2AQWxStXfG+VD9NBo6m4iso7EKmIOmwhcgAGTHXmsqEVsbACCfMB99dEh6YtndfB53dF0zMXMNFF1ns/WwzJGRv3sKo0V2ibGVe85wYBwUqPquHcemxZZxO+3aUjn1vuus4WDi4JtTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcnVqmrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcnVqmrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDAFC113CD;
	Mon, 29 Apr 2024 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406636;
	bh=P6DoGKKLD79A75S/Vn41s9SzZRUUGZv+U45zooQ4PtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcnVqmrsKbn2rR34PUuQdpcvXqOQc81WFyhmio2flAFAJXIrKefv4yIjXyGy+Qc8D
	 QKYFBrt8qnaIwD+T5L5XA+fsHa3E9aRt4+IwYr25DQ8nA1VBcoIOivibglDID2PQ1U
	 Xm7r9ZiYatPzUhJEN/BG2lZdhsEd/Y02o3VIoAuJuPk9RrGTugx7beLSLsnIMrmCEj
	 yV30zAp2sRuzrIwwj5S1PR9ulvz5xJLYsKNTakd9hGTIoXm34PbWtfq3x1Qw8Why1y
	 0QWWziA8dl85xErSKzcq7IS4XRwa/ncAJP0utMBHn3awTa8mE+cvN0fYYyMyptQena
	 F1FGRVg6A7AJQ==
Date: Mon, 29 Apr 2024 09:03:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <20240429160356.GC360908@frogsfrogsfrogs>
References: <20240429060906.465135-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429060906.465135-1-zlang@kernel.org>

On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> The old _require_debugfs helper doesn't work now, fix it to check
> a system supports debugfs. And then call this helper in cases which
> need $DEBUGFS_MNT.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/rc       | 10 ++++++++--
>  tests/btrfs/150 |  1 +
>  tests/ceph/001  |  2 +-
>  tests/xfs/499   |  1 +
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 56f1afb6..6f0bdf60 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2978,8 +2978,14 @@ _require_sparse_files()
>  
>  _require_debugfs()
>  {
> -    #boot_params always present in debugfs
> -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> +	local type
> +
> +	if [ -d "$DEBUGFS_MNT" ];then
> +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> +		[ "$type" = "debugfs" ] && return 0
> +	fi
> +
> +	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
>  }
>  
>  #
> diff --git a/tests/btrfs/150 b/tests/btrfs/150
> index a02bdafc..fd386d92 100755
> --- a/tests/btrfs/150
> +++ b/tests/btrfs/150
> @@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
>  . ./common/fail_make_request
>  
>  _supported_fs btrfs
> +_require_debugfs
>  _require_scratch
>  _require_fail_make_request
>  _require_scratch_dev_pool 2
> diff --git a/tests/ceph/001 b/tests/ceph/001
> index 060c4c45..79a5f58a 100755
> --- a/tests/ceph/001
> +++ b/tests/ceph/001
> @@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
>  
>  # real QA test starts here
>  _supported_fs ceph
> -
> +_require_debugfs
>  _require_xfs_io_command "copy_range"
>  _exclude_test_mount_option "test_dummy_encryption"
>  _require_attrs
> diff --git a/tests/xfs/499 b/tests/xfs/499
> index 9672f95d..6421cc4b 100755
> --- a/tests/xfs/499
> +++ b/tests/xfs/499
> @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
>  # real QA test starts here
>  _supported_fs xfs
>  _require_command "$CC_PROG" "cc"
> +_require_debugfs

This test doesn't mess around with debugfs per se; it actually wants
tracefs.  Perhaps this should be _require_ftrace instead?

--D

>  cprog=$tmp.ftrace.c
>  oprog=$tmp.ftrace
> -- 
> 2.44.0
> 
> 
