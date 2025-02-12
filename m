Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443442D600
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340957; cv=none; b=nCOf9TnzwecenhajeyRnlW2Liz87C+AAI3Ir5AWxObMqE3RpXRl4TgfWK0YS/bMFdp5g8EBiZ0p/KKwbD9oFZmH3cAgZ0iPJb/cOKIsnSE6hLqBHhX8mQW1/FkSQYv6MeDUSVr0EWlyOFVgSUgcDDd8gsxOhCTQ8z2QJikv5MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340957; c=relaxed/simple;
	bh=2yUR1pSoqMzGcnYVVlp8cKWcETXrub9UlRfI/89DXIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIScyP375ZiyvItSkUh7SxILVQs5TqL638N0V7FdLvB/W8MOylBtBTB/j05ylhEyKY6tr+GPHm4qzHoOkfG3gqxeQvjXeGhV5oHqjsvPEZAi5ey7fO1ifzrzAYldLVrE601tNpDY4lysmFo6oC1+C8cg9eq2H9q1OpHiHb1u90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPWq9dg7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPWq9dg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE4C4CEDF;
	Wed, 12 Feb 2025 06:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739340956;
	bh=2yUR1pSoqMzGcnYVVlp8cKWcETXrub9UlRfI/89DXIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPWq9dg7Gtn97XAnvLg922U9jSO1ELL+C9RM9kLG4BBdZxWPYFmk0ut92HYZ1RsV2
	 JDOA8Oj6Tquhoahz0ZrEl9dRiRU87yH0EI7nZF+lpdS9c3oVjWTcDCbtEkMnU7YHzh
	 C+cmDmUcrSGn469o3C6GevvGFDnksvFpSoq9yZYBUlyJws02uU0+gcwfnMC0xW4bSD
	 zlr7fwPGgUUUhYfFzlBIsptWOW1SYUVW4cepqYpcEHbsW6tj71Gb1LfbKQJrw529yy
	 //7zPrJjr5RtzbNdhtVFhyXknvYNOwSvafMhFOiJ8QBz2xiOaUM0WF8LrBvi6OmmNG
	 1N6s3q4Wg2duQ==
Date: Tue, 11 Feb 2025 22:15:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: use '-std=gnu11' to fix build errors with gcc-15
Message-ID: <20250212061556.GW21799@frogsfrogsfrogs>
References: <20250210165715.44659-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210165715.44659-1-zlang@kernel.org>

On Tue, Feb 11, 2025 at 12:57:15AM +0800, Zorro Lang wrote:
> GCC-15 does a big change, it changes the default C compilation
> language standard to -std=gnu23. That cause lots of "old style"
> C codes hit building errors. On the other word, current xfstests
> can't be used with GCC-15. So use a fixed language standard --
> "-std=gnu11" (to match the kernel and xfsprogs).
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> The upcoming gcc-15 does lots of changes, a big change is using C23
> by default:
> 
>   https://gcc.gnu.org/gcc-15/porting_to.html
> 
> xfstests has many old style C codes, they hard to be built with gcc-15.

Quick question -- does the same need to be applied to CXXFLAGS?  There
aren't any C++ modules in fstests, but it'd be nice not to leave a
weirdness where cpp files aren't built with a roughly contemporaneous
language specification.

That said, this at least gets us to the same behavior as the linux
kernel and xfsprogs, so:

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Thanks,
> Zorro
> 
>  include/builddefs.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 7274cde8d..631e5d83f 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
>  
> -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> +GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu11 -Wall
>  
>  ifeq ($(PKG_PLATFORM),linux)
>  PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> -- 
> 2.47.1
> 
> 
