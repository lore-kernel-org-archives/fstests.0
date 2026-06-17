Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623543D45CB
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2026 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688782; cv=none; b=p0KBHLSCZNZBf1yIhQTpOCRUmNNUKjT3N1+u8JZzSIbxhqpa9RQnKMNgMrnL9nUxQ6XLnX++L1iNfw4+BFZs4tgGpfU2b0QnyhIWakC1RuyW+GngSOmgTg4pfa5vsbjT2fA27t/4k5QCmj3/8V/WvgXW/ionsMnoMLvgv01vSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688782; c=relaxed/simple;
	bh=4broHXiJMkTBYXWY501/GG+2E0nv1bMIawsvEDNSu2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l88aEDLKgIDsQn8MqjU1gKfOQZz0JB5XMghTuyFB99U4Fb6j0k81nfyNZcfoVlYVB4B0yTNFWhVF5w7AcnP3+S1oOrJQBESd+5Myv/zhezme/6rE/9Ycl1IEPMBrd8awR7kQu0z4Qwq9GwvGkswkUVVO5pESIoHCshNZ+7Diezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPcu05Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPcu05Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302161F00ADE;
	Wed, 17 Jun 2026 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781688780;
	bh=Gcq1n6EIlnHXyV5ciiZWLkSAiSb2twaidZhX9WfOdPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPcu05CsWhf6xieHWv+3BeWI2e4XLlX1cEl4FRSL6tEqdGgjFQH3Ki7GrSq6+bXuL
	 J1hegIG47LgfC6DZNK+4cOgQ7VTMIkkHgummIl/hH4of9cQhN4ZATWtP5/QBmr1PoA
	 cHrJQgTqRsrUs3bzv9Kefs9H6tdHssyiz7GqEUesgoiSJfDrvflCX1HZL8YA0gquZh
	 B0JpVCGStQFSgsd1L+grDY1ttvxKFD/PiKF0XxEZav04n50mwK8tAN6Xac+O1T2dV5
	 1QXtrtz4p0A4WG6ZfBoj5zSp+RSj2VkamC/gbW8ISo57+EoYXq9tvWf9s8aAugviU7
	 ydpsOUlBgSbbQ==
Date: Wed, 17 Jun 2026 17:32:55 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/366: check minimum dio size correctly
Message-ID: <ajJpo0OzSNZHCGWC@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260617060456.3843384-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617060456.3843384-1-hch@lst.de>

On Wed, Jun 17, 2026 at 08:04:17AM +0200, Christoph Hellwig wrote:
> min_dio_alignment requires the file system to be checked to be mounted,
> so move the call into the main loop.  Drop the pointless blocksize
> argument to _require_odirect, which is only tested on the test device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - only calculate the block size once, based on a code snipplet from
>    Zorro Lang

Thanks Christoph, this version is good to me

Reviewed-by: Zorro Lang <zlang@kernel.org>

> 
>  tests/generic/366 | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/366 b/tests/generic/366
> index 271a01bc2eac..cb183c1bfe21 100755
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
> @@ -57,9 +57,19 @@ filename=file1
>  EOF
>  _require_fio $fio_config
>  
> +blksz=""
> +
>  for (( i = 0; i < $iterations; i++)); do
>  	_scratch_mkfs >>$seqres.full 2>&1
>  	_scratch_mount
> +
> +	if [ -z "$blksz" ]; then
> +		blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +		if [[ $blksz -gt 512 ]]; then
> +			_notrun "512 byte dio alignment required"
> +		fi
> +	fi
> +
>  	# There's a known EIO failure to report collisions between directio and buffered
>  	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
>  	# at here.
> -- 
> 2.53.0
> 
