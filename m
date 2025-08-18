Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619D17A318
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550292; cv=none; b=V2Mgp9k9167zBdnddqRKd8oANaKI73/n854qVtBrrYO9ogos9nvqAvERRBkSoj0QxR3LQ6bhyetLeewAfrFzR7KeytyZe+jGcpET9wWhEHg5oHcyK77Rk43DQHBPMd8I+4wICcvu+iDd45LFqU+UkdenaOrQvqNIrat6TZvcl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550292; c=relaxed/simple;
	bh=vRwpuFKMFcGPMepIZUl2pOTQG7xJCMwRbq4XBIcEMWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgR69IZHVnRV8m48yphXYplZJJZxsO8SjPJoYmzJfm1tEsyRXv+zb31eOZ/JFL+eU8m1uCUL3oka6Bb/PVaSo0PGIxD3JsHyXED4hIw//Bd1nAGEmOLc6lsPaisWmAjEL0+BmM9lfHfHPH/bnQwhsrukOuGi0oGkthYxT/69jfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+3iwElt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+3iwElt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9000C4CEEB;
	Mon, 18 Aug 2025 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550291;
	bh=vRwpuFKMFcGPMepIZUl2pOTQG7xJCMwRbq4XBIcEMWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+3iwEltU65byNoB6pBI50SSve/59Q5D4EKVK/+CXV8eKPL94N9LrKwk1e1TrmARR
	 Th5Yf/PNy/GcMKGGsrU5rxhd2bVPhK20lDMHDUjUPoyfP+oBqIfD4hMQ5scoXHObRg
	 gn/N9+0oMgXbmURVpL6omCPeCFptUVgdINMqTxxRUDlK1or49Ns+T/k1XjQ5mhT5gP
	 h4B0lJ9oA0FwMHsbFhd8cC3OxOYX4wN9thjxNMHBxFgoRG2oSzoqoOZQb34bzku11H
	 uPGEyWTQW57s2M+evUzGAUEu1g3uwmYQQ/Ly41I8xeiTr7efvZMhjwNKemefe68L+D
	 kYBYKmfTfWKxA==
Date: Mon, 18 Aug 2025 13:51:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] dmthin: _notrun when dm-thin setup fails
Message-ID: <20250818205131.GD7952@frogsfrogsfrogs>
References: <20250818072724.1559133-1-hch@lst.de>
 <20250818072724.1559133-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818072724.1559133-2-hch@lst.de>

On Mon, Aug 18, 2025 at 09:27:16AM +0200, Christoph Hellwig wrote:
> dm-think does not work on device with protection information.  Instead
> of failing the tests using it in obscure ways, _norun them.

Heh, I wish we had a thinking device mapper target. :)

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Anyhow, failure to set up a dm-thinp volume sounds like failing to meet
a test precondition, sooo

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/dmthin | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/common/dmthin b/common/dmthin
> index 453e43a0499e..a1e1fb8763c0 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -105,13 +105,13 @@ _dmthin_init()
>  	# Metadata device
>  	DMTHIN_META_TABLE="0 $meta_dev_size linear $dm_backing_dev $meta_dev_offset"
>  	_dmsetup_create $DMTHIN_META_NAME --table "$DMTHIN_META_TABLE" || \
> -		_fatal "failed to create dm thin meta device"
> +		_notrun "failed to create dm thin meta device"
>  
>  	# Data device
>  	local data_dev_offset=$((meta_dev_offset + $meta_dev_size))
>  	DMTHIN_DATA_TABLE="0 $data_dev_size linear $dm_backing_dev $data_dev_offset"
>  	_dmsetup_create $DMTHIN_DATA_NAME --table "$DMTHIN_DATA_TABLE" || \
> -		_fatal "failed to create dm thin data device"
> +		_notrun "failed to create dm thin data device"
>  
>  	# Zap the pool metadata dev.  Explicitly fsync the zeroes to disk
>  	# because a slow-running udev running concurrently with dd can maintain
> @@ -124,16 +124,16 @@ _dmthin_init()
>  	# "start length thin-pool metadata_dev data_dev data_block_size low_water_mark"
>  	DMTHIN_POOL_TABLE="0 $data_dev_size thin-pool $DMTHIN_META_DEV $DMTHIN_DATA_DEV $cluster_size $low_water"
>  	_dmsetup_create $DMTHIN_POOL_NAME --table "$DMTHIN_POOL_TABLE" || \
> -		_fatal "failed to create dm thin pool device"
> +		_notun "failed to create dm thin pool device"
>  
>  	# Thin volume
>  	$DMSETUP_PROG message $DMTHIN_POOL_DEV 0 "create_thin $pool_id" || \
> -		_fatal "failed to message pool device"
> +		_notrun "failed to message pool device"
>  
>  	# start length thin pool_dev dev_id [external_origin_dev]
>  	DMTHIN_VOL_TABLE="0 $virtual_size thin $DMTHIN_POOL_DEV $pool_id"
>  	_dmsetup_create $DMTHIN_VOL_NAME --table "$DMTHIN_VOL_TABLE" || \
> -		_fatal "failed to create dm thin volume device"
> +		_notrun "failed to create dm thin volume device"
>  
>  }
>  
> -- 
> 2.47.2
> 
> 
