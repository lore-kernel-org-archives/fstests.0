Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC7374198
	for <fstests@vger.kernel.org>; Wed,  1 Jul 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923689; cv=none; b=Y7dwwUB/80SpUYUnzP2N3d/snAnf1fS7HYVk8UKhfyM5mvRg/VvdYLpCtXtsQblRYKNhq6N7KGgQDs5kmPFCftuAiI6qm/2pLlQpomdU1K5uM/yL77x+2u9rTHvlnyQlQtXOHvPMhSx7XiM4jXSRiZOEBvxZ308CNbgR1o79lRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923689; c=relaxed/simple;
	bh=nELHqGLoddr2Aw0gFyRg6HBlRg6FJWfnSunz5WNXIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+XVaiQ/+/Wp8Y4WfQsrhvb/a67Uqmic7rmL1WhZa66SAxH4NarzluHT3Mlcd4HwAbq9tU5Uz5itdXo2ToF6oUpEHpgIPtOlxZowPgfLBSRfWhvqBfqGI/uS9sy/SM4ONXiY31U2zYy8exAf6I9OxxY7Dl4hPylE83+eg2wp8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+NW1pAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+NW1pAs"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E82101F000E9;
	Wed,  1 Jul 2026 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923687;
	bh=rteYE7RQZYesLHHhKXxEMv14Z2sINr51g5sa2I1xZio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+NW1pAssl+byKs4qDNRab1+ScnWxPodPXYTcOXvyKT5p0XoETFWp7yRbomiDv1EK
	 oFVTjczXq62m70newNCT/dAgUpB7mJ3DFTuW/XuLb8Fnj9dWKdTkK9K1/KEGrDP7A4
	 FaKGTFUifEBbETg1DSrUKAUfnlbCI/OQvu4N5G1YGEhzTvOTyyWQrNMafbyd/ceasP
	 eDjxMU3Ufs20vEjbuKQ/SUzwTMKtrH3PLYTTRnILYq6oRJiBvF10ViTLqxbUWqRM8+
	 VPg2Y1+7vlKlNIoCOcoSUKpefL0Jx2tfIh2daWVt+y+jWMvcMS8kMzmzD1iv2lEC0E
	 117NVPbuT03Qw==
Date: Wed, 1 Jul 2026 09:34:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: lan@suse.com
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: fix mount options quoting in _mount
Message-ID: <20260701163446.GC6517@frogsfrogsfrogs>
References: <20260629155812.GW6070@frogsfrogsfrogs>
 <20260701061413.10531-1-lan@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701061413.10531-1-lan@suse.com>

On Wed, Jul 01, 2026 at 02:14:07PM +0800, lan@suse.com wrote:
> From: An Long <lan@suse.com>
> 
> In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
> direct calls to $MOUNT_PROG were converted to call the helper function
> _mount.
> However, the _mount helper was implemented using `$*` instead of `"$@"`.
> This unquoted argument expansion triggers word splitting on any arguments
> containing spaces (such as the overlay mount options containing spaces in
> tests `overlay/083` and `overlay/086`), causing the mount to fail with
> "mount: bad usage".
> Fix this regression by using `"$@"` in the _mount helper, which correctly
> preserves argument boundaries exactly as they were provided by the caller.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
> v2: Revert the error log to "$*"

Very good!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 79189e7e..b9a07324 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -296,7 +296,7 @@ _has_dmesg_since_option()
>  
>  _mount()
>  {
> -	$MOUNT_PROG $*
> +	$MOUNT_PROG "$@"
>  	ret=$?
>  	if [ "$ret" -ne 0 ]; then
>  		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
> -- 
> 2.51.0
> 
> 
