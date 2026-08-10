Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39749280331
	for <fstests@vger.kernel.org>; Mon, 10 Aug 2026 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397523; cv=none; b=WpAwSKErbYNcScBBtNwo5w96K6LVbVQnBtmyhpyI6E5zqWiNpUzL0V0Cw8x609npR0T5Q5+D9g7I2T3EcvsD9fHKkW+I2eLSGECjBHfYBA/Xov/GQCYXIsLQ/y321t4Ff3GXqYiSz0TAq6ayAtNOjY9HBHMA1Qj1ISgRdRu7Ihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397523; c=relaxed/simple;
	bh=NPtitaZ9Ize2JLaYWlHIJ9dGZM8oGEadxIlulmquJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+YqBbhIeO9QlMXssIeLJ+9PAsGT+Dmxh0mprhpRK3cW4G16D/uSKBzXtXaOAhhcIOrI9wbsXmuczhlsn8LmyG/F4h56wH+JOAqni1ZxZlJFjiFsjz8fOUdXzlJ03/8hLCGzm25e78qSCL07zpSmD17nvPJhPZBWtrO75LFB9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMuYr/vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMuYr/vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96D1F000E9;
	Mon, 10 Aug 2026 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397521;
	bh=Rq5TXZwGh8bHakwZAjo2zz9SOEUCvr7mY7hsujq1XfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RMuYr/vhlbLe7oT79VRfa0QeMoH19KD0rmCguQoRoKUx0hRYeMofoJJpF7ZzBfxoJ
	 ooaaNs6hm0OHz/Yn9VvhGIJQePrL/n7xXgzkGlvYPF/Pa4yA+TiHPEpe9lhWX2Lceg
	 xvtlXz5d33slPZNujRMaGu/PTVIuSqF30qnWc6ESsHuUg8chLo+HHC0QiXHl4nWiLj
	 kIFd8hqq0lO+Kut+28gYhh9+TsCp6CR8WoTsBpto3XQzEYfpChvoqY+3MS0XlfHq+f
	 0w0Zm1ZuhTxP4sFtGvn6dRfCtLcKiiiTm+VXkgL5MM7y/+bfGCfECVaUHp+wF51Mn5
	 Kbw3Wa9EPg5aA==
Date: Tue, 11 Aug 2026 05:31:57 +0800
From: Zorro Lang <zlang@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: use -w instead of --path for man program portability
Message-ID: <anpCryB4LUn6PCib@zlang-mailbox>
Mail-Followup-To: Anthony Iliopoulos <ailiop@suse.com>, 
	fstests@vger.kernel.org
References: <20260803115819.17110-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803115819.17110-1-ailiop@suse.com>

On Mon, Aug 03, 2026 at 01:58:19PM +0200, Anthony Iliopoulos wrote:
> Some implementations of man(1) do not support the long option --path to
> display the actual location of a man page, which can cause these tests
> to fail on systems using alternative man packages, such as mandoc.
> 
> Switch to using the more standard -w flag across these tests to improve
> portability while maintaining the same behavior, given that the --path
> option is just an alias to -w in the standard man-db utility.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---

Looks harmless and effective,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/xfs/293 | 2 +-
>  tests/xfs/505 | 2 +-
>  tests/xfs/514 | 2 +-
>  tests/xfs/515 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index 3e887f1c40cf..9735c441ab32 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -19,7 +19,7 @@ _require_command "$MAN_PROG" man
>  
>  echo "Silence is golden"
>  
> -MANPAGE=`$MAN_PROG --path xfs_io`
> +MANPAGE=`$MAN_PROG -w xfs_io`
>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> diff --git a/tests/xfs/505 b/tests/xfs/505
> index 81f53ffac23d..f0f435241dda 100755
> --- a/tests/xfs/505
> +++ b/tests/xfs/505
> @@ -16,7 +16,7 @@ _require_command "$MAN_PROG" man
>  
>  echo "Silence is golden"
>  
> -MANPAGE=$($MAN_PROG --path xfs_spaceman)
> +MANPAGE=$($MAN_PROG -w xfs_spaceman)
>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> diff --git a/tests/xfs/514 b/tests/xfs/514
> index d3641c3e1af6..215ae5e7cc5a 100755
> --- a/tests/xfs/514
> +++ b/tests/xfs/514
> @@ -24,7 +24,7 @@ _require_test
>  
>  echo "Silence is golden"
>  
> -MANPAGE=$($MAN_PROG --path xfs_db)
> +MANPAGE=$($MAN_PROG -w xfs_db)
>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> diff --git a/tests/xfs/515 b/tests/xfs/515
> index 7d6e99405972..0596457e5adc 100755
> --- a/tests/xfs/515
> +++ b/tests/xfs/515
> @@ -24,7 +24,7 @@ _require_test
>  
>  echo "Silence is golden"
>  
> -MANPAGE=$($MAN_PROG --path xfs_quota)
> +MANPAGE=$($MAN_PROG -w xfs_quota)
>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> -- 
> 2.49.0
> 
> 
