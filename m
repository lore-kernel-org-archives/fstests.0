Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394C387569
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195085; cv=none; b=WTn/c7zdROUfsBxG38LnuRnnF5BTfVhjzfOE7X2DwXfb9SVE6sYvhllzlfbbsDp63Dkrx54xXl7FBEIT095yZlRM9dJhBwDeXD/57wp3KrIvf3diLzhGlHjyNqoxVoyYlUhNPXb7vyVq1A9EFBUtaTlaTz+JA2S1QfzuV8EjuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195085; c=relaxed/simple;
	bh=zEf0VSwDS7ldt0dJeFIVoM1Wzv+uiAp8/fWiwCAQJKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQDklh8OA4vmVgvi0o4E9+UDkvfc0oXagkW/uOnBn+bx5/TgCdinMViPXMKIuO+zSkuyzlCuyFr92uvB0WyzEcX4wm9Cz/MHS0EfuDzEFuUaOq4uKuvFj19n5I99MBdJq3UrXXmZEk1V1750WegKf0EHtAPBY5Qcem60457uXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxZ8YiXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxZ8YiXK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 925951F000E9;
	Mon, 31 Aug 2026 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788195084;
	bh=Hry/rNtewL1HJO/h6aR4ceWsm7Qga4nZ4zt4v1lVwVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dxZ8YiXKd/mWoj4iu8MWFcLc9/G3YMwzQn3vOThfHOp6623qF57S9gr/7PzQ6jqcJ
	 FRfXD9E7aKTxDj/zazdYuF2owj5YVYn4PPZspwQrqtc/QlTJrwAOoHsQk2AasufL0f
	 TOMKxqICXlZO/57nVZlvTY6KG6z48Xov6AO/AbiT9Q0YPehOaU05JJD+SZUw6xOeDq
	 1zNQx4LJXeU+Ko1kZeEZ0KV7W6J7a7CUdyXyAUsrbEE3wqIWlfyozlMRQ5dtQV1Y6P
	 FwR22K6o6IIi2tNF11Ii+bkrtVZq2J8nfng+tqGVuNmv7jWj9nQZcM/vVOeDXpsmd2
	 qZOGNSAFMUVXA==
Date: Mon, 31 Aug 2026 09:51:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: fix spelling of SCRATCH_DEV_POOL
Message-ID: <20260831165123.GY839663@frogsfrogsfrogs>
References: <20260831064721.2577381-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831064721.2577381-1-hch@lst.de>

On Mon, Aug 31, 2026 at 09:47:21AM +0300, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 5e709dd79993..d5af3a6743ec 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1066,7 +1066,7 @@ _scratch_mkfs()
>  }
>  
>  # Helper function to get a spare or replace-target device from
> -# configured SCRATCH_DEV_POLL, must call _scratch_dev_pool_get()
> +# configured SCRATCH_DEV_POOL, must call _scratch_dev_pool_get()
>  # before _spare_dev_get(). Replace-target-device/Spare-device will
>  # be assigned to SPARE_DEV.
>  # As of now only one replace-target-device/spare-device can be
> -- 
> 2.53.0
> 
> 
