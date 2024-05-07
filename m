Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA571B3B
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120604; cv=none; b=jLnhKOcMX0DbDDR9bbSuE1T78NgbC2jizNC/g+y6AknaCS7StHg1mVNpQ5jQXwZEXTfKnoC8FZDc6DRUiyko8//SBpsV+oOHR/+Z1uQWrxj0nlRER0iuOaPGKL45Uc5kzibUY4ym40pK3Q5XTdEZxA42p7+Eh15Q8lntdxLVVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120604; c=relaxed/simple;
	bh=w0Fq3Oo5Lri/ddv4vtGj4aTicir445avYE0Qcii3Lqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6Y98G0UGex78qvjliXCNZ4Vz/ztTFLFDUZOD5JTq52yXzOVIH0bEF8EQM6gaDxicQFoujYkNoCscu34Sh6MaSREQCkzZl9fCLmhlTSK/Hm/DpYMpKpW3QvqrQ6/BvLjzKo7AIJbntmcnLIMhadnk0sUfLSCNsYzOW1/Um9aIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFdze5H+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFdze5H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5865C2BBFC;
	Tue,  7 May 2024 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715120604;
	bh=w0Fq3Oo5Lri/ddv4vtGj4aTicir445avYE0Qcii3Lqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFdze5H+QWfzs/GUOPRAoq4wnPfYHoYEzm7OHgshmEzvVw+pbrL+PCFG/6OnnsBS6
	 KVqeNMzw6MrQcrWBDP9ZYZ8SuXmBCbZHXAwrqCb5ovOkwWDHNlBn91fSEra5iXmJ/m
	 FWBE+ObUTk3esbPFLFkkXfPvtut9dQj9EhFi0Wxp5JdKek0Dil91QVjjBQDnwd1t0c
	 FzTJQljcJB1R2X9MNXGaw8tPjFwDv/SYQRHy/tUWLWPViETvBf37BroERhRdpFn6Xv
	 BwaEAa832DYPPuh7Tte5kZ0G2GdQlpYYjZdA6yJqs+UlFZUhzWQPU23U05NjEhj4h5
	 8FGaNVmibRZYQ==
Date: Tue, 7 May 2024 15:23:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Message-ID: <20240507222323.GC2049409@frogsfrogsfrogs>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150119.184097-2-kernel@pankajraghav.com>

On Mon, May 06, 2024 at 05:01:17PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> This test fails when xfs is formatted with 64k filesystem block size*.
> It fails because the soft quota is not exceeded with the hardcoded 64k
> pwrite, thereby, the grace time is not set. Even though soft quota is
> set to 12k for uid1, it is rounded up to the nearest blocksize.
> 
> *** Report for user quotas on device /dev/sdb3
> Block grace time: 7days; Inode grace time: 7days
>                         Block limits                File limits
> User            used    soft    hard  grace    used  soft  hard  grace
> ----------------------------------------------------------------------
> 0        --       0       0       0      0       3     0     0      0
> 1        --      64      64    1024      0       1     0     0      0
> 2        --      64       0       0      0       1     0     0      0
> 
> Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.
> 
> Cap the blksz to be at least 64k to retain the same behaviour as before
> for smaller filesystem blocksizes.
> 
> * This happens even on a 64k pagesize system and it is not related to
>   LBS effort.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  tests/xfs/161 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/161 b/tests/xfs/161
> index 486fa6ca..94290f18 100755
> --- a/tests/xfs/161
> +++ b/tests/xfs/161
> @@ -38,9 +38,15 @@ _qmount_option "usrquota"
>  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
>  _scratch_mount >> $seqres.full
>  
> +min_blksz=65536
> +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +# Write more than one block to exceed the soft block quota limit.
> +blksz=$(( 2 * $file_blksz))
> +
> +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))

If we don't set $min_blksize and always write (2 * $file_blksz) does the
test still work?

--D

>  # Force the block counters for uid 1 and 2 above zero
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
> +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
> +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
>  sync
>  chown 1 $SCRATCH_MNT/a
>  chown 2 $SCRATCH_MNT/b
> -- 
> 2.34.1
> 
