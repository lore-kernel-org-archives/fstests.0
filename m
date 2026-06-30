Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA136C9E4
	for <fstests@vger.kernel.org>; Tue, 30 Jun 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846786; cv=none; b=U5rcEYJtz2YtHVG4jfEv/BcgLINxGN4P9PxeJmLh50tsYC7n+BZplRdbDkXPgAR4V9MXWshE0m+VrMWjWjYUooRNTy5D6lay2t2sWZIfRrUX2mV7AR5U2pu+42OoVhA0U0v4mfw5ZCfZpgEDDtJPfJdUyVzb7GEcOxfzpTgLado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846786; c=relaxed/simple;
	bh=ftfquNJ2Zd8ntuvXZgIBQkCIkRLXYOystWDr7BGlSII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIeHz5atbErrqW8MqeEy/STOOO/J6n8DNU7GnZedkDSev+lf5lTqTwWMdzaQGosK1lQnHfp+U+IqHW2lidoQWkXhmPSorou2q+qy/lp7abrKK9+0cD3/v6P+6lBQfyXZ7P/E4X/ym4pIEr0hWw38AsSgCQ3NvCwONQ7fXyw0+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cduA7mEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cduA7mEl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2E7561F000E9;
	Tue, 30 Jun 2026 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782846784;
	bh=AckhKSwtUfeXeMQ6E0vLPnKuWJU2BMmTST6sMg7O3no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cduA7mElyuV+LVVtpztHOFzgsmuVgNYoioqXsj1yTMFsTFJl8a3sRK+jycScQg0dQ
	 DDTLWtcWfmXtgJsqUL927I16s9JPcfFv7ZTq4AYnflQPbhiB5/oBaAnqGY82CsTUPe
	 SKT6J67AXMcsAj3lpImiHSJsN3/vm6U5FGLZpl6GTzFEpNCOMyGQZR5kkXU0f/wM36
	 H/NVG/emzgTom6xPHIeU/wSBhMzWbhSn4Y/eTX/ttuc4cA1YfE0iLcfKygQ7wZySaM
	 GO2YrgCEpe9WzJVpmEyuh48TPRqPHC4x9qQxbw4FWw97qPcjyC02vgUmwomCp+UL1g
	 8zqZz57+Ehwig==
Date: Tue, 30 Jun 2026 12:13:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: log mkfs output in _test_streams
Message-ID: <20260630191303.GA6517@frogsfrogsfrogs>
References: <20260630142047.3612436-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630142047.3612436-1-hch@lst.de>

On Tue, Jun 30, 2026 at 08:20:47AM -0600, Christoph Hellwig wrote:
> Log the mkfs output to allow debugging the mkfs paramters,
> especially when mkfs and thus the test fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/filestreams | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/filestreams b/common/filestreams
> index 459de8c6b6a6..0b11b6644977 100644
> --- a/common/filestreams
> +++ b/common/filestreams
> @@ -89,7 +89,7 @@ _test_streams() {
>  	# Skip these tests on zoned file systems as filestreams don't work
>  	# with the zoned allocator, and the operation below would force it into
>  	# the tiny data section only used for metadata anyway.
> -	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
> +	_try_scratch_mkfs_xfs >$seqres.full 2>&1 || _fail "mkfs failed"

This should >>$seqres.full so that you don't obliterate whatever might
already be in that file.  Otherwise this sounds like a good idea to me.

--D

>  	_scratch_mount
>  	_require_xfs_scratch_non_zoned
>  	_scratch_unmount 2>/dev/null
> -- 
> 2.53.0
> 
> 
