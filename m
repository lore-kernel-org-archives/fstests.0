Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A491370AE4
	for <fstests@vger.kernel.org>; Fri, 10 Jul 2026 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663913; cv=none; b=c/U8FQLmzESLNG1YXCgk+B74v3A24ZBeMIt7UsJgRXw+k0zWYF8II9mQn+cuFyAvkaKQPsHe43BZ93AAGQRyVWB7OwdVWI7JKQ7wjYElbdBP5OV+DKy+plTJF/O0vU5u3urLuwvvIYBb9aSUujXnYpO/gn5EjB0yuwIC2EK6x30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663913; c=relaxed/simple;
	bh=jgtPZj7O5u1qzhidTWu02J6xeQ9VVYYFeccC3klmSO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+/+dLtKMImXynmiD5CRREqCA8GIS0k9UcrPJfwJeSVxhQKQrPByHDCH9ozkKjFnIenO8H9aUMOTOj6x4r/YNqYot0xuFswY94yOJS3ScoC/UBkgAxjC3iIk5ZSM7pOYfxoRRZyvzM9v5kMbTY1MlzAPrbI+9MgChufnkJHDSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjDEhvyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjDEhvyC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0F3B21F00A3D;
	Fri, 10 Jul 2026 06:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663912;
	bh=YtlczdL4HR/VEbv2V2npHuQOKJ3aucitD5FUhKB5fFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AjDEhvyCvnelPcsdtBxjomHm6EL5+cZHC9dC7qkyPnO5daSWDfw/Inv2dAUioeVP+
	 QWDtFO+iP/yKqWbuUWLRzpFcbiAiOK9p1FOJ//sWTqrYinDT+P/creWbwQPT0eHncs
	 aVqPJ7i1prPA3+n2Vxgulpgqx7WIfOacw9lzCk01N0Smh1+werFoZcemzBjqN3CM6h
	 W8ZkBiroUTuF0iUw0ERe28PZ+VwBgB8U7bqyOZlh+sC4HLkAZay8ArPhwxaAoGBgx9
	 z9lEn47h5It9BwwD9xD54/SFa5/2S4k7KMw3OvrZiKi8dCvanaR9Xz0Ws4yukXjjTy
	 aokjC9kwm2C8w==
Date: Thu, 9 Jul 2026 23:11:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] common: log mkfs output in _test_streams
Message-ID: <20260710061151.GJ15228@frogsfrogsfrogs>
References: <20260710052229.1841342-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710052229.1841342-1-hch@lst.de>

On Fri, Jul 10, 2026 at 07:22:08AM +0200, Christoph Hellwig wrote:
> Log the mkfs output to allow debugging the mkfs paramters,
> especially when mkfs and thus the test fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v2:
>  - really append to the log
> 
>  common/filestreams | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/filestreams b/common/filestreams
> index 838b5921520a..cce7599817cd 100644
> --- a/common/filestreams
> +++ b/common/filestreams
> @@ -89,7 +89,7 @@ _test_streams() {
>  	# Skip these tests on zoned file systems as filestreams don't work
>  	# with the zoned allocator, and the operation below would force it into
>  	# the tiny data section only used for metadata anyway.
> -	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
> +	_try_scratch_mkfs_xfs >>$seqres.full 2>&1 || _fail "mkfs failed"

Woot!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	_scratch_mount
>  	_require_xfs_scratch_non_zoned
>  	_scratch_unmount 2>/dev/null
> -- 
> 2.53.0
> 
