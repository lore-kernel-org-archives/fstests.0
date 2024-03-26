Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D51CFBE
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473635; cv=none; b=rqBnPhoZBLlkb0Gt+Y9cxeRMwif2SyznwuKwpqme/tqqeG8CdYUlsTly2u3u837Jhn16X2H+F9u/7H07koE1bGnjeKMpRSfmrngDXAW8qMIqXoN6QjExqRcgVPYklJ4ChxtstUZuu/GpnnvDCZqkRu534AHfMevTzAyvrEsl4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473635; c=relaxed/simple;
	bh=T+Q9vmW+e4gEapMtepx4nZC7hh2gf/WmtDSAxAV5P/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhYa981EY3J8dMEMYbWbb62V9hgD7+0DbLx16eNI/7ea8VTFbYDsSujimzFX5FDRWs8HZAy2bntUDiMBGDRVLjME5/jxjtrKFMRQcwdpuUjua2DTHgPYsGVWYSVXZEF1UKMZI20fXTQ6XGiZac/KsfOAkwN12xIO6LhagwkFbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=aLS+G9Gl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aLS+G9Gl"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V3xQP4Mmjz9sbP;
	Tue, 26 Mar 2024 18:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711473629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSoX2U2+bja76VJttji7swbGJQawRgvJz9HjlWCHZgo=;
	b=aLS+G9GlUkRmPBUjSrE5xn4pRVba064Ne9DsOROxnVoa3I+rd54D3les5y3dBTvEazrcfW
	vAUoGfK343ICBzdCaD5FH8ryafiCwT5GiKNNDREiHjW+K2ccqOq0iKCCOwlPe5B/ZZ/9nv
	skqA6fQU3Sx7A9hdS6WPeDFMTfR3iKewp7lEAYMjORVurPObyreTpeLmDGpj5hZIsE3O8j
	PX0gCBRWgjjdSbdplGYpARQw70t8iH0YPS01voUHVWthLevDT/EVxWPxpKjwwBunCN+8Ap
	+kH9U/2kBFRbWetNmjAbS7HiH+nd+0wjw6RKI4og5McaB9oizcdcanfJKVCquA==
Message-ID: <7f1c749d-069d-4a42-8b87-637f2dfa6f5d@pankajraghav.com>
Date: Tue, 26 Mar 2024 18:20:27 +0100
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/558: scale blk IO size based on the filesystem blksz
Content-Language: en-US
To: fstests@vger.kernel.org, zlang@redhat.com
Cc: djwong@kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
References: <CGME20240313203828eucas1p22e2b127e8597e2e72397f26370c54b42@eucas1p2.samsung.com>
 <20240313203818.2361119-1-kernel@pankajraghav.com>
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20240313203818.2361119-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4V3xQP4Mmjz9sbP

On 13/03/2024 21:38, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> This test fails for 64k filesystem block size on a 4k PAGE_SIZE
> system. Scale the `blksz` based on the filesystem block size instead of
> fixing it as 64k so that we do get some iomap invalidations while doing
> concurrent writes.
> 
> Cap the blksz to be at least 64k to retain the same behaviour as before
> for smaller filesystem blocksizes.
> 
> This fixes the "Expected to hear about writeback iomap invalidations?"
> message for 64k filesystems.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Tested-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---

Hi Zorro,
  I checked xfstests/for-next and didn't see this patch queued up. Do I need
to do something or will it get queued up for the next release?

>  tests/xfs/558 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/558 b/tests/xfs/558
> index 9e9b3be8..270f458c 100755
> --- a/tests/xfs/558
> +++ b/tests/xfs/558
> @@ -127,7 +127,12 @@ _scratch_mount >> $seqres.full
>  $XFS_IO_PROG -c 'chattr -x' $SCRATCH_MNT &> $seqres.full
>  _require_pagecache_access $SCRATCH_MNT
>  
> -blksz=65536
> +min_blksz=65536
> +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +blksz=$(( 8 * $file_blksz ))
> +
> +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
> +
>  _require_congruent_file_oplen $SCRATCH_MNT $blksz
>  
>  # Make sure we have sufficient extent size to create speculative CoW
