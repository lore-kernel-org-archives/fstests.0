Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15742E8B98
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566996; cv=none; b=nNLtkYqB7820pqtKRh28jRgwsmEPgh1KKqSIXuaGc6QQp+xcwoUybN2mBumsbmv14uYBrUmx1izNK+jYx0PfAu8zZmm+e8GgCs08F58G4QnzVSpnaJIGDdqxqncu+MUu+P85ds4DlG0gDTluJrajpsRfP6xe3PzSQUH3AHuEobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566996; c=relaxed/simple;
	bh=2S6YVgoI9kSnf4qi4UZfK/6M70IixtCtZNeQqc9IPmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/HqyH8kdu1x5ukxI1H3DZU62rj83XHjoK4wREDR5bznydE2KpcAEhII+8QETkJyhjFBr5EpQvWYUapT2R+3yAp7wvrjZMut6YYpb5AzTqOvmJ+MKzut1FGEXW9dooavkuZRhcNWln3FzLZmQsYLa3i1pWWS6RCSQp7OPIYqIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezpk84hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezpk84hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C39C2BCB3;
	Thu, 30 Apr 2026 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566995;
	bh=2S6YVgoI9kSnf4qi4UZfK/6M70IixtCtZNeQqc9IPmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezpk84hwQYOTGrZwqBWYzXjrp1mHlS2Ai39WYZbE2BjXdQ9WoOcS+09nczXhxiQFM
	 iT7e3RVm9YiE1s3cgrOKF9ELw595TODvY+KtF+ftrg3dQR4QHljUnYlXw7BF4HQiCV
	 UppZbY6hGu+dWJKJyok7cSo5VHikJ/nxaBYyov/XipncFuATHURFXXtBWr6JOSvWLW
	 MQmtNQzzUxZh+ra6XqtIs/aTpupCcYTP8i5gvJ98QjPq64cMMAnxi5SMYzwV46c6Qb
	 XF0Tiaf75gXCr2amZpmGfvidbMgNNmh/mdgZuCnCjKUhh5i8lCYfiP3htwf0Tw2aSF
	 53qh17Fa0/e5w==
Date: Thu, 30 Apr 2026 09:36:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs/216 xfs/217 Use default -l conccurency=0 on
 mkfs.xfs that supports it
Message-ID: <20260430163635.GS7739@frogsfrogsfrogs>
References: <20260430131317.693845-2-lukas@herbolt.com>
 <20260430131317.693845-10-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430131317.693845-10-lukas@herbolt.com>

On Thu, Apr 30, 2026 at 03:13:22PM +0200, Lukas Herbolt wrote:
> The XFS conccurency optimalization breaks the log sizing check on

"concurrency optimization"

> systems with non-rotational disks and high amount of CPUs. Default to
> the old behavior with -l conccurency=0 and with -d concurrency=0.

"-l concurrency=0"

> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  tests/xfs/216 |  9 +++++++--
>  tests/xfs/217 | 17 +++++++++++++++--
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/216 b/tests/xfs/216
> index 091c11d08642..8b4610d5a0a6 100755
> --- a/tests/xfs/216
> +++ b/tests/xfs/216
> @@ -21,14 +21,19 @@ _cleanup()
>  }
>  
>  _require_scratch
> -_scratch_mkfs_xfs >/dev/null 2>&1
> +if _scratch_mkfs_supports_concurrency -l >> $seqres.full 2>&1; then
> +	_scratch_mkfs_xfs -l concurrency=0 >/dev/null 2>&1
> +	loop_mkfs_opts="-l concurrency=0"
> +else
> +	_scratch_mkfs_xfs >/dev/null 2>&1
> +	loop_mkfs_opts=
> +fi
>  _scratch_mount
>  
>  _require_loop
>  LOOP_IMG=$SCRATCH_MNT/test_fs
>  LOOP_MNT=$SCRATCH_MNT/test_fs_dir
>  
> -loop_mkfs_opts=
>  $MKFS_XFS_PROG 2>&1 | grep -q rmapbt && \
>  	loop_mkfs_opts="$loop_mkfs_opts -m rmapbt=0"
>  $MKFS_XFS_PROG 2>&1 | grep -q reflink && \
> diff --git a/tests/xfs/217 b/tests/xfs/217
> index dae6ce55f475..7c7b33b1ccf7 100755
> --- a/tests/xfs/217
> +++ b/tests/xfs/217
> @@ -20,7 +20,20 @@ _cleanup()
>  }
>  
>  _require_scratch
> -_scratch_mkfs_xfs >/dev/null 2>&1
> +if _scratch_mkfs_supports_concurrency -l >> $seqres.full 2>&1; then
> +	_scratch_mkfs_xfs -l concurrency=0 >/dev/null 2>&1

Why does the scratch fs need a -lconcurrency option?

> +	loop_mkfs_opts="-l concurrency=0"
> +		if _scratch_mkfs_supports_concurrency -d >> $seqres.full 2>&1; then
> +			# We could go just with -l concurency but then on 512CPUs
> +			# it gives log size off by one block so better to set
> +			# -d concurrency to 0.
> +			loop_mkfs_opts="$loop_mkfs_opts -d concurrency=0"

concurrency= was added for -d and -l in the same release (6.7) so you
don't have to test them separately.

--D

> +
> +		fi
> +else
> +	_scratch_mkfs_xfs >/dev/null 2>&1
> +	loop_mkfs_opts=
> +fi
>  _scratch_mount
>  # 16T mkfs requires a bit over 2G free
>  _require_fs_space $SCRATCH_MNT 2202000
> @@ -34,7 +47,7 @@ _do_mkfs()
>  	for i in $*; do
>  		echo -n "fssize=${i}g "
>  		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
> -			-d size=${i}g $loop_dev |grep log
> +			-d size=${i}g $loop_dev $loop_mkfs_opts |grep log
>  		_mount $loop_dev $LOOP_MNT
>  		echo "test write" > $LOOP_MNT/test
>  		_unmount $LOOP_MNT > /dev/null 2>&1
> -- 
> 2.53.0
> 
> 
