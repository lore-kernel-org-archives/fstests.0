Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610A3E714A
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862697; cv=none; b=PAhFKIigl0TOcolLfhz9OK6it2dpzIrWwcl3e43n8WIAffD3NLN3pn7rOYn/un2hHkqstf7VQ/6rjpaInm5jeEleKPOm8xcjWJMu0uDGml70yUtgThiOjMCk1MAjQtZEI3A6aTdJv3bEdGly/reNt1hmupLGH3rM42y/Nwyh7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862697; c=relaxed/simple;
	bh=lhgn9iEYiDqiaZRkpMpRjfgQdyOjIzYzz0y8SbngUo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf1gNRTyH3n9poB0JDwZBbunpVKSYLhGrIYid4lllwq9lGcW+3X8sxors7tBFMpuGxu221vN5TFoDVB+HlM1OQE5YR8PEsIqJMNFIAETP92lsXpL+E0YfP0ohQobK+pxjjw5A4sr02ZhfY6FiJgwI4g5ry2CwrPOErT3vO7HE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m84C9KnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m84C9KnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72155C2BCB0;
	Fri, 15 May 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778862697;
	bh=lhgn9iEYiDqiaZRkpMpRjfgQdyOjIzYzz0y8SbngUo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m84C9KnZ2CETghuu4zAmoi3cdKSjmvBs2R0pS/wFhriSaO86sH/7y/8X2LM/mkQgk
	 Uq2Zmbl2BZoLEc59mk4eIPweMOj+GhOWCLdvKgfuEGa0COXBnRnxtRdTvg/2Mvlgiz
	 hSeMI0fC1DFPOwq0EPiI0KA+iZAXd85uT7WRuvqDkLpN08wD7rCWHn4Zs8iXPb9ei1
	 DCRffzGYoFdiBorx+KFNhWonx1CxMS8WoVUBGanT8SQvYPBQnYWRInOlYDXuZjp6yn
	 UbfWGRg2uLT7hJl2AktcmykMpggeSMcA3GP9PfTfOIlNJMFFEKXaSGqOK1V1Fr/h4K
	 Z8nxqpkT//MYQ==
Date: Sat, 16 May 2026 00:31:31 +0800
From: Zorro Lang <zlang@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] common/rc: add default _udev_wait timeout
Message-ID: <agdKGqbpc8VABCmi@zlang-mailbox>
Mail-Followup-To: David Disseldorp <ddiss@suse.de>, 
	fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
References: <20260323044557.2668-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323044557.2668-2-ddiss@suse.de>

On Mon, Mar 23, 2026 at 03:45:58PM +1100, David Disseldorp wrote:
> If udevd isn't running then "udevadm wait" loops endlessly. With a
> --timeout parameter provided, udevadm (udev-254.27) prints to stderr:
>   Timed out for waiting devices being initialized.
> 
> The error message causes test failure via golden output mismatch and
> is easier to debug than an infinite loop.
> 
> The timeout parameter is also compatible with existing
> args="--removed <dev>" callers. 60 seconds is relatively arbitrary, but
> should be long enough to avoid premature timeout on regular systems.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
> Changes since v1:
> - increase timeout from 10 to 60 seconds
> 
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index fd4ca964..a490893f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5544,7 +5544,7 @@ _udev_wait()
>  	if [ -z "$UDEV_WAIT_PROG" ]; then
>  		$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	else
> -		$UDEV_WAIT_PROG $args
> +		$UDEV_WAIT_PROG --timeout 60 $args

60s is good to me. As there's not more review points from others, let's
have this change.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  	fi
>  }
>  
> -- 
> 2.51.0
> 
> 
