Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96E17A303
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164117; cv=none; b=WqMiqMjb67iuxRwLwZfEIZgvzU50jpqDe7FWWGlzzuKcOYUUGsBr6icJxmQu6+8CczEmES38m2EcdiLJRVjDNeWlcQGdidiJojj4wizl2Xcg8eUqTJmHGgekwBep+WvEYLl0LxAeATltmwUMYMg/nFJLTD++Ssz3u7FwZKmG/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164117; c=relaxed/simple;
	bh=tX92deriQhNMPgmXRC6foloZVAcOxW7QAC/Hh9ISJek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU0hXOf3xbVv5kd3fvuFeFTBbQMZpkJiBD2AVkoXoxKYF6ML6SWysBrwOQxCfREu0fGTFZ+EpIgAUpS9OSWeno8Ja36GBE14+UUXSXl+YjXcYzofIA4YUfyDQCWgnJpsTN39XPYJlIh++bHhcRF8tUxWhFkaf+Sowc3Uxn2dYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbGXOnFe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbGXOnFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A8CC4CEE3;
	Thu, 10 Jul 2025 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752164116;
	bh=tX92deriQhNMPgmXRC6foloZVAcOxW7QAC/Hh9ISJek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbGXOnFewPzT0H+eMxvdaVrhc1Fa+TlekH9QzGpf9x+My2UWAgPE7Z75ou5WRdN39
	 c4uaxtuYVdPPo4ZDvVEbd2jU0dzgMxRE13t8tb+fVO84H2qx1F2eJoiXyxIaDV5edf
	 Qxal9FZPJiqB7snvkKxuDHBvjLABb01jjkNCfaMf+cKGLovwuV5eQ/ZfnRrRJwGSdY
	 W+k3oysaXvvc2a+ryY6O+9HyMtpSG4z8CYngtULtKMfgUqbyIS5v2cOg+XoooFI02v
	 r0Uv+BCmscj13NGa2b4IpASEb723rMEP2W5OUhbwdJlCaGgXEw5IRO/7GhHJXpCh7L
	 Js30pn7pfhc6A==
Date: Thu, 10 Jul 2025 09:15:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] common/rc: _add_dmesg_filter returns when RESULT_DIR
 is null
Message-ID: <20250710161515.GB2672039@frogsfrogsfrogs>
References: <20250622203947.797199-1-zlang@kernel.org>
 <20250622203947.797199-2-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622203947.797199-2-zlang@kernel.org>

On Mon, Jun 23, 2025 at 04:39:47AM +0800, Zorro Lang wrote:
> I always hit below error on a system with readonly rootfs:
> 
>   ++ _xfs_prepare_for_eio_shutdown /dev/loop0
>   ...
>   ++ _add_dmesg_filter 'Internal error'
>   ++ local 'regexp=Internal error'
>   ++ local filter_file=/dmesg_filter
>   ++ '[' '!' -e /dmesg_filter ']'
>   ++ echo 'Internal error'
>   ./common/rc: line 4716: /dmesg_filter: Read-only file system
> 
> The RESULT_DIR is null, due to xfstests/check calls _test_mount and
> _scratch_mount before RESULT_DIR creation. And _test_mount does
> _prepare_for_eio_shutdown -> _xfs_prepare_for_eio_shutdown ->
> _add_dmesg_filter "Internal error" when RESULT_DIR is null.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index a27f87a0b..549f42135 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4800,6 +4800,12 @@ _check_dmesg_filter()
>  # Add a simple expression to the default dmesg filter
>  _add_dmesg_filter()
>  {
> +	# This function might be called before having RESULT_DIR, do nothing
> +	# if RESULT_DIR isn't created
> +	if [ ! -d "${RESULT_DIR}" ];then
> +		return 1
> +	fi
> +
>  	local regexp="$1"
>  	local filter_file="${RESULT_DIR}/dmesg_filter"
>  
> -- 
> 2.47.1
> 
> 
