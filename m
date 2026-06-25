Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AF25771
	for <fstests@vger.kernel.org>; Thu, 25 Jun 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413146; cv=none; b=ea1XMtDPFVKn4BDXKZO8MMhygnI0un4stqF3jt6II72ENdb+0QoDNbdg07dxr2kCc/OihJ0clw3IgUYZQwDeFLnMgioT7nKU9SppAkXDoF3RXU+RhXmFhPM24FYs+FSS3t8Foa1be93Gp+rAA+Z+n+SVG0/Au2+E/54K9vY/6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413146; c=relaxed/simple;
	bh=hpkyzaxMJSy8ndWYm0Xwq5L0XefdjdU0B4obUcOP5yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe3P0+FtaFeY9gsSkOaYBNMN42wHu/bKXCPyuTrGIXj0GAWmJrWGxsHGWZfLAhd2TNX8wVaJ8X1IfhIG3bCPrFV2dA34WAj9fvyPU6B+xdH8K7QffyVI3fW2RODpaVCPEuR4fok99lGe+2RrF8gSgN/ofqY0SWiQrcxAGVdzmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXBXLhWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXBXLhWS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 469D51F000E9;
	Thu, 25 Jun 2026 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782413145;
	bh=p4/+JjWObhIiSyUZ+OROdkIzYFTARGUTR8GtHSzJL5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XXBXLhWSwdBuG1ovEJ9gaWg/aF1UU3afoCFtM7PNHk/Cfzkw6O58xcaOCaXw9gTlU
	 VOoY1sWCpsZIFfyEVZww5pxjo6hXghaEYQuxgTxY9NHevGg+k8gdITqhr58zNeuL/C
	 lejMAN27/K11pXvZQqLwFpwzyjJqNfRVIsnE9yMIyGtASopk3DhTIKrRtjLXAnBVH2
	 pwN4s+xN5A2UO9s02V1qnRI+Bq3ANCKzA3EWuodwrWnw4WbJPhf709SjdiROpi/c1l
	 R6fSL6PdOCyLduOapxgk4XiXDonVYkH+m1KiRL/ktGVnTOPnXCM53Ee4sVSFnbN88m
	 UVjq36KcMzoaA==
Date: Thu, 25 Jun 2026 11:45:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Zorro Lang <zlang@kernel.org>, Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/740: add --force option to mkfs.ntfs
Message-ID: <20260625184544.GR6070@frogsfrogsfrogs>
References: <20260618192236.654082-1-dxdt@dev.snart.me>
 <20260618192236.654082-2-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618192236.654082-2-dxdt@dev.snart.me>

On Fri, Jun 19, 2026 at 04:22:36AM +0900, David Timber wrote:
> mkntfs refuses to format the target if it's backed by a "real" device
> but not a partition to maintain compatibility with Windows. When
> formatting the scratch device in NTFS for testing, this behaviour has
> to be overridden so that any type of blockdev can be used as a scratch
> device.
> 
> Signed-off-by: David Timber <dxdt@dev.snart.me>
> ---
>  tests/generic/740 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/740 b/tests/generic/740
> index 4f8bf099..718d983d 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -72,8 +72,10 @@ do
>  		postargs=2000
>  		;;
>  	ntfs)
> -		# "quick" format that doesn't zero the entire device
> -		postargs="--quick"
> +		# "quick" format that doesn't zero the entire device. Use -F so

"Use --force..." ?

--D

> +		# that NTFS-3G mkfs formats the volume even if the scratch
> +		# blockdev is not a partition.
> +		postargs="--quick --force"
>  		;;
>  	reiser4)
>  		preop="echo y |"
> -- 
> 2.54.0
> 
> 
