Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADF196C63
	for <fstests@vger.kernel.org>; Thu,  6 Jun 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685742; cv=none; b=eXR7NlnIQYGnhk9PpO8pxxM48I4WP73D7CLPFkm1AI8QfoY3/vpEtssfRaErZPg8+1oENWdBxlcgbv1UBEOZ/fsv7DJwtDSD6peH6id21o/6+H6osX8Lz2AZOn/PEjX+GQjl/210D3iLhTvR2SLP4S/KMjgTIvll5x51qHVAFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685742; c=relaxed/simple;
	bh=huoFU5/vF7G8HQlVF7GlwwZ5YVqzTm5mpXRs9Do6rXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5vTR4I7LeJBhYg47KmP4KR3IxZ6Uv4Bs0qwli3FOBqc4ZtdakwLAdeaGDBKoGAykIrtZhND0kxW0PtSASLELUYjQohvfqAlo6X5BoCzFfdL2JI0IH8L9uEC0nhsPAHtsSMyp7GDUGhpInJBdL31subkAGpC81JtoOIdV920s1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEk/aAT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEk/aAT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB9DC2BD10;
	Thu,  6 Jun 2024 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685740;
	bh=huoFU5/vF7G8HQlVF7GlwwZ5YVqzTm5mpXRs9Do6rXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEk/aAT+6CU6+zsBuZLD0yYL+BcWQr/iAXUwrTPnjYov9uUUv1mzOnawaM9oAHu4b
	 uov4C0377O2kiY17o2ipfX4+K2bQMRGiWbEkQUR/1/nNIsdKAcTMdiZ7BLdBI4ooVY
	 XgnzjAG3UbnRJriKm2Nyl7+8+3oInFN5KCdc3RIitXY/GQ1ZW8TQIqqTqD6cf4vjPh
	 pHCR/NMkS03A0WD5y5nzKn8sbZfWh5mh0ZlNXKtQ8Smru5kJ/LUejyWVRPKsxwM/G2
	 DU0/xg2XT7VkIZ/dbVZZCoCLyEsnRnj/I8YodDuNRYTAQDQ2lFsJn2d8JhPAOooDUS
	 U8qP7Sf2uiZxQ==
Date: Thu, 6 Jun 2024 07:55:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/747: Redirect stderr of _scratch_mkfs_sized
Message-ID: <20240606145540.GC52977@frogsfrogsfrogs>
References: <20240606055759.2594-1-maxj.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606055759.2594-1-maxj.fnst@fujitsu.com>

On Thu, Jun 06, 2024 at 01:58:00PM +0800, Ma Xinjian wrote:
> The mkfs tool may output some information into stderr, which will cause the
> output check failed.
> 
> In _scratch_mkfs_sized, the return value of mkfs tool is checked. So the
> error message can be redirect to stdout, just like what other cases do.

Read list please
https://lore.kernel.org/fstests/171744525128.1531941.8755552045266618674.stgit@frogsfrogsfrogs/

--D

> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  tests/generic/747 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/747 b/tests/generic/747
> index 50b7ae11..a0da1be5 100755
> --- a/tests/generic/747
> +++ b/tests/generic/747
> @@ -99,7 +99,7 @@ seed=$RANDOM
>  RANDOM=$seed
>  echo "Running test with seed=$seed" >>$seqres.full
>  
> -_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full
> +_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
>  _scratch_mount
>  
>  echo "Starting fillup using direct IO"
> -- 
> 2.39.3
> 
> 
