Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA1197A8E
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881991; cv=none; b=anDHJTzJQrFQKa3lxMuy0rYmHmMrp7YOlwZkeC9CeOwEpQKh18y+yfga6CeFkbKNZHhhaThRgIfp1uoF18Q/aBAWp1XLtTR5Mk9H/UivJoKei7kQcQwbqjP/wZrooJb2y7uYvEt4BweB87F0mcXXUhqF2PXLWHYgIagrtTMTsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881991; c=relaxed/simple;
	bh=zkxifvOZAiPsXWCm3HLmTuYhICk8fKLhzL6remg6WsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpljsWsHAPPXbXzRaV117qwrFE83fmUuYQo235T7pevy7GNtCy9y9PaRA3h/KLSC5fpQpgiVJjmIuMS4LM7NkeQWfWoVxrL/24zrCS/sH9Pw9fXk6EtJZqn1ZlAck0II3QfLvML0Gc3MaqRdDz61VaXOZ6g6r3qI4+bUioLwuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/zok1ae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/zok1ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB9AC4CEDD;
	Thu,  6 Feb 2025 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738881991;
	bh=zkxifvOZAiPsXWCm3HLmTuYhICk8fKLhzL6remg6WsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/zok1ae/ZRI5K1VjRpGGQ85swB6TrDwzZtad8x8sD3TLYolFHVBBXAN8wkhSHuwV
	 UCHYNggWJWzLrMCFIlE9plCx1eecPahseLU1H2Zblty7Tyv9+nMc5ll6Z7GrbEyWcG
	 K3rA7yTd442tF8OTHIeP+dUKxVR7xt9e5KJXUWfS/OSKFjA9yOc4I7yb1KzuPlmNEU
	 vqZNQRpbjNsCcgYaPo4X4IlGjN3JStHoE74xFGN43CMBcZkyOOGI8/5i5Q0Rmm4NnF
	 ObNq/OaxAX80PAj8Od0+4F+UCCAMmOYvzm7TgaN1XDLG24MEqoVPyfjm4WskGDVEYt
	 U3Lg8bltQeWyA==
Date: Thu, 6 Feb 2025 14:46:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 6/7] lib: make a few symbols static
Message-ID: <20250206224631.GS21799@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-7-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-7-sandeen@redhat.com>

On Thu, Feb 06, 2025 at 03:20:01PM -0600, Eric Sandeen wrote:
> There are a few symbols in lib/tlibio.c which should be static,
> and sparse notices this so fix it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Yep, that's pretty straightforward.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/tlibio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index 22ff1adc..2aa8175b 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -82,6 +82,7 @@ static void lio_async_signal_handler(int sig);
>  /*
>   * Define the structure as used in lio_parse_arg1 and lio_help1
>   */
> +static
>  struct lio_info_type  Lio_info1[] = {
>      { "s", LIO_IO_SYNC, "sync i/o" },
>      { "p", LIO_IO_ASYNC|LIO_WAIT_SIGACTIVE, "async i/o using a loop to wait for a signal" },
> @@ -101,6 +102,7 @@ struct lio_info_type  Lio_info1[] = {
>  /*
>   * Define the structure used by lio_parse_arg2 and lio_help2
>   */
> +static
>  struct lio_info_type  Lio_info2[] = {
>      { "sync",      LIO_IO_SYNC,		"sync i/o (read/write)"},
>      { "async",     LIO_IO_ASYNC,	"async i/o (reada/writea/aio_read/aio_write)" },
> @@ -120,7 +122,7 @@ struct lio_info_type  Lio_info2[] = {
>  	"all random i/o types and wait methods (except nowait)" },
>  };
>  
> -char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
> +static char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
>  
>  static volatile int Received_signal = 0;	/* number of signals received */
>  static volatile int Rec_signal;
> -- 
> 2.48.0
> 
> 
