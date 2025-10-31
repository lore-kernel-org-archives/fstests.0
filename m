Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8701AF0AF
	for <fstests@vger.kernel.org>; Fri, 31 Oct 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924566; cv=none; b=vAcDXVGjmCk4bxs3g7IFIfHtU/U0LaIfsY9+eFK/kCbyC7Brz5rUuwguXllXaKy5axGMgaHsnjIaXo5giJaNdL3UXEa+13XrEGkhEzB3G2YgArVktSGGnuXLx3v4V4wzXNLSlNgr2U4hF1jYR4ai07SbYGOE1YkfiEExuD+XEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924566; c=relaxed/simple;
	bh=G3fX0mjV6lGBCHOv+sx0J+Ro+x+pcQ18GlV8MoxxjAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtL82raWNBLdtKvS1592j/78/HTh4O0rjywu8wgmQCnDcbMbZz9g6dqm4L4Tp+QVmHUXrFPGCMQJjrkgMWBamaCj4LRG/rNu63UEqJMO7Ary+PyJeQtP3+gVTFL9igPxyUC6GE4eLHvHnCaQBynj5Jb3Zbk0TuSc6dqACX0WG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFmPpoya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFmPpoya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB85EC4CEE7;
	Fri, 31 Oct 2025 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924564;
	bh=G3fX0mjV6lGBCHOv+sx0J+Ro+x+pcQ18GlV8MoxxjAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFmPpoyaw7hBaAPwUyttUVAr3zDE5AaVOzCkT0bvKZp4XASOKflrrTkzZ/8jXugYh
	 2ctueX8kIP933dlXibNkrKDJciBZDeqgxCtjEGtr1xKy3VnmHJMs5Kgcz5agqh3Qkg
	 gDKeQ48joAZmNMs0ugV3/QcOVGo2zApL96CV8dtOPaX4sDfUEFLOIc/GGzXzVbAeco
	 cpLfxTVlOIAWIJz+OCxk3l64xf9pfM7uKCX4iAm2mBY0LpMsMKRV0jNMOH5T2AygjV
	 1QTApPCasAFmw9bAgagGo3fVPYBu1bkU3ehMD7Apqo+XDdkNDX2mb8uBRi3Iep0SXz
	 eZwas3vq8vbuA==
Date: Fri, 31 Oct 2025 08:29:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yong Sun <yosun@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/270: replace pidwait to wait
Message-ID: <20251031152924.GB6178@frogsfrogsfrogs>
References: <20251031092729.73144-1-yosun@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031092729.73144-1-yosun@suse.com>

On Fri, Oct 31, 2025 at 05:27:29PM +0800, Yong Sun wrote:
> Some system without command pidwait run generic/270 will fail with
> "pidwait: command not found". Replace pidwait to wait could solve it.
> 
> Signed-off-by: Yong Sun <yosun@suse.com>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/270 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/270 b/tests/generic/270
> index ce515920..c3d5127a 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -51,7 +51,7 @@ _workout()
>  	done
>  
>  	_pkill -PIPE -f fsstress
> -	pidwait $_FSSTRESS_PID
> +	wait $_FSSTRESS_PID
>  	return 0
>  }
>  
> -- 
> 2.51.0
> 
> 
