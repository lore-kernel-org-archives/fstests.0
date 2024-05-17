Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65A12F58D
	for <fstests@vger.kernel.org>; Fri, 17 May 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961278; cv=none; b=PKj3CKWLyYHu1+OUAA2DQob8ocZv6Ep1qkUZ7S3Bo5twJrcViLiUrWLLGQyBieX2CL+7utMXHJY1UGjJwMNtfshUHQR+roGyhfOUwGbTsAhlyuwImEmrQRnqDODclvpRs75W1IKnaAdoGIfpRRzj+QrsoWQGnIrQqoyyi4ibKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961278; c=relaxed/simple;
	bh=XxQBbdnSCv+pPTKYozrKosgdHCBUKOheOxPH9+HRLPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKc3NInss+gssCGC6XlVXgPGXSJD5/vw9dJmKL2yiJHSNmf7cAC0TOabKPhqdQ1a0pJ8ZeGbXcvEaRz3ICLH2KDWW5OzmX6yQj6fRivyWUH8RiUGBis5wBL3ikn+S5jZwPMste6fX1YcVV2lfDASq4S8exje5vQJ3NF4By5iP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRhdvcQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRhdvcQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3882C2BD10;
	Fri, 17 May 2024 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961277;
	bh=XxQBbdnSCv+pPTKYozrKosgdHCBUKOheOxPH9+HRLPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRhdvcQ3BRtzr0GRp9U8esE6GwCq28wIkqDhP7ulQersq6cb0Qmv/1XW4Fdh3fEx5
	 +LEWS1QJ8t0cxw/UB/MG+4UmwZpiKq47wzZfUMPdH0YMZYwRhVkp9zUwzw2ycmYLT+
	 qzeuLQJqFuAFBS2vDIArjpcfA/wDzLe7MArhVqUYdUWt0CbxEizLZd+qU9hjp0+BmH
	 8n6Q3FRkjCpNZ4YTTXqoOIjr5KeSlSIDwVjmul9VUk/ZpU4doBIUHIFOCjyaSWiWv9
	 zG+jgYxDENEioN+nVwjImJyYUoYGH2auwp9rgR4k4z0v6ZS7+dRx/Yd30X/M84aASB
	 hZZH5pTPt9VKw==
Date: Fri, 17 May 2024 08:54:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240517155437.GK360908@frogsfrogsfrogs>
References: <20240513131254.92412-1-kernel@pankajraghav.com>
 <20240513131254.92412-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513131254.92412-3-kernel@pankajraghav.com>

On Mon, May 13, 2024 at 07:12:53AM -0600, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
> while filling up the buffer for test 13 - 16, round up the bufsz to the
> closest filesystem blksz.
> 
> As we only allowed blocksizes lower than the pagesize, this was never an
> issue and it always aligned. Once we have blocksize > pagesize, this
> assumption will break.
> 
> Fixes the test for LBS configuration.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Seems fine to me
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/seek_sanity_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 48b3ccc0..a61ed3da 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -643,7 +643,7 @@ static int test14(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -692,7 +692,7 @@ static int test13(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> -- 
> 2.34.1
> 
> 
