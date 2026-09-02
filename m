Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDB4AA585
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369604; cv=none; b=toQ8vTcyTs6N1kulBv7uoBXy86RKkjV54ui+YPD02Httw6xOr2mKI6C844y+Sba7wzWhNbBWPatFovAscZaiMOfC8OAb3+NccIFjXHiJPevWmC4UjVuu6rPG8ka7tKciUJMG50prQjWXjJ38CSgAQLB1BmdcbM3ATThqJsaBY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369604; c=relaxed/simple;
	bh=SNrgP5N8i9okpwT8ZO1xv2u+y4MokbU4nxSwN7JaX5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBb3rVcWxfJRUyojYzXL4VDB5h9aPGU+YuU4rW00U5w4YMJhWXaKlnrZPVzllqenIphBkysKN+iMPbptEFu6PJYONhxbg7Rfc1R12G81iCZN1AQyjE6Pdk9AhaC8ow7C9BoR7SmW93njU3ieGfuuUgIaJywzGBJbAzOHxf+Td9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/KnHQ2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/KnHQ2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C81F000E9;
	Wed,  2 Sep 2026 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788369603;
	bh=HQjvxoCsUGZp7xbedM7f1brgwAts7xpJu8FvliKE2f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M/KnHQ2rXMhNWUxY/+QPx6Cvn2iFPbk0l10jxSa5KroX+OkQmyVGkf/NM69C9bPwQ
	 t9mxUuVm65qw/SFcbjmLh+5rzxEc2mhobbtpnJVjLBmnQN3JfNf3K55JFYZpAnSTkc
	 uJ2e3IWxWbvWZH+jsWq/Lv232ui/VvUiy77uNwBz+MiRGZAPE+XkZ36VbaAloIh15Z
	 xbJp+0HVx4rQA/TM/hnLX1lXdax+G7MZt2p15P5pKeQJ6DphTBvQeX5OnOnofhzqpa
	 rWsz8nM49G07Lsx1frP6NabpDZuDvzdsXLD8KMHt+Kwub7V2dvc/RZaKPq7wAFsHTf
	 E4ox89iIsi8tQ==
Date: Thu, 3 Sep 2026 01:19:57 +0800
From: Zorro Lang <zlang@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/590,735: add missing _require_scratch check
Message-ID: <aphYxFfLThLQj8y2@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
	fstests@vger.kernel.org
References: <20260831104148.2243-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831104148.2243-1-prabhakar.pujeri@dell.com>

On Mon, Aug 31, 2026 at 10:41:48AM +0000, Prabhakar Pujeri wrote:
> Both tests use the scratch device without first requiring one, so they
> fail messily instead of skipping when no scratch device is configured.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

Hmm... one more

And why does this patch need to be separate from the other one --
"generic/795: add missing _require_scratch check" ?

Please group patches with the same rationale and goal together, it'll prevent
them from being scattered everywhere and helps ensure I don't overlook any.
I'll drop the ones I already merged and wait for your consolidated patch or
patchset :)

Thanks,
Zorro

>  tests/generic/590 | 1 +
>  tests/generic/735 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/generic/590 b/tests/generic/590
> index 54c26f2..0775d6f 100755
> --- a/tests/generic/590
> +++ b/tests/generic/590
> @@ -13,6 +13,7 @@ _begin_fstest auto prealloc preallocrw
>  
>  . ./common/filter
>  
> +_require_scratch
>  _require_xfs_io_command "falloc"
>  
>  maxextlen=$((0x1fffff))
> diff --git a/tests/generic/735 b/tests/generic/735
> index 60fa3dc..d7e732b 100755
> --- a/tests/generic/735
> +++ b/tests/generic/735
> @@ -20,6 +20,7 @@ if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
>  fi
>  
>  _require_odirect
> +_require_scratch
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "finsert"
>  _require_max_file_range_blocks $(( (1 << 32) - 1 ))
> -- 
> 2.55.0
> 
