Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04B2DC762
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860782; cv=none; b=OOEUc2E7/RRsZluzYZ+M8U2JKInhkw5YZTC9eLK5spvElIb0it6QWvDKa+4o7bDRSYVntt6LDNUIFYO+Bq6Ut+kSyggTfTGff4hiMGxksTYKU7RpxFzEeVSkCtPoW3LcRfWPmagvpXRJ9JDp+A9po+73LqCqDgC6id/qMghRsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860782; c=relaxed/simple;
	bh=3vNxX95IlX+XjjxQLAWGdHScY6w2vivB3ZHgtpPfWA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+wSzrxltlf7oCacCwtUmganzMNZEgRkxOX33bEG1SrdCL6dfwiQTdtuM07cq2QqiFR+1W3jOAYojGBdgtue5QByXOljvunD899zNWcFGi7uWoKzMEHal9xIJCqCeyevqdHHRumSY++DggqQOGV8bKjV64vtkPVH2e+4De1TBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpgSBBVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpgSBBVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A384DC2BCB3;
	Fri, 15 May 2026 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860782;
	bh=3vNxX95IlX+XjjxQLAWGdHScY6w2vivB3ZHgtpPfWA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpgSBBVEKaQh0SV6xYV0C86PiSUJxhPWFegYYVPpue24Z4aJhsIA9lqn8hC2n8n68
	 RjFUiaDeAL+PKLnRksNgjknbIf+/fNrItsbJgu44LPTaeMRLA2NVJKRNLi4E3rch4q
	 /U45pxhxW4K765yF0URGflrFPUqdzhhaw8J0fl3B2vnR9UyEjnsyz+5VqWO3/YRL/T
	 76wEBngNEkI2HnNfHwBDyjE/kHxYGAu6QNOeA2i8xAEO9Xg1jT36s7wJ3cD37BuHiW
	 3M7dG6E5vLgvtEv9FDlkG+tnHTfTvaTQqcRNJAqLoYMvgdNajNtj9P85EDO0M1V2kp
	 Wh3e7Rdojq1kQ==
Date: Fri, 15 May 2026 23:59:34 +0800
From: Zorro Lang <zlang@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: djwong@kernel.org, fstests@vger.kernel.org, xfs-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/4] common/rc: Add helper to calculate percentage of
 free space available
Message-ID: <agdCc4iaVWsWUY8e@zlang-mailbox>
Mail-Followup-To: Lukas Herbolt <lukas@herbolt.com>, djwong@kernel.org, 
	fstests@vger.kernel.org, xfs-linux@vger.kernel.org
References: <20260514113910.866888-2-lukas@herbolt.com>
 <20260514113910.866888-4-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514113910.866888-4-lukas@herbolt.com>

On Thu, May 14, 2026 at 01:39:09PM +0200, Lukas Herbolt wrote:
> It calculates percentage of filesystem available space and returns it
> in MB. This helper will be used in the following test/generic fixes.
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  changes v2:
> 	spelling and description
>  common/rc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5fe44e2158ff..9fc733ebdcf4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6189,6 +6189,16 @@ _require_fanotify_ioerrors()
>  	_notrun "$FSTYP does not support fanotify ioerrors"
>  }
>  
> +# Computes a percentage of the available space in a filesystem and
> +# returns that quantity in MB. The percentage must not contain a percent
> +# sign ("%").
> +# usage example:
> +# _mb_pct_of_available_space <mount point> <percent>
> +#
> +_mb_pct_of_available_space()
> +{
> +        _df_device $1 | $AWK_PROG -v pct=$2 '{printf "%.f", (($5*(pct/100))/1024)}'

Good to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

> +}
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.54.0
> 
