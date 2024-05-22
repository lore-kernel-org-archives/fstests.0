Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F51A29A
	for <fstests@vger.kernel.org>; Wed, 22 May 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388962; cv=none; b=cyDFtDQm/VC8zs4TXBy6JMlee8hmv/NIWsCqTIEDrVQS94DsHipsHuXIRE3Q+u35MlmTPJstZ2eeX+SjPzRbat/ZXeek+acoP6Vowot6PbaHJjBUbhiNM/tpqq4Z6WNLcQFw1ZkLaqHXX8RA/OcAUQcETUtAsZoFXf3iWch60aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388962; c=relaxed/simple;
	bh=6iFYPVcmTxjkFScdWbvrsxfYnLxutrMiBw9O96s+PmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKT5bELJqPZej+pbIx209QT0iVG7RA2nl77nWkb+UNVQp26iqlfb9Z52D5zHnkPkBSmRKpAW1QjewWkFGC8KBMKzXTxqfuSbCHHOBqqNXRXw9M59UIn8JYpKyL/WR3SqidgQyTWqGDIDMOtrS4eylRDq4M5TJ+nUnd8xtNGhq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjizFZPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjizFZPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72039C2BBFC;
	Wed, 22 May 2024 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388962;
	bh=6iFYPVcmTxjkFScdWbvrsxfYnLxutrMiBw9O96s+PmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjizFZPBcGHidrPo94oV7dsEB/odjyHgZEsEHgv4J/uUefTspSSBFMg5v0mM5sjoN
	 EGK5igMwk877aAOZFAkfbO8WaEVtYAHQpnfUfWtYnwm0C8BSnjgH8GZJXhf2rXFDIA
	 gfEF70prLSF2CwErLhbe5Atsx+YlAPyfeiPTqtP/aVlC6hrTHLd+SPbcWZaUWKVD2L
	 5UTd72XpdkCLO2eIul783eSvubXF5t4Z0YU8HLB+AIoiTpJNvAaoBrYVVccDLzRr2S
	 NfH6+vY2Y2nRkbUIwxfjoKrwfgZ/CGV9dR0lYXOUs5hOQgvXoIvgMvRrHiru0mKIZb
	 +khg+4nXe4zAQ==
Date: Wed, 22 May 2024 07:42:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] Log kernel version in check.log
Message-ID: <20240522144241.GA25508@frogsfrogsfrogs>
References: <20240522113408.392468-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522113408.392468-1-cem@kernel.org>

On Wed, May 22, 2024 at 01:33:38PM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> After collecting several xfstests runs, it's useful to keep track on
> which kernel a specific run happened.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

I wonder if you want to capture more of the system variables, like
__generate_report_vars does?

(Should we be capturing ${FSTYP}progs version too?)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  check | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/check b/check
> index c6dba89b..7703c128 100755
> --- a/check
> +++ b/check
> @@ -478,6 +478,7 @@ _wrapup()
>  		fi
>  
>  		_global_log ""
> +		_global_log "Kernel version: $(uname -r)"
>  		_global_log "$(date)"
>  
>  		echo "SECTION       -- $section" >>$tmp.summary
> -- 
> 2.45.1
> 
> 
