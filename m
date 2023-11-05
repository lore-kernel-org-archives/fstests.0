Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078B1FD5
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7Y03aw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEC6C433C8;
	Sun,  5 Nov 2023 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699202473;
	bh=JEffrfn8DElXvR5vUzPy7Gq6oJvycqlXV4ewydJbkAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7Y03aw2yPGCH5RPvUC2ZSrBLPfxaEuZttOQw+1hBsr2v0paFlhouE4qLg3O0LZbR
	 QlY1os/lbpk416OY4qtMv4S69FMiwDllyqAtbRPjWjgyKjWqpJgp0mfpC30hhe7cXO
	 58QWoUuftjwe05JsK8Osa6RtXYpL+nommbKbVUOKf48DVX18vC+80CZTmxpueu2RqD
	 MqS8Dh+pY7DVZd/DsOytvJeUcg9rF+1lNfJRBPG5vnn2h4Zxf5q8rtS+y6Og66A5DQ
	 OWU5fEbkhE+rUv+voEduoTS+Q75Zz2E4TjGYJZZVY/wHp0T/ycDua6ROCFNHk7AfYX
	 tPiPfFHoAHwkA==
Date: Sun, 5 Nov 2023 08:41:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] ltp/fsx.h: Explicitly use int for return type for
 aio_rw()
Message-ID: <20231105164112.GB1203404@frogsfrogsfrogs>
References: <20231105082014.1010683-1-raj.khem@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105082014.1010683-1-raj.khem@gmail.com>

On Sun, Nov 05, 2023 at 01:20:14AM -0700, Khem Raj wrote:
> Fixes build with clang-17+
> error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index ee4b8fe4..c0aec23f 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2581,7 +2581,7 @@ out_error:
>  	return -1;
>  }
>  #else
> -aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  {
>  	fprintf(stderr, "io_rw: need AIO support!\n");
>  	exit(111);
> -- 
> 2.42.1
> 
> 
