Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661D15199A
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826616; cv=none; b=oFEsduCfEuRjDbDhB6sC5+kKxUhY6mGB8r94mB7FoPlChIyq30qE2zoqtCHBQ/EBJ43Yg5Auy3iB6JsTyIL72qb6TEXqVu/MbMnyJcpeC9yoDDsorOzP5orKCLi6zFJUkWHlRkrRjg40Q3C0QE5UHuXagSEEf3dGQChpRdj9lD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826616; c=relaxed/simple;
	bh=OnyH9fVTe7eveGb62N8qAhSYYFq1CjIuLgnPGabaIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqBTpxSc07MmhN9LaxLr4az/sZcDFttletrv+uhHoye9h75zMoCkite9FI/B9zANFh4PZuH3RLY2mPSfj4TeUVfd4vMPjAOJoQfxlY7Tasl6/+AUGoC1xhAepk5s1yWoxUoAKi48Cz+UM4d9thzOluPemmDfuPoxK0n39xvUOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc1NXOkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc1NXOkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA972C4CEE3;
	Fri, 13 Jun 2025 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826615;
	bh=OnyH9fVTe7eveGb62N8qAhSYYFq1CjIuLgnPGabaIC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zc1NXOkCqhRpglv9RL+WL+IbxCXtWf7QCauANj1CrWQ0w0oAaek9Eiq2fw9bQwDjt
	 CMjvz5nPn2fuq1mJhRYNWrliLyxfeWXW1q28c1Dumwl4wCFIbykmy+N626qOk0xZKs
	 Qd1ovjXufzoJ8XoBKNQndlv2H3biLg4iCnjJHWsIz9ZcJsGLJnkrCnmQG+UBOVOn7W
	 S042CX1QRoRuNHUCSvi+XKcsdY9o+2GaoAYWG1VreOPN939sHzIcUHaOlJYGWLRchc
	 KwmpoZiDsPbH1COz6ESPreJGFdJogDhPxj8ytd6GMSWK19AEWY/krjc8oUhoUONM4A
	 c3M7Chc7kyS5w==
Date: Fri, 13 Jun 2025 07:56:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: move checking for a scratch device up
Message-ID: <20250613145655.GV6143@frogsfrogsfrogs>
References: <20250613061417.2794099-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613061417.2794099-1-hch@lst.de>

On Fri, Jun 13, 2025 at 08:14:17AM +0200, Christoph Hellwig wrote:
> Commit 3ae8a19f97d0 ("generic/740: enable by default") moved these checks
> down accidentally.  Move them back up to make the test exit gracefully
> when no scratch device is provided.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/740 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/740 b/tests/generic/740
> index c0a634f2302b..ce55200f7bc3 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -21,13 +21,13 @@ _exclude_fs jfs
>  _exclude_fs ocfs2
>  _exclude_fs udf
>  
> +_require_scratch_nocheck
> +_require_no_large_scratch_dev
> +
>  _require_block_device "${SCRATCH_DEV}"
>  # not all the FS support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  
> -_require_scratch_nocheck
> -_require_no_large_scratch_dev
> -
>  echo "Silence is golden."
>  for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
>  do
> -- 
> 2.47.2
> 
> 
