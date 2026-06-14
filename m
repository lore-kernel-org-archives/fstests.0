Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659113033D6
	for <fstests@vger.kernel.org>; Sun, 14 Jun 2026 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463497; cv=none; b=jiDwiLfo/itXIk0bcUsdVPxXBwPXA7s0yXzhn0SM090Z+vTjgUjD/QG/SDVBaFSw7R5zmgKb45ycJ20lbUH22IsH10du8qppr67lkismVw1Yj4ozh6i2dvN+Y77D9pODsL4HUdpAoouGp2OkmdRIZODjaDaxC+tpF7u7upuHbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463497; c=relaxed/simple;
	bh=rj6wmHfSsd8M/eVB6MIieptVuf42dCjtkMVIEm0zPsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj1nsmDUnoznbsvOxqPmyTr/UHQvM1GLnG2evVc0q3mtjQ77wPUozYUV1xy4V/3XQG7z7vPUFOPUUJAVFtqqnFxYnFEPGxKqINV+jeFjovSzjELRza+jFLXYejC/TIJtOVkcLUYWYYttdZEZie91jrwNvoRPnbvB2gZWdm4W+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/cy1ko8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/cy1ko8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27831F000E9;
	Sun, 14 Jun 2026 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781463495;
	bh=p+y65GekcUKzCLsvRS9EY86m5/xT1vXZujkSb0rr5/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M/cy1ko8ZI30LRjceuIuDTx10DHQotaZZ7AB7ZA+H1h7HlmxOCX0DQseNftojthhh
	 NEHZPn7IswQdhJmsuIHNOe7tYYdaY5RuismOpIg+x+pq+rlPkk9m3aVAx8S6pGYJwD
	 TXL4If2OIjrsKwUmG4kYtAXBCowbSeo8QSnW8fFb5s1hScpLmSWiZ1oK4piNPN6Hbt
	 Zun8v7SEV0PnrkiRoMCZgnMptJOy52mqGZPOS/oz5XLvHuCNud2IClEdwIRe/lUXFL
	 2dndhXKFOVTVyoiFeM0CkBYfvFuBx8SRF4sfvFmDVdXlLN5YTvoR9/EVI292zIY++g
	 hKqWX2rR4ORRw==
Date: Mon, 15 Jun 2026 02:58:11 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/366: check minimum dio size correctly
Message-ID: <ai75PcdwbK7kYBTU@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260608070010.1285677-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608070010.1285677-1-hch@lst.de>

On Mon, Jun 08, 2026 at 09:00:10AM +0200, Christoph Hellwig wrote:
> min_dio_alignment requires the file system to be checked to be mounted,
> so move the call into the main loop.  Drop the pointless blocksize
> argument to _require_odirect, which is only tested on the test device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/366 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/366 b/tests/generic/366
> index 271a01bc2eac..ef69bf09d6ff 100755
> --- a/tests/generic/366
> +++ b/tests/generic/366
> @@ -20,7 +20,7 @@ _begin_fstest auto quick rw
>  . ./common/filter
>  
>  _require_scratch
> -_require_odirect 512	# see fio job1 config below
> +_require_odirect
>  _require_aio
>  
>  _fixed_by_fs_commit btrfs xxxxxxxxxxxx \
> @@ -30,7 +30,7 @@ iterations=$((32 * LOAD_FACTOR))
>  
>  fio_config=$tmp.fio
>  fio_out=$tmp.fio.out
> -blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +
>  cat >$fio_config <<EOF
>  [global]
>  bs=8k
> @@ -60,6 +60,12 @@ _require_fio $fio_config
>  for (( i = 0; i < $iterations; i++)); do
>  	_scratch_mkfs >>$seqres.full 2>&1
>  	_scratch_mount
> +
> +	blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +	if [[ $blksz -gt 512 ]]; then
> +		_notrun "512 byte dio alignment required"
> +	fi

Do we need to check this in every iteration?

> +
>  	# There's a known EIO failure to report collisions between directio and buffered
>  	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
>  	# at here.
> -- 
> 2.53.0
> 
