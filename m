Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B150383
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380049; cv=none; b=hFYjF2Uz9amWID5tCxcTLC/sLnmY4apCEfxuCAq0Rk1guTLN7T9vK9EWf5/orXvCm592gk82yt0VLcR+4M3bYIBrohIN9Q3SbKwng9i0uFojIcsB6RJ/Xzng4AqAgpyK9lDRWMAoXyxr1cLW4WrON+Ax5LgImNsh+UWzNxVnb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380049; c=relaxed/simple;
	bh=jyaEaabv/WG71extKDhbaWiPSu995Sb+mcFVwkyMqFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRU19JtHC08KPGwD5B5mWGzFXB4UIcwqgfT8EgqcLunf8wKD+MWEnM9TwaeJPh8zU0+aX7jP4ymuJKhkRGSUCQPntrt2jHUGqy5bgHxmnzR/SuhOQbJuJc8h84PPjedRFq2iH9sjGmyeX+PvVkt7vt9ErB5BqXmdHAMKmvMbMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5FvNDzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5FvNDzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32332C2BD10;
	Fri, 14 Jun 2024 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718380049;
	bh=jyaEaabv/WG71extKDhbaWiPSu995Sb+mcFVwkyMqFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5FvNDzG7/SGNSA17hrrpbAamwt11oijsz/nUOyUPx204nEhOq56683pzoPDvxmk5
	 x2KfK4zkouaYHJOtkk8qC16fZv28idKvSp6TnmquRibtepNClNgH8+oTMIWDYOLE6q
	 ltZUWn+UadSbMKwKeSutGjihZE5L2FSGtnvzWIkA6ABK0vYTFlO21SwErRBxwKsTm8
	 LCxQxKYt/XJQX7FvBTPeyz+xPo3ii80Db+6k3+L/76V+JI9+4MShaFhRm3LhZsBbEA
	 lScoya6dLoYVOcmXQCzF0ArzSbpcIOiMZYOSa2lSx9x7M44nHsBytBNZrLljEcAKT7
	 13lHb4TTCwjSA==
Date: Fri, 14 Jun 2024 08:47:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 4/5] common/rc: fix scratch mount options for tmpfs
Message-ID: <20240614154728.GC6110@frogsfrogsfrogs>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5@eucas1p1.samsung.com>
 <20240614061722.1080-5-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061722.1080-5-da.gomez@samsung.com>

On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> Make sure tmpfs scratch device inherits the extra tmpfs mount options
> variable (TMPFS_MOUNT_OPTIONS).
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f995b0fa..a42792c37 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -224,7 +224,7 @@ _test_options()
>  # hosted on $SCRATCH_DEV, so can't use external scratch devices).
>  _common_dev_mount_options()
>  {
> -	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $*
> +	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $*

Why is it necessary to include tmpfs mount options for all fs types?
XFS does not accept tmpfs mount options.

For that matter, why is TMPFS_MOUNT_OPTIONS necessary at all?  Shouldn't
that simply be "MOUNT_OPTIONS=<stuff> FSTYP=tmpfs ./check" ?

--D

>  }
>  
>  _scratch_mount_options()
> -- 
> 2.43.0
> 
