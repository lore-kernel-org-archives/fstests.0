Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551390;
	b=0nxFufDxamGoCNyFdTdpsjQF4FAhhSN63PpLjgT1/p7+9hfvN1xMo6JzAikUvYxQ6Sx8
	 M32VQpAeNclUGOrRQqJ07fERYZ78Lm1tLXftsywws5V19e1JFPUke7/aAiVpYp332joNK
	 Y1EtPQ0fl0Szn8bMxVS8BboBHKqfS1dfLIeMU3H2vncyVWVkliyUd5RG4es7bUgERxGDx
	 nh+MxwfWix3isEU40PFUearOKj/7so4/l0pke1Ot7Xr2WGYEsv1BzfNx0icxU6O/DXyIR
	 5gRBx+lmF4kDzDeV+vzfRyvvA6PMmV4md/lIG7uyuU4UxIY+DOtTTZzwrmUR+JxN51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZL+pJNz2ehOhJIoC7sRcZiDnqegisV/CbcSMDEubbH8=;
	b=3K5Db4NqaV7PWK28BtYlTW/DYUP/HkioOP/dlRMSoHY+18w+OK2sm3jeb/4HgYm/fWoL
	 oYWgWxK5qw+ydkzWQ5cvMicPJqSYXqdFYunsrJixe14fJ5akCm/mY3t5R+ecpI3kDt8Oa
	 PjIf6zK2SmBB3rTvwC/sY86wX0gu0RScLB0TTOaj4ypjvDvoBbclyGGyrgDst7Pnxiyft
	 yXn79h50zjLp1cNc7nna/+DpZetKkBHWdBZxIADEZhRujwPNLuMd14Xa3lmrgt8dObmSr
	 E85MGn5BjELz0IcUVuM8EVuGX1vRr7qxWtOe6aUdlnqh5bSVwKp+vaSdZkgdx95+G1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+eEEEMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F8606A327
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+eEEEMu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363B51F000C0;
	Tue, 24 Nov 2026 20:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551389;
	bh=ZL+pJNz2ehOhJIoC7sRcZiDnqegisV/CbcSMDEubbH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k+eEEEMuyC1rvSqUyDXuLf+PZGgi+mEPASbuGuN0NUe0xlHaKtxWix6fy3s7MA87g
	 QSAqFXZmw4qYZZq3jhMNDluArPZNAs9sc5RD9s5kmBgruPYSSC2qjc3BahIN2wjZIx
	 fU9TG7KVAS3Q8XsYf17NzHbbyJn/JU2kx9JJ9XzbgQSNNxj25LlIk1IipEUBQvx/Wv
	 KaAF50o3pJZu83y5ae1mWqlSr38O2JDxVO7ICK0e4IDFHZY4TFkKnP26S7C3b5/rCT
	 uy7HyKKz8FNmkDGHN4iPlIaAvyDfdsgiYuY3aqVU4bkQh/4U1Uzwo76vpFSDga8RVN
	 B1cA7HJGFQFug==
Date: Wed, 25 Nov 2026 04:16:22 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 1/2] generic/453,generic/454: add a hint for the missing
 xfsprogs commit
Message-ID: <awXwfJ-CuO7XpuzY@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests <fstests@vger.kernel.org>, preichl@redhat.com
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-2-aalbersh@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124103617.4012647-2-aalbersh@kernel.org>

On Tue, Nov 24, 2026 at 11:36:14AM +0100, Andrey Albershteyn wrote:
> These two test will fail with xfs_scrub before v7.0.0 which dropped
> warning about use of bidirectional characters. These tests trigger these
> warning and break the golden output on older xfsprogs.
> 
> +Unnecessary complaints about mixed bidi characters in a name?

Sorry, what's this question for?

> 
> This warning was removed in the referenced commit.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/generic/453 | 3 +++
>  tests/generic/454 | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tests/generic/453 b/tests/generic/453
> index 9b121d995ad1..7d1deb553cd3 100755
> --- a/tests/generic/453
> +++ b/tests/generic/453
> @@ -17,6 +17,9 @@ _begin_fstest auto quick dir
>  _require_scratch
>  _require_names_are_bytes
>  
> +_fixed_by_git_commit xfsprogs 5f5d7fe4a7ef \
> +	"xfs_scrub: drop the warning about mixed bidirectional codepoints in names"
> +
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
> diff --git a/tests/generic/454 b/tests/generic/454
> index 81c9a721561c..b55e9474c35a 100755
> --- a/tests/generic/454
> +++ b/tests/generic/454
> @@ -19,6 +19,9 @@ _require_scratch
>  _require_attrs
>  _require_names_are_bytes
>  
> +_fixed_by_git_commit xfsprogs 5f5d7fe4a7ef \
> +	"xfs_scrub: drop the warning about mixed bidirectional codepoints in names"
> +
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
> -- 
> 2.54.0
> 
