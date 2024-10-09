Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B244198E96
	for <fstests@vger.kernel.org>; Wed,  9 Oct 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485298; cv=none; b=pZ0Lud97Jn0yjSoMT2WWqXeh+T0z02QmEveMal+eNC3IO0+AJxu7YEIs+c/zrdLmFwMRfXbB2qnVNposWaIBCLt9vdlYPOdrdDi8vdD1HcRfRfwbt4tRvE6Nt1MfmnIwrtF/x8kYLhdF7Kr2R2ySiH2vGkIRIOGjbex1+66BsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485298; c=relaxed/simple;
	bh=3LR7Zw0E37PQqTnDCcR/biviKFFlpjElX5otjcm6Sk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeDr9R8Q/HkDxjv3lYD/65bzpM/HDEC0L95BtiaJJeenh8Apu1qJ/GNsFbPQ+klk71ZGho5gv5v1GNcFBQGFW+WHt96YpUR7s6KM85KgvUqW2soLKuNJPt/3JGfRizmZ6tm4uNUiCp9jLGWi9d6FEiDURmeO0uNG1VKEI2OWj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8tkBumH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8tkBumH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D6C4CEC5;
	Wed,  9 Oct 2024 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728485298;
	bh=3LR7Zw0E37PQqTnDCcR/biviKFFlpjElX5otjcm6Sk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8tkBumH+wgHjjCuSic2kdzAJOVzM96haT4lVBFnliO3gklJPFC6y5kZM4HfylCog
	 jOvGMnMW8JWX5l0oz1/jPI6t+5QD1W8hYC9mgw2QQgRjKOzTsF7aQvY7kF01PoosSP
	 xG4owgaG1JKbWvG6zFJd7L6UQH7ycgCvFdRgAoiR2CerU/a09fsZIUbbH+8kkcWAHg
	 ZxCOQ8cvokHyx5WBh+5CHYZhQ2vJH5uJZItRBQvBxq0blY8ZQ9jCbDwwlkCOqpdgyI
	 LCr4WEkz4VmhDUHStrSOva3Mf/6EIQ4J0C4npfnv//r5OMjaPkuILNlFaCEUsOrABB
	 BaHph3N3ebowA==
Date: Wed, 9 Oct 2024 07:48:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/694: sync before sampling i_blocks
Message-ID: <20241009144817.GL21840@frogsfrogsfrogs>
References: <20241008071209.160188-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008071209.160188-1-hch@lst.de>

On Tue, Oct 08, 2024 at 09:12:09AM +0200, Christoph Hellwig wrote:
> Without a sync there might still be temporary blocks in i_blocks like
> indirect block reservations or additional blocks reserved for out of
> place writes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/694 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/694 b/tests/generic/694
> index 02253ef75..b6bc8a75f 100755
> --- a/tests/generic/694
> +++ b/tests/generic/694
> @@ -37,6 +37,10 @@ if [ $? -ne 0 ]; then
>  	echo "Could not create 4G test file"
>  fi
>  
> +# make sure indirect block reservations and other temporary block reservations
> +# are release before sampling i_blocks

Nit: '...are released before...'

> +sync

Should this be more targeted since we only care about junk_file's
i_blocks, not flushing everything in the system. e.g.

sync $junk_file

--D

> +
>  iblocks=`stat -c '%b' $junk_file`
>  
>  _test_cycle_mount
> -- 
> 2.45.2
> 
> 
