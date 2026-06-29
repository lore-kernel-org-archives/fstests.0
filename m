Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348B426D22
	for <fstests@vger.kernel.org>; Mon, 29 Jun 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748694; cv=none; b=Kb/VTWwrvtHSeD0ir4biiqoX4qqQ1VDNz/saHMhIlop7nRlEdG5hu0sZaTzJ7UZrV1kTvFOnqLlJybNj3Q+Nuyej/tVEg/j2nOS6l2p+ommlEcNI83i5S2IvyC8qOBvY90KkHSwxD9+ob0oVrAPlo75nWHAXBCTg+hOA9kfkEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748694; c=relaxed/simple;
	bh=hyvDWZ0Kjsm/HfFzC/A6tU7oi+GOkg7DaULSUmbQyd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBn4Ux69zmQwKo1A/pw81aKHn8X+fyxnLDqLGiVFiisLYixg0FVMVE8QWBIEn5Qz5QOz9ZghBF9OnPl0dX9d5CCoxsdDdL4sbXWmh6e/bQu+s04k2VbkbV6lP56BYImKRbK39qjtlpZiG9ElFqKas8spjqZdTnB0/ZrsXDdkl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlMaRWjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlMaRWjV"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5E8551F00A3A;
	Mon, 29 Jun 2026 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748693;
	bh=UzCJ22oWGdwSHpAKJousrgn2Vw661SwRGheQm+SlOt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlMaRWjVGEWvKvq3xc0tyrG/9VpdiKyGPfA12AkGlJJsaAciYgITDUMI+iBQbVLpd
	 lcKbyb4Crk1/rX75gV/73zDAx5Go8HvMeQwcT17McwgpJEG7t1mg0Lt3DBUlR5ylm0
	 aLRUcXhKDUyZoEpGRO9VtNnh2tf70pgcJDINk1ketd33nfGfFwyK6v3k+KhnoRiy67
	 dFCel/Mftjn8AWySQsVjk6sA4SqW4UcHXEboOZQdSlynHqVaA4cd2k1F222U6RazX+
	 ed5JBpbjfAb6CBklNx/wFpGCIVLyAf6vpJwmwWRpwapGWPUxHxFwU8eh73iTRGPsbx
	 ZFXZrHd46uBIw==
Date: Mon, 29 Jun 2026 08:58:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: lan@suse.com
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: fix mount options quoting in _mount
Message-ID: <20260629155812.GW6070@frogsfrogsfrogs>
References: <20260629132935.30559-1-lan@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629132935.30559-1-lan@suse.com>

On Mon, Jun 29, 2026 at 09:29:35PM +0800, lan@suse.com wrote:
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
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 79189e7e..56dbea6f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -296,10 +296,10 @@ _has_dmesg_since_option()
>  
>  _mount()
>  {
> -	$MOUNT_PROG $*
> +	$MOUNT_PROG "$@"

Yes, "$@" is how you're supposed to convey the current list of arguments
to a subprogram as a list, without alteration...

>  	ret=$?
>  	if [ "$ret" -ne 0 ]; then
> -		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
> +		echo "\"$MOUNT_PROG $@\" failed at $(date)" >> "$seqres.mountfail?"

...but when embedding those arguments in a string, $* is the correct
usage.

--D

>  		if _has_dmesg_since_option; then
>  			dmesg --since '30s ago' >> "$seqres.mountfail?"
>  		else
> -- 
> 2.51.0
> 
> 
