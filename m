Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACD21885A
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550323; cv=none; b=KQCwI4SNiu+NOeyzuYvWH9R/C5vsGTKcPpTzojqDO5dBgVT81bBd+SyC6sKm7kjnUVX8RomCZVnZwg9akQGqQNCO0l5YgMSfDDDmxRKCHFjA/1oRq2zYVHsHN+NH8ybNf/ynAhBA43ZX31Kwmhk0WIm5Hz6Ch+jQf2VL5Tm+MS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550323; c=relaxed/simple;
	bh=BJpsJvYvV4BUkJVdQVC30H7mSrxqaTGUT1dJWJU2+m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5zjD9u3NjDheB8mHFI7EjiLpXR8zwq8oGljTclnmKjJa3z+j3YRyZ3i3nqXTcVJ71gzXj4A7ofRNNm2THirINaQbtiGF8fCP53wcwQPzutkXbMujwgq+WtBVrjg4YX8eku4CFdTdW5V/5X0ZrEYSCmWcxgOKb+k9/sH0FUYlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghb3oTA3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghb3oTA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87A8C4CEEB;
	Mon, 18 Aug 2025 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550323;
	bh=BJpsJvYvV4BUkJVdQVC30H7mSrxqaTGUT1dJWJU2+m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghb3oTA3UGHkXhjMC49jX+uS34jbV6y/BCIJnueOj5kp9VHfbnKvH4P4abOQzKFhL
	 y4OqVmR9rvd+wztocZT/oWVL/RhzQtLdne3veW7jwXsV4usu9ER+Vyf0+jtgstmonG
	 8swK5Pgos1vfRs2qnurQn63e5ebm4ZJpjpDy2jKbY7NqsI55pX3BIB3LKc3q+Wo6gX
	 VY2nGrS3ltW4j11mWylEnesxEZ5e+DknADogNnrxbw+Pnzd2DUiN2ng5jk2BfsZh0b
	 Wb0RrsCm0IZOJ8J6apXc1P0xyicB0ksYHyCmQBHGzBZ5nvgCcv+khH/V8hOBKO7ybh
	 Nc4gDIG1jrCGw==
Date: Mon, 18 Aug 2025 13:52:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] generic/450: don't hang when running on devices with
 protection information
Message-ID: <20250818205202.GF7952@frogsfrogsfrogs>
References: <20250818072724.1559133-1-hch@lst.de>
 <20250818072724.1559133-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818072724.1559133-4-hch@lst.de>

On Mon, Aug 18, 2025 at 09:27:18AM +0200, Christoph Hellwig wrote:
> The dm thinp target does not work on devices with protection information,
> and the udevadm settle command simply hangs when lvcreate failed because
> of that.  Avoid that by doing a strategic _notrun when lvcreate fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/459 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/459 b/tests/generic/459
> index 3f5f0f2b7dc1..48520f9f4af0 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -93,12 +93,14 @@ $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
>  
>  $LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
>  		    --zero n -L $origpsize \
> -		    --poolmetadatasize 4M $vgname >>$seqres.full 2>&1
> +		    --poolmetadatasize 4M $vgname >>$seqres.full 2>&1 || \
> +	_notrun "Can't create thin pool"
>  
>  # Create a overprovisioned 300MB dm-thin virt. device
>  $LVM_PROG lvcreate  --virtualsize $virtsize \
>  		    -T $vgname/$poolname \
> -		    -n $lvname >>$seqres.full 2>&1
> +		    -n $lvname >>$seqres.full 2>&1 || \
> +	_notrun "Can't create thin volume"
>  _udev_wait /dev/mapper/$vgname-$lvname
>  _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
>  
> -- 
> 2.47.2
> 
> 
