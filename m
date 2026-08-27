Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C6448B9A
	for <fstests@vger.kernel.org>; Thu, 27 Aug 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843977; cv=none; b=mUVHMdjpmz7VYKKAyZiMeVf/QHfriJUkSbeg7nNP9jBiRTySO+iE9Amp1tJkIdqh8j/nM2fc8gUJtJiR8XN3ZpfvHg+xgvY1quqFeOFQ667KxC8x6WT4C80Lb5NrzBOCUwqIvFXiAMX9UbdC83jG7GSWE0Z5kCRoc78K8hrLFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843977; c=relaxed/simple;
	bh=9p2RM4D+u3M1IyjG4TwrlUiv/pzcqMG++XPwvzpvkrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL2F2yzDJHKOIdCKIEMsZBE4fxjqGnn+442LmCNkEl0e6hfDRapaM9Ac5t8gVEbBahWGIEWbdAfmm6gzQbzXxVKJkOAKlHEOCk5Q6yCdg2MUHD+NaeJ0bbn3byMKyvhx5FQBpX/iAJMZkNwWx+StS2xhxHwQBj6UbmIAfXQPg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTXJWCfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTXJWCfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC21F00A3D;
	Thu, 27 Aug 2026 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843975;
	bh=tHb1c06zFIzQ8rbuFZfxfj1HBwc5b7391Yt8FkbYtrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XTXJWCfnx+EUPq9nzCeruo6kz3HgOIvEFkCJ8TpsnfgSMiOaXfhC6CN+DSQm1kyAV
	 ADtooT8jYce+zof5LMp0vc6Lza1NHzzYo1VgKabXXwoLK7JNv1SDRFdv6u2NVfdQZc
	 CGkhoGdijgMXkqMoQ/5QWFFFC3WHivYYhvrnL2OfTBS1Mlq+3o1DzgSJQA/JrM+noi
	 hGe5RDbS/5weawcOrO36LAMQ9XA6dOlitRiUDXew8jAT2j7b9qXIWlQfaYMpSS0YST
	 T9riS6pOeGRHnZgAmDGDktJ5vDlIDBLoL1K33zLIYRwpK61mHTi9Q+3JZq5IOMttl8
	 A/1of6aPFXO/Q==
Date: Thu, 27 Aug 2026 23:19:29 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 5/5] Add _require_mknod as needed
Message-ID: <apBVcIQ_6b6KYDjU@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>, 
	fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825001337.449670-6-sandeen@redhat.com>

On Mon, Aug 24, 2026 at 07:11:12PM -0500, Eric Sandeen wrote:
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/398 | 1 +
>  tests/generic/598 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/generic/398 b/tests/generic/398
> index a6939b22..927f63d3 100755
> --- a/tests/generic/398
> +++ b/tests/generic/398
> @@ -21,6 +21,7 @@ _begin_fstest auto quick encrypt
>  
>  _require_scratch_encryption
>  _require_hardlinks
> +_require_mknod
>  _require_renameat2 exchange
>  
>  _init_session_keyring
> diff --git a/tests/generic/598 b/tests/generic/598
> index 52541b3e..9cb29021 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -36,6 +36,7 @@ _require_user fsgqa
>  _require_group fsgqa
>  _require_chmod
>  _require_chown
> +_require_mknod
>  
>  USER1=fsgqa2
>  USER2=fsgqa
> -- 
> 2.55.0
> 
> 
