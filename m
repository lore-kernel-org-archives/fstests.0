Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E67275AEB
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053819; cv=none; b=PqnCO8rB6NMDgNXJhLjG3ecvN5mP9VyIkRhSBMf5LKw47g999AO2Pt3t28vHymkfn3sk2M2EbGf9QtkSGZOxKY46N02ETKZhZ4G3PDa6mgXQj6AmAf4vDYymKWDDWh0MxgdZDpAGd0h6YnFr4A8XGoaifT+DYxyC1iiVpaP2XM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053819; c=relaxed/simple;
	bh=BdQQjPGsBexVS2ubj+AkQ5a9A2Mx+amCroK3pTMsoF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssr9lX4jJ7iDmXYWNX5kSUv847DEFOunJunxZxWIdS2lzfrPjWobplGwBQCIVBcSGlDI8m7juFYkTWTbO4Qab5M8SdMAaG21X0BuMSe68bVrEzn7IDMKAw55Cftd+aM6XRVcAEutjkMDVSmovXQwEOt7LcqhRBdXFMolJ7uLnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2A9IZLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2A9IZLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFF0C4CEF7;
	Wed,  1 Apr 2026 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053819;
	bh=BdQQjPGsBexVS2ubj+AkQ5a9A2Mx+amCroK3pTMsoF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2A9IZLdKsq2AIlg8itMIlb6FwB0+hvn5zJSelMmufZRKf4FKpqovvIYBAiQpKr22
	 4ex62FQL9jIKcut0qqT/ulmc3o/nkwQTvbcttK9A6seLZ7LIWjojkW2V7/1AU5L92T
	 opBQmFGMkyTV4nsoFtwqs6ykXy8PRJ3zEKPzIbkTmZztfYC3wBXFi8kcacDIdyiwKk
	 JWWTmX5Rq0lz5HxoNAatOjblPfhiQ9EDls1LDFUGrhSd0muncb8HRvZrFBMFqNjknQ
	 F8GwdqVXaOlewQk9nLB4h0SaMfbKmXm2OQBT81NhR+Yoeyp1Itmyl7ypb+0eudkorI
	 f5XuUpCjVM9Pw==
Date: Wed, 1 Apr 2026 07:30:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Super User <root@ltcrain119-lp6.ltc.tadn.ibm.com>,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 3/4] generic/765: Ignore mkfs warning
Message-ID: <20260401143018.GH6212@frogsfrogsfrogs>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <1418f57e6115c93278a3891f075338163e2ec667.1775039135.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418f57e6115c93278a3891f075338163e2ec667.1775039135.git.ojaswin@linux.ibm.com>

On Wed, Apr 01, 2026 at 04:10:49PM +0530, Ojaswin Mujoo wrote:
> From: Super User <root@ltcrain119-lp6.ltc.tadn.ibm.com>

Who?

> This test validates atomic writes for all possible block sizes. In ext4, for
> smaller block sizes with configurations like:
> 
> export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> 
> The output can get corrupted with warnings like below because clustersize
> more than 16xbs is experimental:
> 
> + 16 times the block size is considered experimental

Er... a message that doesn't fail the mkfs is printed to stderr?
Maybe mke2fs should fix that...

> Hence pipe these to seqres.full to avoid false negatives.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/765 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/765 b/tests/generic/765
> index 4c768783..6794eb72 100755
> --- a/tests/generic/765
> +++ b/tests/generic/765
> @@ -64,7 +64,7 @@ test_atomic_writes()
>      local bsize=$1
>  
>      get_mkfs_opts $bsize
> -    _scratch_mkfs $mkfs_opts >> $seqres.full
> +    _scratch_mkfs $mkfs_opts >> $seqres.full 2>&1

I think we still want to check that the format succeeded as a
precondition for the test round, right?

	_scratch_mkfs $mkfs_opts &>> $seqres.full || \
		echo "mkfs $mkfs_opts" failed"

--D

>      _scratch_mount
>  
>      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> -- 
> 2.53.0
> 
> 
