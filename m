Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43771B3B
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120648; cv=none; b=Vtt7Nxtj7gLm8gitWWJMJFzH64OMSBfeqf7wf6bjgGWA52Bmq47WTQ6ZCqhbU7LSC3tVbEZAJHdsoafUalqBMnwruX1GK8BppvdEebaz5W1MHpjERfYmuhnvvTFthyd5Aerv4wxlmi2DSEHajgdboSyO0NxIrKnCUHfQ86Ck3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120648; c=relaxed/simple;
	bh=3ymh5udtU7Z0J+Sf+ilBNoJc76E2iJbVdcVg1sgjYiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBFkQQcC34GMt4ZULJ6kTDvMdkGlQ7jBUwS3Z2MUn/iPxFZy21Tv5wmzkWYTzqGxqQ90wmXqa00/CXnrdehqcWNZAma4HAZXFBOzrwMym2hzlJg/YlPNa572qOqg/1GHrJ2xmCzd3xef1cv/JZXQWlHAzgUAPzY0JKpcoyrgauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYeY1HVv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYeY1HVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA796C2BBFC;
	Tue,  7 May 2024 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715120647;
	bh=3ymh5udtU7Z0J+Sf+ilBNoJc76E2iJbVdcVg1sgjYiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYeY1HVvLc+jSysxGcvtWQ6TO5FUXC/EOh3JjUUFCXEB6F62pO0NV9Az0/QlSFrmj
	 LWyw6LYqog00fpJwifKuUL6z6dYuy/MaRolCAB9M5fxgGUJCAECpQzsPYkYX98CMYy
	 VJLMc4tsW746G+DK/UeITffUFJ3Qt5D+cxyLMxPTPiUnW1oopazcwSB+wYb9R1CGWV
	 UaTlGF5hWoXRx1+lsSN9Gieti2UPImOvMix7uoK16YhXtHSMZLvRm1txLz0iYqLxz/
	 o3sMYq2aqH5Qjf4HxGlq4p+DdYGyc46dKJ09WmsiwAt1ctNH150JU3gZJ23WMcj1au
	 OyJoPDOKIYK/A==
Date: Tue, 7 May 2024 15:24:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240507222407.GD2049409@frogsfrogsfrogs>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150119.184097-3-kernel@pankajraghav.com>

On Mon, May 06, 2024 at 05:01:18PM +0200, Pankaj Raghav (Samsung) wrote:
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
> ---
>  src/seek_sanity_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 48b3ccc0..bc30f77c 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);

Why is the page size multiplied by 14?

--D

>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
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
