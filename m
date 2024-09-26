Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291F14B959
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362229; cv=none; b=Rm4FXlRDnVt0dSB/Iko5x1LOMGXgl3K+48kxuzH4dx+v5eH9MZ4f5bqnVBP1W1qlrCjDMdNAKvZXzU9/Wstgmpwf941isooTWpDlylpZGYywSFUr6MNhJ9C5tuJ40O1yg87NA19RqAJRJw/NPE59V/Ybd1bAtlkoZCCp1hmgyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362229; c=relaxed/simple;
	bh=OO/EJ9hsu+Tk5U1pApltSE/hLhdCbizKvzbgLETJJ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoVpjwyL6sqxJSrz7VH8EUNMELBf0uP6PsFjNvDcy/uiO4ioJuqOMySam8SvozLWtP2L/82ALwgvAWQQ5xMpBlue9LW9OQUaHyddvDkbPIUwvtsDpzsHJybiyBeX1ubsqav7y60JsmZcuGc573Weu7vVqMLUz6hxcyUiocQV/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEtiGw7i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEtiGw7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889AFC4CEC5;
	Thu, 26 Sep 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727362228;
	bh=OO/EJ9hsu+Tk5U1pApltSE/hLhdCbizKvzbgLETJJ7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEtiGw7ibn40WrzgJhtU+1WbyF6T808QMLo1qzT2cVKS3Rq/absqzujw0tzBBc3FK
	 EJMEQyqx8mn0IGEm+Va+nfNL/SRvF8ps/+Lsl2mTBtJQApW3ChY08I1Cr2LJOK0fxf
	 tJDOabHUn6bJbh7sOR0yLcMqyo06TTYv3Wgq6So2rP8jSc/oMBj9lKrbiKl3jHSJUf
	 4XW0C9Ct0S+OiOeEFltgJMi8Yl25S6+xOIIudZsHRU8bYcwGHErL/OxJhlBd3gOMNK
	 F9cX5UUVxl8YQKAUd0iCGV6UKnnYPxBk6ADedUSW8yonF6xUMkrRh4gd0MfNkhRBlz
	 Z+MWyOn4E857Q==
Date: Thu, 26 Sep 2024 07:50:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add missing fallocate flag ifdefs
Message-ID: <20240926145028.GC21840@frogsfrogsfrogs>
References: <20240926144147.106685-1-bfoster@redhat.com>
 <20240926144147.106685-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926144147.106685-3-bfoster@redhat.com>

On Thu, Sep 26, 2024 at 10:41:47AM -0400, Brian Foster wrote:
> The various fallocate flags are mostly ifdef'd for backward
> compatibility with the exception of the associated test_fallocate()
> calls to verify functionality at runtime. I suspect the reason for
> this was to avoid ifdef ugliness around having to clear the runtime
> flag for each operation, but unfortunately this defeats the purpose
> of the ifdef protection everywhere else.
> 
> Factor out the fallocate related test calls into a new helper and
> add the appropriate ifdefs.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  ltp/fsx.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 14 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 677f8c9f..417743c5 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2833,6 +2833,50 @@ __test_fallocate(int mode, const char *mode_str)
>  #endif
>  }
>  
> +void
> +test_fallocate_calls(void)
> +{
> +	if (fallocate_calls)
> +		fallocate_calls = test_fallocate(0);
> +	if (keep_size_calls)
> +		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> +
> +#ifdef FALLOC_FL_UNSHARE_RANGE
> +	if (unshare_range_calls)
> +		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> +#else
> +	unshare_range_calls = 0;
> +#endif
> +
> +#ifdef FALLOC_FL_PUNCH_HOLE
> +	if (punch_hole_calls)
> +		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> +#else
> +	punch_hole_calls = 0;
> +#endif
> +
> +#ifdef FALLOC_FL_ZERO_RANGE
> +	if (zero_range_calls)
> +		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> +#else
> +	zero_range_calls = 0;
> +#endif
> +
> +#ifdef FALLOC_FL_COLLAPSE_RANGE
> +	if (collapse_range_calls)
> +		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> +#else
> +	collapse_range_calls = 0;
> +#endif

The concept looks fine, but collapse and zero range have been in the
kernel for a decade now, do we really need to have ifdef tests for them?

--D

> +
> +#ifdef FALLOC_FL_INSERT_RANGE
> +	if (insert_range_calls)
> +		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> +#else
> +	insert_range_calls = 0;
> +#endif
> +}
> +
>  bool
>  keep_running(void)
>  {
> @@ -3271,20 +3315,7 @@ main(int argc, char **argv)
>  		check_trunc_hack();
>  	}
>  
> -	if (fallocate_calls)
> -		fallocate_calls = test_fallocate(0);
> -	if (keep_size_calls)
> -		keep_size_calls = test_fallocate(FALLOC_FL_KEEP_SIZE);
> -	if (unshare_range_calls)
> -		unshare_range_calls = test_fallocate(FALLOC_FL_UNSHARE_RANGE);
> -	if (punch_hole_calls)
> -		punch_hole_calls = test_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> -	if (zero_range_calls)
> -		zero_range_calls = test_fallocate(FALLOC_FL_ZERO_RANGE);
> -	if (collapse_range_calls)
> -		collapse_range_calls = test_fallocate(FALLOC_FL_COLLAPSE_RANGE);
> -	if (insert_range_calls)
> -		insert_range_calls = test_fallocate(FALLOC_FL_INSERT_RANGE);
> +	test_fallocate_calls();
>  	if (clone_range_calls)
>  		clone_range_calls = test_clone_range();
>  	if (dedupe_range_calls)
> -- 
> 2.46.1
> 
> 
