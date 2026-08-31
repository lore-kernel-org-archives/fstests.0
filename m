Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BC463B8D
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196786; cv=none; b=oki0Xx1pGjghAkDYeP17xrM7ivapc/Rf6EfnrGiMv7OfDLt3+WBumpwJcsqzQbC6ZUQoVqreQmBgTtHNd9fI0fiLwV4W1rAttP5OEP4b9T17ufa/vzAVpHC54nJ5ndjsluhOFAAHYh7yBX2YnPNwKO3jCLVVHvU5wwi/imb/Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196786; c=relaxed/simple;
	bh=peTrvDR+V0VGQQzPurl56P6/EgKRYnYv8CtHT04XNW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OutC5/Qz6lQhNhhYnz7eihOk0bby1jrp9+jte5YT8YogGRk1RzRcv3QzDAKetQ6whS1h+gG26GS/D86e/wOapAwEcyPgBt5Ko5Mm9pxCYcxPWT/KleaXvndlC8IRz06EfFaGP8jVALzdtjfTUCpYNcyUicF+hDEP74Dc4iYYa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUzFmhGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUzFmhGD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A678D1F000E9;
	Mon, 31 Aug 2026 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196784;
	bh=5VFxBrOYcAdv2Yd2gTTLdPGjrFp1y3+tzswiFN+Y4fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aUzFmhGDPSpjCwaGsKFz/3ku/AYOQ/asOCbNoPSzEPQuvliFv1vpPp5+ErZyVkccg
	 OpW+ay91j/H4OGkpQHVK39EhEhRcJvPz1rj8YNu7Qz5q2Bx2FLaVbx2brvH/rnLcG2
	 T5FuOLtwj1ppH4pdVvHc/qh3o7Y8fuhxXa3a40R3LglxJzaIMFCkoaET9VOebMki45
	 zGOnBojpUkVYRVoTqS5T/o+kwEXb/P12uyseIF1i25aaREhjzIIK9vPmN234mCatFq
	 SVpHow0+Zy7RxH5BrNkg1D0ta91VIU3vhZRub0+FrEouIWFrvx2+e2ygRP5y9a5vfW
	 YfFFlr6ONcHxg==
Date: Mon, 31 Aug 2026 10:19:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 5/5] generic/760: enable sub-block reads
Message-ID: <20260831171944.GF839663@frogsfrogsfrogs>
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831065120.2578146-6-hch@lst.de>

On Mon, Aug 31, 2026 at 09:51:08AM +0300, Christoph Hellwig wrote:
> generic/760 currently limits reads to PAGE_SIZE alignments while allowing
> smaller writes. Use the new min_dio_alignment -r option to query the minimal
> read alignment and only limit the read alignment to that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/760 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/760 b/tests/generic/760
> index f270636e56a3..facd83e4af0c 100755
> --- a/tests/generic/760
> +++ b/tests/generic/760
> @@ -16,7 +16,7 @@ _require_odirect
>  _require_thp
>  _require_hugepage_fsx
>  
> -psize=`$here/src/feature -s`
> +psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`
>  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
>  
>  _run_hugepage_fsx -N 10000            -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
> -- 
> 2.53.0
> 
> 
