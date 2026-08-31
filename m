Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADE46D2D0
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196821; cv=none; b=UbP/W+FmNqBtbNlt7bZ29XExvJvxq8I6eeW0dg4Jf5Pwz/N2EOcKQfv8GBYpvm2BUxNaWLEolM8+g/1HoRD6BhPepsvFDamDeU0YEJw2pFJJF4SfU662xCa+lc0T/w5uEi/6g9x0BlcxczslGEmA9XftmbmXmQdWNjidYbgeC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196821; c=relaxed/simple;
	bh=Z0pK7wtEo9EsijXtDjYGompwuwvQsq7Q9f3gizvBCkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezFGwwaB65a4EL92xBSqgdysB7tzpGLw347SIpPhDUwQ6CTCcoBc+jTRmIk82IUUHgxqTKE/QFYOCqvmBj4xakbHDj9W9VfIywS1RdhTy0WiSNReVe+pFvSKQAsSpiuA/feXAE18+oFCTZgdSnbGO8T2rDO6atNDd6GLcWb34Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHySJ5UA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHySJ5UA"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F176C1F000E9;
	Mon, 31 Aug 2026 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196820;
	bh=xUU3BfavZulFfKlLtBFTecZ8QNyFwxZlqquqT+OcF78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BHySJ5UAvPhso7JYFQX9PXGAyJXnTz25kGpeW7S2j/xDzEKL+8PbZWJQRENUsgC+d
	 3ZmoWrFN+tywv/+v/kz2MR9/uhy6r0hoAybNrqKXUZpLlDDX6tkFEg+FLZV74W8/Ja
	 eq2O4nTT5Al4dQBXTRsjYKodvJaq03Txm4ztKl+QrvrIXw4dIrPPLf5Ej7dn5+h8b3
	 roMWKe0OqkzQ7cTuojCSsQZ4yuEum6AoY9iHAR8OJNfJeyTYzn11aD9RmC4s7zj+7X
	 B+vtS746ZZmF2v743SNu7PRGP91ioQJoroutoZd/C5sNdRMCKZ7zug+1UbRqitHNYf
	 3YqG0mpxKyiXw==
Date: Mon, 31 Aug 2026 10:20:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH] generic/590,735: add missing _require_scratch check
Message-ID: <20260831172019.GG839663@frogsfrogsfrogs>
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

Yep, those are missing.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
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
> 
