Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E0492E39
	for <fstests@vger.kernel.org>; Mon, 28 Sep 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589044; cv=none; b=r0kQosCwjoSLSMz+TsZH6qK6+bM2ossHzBQPNVHWSdoeGN1vUX5mC5ZvHl5WdF1QEzBIqkE17KYeGdhhdT87m9M4qEw6SUy3y25MLOEMdwTty8wgpywygewDRxAZN2rfAOBAzXlw5hf6cv3JdUJvcn7SDuNkYRrnQGLwfOKBe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589044; c=relaxed/simple;
	bh=jlDDwnGIo+5xSyDY11lM/zo5Jky5y6u2mE7xFpz70TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq7+2rASRKcIx8FKmgKnFJ8GL4QFw/L1YZ8snfNMnhxA9FZMbHKGIYncigChl4XZtDvnvxa0mUhL/+v6yjx0mzdqoA5jAjp0ayduzrNNUvYP0noSZgQuQHNDNyZ0xksZMqz5tVOHGaXKVmQb1ADTAoQDoKjrmq4awM/8z4EwrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipRtxDKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipRtxDKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0761F000FF;
	Mon, 28 Sep 2026 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589043;
	bh=zFWGeYStz8yg84u1yxEezXrsA6K3Shx6smatWK1szvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ipRtxDKGk5Q3CMPU8/WjZyodZohNtHvVgS3Rrd56ERsCivhuAyaZQehko40g5BojM
	 W92VBdsohIC+bl0dZnCqGB5qlBuWB1W6R+wfnm1MNFysUT8qmEadPYfvQ+AdHeqdcm
	 lYqRvThvIxcjLpuusrPF6FoDZolWOyAcM6FAnPgZ/L24fqFpvzuqqpy9a4QEQl5M7l
	 ufO00seq2O9zJ+SBgZi0T343pg/gcweSyTRSboT9P5JFWl2zCZwi1ird4t3WFxjqeN
	 so2bOVtoJowyRjS9shcsOHdlG9C2lzLx1xrxTqdDqHCsT1b0qSzAxoslHNwPkwQmwo
	 knlEYt1ehzXVA==
Date: Mon, 28 Sep 2026 17:50:38 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: moritz.tanner@linbit.com, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/805: fix for external RT devices
Message-ID: <aro32oI1akyaTv8i@zlang-mailbox>
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
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

This change is good to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

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
