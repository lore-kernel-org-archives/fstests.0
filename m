Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0024632C
	for <fstests@vger.kernel.org>; Wed, 11 Dec 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939083; cv=none; b=jd5To7ps9kGG26jGMj3oeJb8gvQxXST5bT5lP+DN3cFGZT6jwAAMQaC7izskbCu6ILFwZVhtnKTLG/5tLh7JjYovvWobVw319DNLEbAJv/LREjGH9nf7ZF+Xq8uMgc0xjVkKGTfRd0ODKWDfbUC7KBNx335mlMg7ZYz3gM2nSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939083; c=relaxed/simple;
	bh=HnnCSO4hdUJZAlP9sqMLeT4e8wlU3dRIVs1T4FcpB94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccv5wgsBjcZOtfxG80cR+v4bMgsfsUfKEm8191jBsILKLG8Q1cbx/wxyVjwRxkVuhHMOVTpXzkQTKcYKB6lU1GYfMOxeT+jvVSuUR8rUtpLXZigmrjQdWUG6h6w6WttglcTyI4ZXA22yTls2QrAa1tzeyzu25qjtItmn4KYz4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adf33iue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adf33iue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3DBC4CED2;
	Wed, 11 Dec 2024 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733939082;
	bh=HnnCSO4hdUJZAlP9sqMLeT4e8wlU3dRIVs1T4FcpB94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Adf33iueslxMwugLapoJzDFOq7G2qIURb9rUUN3fWx1HPVGDWgL8AgRRKe+wCSdGo
	 VAdMriExFPZ0E4jakCwsoQa9JDvLnagSoPKDrt9rfZIF2SYCRES9JdvcfwUeDRO9y0
	 chS4IxQCJ4YrvvCfvTFWHmMDhwqfcilEtEefEUkJI7oYUrMlAZSMKnzObOgThMmz+n
	 FFNaIHGF7q/WzVnSrL1jvIBxwVR8dzA6afH952DgQgn+Oq6Eu/boBGoPhI2y3Mdqtr
	 u+2pI+e7kV2c1vPdo2FDx7YvJ8Y8Kl/i1r19dqFpjfGdCzHKqppF6sIxdVp2J1eG5j
	 dsxiXOHdOECsw==
Date: Wed, 11 Dec 2024 09:44:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: cleanup scratch_mkfs_sized
Message-ID: <20241211174441.GF6698@frogsfrogsfrogs>
References: <20241210065435.1234629-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210065435.1234629-1-hch@lst.de>

On Tue, Dec 10, 2024 at 07:54:35AM +0100, Christoph Hellwig wrote:
> Move the XFS RT specific code into the file system type switch
> statement.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 1b2e4508d767..906905daa92d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1152,7 +1152,6 @@ _try_scratch_mkfs_sized()
>  	shift
>  	local def_blksz
>  	local blocksize_opt
> -	local rt_ops
>  
>  	case $FSTYP in
>  	xfs)
> @@ -1202,14 +1201,18 @@ _try_scratch_mkfs_sized()
>  		[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
>  	fi
>  
> -	if [ "$FSTYP" = "xfs" ] && [ -b "$SCRATCH_RTDEV" ]; then
> -		local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
> -		[ "$fssize" -gt "$rtdevsize" ] && _notrun "Scratch rt device too small"
> -		rt_ops="-r size=$fssize"
> -	fi
> -
>  	case $FSTYP in
>  	xfs)
> +		local rt_ops
> +
> +		if [ -b "$SCRATCH_RTDEV" ]; then
> +			local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
> +			if [ "$fssize" -gt "$rtdevsize" ]; then
> +				_notrun "Scratch rt device too small"
> +			fi
> +			rt_ops="-r size=$fssize"
> +		fi
> +
>  		# don't override MKFS_OPTIONS that set a block size.
>  		echo $MKFS_OPTIONS |grep -E -q "b\s*size="
>  		if [ $? -eq 0 ]; then
> -- 
> 2.45.2
> 
