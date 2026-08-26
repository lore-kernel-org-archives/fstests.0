Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960940855
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757307; cv=none; b=Pc3n8cfNYVViaCb5FYWTOn51O0WVD1zGCkLhEawD374jx3VgOEf33JPvHrjkIP2s2hUisnxMswmSS3QzzSQ2E6Hx0ES4vwZrwu6Jvs67MkdhRwdaeFJvsHA9C5JjWrHz0mN31vec2YhEO7oqQHJN5iHHoG6Vcv4zAWYvUQ/J90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757307; c=relaxed/simple;
	bh=uFqHHRjqwiX2bRrKDtNpF4qoHrGVXyVus/LKPXzXD/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjT1SNsLsDF61okqm7n2RdqckWtefFwYwahPSJCFHbVofiqYh1O5x86NjCiW38+ftBNWuLjImQ1WBLDXoUT60qpiJPXLYv4vBm0PKhGZll0cf4hbwLMYL9/5P9thGoCeYZs1G9tH7IZxNZLe4SSjOGAvrlcpzAfg12VmuOM2cAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMDnZfZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMDnZfZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC0B1F000E9;
	Wed, 26 Aug 2026 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757306;
	bh=mkGe10c+2l/fp0mTq09eAdaCTXnAYZJd3S5UoBx+SLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jMDnZfZxLSuYN9KPw/WDxvgT1zJ6y/XRVw4ysOtuVguzHhewAiAKkINbTZ1F29oN3
	 eIlZ1lg7KMMX6jg6g2688zzjZ0+T8P1qLkiOxSh7HGZpOFVVvBZhPxkBeqHiPAvgKT
	 5WJheLMMxGmFNsQvd2DwHE9J/R3IyB0/jTGMTaSV5KEIfRq5egRWUTt1kxd9UG2Fh6
	 WHkFWrthdr/dxxUVrTPAsd2fnvgRbvKS9bnmtzZZUkOnUUUjNl1l4I2WIikmp1h+/j
	 Gf+2+1N2bvWphYeSJjbBNRmW79PTqDPj5Y2yJqbVodGkZQyuPsllH+tCYQiJIMU3aW
	 ZjbWbLn/mkOCg==
Date: Wed, 26 Aug 2026 23:15:01 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] generic: remove chmod of $seqres.full file
Message-ID: <ao8C0KyuizVTgQzH@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>, 
	fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-2-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825001337.449670-2-sandeen@redhat.com>

On Mon, Aug 24, 2026 at 07:11:08PM -0500, Eric Sandeen wrote:
> This appears to be an historical artifact.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Makes sense,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/379 | 3 ---
>  tests/generic/384 | 3 ---
>  2 files changed, 6 deletions(-)
> 
> diff --git a/tests/generic/379 b/tests/generic/379
> index 4c7fc939..9e5889b9 100755
> --- a/tests/generic/379
> +++ b/tests/generic/379
> @@ -22,9 +22,6 @@ _cleanup()
>  }
>  
>  
> -cp /dev/null $seqres.full
> -chmod ugo+rwx $seqres.full
> -
>  _require_scratch
>  _require_quota
>  _require_xfs_quota_foreign
> diff --git a/tests/generic/384 b/tests/generic/384
> index f2344380..69fe3695 100755
> --- a/tests/generic/384
> +++ b/tests/generic/384
> @@ -42,9 +42,6 @@ cat >$tmp.projid <<EOF
>  test:1
>  EOF
>  
> -cp /dev/null $seqres.full
> -chmod a+rwx $seqres.full	# arbitrary users will write here
> -
>  _require_scratch
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_enable_pquota
> -- 
> 2.55.0
> 
> 
