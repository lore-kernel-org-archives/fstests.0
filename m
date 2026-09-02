Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97525B099
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367760; cv=none; b=qC2skU1Ya/PWLIa29t6RArtwhweAtqrQynbr5Xg6uYl3a4l7BDTdc9FZbfNiZdKhuhp6/I5RsanZ2Y3hNlDGW7iN41UTOBKdE3C92dB1CphBLQ76b66vjocNH8jbAbxd8976j07Y6f8clY8AqjKg/mu1t0jZusiw4BSxE9vmcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367760; c=relaxed/simple;
	bh=iG2ss92tY3dYKghUiDJKGcv/m9314sWP0lISdBZ89OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSaLmrM21nx0D+L/NDshjdg0M0T9MViLYtGyKy5ADpZsSPrNitbWVhn/bGyomr88aeFyLegeOyuVw5KvCTn2fmPQRr7XT+WbE9J35Qn7WyejKc2Psxb9nyxbCRGe1jy/qgf8LIfP5Txm+Wo/8ASuprA2mLJDNa6RmId964NKRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg0hQtCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg0hQtCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E9A1F00A3F;
	Wed,  2 Sep 2026 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367759;
	bh=8j1y7A/k80IKHeUMJSbvHLgY28B952Pb4hqpofDCGVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lg0hQtCGnEINwXThayWIj5OtwL+TeLWRqKKAV2r1+Bnok6o6byiPxGRgHicIiNeV0
	 KQUip6FujjVmqtLSfpump7z0LtCNXx2S7/a3zd6S+j4zJsw5tTmwqte3x9/YrQeyLr
	 GDFAv2elPyt4Vvizg40BtSDH5sqjcAgtcQPyxyRssB/dbN4n8OjLynql3Lg/KsyYIG
	 MVFX+tzaQVkjiMjSq8Fm1o2Q1fVMCZspBF84p3NVJNc5qRRpNsxHfxsxcRrtPY48C5
	 gEyx8WC/24SRxLh1RITzSdgiCd0M0QYSWyGP0tu1cDk2K2SFR1AdujewqJK0mMchEA
	 9fgGiKkFxaTqw==
Date: Thu, 3 Sep 2026 00:49:14 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 5/5] generic/760: enable sub-block reads
Message-ID: <aphTd4oTGocK6hys@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
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

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
>  
>  _run_hugepage_fsx -N 10000            -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
> -- 
> 2.53.0
> 
