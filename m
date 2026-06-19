Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D581E4AF
	for <fstests@vger.kernel.org>; Fri, 19 Jun 2026 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844793; cv=none; b=HeBqvkDrBJMGAszbMgRW4I1plkPGs/z1gilZ2SYboZmGMPHm+C6cffy9lGmryBOpNGTh41U1Y4Hmm3rU0G3Nhmqkasjfv6bgckR6S7gySHIPPBIQ/Kt1gyHfFJ6SPR4kQ27JmmUZqmAJ20dSeMr2EeyvP3Wcm+/k7NxfixUW7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844793; c=relaxed/simple;
	bh=W4XYEtxmXQU1qXdYAN+ZNTvtjcGMixohxsi76Y6TOO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSfIvpR6+oHNtuHlBX7r3deUCaz+Z1+S2QAJWIPExjkeNeSUhtEHTYufWkZCBngjb3ZaE6ROeSe/TJvScLkNf7XxTagJRFFvPlUBNfXTlwF+0coFN8uX9Gw5HuKu14qTwlsyZq7oNV70xgCd5Wi6L2R1B3vc/icNtMUGCVH0jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A90BF68AFE; Fri, 19 Jun 2026 06:53:06 +0200 (CEST)
Date: Fri, 19 Jun 2026 06:53:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Timber <dxdt@dev.snart.me>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic/740: set env for mkfs.exfat
Message-ID: <20260619045306.GA24829@lst.de>
References: <20260618192236.654082-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618192236.654082-1-dxdt@dev.snart.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 19, 2026 at 04:22:35AM +0900, David Timber wrote:
> Foreign filesystem detection is added in exfatprogs version 1.4.1. To
> maintain backward compatibility, mkfs.exfat refuses to format the device
> only when it's run from terminal with a tty associated to it.
> 
> This is similar to how e2fsprogs work around the issue. However,
> with exfatprogs, this behaviour can be overridden with the special
> environment variable EXFAT_TTY_OVERRIDE to simulate shell invocation by
> user.
> 
> Signed-off-by: David Timber <dxdt@dev.snart.me>
> ---
>  tests/generic/740 | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/740 b/tests/generic/740
> index ce55200f..4f8bf099 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -28,6 +28,18 @@ _require_block_device "${SCRATCH_DEV}"
>  # not all the FS support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  
> +mkfs_preop=""
> +mkfs_preargs=""
> +mkfs_postargs=""
> +
> +case "$FSTYP" in
> +exfat)
> +	# For backward compatibility, mkfs.exfat refuses to format only when run
> +	# from a tty. This env var should override the behaviour if supported.
> +	mkfs_preop="EXFAT_TTY_OVERRIDE=1"
> +	;;
> +esac
> +
>  echo "Silence is golden."
>  for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
>  do
> @@ -83,7 +95,8 @@ do
>  		# next, ensure we don't overwrite it
>  
>  		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
> -		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
> +		eval $mkfs_preop ${MKFS_PROG} -t $FSTYP $mkfs_preargs $SCRATCH_DEV $mkfs_postargs \

breaking up the long line still would be nice here, i.e. keep at 80
characters.  Else looks good.

