Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723F273D91
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164079; cv=none; b=ogZwTZXvIuE81F1/9R+emE1A4mdpYzLSxfhOcRYrqBVvjV30FZgYxk8A1adzRLvPQFKnD+qurH1LI20nxa1+Ocpq/z1Vn1MjI23hQInd/kivl9X2SkG3Aa3gwuRRsHeQszL4ik4M9sp++R8+c//po/gJ8iLmwMbhUUV03ZinPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164079; c=relaxed/simple;
	bh=3tda+mur50oCZP4ZbpbzhGDYaanJCxL2rsu8SyCUQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTGcS8uRuRRHYTh88UVTBCq3FjftQOg9v2UlU/837vF2zVtHiWWiiFYYNzlgaUK0Ipk4Uc3hCIdquC9pyx2YhUuw32EMQYZX8HbFz3WJQ2FN0y+5nPpIcuylzEIOj2lq9qFLhPpCQN+O6Olto0o+luE4hiUDURReT8Tz5reM9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtT/3c9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtT/3c9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D503C4CEE3;
	Thu, 10 Jul 2025 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752164078;
	bh=3tda+mur50oCZP4ZbpbzhGDYaanJCxL2rsu8SyCUQYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtT/3c9kHiMRFhn4X0ei7wcfbEIpqJ4RdV6Ja+6hnuRBPRmEp/SjJGcJkJDqWxGlE
	 79boKJZV4hZVNZB+H9kX5RRxLS/q+SHIcHCYPfrCPjVrVm/h4GLmm9nsHDsmaGoX91
	 AWww/ZwEBuPX0bAJWtwM+4mdwDWivz8tFZjKOtU8M6obMLhvLN9+M91tPh80TW7/Ea
	 AfoNKDKYQLy/nImZc/WzyRt/hu1Eki/MkNMADDtGjnWGgSVWadNW9+Gj2OFB7vLZBe
	 qbQAMuL6SZXke/b2ShUAmGlqMQLnv0F9M4aOJQSpaM6DFufaccuMpVeKwth/NLcb+/
	 8SpSZNRteFL0Q==
Date: Thu, 10 Jul 2025 09:14:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: remove useless _pgrep funcion
Message-ID: <20250710161437.GA2672039@frogsfrogsfrogs>
References: <20250622203947.797199-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622203947.797199-1-zlang@kernel.org>

On Mon, Jun 23, 2025 at 04:39:46AM +0800, Zorro Lang wrote:
> The _pgrep() function isn't used anymore, remove it.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Yeah, seems fine to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index fbab26b25..a27f87a0b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -36,16 +36,6 @@ _pkill()
>  	pkill "$@"
>  }
>  
> -# Find only the test processes started by this test
> -_pgrep()
> -{
> -	if [ "$FSTESTS_ISOL" = "setsid" ]; then
> -		pgrep --session 0 "$@"
> -	else
> -		pgrep "$@"
> -	fi
> -}
> -
>  # Common execution handling for fsstress invocation.
>  #
>  # We need per-test fsstress binaries because of the way fsstress forks and
> -- 
> 2.47.1
> 
> 
