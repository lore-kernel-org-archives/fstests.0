Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FB352017
	for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258220; cv=none; b=AtzYVtS9dksH9r0sdk//h6azFjAGFoXMwUYQ39F9zru+BkHuEuSum2l6rsJiWxWm2EaSRj7sKWTAxX7p5yvr/rDwXxvwFm1vD+SGXhD/4dmflUnULtdso0qoYWfgRTtvCxlyLApadWJpUjPdgssir7ls6Y+g2xSNxIaRHZIxZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258220; c=relaxed/simple;
	bh=GmQLzRb99n0kYrbHoSJR2ZDLPXGrT6Bu/zQ09+h1S0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhBhA5ywddkGqkse2Ny4fk5kVO+0jt37bdJc6OF74YlQse5l0TCAncOzer4gRV5+KuYSN3ofBEwCsxjMPoWe33EfM6sHH+o0fo16DwBFBCBO0CBQEwK8UbPUDhcIORN5MqiTrqP9TFsf7s5sr6wOxOeYx4LcS+2+QI6QVfN68OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO3JJaOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO3JJaOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997C1F000FF;
	Thu, 24 Sep 2026 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790258218;
	bh=YPfO7OmovkH+9SVp7OzMe1JaAb7+KUNTkrxy1ItGhks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IO3JJaOyM4llWFt+5aSN5WAocRmAasm/iqqw1x43uQgwq2REth6nyHd36BWAxZijl
	 JeSFtdkrsKaZpW3NYootg0iP0T68RaDZ03MDQQrFBaDbmBQKqTZASczLBKLNOrpKis
	 aUwAlaAL1xr8DXixF0KeDgY9tdD/OIPYYs8SXzbPj4NwSLTnHwvYRy5Dhf676Sw5UE
	 7GrcIacnReI5bmbcjLnw9hedig4D8XFYbrC+81SzaVVLekj81zqcZ7sXkx6CwFZBz4
	 BWqIYk5OE2wDBqo8JtoE4by/DJmc1ho0mqfvjzeSB4f/IlkshHbufpUzb9p0DW8COk
	 R0BqyUDmuFCxw==
Date: Thu, 24 Sep 2026 21:56:53 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: moritz.tanner@linbit.com, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/805: fix for external RT devices
Message-ID: <arUqzDhkxgvrhpa6@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, moritz.tanner@linbit.com, 
	fstests@vger.kernel.org
References: <20260924062118.2684441-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924062118.2684441-1-hch@lst.de>

On Thu, Sep 24, 2026 at 08:21:18AM +0200, Christoph Hellwig wrote:
> use _mkfs_dev on the dm device instead of _scratch_mkfs_sized, otherwise
> the file system could be created with an external RT device, and will
> then fail to mount without it.

This patch makes sense to me. But I was wondering if we should have a helper
similar to _ignore_scratch_external_devices to allow a temporary device to
act as SCRATCH_DEV, so it can use the _scratch_* helpers ?

Thanks,
Zorro

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/805 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/805 b/tests/generic/805
> index ae498f5c6698..401829c4c6fc 100755
> --- a/tests/generic/805
> +++ b/tests/generic/805
> @@ -31,7 +31,7 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> -_require_scratch
> +_require_scratch_nocheck
>  _require_dm_target linear
>  _require_freeze
>  
> @@ -39,13 +39,13 @@ echo "Silence is golden"
>  
>  size=$((256 * 1024 * 1024))
>  size_in_sector=$((size / 512))
> -_scratch_mkfs_sized $size >> $seqres.full 2>&1
>  
>  node=$seq-test
>  lvdev=/dev/mapper/$node
>  table="0 $size_in_sector linear $SCRATCH_DEV 0"
>  _dmsetup_create $node --table "$table" || \
>  	_fail "failed to create dm device"
> +_mkfs_dev $lvdev >> $seqres.full 2>&1
>  
>  _mount $lvdev $SCRATCH_MNT || _fail "failed to mount dm device"
>  
> -- 
> 2.53.0
> 
