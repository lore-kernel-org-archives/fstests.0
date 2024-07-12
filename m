Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C413D622
	for <fstests@vger.kernel.org>; Fri, 12 Jul 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777769; cv=none; b=d6fCqZuuIGvcSFe4F9hE5xZJM+2ReKZJTChvQsrPnBl0slZC8ESfMMJu3etwUh2593tQXr1KYmthBDEhRURmKj3p6F9+Urd+f9oUI5bIUdx/Gcn/jxOEpw29HfDQSMO0RvGcZlVX+1W5y6DQ9hyLsrEg93OOMVhDlNObp99Oan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777769; c=relaxed/simple;
	bh=w8Xrf/IpCVCPhAEoCqORQ5F6W3zNsd/b+U/U5CQploE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl3nv67pUd228IwpzH0RYtEua+No5NFMbhnsHDF+y5UGavaelTbZ6Oc3fi31x2bS8X+QAUI1p86sFuU/kX7qBjggC4GBtYITuyPz3MrTzgLWFrOYv+gJZmTj2migAjT9VNdXiuOMnui6uKalE16JzMb+iu0CP5E9hLjPAKzcRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C42uG3cD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C42uG3cD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EC1C32782;
	Fri, 12 Jul 2024 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720777769;
	bh=w8Xrf/IpCVCPhAEoCqORQ5F6W3zNsd/b+U/U5CQploE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C42uG3cDeZyuc6fN4ujql0tIaDpNlX3nGhTwS/isZLcmRZRhsKiJ7z3s5S5X6ek05
	 ztJ6/1QVT2NssaPsD9vJhrpdYzWBiVLMkUzA4Bf76Byeks9pKX1qauDyNwIx6opy3z
	 eBsqvTdDVF0KUO85cFXtSwRG8xyiHwzwt11JnF17iCE3x3zCGtEdm8UjvvcBR5/JcJ
	 +umRqqkYhilR+ClpZOlJ+8EmNibjnf+g1CSfczcrN2Xrw3q+TbEcX1G6KiscMJiF3t
	 nLe5rOB6cuMOSD0SS68Zx/miMmrIfBA80xMSBWGI2IKXgzhWpTmzlvBxBlyOqFzmvu
	 hCCQYEJgauirg==
Date: Fri, 12 Jul 2024 17:49:24 +0800
From: Zorro Lang <zlang@kernel.org>
To: da.gomez@samsung.com
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Zorro Lang <zlang@redhat.com>, mcgrof@kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v2 4/5] common/rc: read config section mount options for
 scratch devs
Message-ID: <20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
 <20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>

On Sun, Jun 30, 2024 at 11:52:43PM +0200, Daniel Gomez via B4 Relay wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> MOUNT_OPTIONS for scratch devices do not have specific fs mount options
> values (such as TMPFS_MOUNT_OPTIONS) from the config section. So, allow
> the scratch mount options to inherit section config values by reading
> them from _common_mount_opts().
> 
> Move $* to the end so scratch device can be umount/mount. Otherwise, we
> end up with multiple mounts in the same scratch directory.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 51827119c..627dbaaaa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -231,8 +231,8 @@ _scratch_mount_options()
>  {
>  	_scratch_options mount
>  
> -	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> -					$SCRATCH_DEV $SCRATCH_MNT
> +	echo `_common_mount_opts` $SCRATCH_OPTIONS \
> +					$SCRATCH_DEV $SCRATCH_MNT $*

Oh, you want to get the "specific fs mount options". But sorry this
change brings in many regression failures, e.g. generic/219, generic/691,
generc/381, generic/382 ... fail (on ext4 and so on).

Thanks,
Zorro

>  }
>  
>  _supports_filetype()
> 
> -- 
> 2.43.0
> 
> 
> 
