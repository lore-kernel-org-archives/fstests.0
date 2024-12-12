Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123013B791
	for <fstests@vger.kernel.org>; Thu, 12 Dec 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985655; cv=none; b=Hedgj0vqZEPGLvnCPzm6taYVuyoGC3KBoAd5tXz9wjqHDAlVzN9/SFJ/Z8KCByz1XulkKcCIs3BZpB4jYLGe4pnF6f7xC67nxeXvk6IpItZd0H28gZeBJdD3S1V8YbTbz3vfe8JAhtHOk9O6ptldvUMuQVhMYpNk3NWaWep5YJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985655; c=relaxed/simple;
	bh=vgDlMSAQNN79EhwrWSENTVowpcQzx+ftWdh1qP2GGc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGLD1UsxiERCFZ7dl9DQILsFyJlgCggQgvONjrd/JXGG0OxdY76uEWsaR5+Ab5HpdNItDB4BCUUr9Vjy34QR+COYMY5GFQw3+4NnqdyWaEcL4HNfKwQZR6MAmZfIOKp2/1ah/eDxATKfRDFeXTlnDg5KCnVtLUw8CYXNSEQBdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIOSlDqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIOSlDqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D707C4CECE;
	Thu, 12 Dec 2024 06:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733985655;
	bh=vgDlMSAQNN79EhwrWSENTVowpcQzx+ftWdh1qP2GGc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIOSlDqTJBNr+NWV99dolloPudd2MfvIbCdkU15QDMukJHcQa6EuC54HrT7GreqH/
	 Y71OpbTMvvUxHd3Zc2793+/OajgEr3U4faHr/xDpKh8MUw5JAbG5kzkb3xcwLmT8My
	 GOk/cpTL0ABdrQHgiuZk+o57I37/XQuxU/8sRiU+Yl2J5jVKtLwhnU35sV2mdW/l6V
	 S635t+gRAXgfmM/uI6n0tolnQPudG7MrlTUqBLMZfls3/ynwLSeQEh4eL9DwR7wUMJ
	 D3BOdYwfpAQoHikLpaZK2OeObOAji4CXDEC6o6LD5bPNI2uj7GNbOmb3kXG5AVXx5c
	 /Af97nj4Jp2Sg==
Date: Wed, 11 Dec 2024 22:40:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org, cel@kernel.org
Subject: Re: [PATCH] common: call _require_scratch_dedupe from
 _require_scratch_duperemove
Message-ID: <20241212064054.GA6662@frogsfrogsfrogs>
References: <20241210065346.1234550-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210065346.1234550-1-hch@lst.de>

On Tue, Dec 10, 2024 at 07:53:15AM +0100, Christoph Hellwig wrote:
> _require_scratch_duperemove doesn't check if the scratch file system
> actually supports dedup, so add the proper call for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

> ---
> 
> Btw, I wonder if we should simply stop using dupremove in favor of the
> xfs_io dedup command which seems lot less cumbersome?  For now this is
> a quick fix, though.

In the old days of xfs reflink support, duperemove was a good trigger of
argument parsing bugs because it would effectively launch 1000 ships of
weird at the kernel.  I haven't seen 559 or 560 barf in a few years
though, and I've had 561 disabled for years because it takes forever to
finish.

--D

>  common/reflink | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/reflink b/common/reflink
> index 22adc4449bc6..9177c45e70bb 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -83,6 +83,8 @@ _require_scratch_duperemove()
>  
>  	_scratch_mkfs > /dev/null
>  	_scratch_mount
> +	_require_scratch_dedupe
> +
>  	dd if=/dev/zero of="$SCRATCH_MNT/file1" bs=128k count=1 >& /dev/null
>  	dd if=/dev/zero of="$SCRATCH_MNT/file2" bs=128k count=1 >& /dev/null
>  	if ! "$DUPEREMOVE_PROG" -d "$SCRATCH_MNT/file1" \
> -- 
> 2.45.2
> 
> 
