Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398C21CC4F
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550314; cv=none; b=NMvFOYSIJX2xCxQ57Mgad9BRx4a+N6mYa5YSz5gnsa3yIn3CUB81nZTqjneKAz9H+mgnBMRK1VXJcc63icI1afDRd1D/d5BXoypwZEL9WVFibMuJcrhKDKyXlPGBe6el6we3oHtEgAQPagYh076brTQDP7euY1dF1o0oLpql938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550314; c=relaxed/simple;
	bh=fhAX64/8zJiB5BUmU3Xnem9Ub9u4pGcKAXDZBz96yaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq+uyYJwurBkbz3K24vlmv2GKHPxwutP+rX/vJMcUBlKER11ABus9utzkAtSCKLrQYbZNeGiQDtDXMmu8QW5cNmIPJlYfCi8q6c9qJjSYvbfQVRL4ODD3F/7y72vEZbsFdILQNBa3oChDBYrT8qGeiQSu1p6PH44eBryVAlSjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLHidYG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLHidYG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47326C4CEEB;
	Mon, 18 Aug 2025 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550314;
	bh=fhAX64/8zJiB5BUmU3Xnem9Ub9u4pGcKAXDZBz96yaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLHidYG91jB4yWlIrnOGG7vdCmnyPlsY5zyJTn3LSWf7D+i/B2qVaBra8g3z+dB62
	 stakmUgR1vz+w7zuoAzApJnfrs0XBhQodl2lHefkIiBzfhp4LXaTUh15xF+BbRfA/1
	 WOlmqyD9XgwLJFrHYJw+8UjnU+lP6Po3MFwYLcYZ8lvu/F/9q6ZYH0pqf+TTcHJiWs
	 aHwKkuXFATVu1o0LECdWjb+qUGSwCdiWdtCKvAeft2y+J6QPpAa0PwkRiXWrLrUx3l
	 xnWRjWus0ulJxbxyZJvt1ebOac7qUDhvKBKitMisAZ5d7gRdCVZAnWPZwRkG6O62vu
	 2dmW2WjdidIog==
Date: Mon, 18 Aug 2025 13:51:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] generic/081: don't hang when running on devices with
 protection information
Message-ID: <20250818205153.GE7952@frogsfrogsfrogs>
References: <20250818072724.1559133-1-hch@lst.de>
 <20250818072724.1559133-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818072724.1559133-3-hch@lst.de>

On Mon, Aug 18, 2025 at 09:27:17AM +0200, Christoph Hellwig wrote:
> The dm snapshot target does not work on devices with protection
> information, and the udevadm settle command simply hangs when lvcreate
> failed because of that.  Avoid that by doing a strategic _notrun when
> lvcreate fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/081 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 97928bf4a435..00280e9cff3b 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -73,7 +73,8 @@ $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1 || \
>  	_notrun "LVM is too stupid for this device"
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
> -yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1
> +yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1 \
> +	|| _notrun "Can't set up LVM"
>  _udev_wait /dev/mapper/$vgname-$lvname
>  
>  
> -- 
> 2.47.2
> 
> 
