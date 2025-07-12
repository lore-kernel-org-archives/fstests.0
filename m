Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BA2C9D;
	Sat, 12 Jul 2025 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752294478; cv=none; b=qjQI/HCDCSSy1NxDYwJ6KJ8MoKyYN5TL/uV6Z8HEbU9lvLg76juEcDk90zFVlQJxD8nnrR3uNwdLOvj7SgyhLe3ad4VvohSjkSbt3kbf7K4bExHyqx023blWSOD2ttzSS6g34IJnCwXyg8jfNeCiHjCMRo5IRAnMOYGO0sqgJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752294478; c=relaxed/simple;
	bh=80xnJlhSTp+jSm2kRgJWpfgTNCIZ82m3o5GCPIzFbb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkdJawFZABdl8znBrkmTGimNEtr5e1yuP1Ak7+n/JFhKG72EsO6PR5NX/orW1/ABz7+4C/MZB68BbAoovpGCbENl1Nbc/vTVK4/UzqQBYYgVNeg3W8vMeSXelxM2XsUqFD7DzEYmksKoQo28D0ywn2LmlgwNynl8j+4gGBkX3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1qnsP7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1qnsP7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF55EC4CEEF;
	Sat, 12 Jul 2025 04:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752294477;
	bh=80xnJlhSTp+jSm2kRgJWpfgTNCIZ82m3o5GCPIzFbb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1qnsP7CS70n6iUJ+5O1Ksugrol0ZPgBd+BDYgmLeJPMc/0w+57q4rjIJ3TaDwrWG
	 Oc4sVZJuoeBscTyK9ZuRNGET6HfsC8AKl9xpj5pKA6azZwMIn0duPl3+8Y9ds1G+Pg
	 5dd/3r1cSX7J5sHKcW2S6TIEUSHD58lUKPKclRr+b6fi90TYFqdvu369v6ECFyrcHX
	 dKNe6s7SrFurqmnOeOJ92fS/DsM1nLZhg6pk8Uxqnqxxb/7xNd5k/C7mzg1rY27XIz
	 HjzoW7KwniGn0jqvXZb75tHwuyHk6BddYcwwLiotbZO6YxSHKTKWJwiCht5nxLLsWA
	 9KPGmlMAA7nFQ==
Date: Fri, 11 Jul 2025 21:27:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Add fix hint for ext4
Message-ID: <20250712042757.GD2672039@frogsfrogsfrogs>
References: <20250711182744.1512486-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711182744.1512486-1-ojaswin@linux.ibm.com>

On Fri, Jul 11, 2025 at 11:57:44PM +0530, Ojaswin Mujoo wrote:
> This test fails on ext4 if the commit 4a622e4d477b
> is missing in the kernel. Add this hint.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

LGTM
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/365 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 1bca848a..36cb2530 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -14,6 +14,9 @@ if [ "$FSTYP" = "xfs" ]; then
>  		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
>  	_fixed_by_kernel_commit ca6448aed4f1 \
>  		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> +elif [ "$FSTYP" = "ext4" ]; then
> +	_fixed_by_kernel_commit 4a622e4d477b \
> +		"ext4: fix FS_IOC_GETFSMAP handling"
>  fi
>  
>  . ./common/filter
> -- 
> 2.49.0
> 
> 
