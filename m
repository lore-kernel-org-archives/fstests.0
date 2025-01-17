Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80619993B
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737147723; cv=none; b=ARDVO15/NJx9brj/cUmpURIHhtyo6EhP9Yzm6z1jB+IFvzVQeH+m3LVRduuSPy9ri5Am9TTiposwT2+AWbwHP3fgl/DUscHA1hTmHXm87nehz/7XqLKQg4nlCygqVlKt+yrTg2nahdiw6cTfelYWy6cf4weYwUrecigc0Td3Gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737147723; c=relaxed/simple;
	bh=/Rjm4i0iFLn+Yxh2mCAY9Elz8pix7dLgSHXN5chhLbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkegVxhiH6VYDUUrZ5tvjewXRSxC/RXcKb/EYs55bSXW1C1ljlpaxBZoU7DAL9yWTK09Ur8162fCANWWaAhgF8/lCy4hUkqRPePGkCThk+l43TaJ79A93tvh8QkdT28Pzd2gWimI1c8h+rJaTNGbUypBMx2LkxqYO8ILReSB4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJTCuyzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJTCuyzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33F4C4CEDD;
	Fri, 17 Jan 2025 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737147722;
	bh=/Rjm4i0iFLn+Yxh2mCAY9Elz8pix7dLgSHXN5chhLbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJTCuyzlScXDyuHNIXTKoK3xwgU/of6isbM5sKSd/EqcfgHnfbCtXdQ7RdGDYX/bC
	 NwNCOYOcLMeLqJW8IecislNZ5mS5xa1GaXhudzk30NQRjomxFpvPEfXCs3SClQqUb7
	 64CjqdRbNIy/ITtppevFifL2TEPsgDpEJcR928zpXfz78Ub7aayPIG7OHwYUd13sQu
	 8Gns6GSOnlhVXlscYDnr5j/AkZUeflYyw8LEDrRmkYXv347JO7i94umwAEQ2pMxy0y
	 LAWBTVFrP15tat6H27g3XRenGdmaXRJ9g2Jwa34gDIasvgFsg+HB/4S85RpTK4pRyU
	 hUYKGqakC2kng==
Date: Fri, 17 Jan 2025 13:02:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/32: fix test failure on kernels which don't support
 bs > ps
Message-ID: <20250117210202.GJ3557695@frogsfrogsfrogs>
References: <20250117190659.3189518-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117190659.3189518-1-tytso@mit.edu>

On Fri, Jan 17, 2025 at 02:06:59PM -0500, Theodore Ts'o wrote:
> When trying to mount a file system with a block size > page size on
> kernel which doesn't support this, suppress the error messages from
> showing up in the output file lest it cause test failures.
> 
> Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/xfs/032 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index 41a9134d8..9c1741cf1 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -44,7 +44,7 @@ for ((; SECTORSIZE <= 65536; SECTORSIZE *= 2)); do
>  		if [ $? -ne 0 ]; then
>  			continue
>  		fi
> -		if ! _try_scratch_mount; then
> +		if ! _try_scratch_mount >& /dev/null ; then

Should we dump that to $seqres.full instead of discarding it?

--D

>  			if [ $BLOCKSIZE -le $PAGESIZE ]; then
>  				_fail "mount $(_scratch_mount_options $*) failed"
>  			fi
> -- 
> 2.45.2
> 
> 
