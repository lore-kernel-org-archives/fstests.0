Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DB4A8A0D
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196773; cv=none; b=dGmeyAGwVgZU0p3pLrWgb37ESCKdCN9EN3MUSo00NKaIVVi2BFK4UaN3dwdevN9BNcBschowykOnIKMgDV4nll+wlLk+suCyjMGfM9gDlyuNA8jn6xZhWEVeg1KVO+j8abIxKq6GvlJyFjudzuRsSxqd1dNqHBhl82jE5cZ8Izg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196773; c=relaxed/simple;
	bh=Y3R6i/qsrzDsVKdcgp2LBpMN9j17TIkog9OD7mKKMbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZbjNteiMZT+urXCVTweJwcLEpU6cRBYcpINHWB8M9URlIDAEN2qYuZcprIuYQRO7hj8SXnQrYJB8+VSzgLWYi7nuTQs6lRTBOni5icTr+WDP8JAyT70EtOHS8zl+NjgkYnNAqACl1siOHPDoSSGYf8xSdNlQhTXlU+h0Sdvqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mASgPyem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mASgPyem"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 041541F000E9;
	Mon, 31 Aug 2026 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196772;
	bh=u/45FB6zZSl70iU5WdM5N6b9LW6Dfx5NKw4z8xyO0bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mASgPyeminTzKITPbakK1FVobmUTmzMvTf34gCtZu/jjvs4+qIQmYt95jReYavzCq
	 YIzt3i/lfcRe8oPSlljIGJOAuhI67oxE/ifIiPudJMPN6IUQ0Ak2HlaiihpvW459D/
	 cwvlnu1nfq/NJTIkg3rmEheM/S7NXjzcyzR2GJwbtOF7TGPm51ogdTF8twnE/N5raO
	 vsHxo1e9i1s3EidDl/12SMAELaHpLdv/fBqpLoovZkqeoXthpBsaygwAcaAW1PoC4d
	 9/mTDY3PtJfq5wLERA9Q5U5f7QbGe7Xalviu+n4Qvw+xNJbjbxrpm1Xn1L1OR0Nqyx
	 YzDkq9KbX5+bg==
Date: Mon, 31 Aug 2026 10:19:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/091: enable sub-block reads
Message-ID: <20260831171931.GD839663@frogsfrogsfrogs>
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831065120.2578146-4-hch@lst.de>

On Mon, Aug 31, 2026 at 09:51:06AM +0300, Christoph Hellwig wrote:
> The description of generic/091 claims that it tries to exercise sub-block
> direct I/O, but the test currently limits reads to PAGE_SIZE alignment.
> 
> Use the new min_dio_alignment -r option to query the minimal read
> alignment and only limit the read alignment to that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I've long wondered about why reads are the page size when xfs could
easily do smaller...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/091 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/091 b/tests/generic/091
> index 5cdf04890c0e..b2fba09d39ef 100755
> --- a/tests/generic/091
> +++ b/tests/generic/091
> @@ -15,8 +15,8 @@ _begin_fstest rw auto quick
>  _require_test
>  _require_odirect
>  
> -psize=`$here/src/feature -s`
>  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> +psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`
>  
>  # fsx usage:
>  # 
> -- 
> 2.53.0
> 
> 
