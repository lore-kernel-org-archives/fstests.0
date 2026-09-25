Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040D38F642
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366625; cv=none; b=lOcc9YNvVk1+7KD6Lzv+c+Y8nUbX397YmM3w3QY95oiJ5I188bgrBQ+AWbFAH0uaWGBvtf68acELDLVEDxZRJA2siO3CQ/yEu/jBEWTaMvAx3m2beOSkK+NCVmPWLeJ8AiH3zdlVsCVVBQrRusn8GoqIBfMYyL9rDTvpdghqsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366625; c=relaxed/simple;
	bh=FDxXoC0HxRB/EME1oDBALmd0Rvwcay5FVJY/bRBUZa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk2el+g6BFN0w2OAqSfUk+vG1w19zTW7/9ZDUmr2fJ8syM2ypuPKnLXSlKGHMjghE9BXLDK0vpa85E8YggqIGOhIG47L1YMjphH8RjtaXT8WmFIeOX+TPsOE3ABvgSrWIavfs2bMmB2sla4iwPqgHgyL5CIb9EIJQXiacTWAJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVlIlBr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVlIlBr2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2F9D81F000FF;
	Fri, 25 Sep 2026 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366624;
	bh=e9PrfueXgQ2qtAjngCLPlwTcYz3gqBh5hRUZ1ICZ5X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RVlIlBr2kO6JiA1RkjP37Re9bCACFWBAJy/0CMQ5a8P6bi97U7UTL8E2WT+FRIHHf
	 Im2r+s3lGtxeoE/olnRcreOCosVF3sYgOco4E+ERyVIYvvzfm+NarwcD/99IqYpgik
	 XaAg8OFbtPliCFod8oNq9HRC3bPG0OrIUvUFkg6Dh35HbhSJ8VGJBCIvEk9OdaHHbz
	 wOjqMr6/7/XK80n3hNV3/uCERoU3yoYjS3BJvhzvmuMnGNH3spWGknCgHns0m9LYp+
	 j9cUo9ZrTYArWo+XB4CsTt4PSJ/ga4OcgFGhoMcHcCZe2NgJJqtOcQjKxJLqFOzlmk
	 i0tvbsUqMUcrw==
Date: Fri, 25 Sep 2026 13:03:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/4] xfs/071: use _link_out_link instead of opencoding
 file picking
Message-ID: <20260925200343.GM6253@frogsfrogsfrogs>
References: <20260925104514.664260-1-aalbersh@kernel.org>
 <20260925104514.664260-2-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925104514.664260-2-aalbersh@kernel.org>

On Fri, Sep 25, 2026 at 12:45:09PM +0200, Andrey Albershteyn wrote:
> There's function which handles picking the right output file based on
> the .cfg.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/071                             | 7 +++----
>  tests/xfs/071.cfg                         | 1 +
>  tests/xfs/{071.out.64 => 071.out.default} | 0
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  create mode 100644 tests/xfs/071.cfg
>  rename tests/xfs/{071.out.64 => 071.out.default} (100%)
> 
> diff --git a/tests/xfs/071 b/tests/xfs/071
> index c4722f67181a..47874e505c01 100755
> --- a/tests/xfs/071
> +++ b/tests/xfs/071
> @@ -5,7 +5,6 @@
>  # FS QA Test No. 071
>  #
>  # Exercise IO at large file offsets.
> -seqfull=$0
>  . ./common/preamble
>  _begin_fstest rw auto
>  
> @@ -22,11 +21,11 @@ _cleanup()
>  
>  bitsperlong=`$here/src/feature -w`
>  # link correct .out file
> -rm -f $seqfull.out
> +seqfull=$0
>  if [ "$bitsperlong" -eq 32 ]; then
> -	ln -s $seq.out.32 $seqfull.out
> +	_link_out_file "32"
>  else
> -	ln -s $seq.out.64 $seqfull.out
> +	_link_out_file ""
>  fi
>  
>  _filter_io()
> diff --git a/tests/xfs/071.cfg b/tests/xfs/071.cfg
> new file mode 100644
> index 000000000000..e806b07bc08b
> --- /dev/null
> +++ b/tests/xfs/071.cfg
> @@ -0,0 +1 @@
> +32: 32
> diff --git a/tests/xfs/071.out.64 b/tests/xfs/071.out.default
> similarity index 100%
> rename from tests/xfs/071.out.64
> rename to tests/xfs/071.out.default
> -- 
> 2.54.0
> 
> 
