Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24483DDC3
	for <fstests@vger.kernel.org>; Mon, 14 Apr 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656765; cv=none; b=Aq9nGdvLAR83JytN7OQeeBHTmzXcQyOKCd2Lg6LWDcvcojBQPAp/lr+d00JTeGIHlvabZeGbS6Tav90Dit0KptsOSTZ89mA+pib9OPf4VffwZgOx+avWE8L2htxxvVsepBsdn9e4mVMPpeQ2F7Ou0Ql2icTJ3U/Y+8iVtsSHgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656765; c=relaxed/simple;
	bh=OfyTHtN6OLTVmYogwZSXPzCtLYZtRnEJN93QOnY2QCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUM3IHcTREhr07OuXQWWWE1+Ufu1qw4hXqlImuYdoHOQhHv5ELIOfEv9lkt5MDVDZCOF13iKvZKpqYNUs44mgRu7M/d/MDUKupVNjGG9r73/IIjG2334G/skbywdTLgk1c9YZKpcctO+wFuVUr0T3Zv/JhD12NFkFr5LFUB4ews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDd++IHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDd++IHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C227C4CEE2;
	Mon, 14 Apr 2025 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744656764;
	bh=OfyTHtN6OLTVmYogwZSXPzCtLYZtRnEJN93QOnY2QCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDd++IHqDbraLMf7l+CHi8EifyoGInD3paOeP6l5UPOFerACJ1pu19zJSrOAbC2x2
	 JIO5XMdGhWy3DOjzWW8C0Qzx+rnStbpfHngamUdwudStRkuZsVNBzxFKtl9XyNqS3H
	 qxBRgxAh4H4yNdqEFRjQ1LS792bOC1xtLnR2lBT0P2S+wAAFcwnrtsHOV1yAk0zHY/
	 lcm+Cvsu/RPcTADt0l6rz/Rtvivsv612ALSat1Xb1MsYn9GwMDz+4PGGxaDThrJ99y
	 oFcn3danjHrzk6q7qdPS1hwhH4azp/2oNAxgDysqAXoci9xPn/UMDi1eEkh5MFB0zp
	 5lCZjxZqpmMnw==
Date: Mon, 14 Apr 2025 11:52:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/231: use relative path to invoke fsx
Message-ID: <20250414185243.GB25667@frogsfrogsfrogs>
References: <20250414120102.400383-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414120102.400383-1-hch@lst.de>

On Mon, Apr 14, 2025 at 02:01:02PM +0200, Christoph Hellwig wrote:
> This test uses su to run fsx as $qa_user.  Because the shell calling
> fsx is run as $qa_user it might not be able to access the xfstests or
> parent directory which might only be accessible to the user xfstests
> is run as (e.g. root).  Switch back to calling fsx using a relative
> path, partially reverting commit 1c67e8b191fe
> ("config: add FSX_PROG variable").
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I make the same statement about leaving a note about using relative
paths in the comments as I had for the previous fix.

With that applied here,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/231 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/231 b/tests/generic/231
> index b598a5d568bd..8dda926d875e 100755
> --- a/tests/generic/231
> +++ b/tests/generic/231
> @@ -23,8 +23,8 @@ _fsx()
>  	echo "=== FSX Standard Mode, Memory Mapping, $tasks Tasks ==="
>  	for (( i = 1; i <= $tasks; i++ )); do
>  		SEED=$RANDOM
> -		echo "$FSX_PROG $FSX_ARGS -S $SEED $SCRATCH_MNT/fsx_file$i" >>$seqres.full
> -		_su $qa_user -c "$FSX_PROG $FSX_ARGS -S $SEED \
> +		echo "ltp/fsx $FSX_ARGS -S $SEED $SCRATCH_MNT/fsx_file$i" >>$seqres.full
> +		_su $qa_user -c "ltp/fsx $FSX_ARGS -S $SEED \
>  			$FSX_AVOID $SCRATCH_MNT/fsx_file$i" >$tmp.output$i 2>&1 &
>  	done
>  
> -- 
> 2.47.2
> 
> 
