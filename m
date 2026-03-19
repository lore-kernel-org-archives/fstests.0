Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C63DEAC3
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934724; cv=none; b=LcqjJgMlXqZJThqgTWwJse58fwr/fTRtRXL53aE0G9nvDghRroEx5IkdXTvpJRUPCYR4mUMZ3vUMGxOUA3gD6i2AU/xLiLn5kz07we6EP/wFuFvs2EFiHk22ZE5t8Rs/6UkRVXiE1GpFtwnfemCHbTbJy9neWcBTWhPvSm4PS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934724; c=relaxed/simple;
	bh=I7P2ioAT3T3Wtt+ot8egGP0dSrGK8fWLydG8pH0tcSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL+W2uCal5bDZBEZ8L+cXmCKy56rk3PJT0t4bQcmltunNgys2Z+EW4RBTUyoV2fq+6gKQull8rj4ctdaupIghy3adctPfrECJWqyygdHTdjVjwd86BQE3QtXgSreFdVWzcXr7taDyL4uQr2upM1rGgZV74LeLWHwFtvWOFqMJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrnVTP5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrnVTP5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5874EC19424;
	Thu, 19 Mar 2026 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773934724;
	bh=I7P2ioAT3T3Wtt+ot8egGP0dSrGK8fWLydG8pH0tcSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrnVTP5N/V6Tyl8X44hDbyh6ZJEoRkw30vU+V4SsntS1mLTMFzp5oYUUpELbi1wA0
	 W2gQGb9DQ3K3CHP8s5JsyBzF+TA1DmCfGewnYVFWfZXVPC4HuHCJrY+vQ1DWifwuFu
	 MMISkhgHEMMRRAER91ThMb3Gw1uQxuTPddStexvBO27QOw6w/T0sStHFrMaRS/AQE0
	 67KcYj9se/F5riuAV7ivp817OS8qmDptfL0FT7mxHbFLCIYWjYlg95DKFc8sBi/tup
	 xc8gJBrACu0FS6WQqCdXLiAXrAQlgqQh85gJ5luhoPnIFP89l37gue6TZubXlgqKes
	 phEUKdsgKfrWQ==
Date: Thu, 19 Mar 2026 08:38:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: add default _udev_wait timeout
Message-ID: <20260319153843.GI6023@frogsfrogsfrogs>
References: <20260319005154.29274-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319005154.29274-1-ddiss@suse.de>

On Thu, Mar 19, 2026 at 11:51:54AM +1100, David Disseldorp wrote:
> If udevd isn't running then "udevadm wait" loops endlessly. With a
> --timeout parameter provided, udevadm (udev-254.27) prints to stderr:
>   Timed out for waiting devices being initialized.

If you don't have udevd running, then perhaps we should detect that and
directly call "sleep 10"?  Because otherwise...

> The error message causes test failure via golden output mismatch and
> is easier to debug than an infinite loop.
> 
> The timeout parameter is also compatible with existing
> args="--removed <dev>" callers.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index fd4ca964..aade0e5b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5544,7 +5544,7 @@ _udev_wait()
>  	if [ -z "$UDEV_WAIT_PROG" ]; then
>  		$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	else
> -		$UDEV_WAIT_PROG $args
> +		$UDEV_WAIT_PROG --timeout 10 $args

...a system running udevd that's taking forever to process rules can hit
this 10 second timeout, at which point the test moves on and might just
fail due to unconfigured /dev nodes.

/methinks this could be done like so:

	if [ ! -S /run/udev/control ]; then
		sleep 10
	elif [ -z "$UDEV_WAIT_PROG" ]; then
		...

I don't know if your test setup has prepopulated /dev or if you've a
script that sets up devices, or something else.  10 seconds is just a
copy-paste.

--D

>  	fi
>  }
>  
> -- 
> 2.51.0
> 
> 
