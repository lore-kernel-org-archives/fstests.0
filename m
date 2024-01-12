Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141F175B0
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7XfyT0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C3C433F1;
	Fri, 12 Jan 2024 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078749;
	bh=nVbfdQHWJpWkdcBiZ7Ehfw0gJ9aNdrxrc2X2Of20Akk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7XfyT0BM/jATPzH0tAjbcXFG0MTGrTMQ5gYQxEIukMSvqm11QVq8LxXWkYTNb5dU
	 zW8lOliOzguubjprFc+LslN+InwtvwTbamnF+wWEdr8TwUinleFMNElvqueMKB6PzG
	 nYD9XaddA6l0rWmpSaL1X9Po1JSejm+GF7BSL7QC/J5YEXb3Ixk+u928+jk+iEIw9y
	 PUviajCSog1tOGHDAoRr/n+izRGNE6Gc+nOiUA24z6CyGzuDRhhcUdNCrfE4lPytMC
	 3FCtlyaA0Xd93ZSs6ozG0eal3Ag4tH7FvDkKdKvcKBosWtxgHdVJdGbi704kbfsF0A
	 To+N66XHYhiRA==
Date: Fri, 12 Jan 2024 08:59:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] gitignore: Add missing /src/t_reflink_read_race
Message-ID: <20240112165908.GE722968@frogsfrogsfrogs>
References: <20240112094524.3797754-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112094524.3797754-1-lizhijian@fujitsu.com>

On Fri, Jan 12, 2024 at 05:45:24PM +0800, Li Zhijian wrote:
> Add the binary to gitignore, make git status clean
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 7508b6e8b282..e567a56ff129 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -165,6 +165,7 @@ tags
>  /src/t_readdir_1
>  /src/t_readdir_2
>  /src/t_readdir_3
> +/src/t_reflink_read_race
>  /src/t_rename_overwrite
>  /src/t_stripealign
>  /src/t_truncate_cmtime
> -- 
> 2.29.2
> 
> 
