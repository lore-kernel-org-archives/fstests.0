Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93717B42B
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116075; cv=none; b=T9jkX0UJmifsR01JBr+TN3v+9JsqUkVG2pWEZG30Qw0qxi+WYCYCFsrLA9TuXiOF+sVRWH6VqJFn5NjQjVlRxtrOgiWJfrhZWnA/1C5C6tlRFs/XuWKOMKUU9DD48dlln6aJ0jhTHVcq3800qV4MkiXF8u2YqDsxA6Kw8zeFav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116075; c=relaxed/simple;
	bh=0aROTIzHSyPjVtvh6LIqm7GZZ0dCSgEjk48RWtzx3Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPlXcxKl9q6hTrbyGSFiQ0fdJ2lwN4lqavxJsax0DG+6FmqeXTt1Rz/jeN3rDOBvtJywc4aFnl4EyNioeVd7WFP9q8UEYNuNgxzpBlvmxt+1aDevfg490oVrYtqOyR/ubNsSL1PleG6UYFXHnaTP2zI//3c+5MtAECGkZmoJEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPrNgzWO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPrNgzWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9356EC2BD10;
	Tue, 11 Jun 2024 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116074;
	bh=0aROTIzHSyPjVtvh6LIqm7GZZ0dCSgEjk48RWtzx3Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPrNgzWOEJGiRsVXyLQAQwrf110Q594roa0/bbE4CK0g5y/CclxMOoPze6XGJ6Szt
	 u5ZQ0mz+IXHBbm7cCmG8PVzxGBLkWwPGxdMwUkuxHJ6CuqpuA6X92L30h/aLflljsq
	 RXFn2iXhJW9sSP1x/visF+scCD7kGqwT9lJxyyqwBsRzummZZ1rcTh2nlUHWaZUpnC
	 OuFMUe3S1FVUf+kNhF4y/cIq4A8IGZ8jNTJDltW4SZpAYo/1GiLVII+ybB4Egz80yQ
	 ERkFWOy/s3iDpjyaNwi9FDqxmNQTBPOkcaCgzIbjToH6mh4sSkBtibIHIEfWYYs87g
	 MHzof/TgqpOaQ==
Date: Tue, 11 Jun 2024 07:27:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4/045: skip test if the block size is 1k
Message-ID: <20240611142754.GF52977@frogsfrogsfrogs>
References: <20240611085853.200102-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611085853.200102-1-tytso@mit.edu>

On Tue, Jun 11, 2024 at 04:58:52AM -0400, Theodore Ts'o wrote:
> If the file system is 1k, this test will fail because with dir_index
> enabled, the directory tree will get too deep, and the kernel will
> return ENOSPC and log the EXT4-fs warning "Directory (ino: NNN) index
> full, reach max htree level: 2".  So if the blocksize is less than 2k,
> _notrun this test.

Didn't ext4 recently gain support for 3-level htrees?

--D

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/045 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/ext4/045 b/tests/ext4/045
> index 4f0ad4aa7..5ae7a45b5 100755
> --- a/tests/ext4/045
> +++ b/tests/ext4/045
> @@ -44,6 +44,10 @@ workout()
>  
>         _scratch_mkfs "-O extent,dir_nlink,dir_index -I 256" >> $seqres.full 2>&1
>         _scratch_mount
> +       blocksize=$(_get_block_size $SCRATCH_MNT)
> +       if [ "$blocksize" -lt 2048 ]; then
> +	   _notrun "blocksize $blocksize, too small"
> +       fi
>  
>         # create directories
>         mkdir -p $3 2> /dev/null
> -- 
> 2.43.0
> 
> 
