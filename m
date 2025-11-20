Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC811E2614
	for <fstests@vger.kernel.org>; Thu, 20 Nov 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681068; cv=none; b=qvCF/sxWgya3BadhxnLXvXJ0Ds5//2wlS+iD1Tj0ErWgX454Zc14NOm6ZV+7zhddmS8l7SBqrpAg/a0zZogaclBlhU6wDAQuCiRCMoAWlQrf5zDabdVk+UIXkx+1uOjmLluKwBXo2CrJu7HJoFE+Ck/izLo0QEPhfCSUFjgWOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681068; c=relaxed/simple;
	bh=NiDBIaxDCoTmLrvC08JyDMBDabOR6+aa0wL4J8NrW5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwMwjfJ4ULbKoi0p8t01zz/vmPffB/rpRFWiVONMEMY1QineQ8sPaMvaNE41r/TIoNJKIYJexZYWSbW3dNrrs9RgpV1Ksa1mXRKoC6dcafig83D+MCQjePhIqbadcaIJ6IUBd1aUHOCXFxMFgdm4o+KXBiysjH5925IardRFXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNicq9Fr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNicq9Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EEEC4CEF1;
	Thu, 20 Nov 2025 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763681067;
	bh=NiDBIaxDCoTmLrvC08JyDMBDabOR6+aa0wL4J8NrW5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNicq9FrCaOfS3bI2ljcvlpmRENdIZRB32yqSznaMhSLlDjcNb8CKLWrcde3ljEso
	 iPJBXVOC+jpiXaKDG8wgUTyXl4qEKJ5JDF4oTKIGJqs3b7MgwUGZhrcA0dSjT6RJnb
	 iWu9fE985PPcL4nUybcX8fFsbxIeG/sbkZOLvJLBLuR82xi8JXnuyevbsprq9A7eaH
	 Ud8fzVfZgHQat5mKozTSlW71IxSZNeZhwMywKWVcmSd20BbVFVI13LUOlN7z2cjq3z
	 Wx6asUEhYs4h+0iirsL1kC8o+g/ncd2FFomumOSC6bxYD4lwrX7a4lBjNv4XgENH19
	 gcwDcAGSfUA1Q==
Date: Thu, 20 Nov 2025 15:24:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] common/rc: fix _xfs_is_realtime_file for internal rt
 devices
Message-ID: <20251120232426.GL196366@frogsfrogsfrogs>
References: <20251120160901.63810-1-cem@kernel.org>
 <20251120231536.GK196366@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120231536.GK196366@frogsfrogsfrogs>

On Thu, Nov 20, 2025 at 03:15:36PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that we can have internal realtime devices, it's possible to have a
> realtime filesystem without setting USE_EXTERNAL=yes or SCRATCH_RTDEV.
> Use the existing _xfs_has_feature helper to figure out if the given path
> points to a filesystem with an online realtime volume.

Oops, silly me must have hit reply-all by mistake.

--D

> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/xfs |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index ffdb82e6c970ba..8b1b87413659ad 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -253,9 +253,9 @@ _xfs_get_dir_blocksize()
>  # Decide if this path is a file on the realtime device
>  _xfs_is_realtime_file()
>  {
> -	if [ "$USE_EXTERNAL" != "yes" ] || [ -z "$SCRATCH_RTDEV" ]; then
> -		return 1
> -	fi
> +	local mntpt="$(findmnt --target "$1" --noheadings --output TARGET)"
> +
> +	_xfs_has_feature $mntpt realtime || return 1
>  	$XFS_IO_PROG -c 'stat -v' "$1" | grep -q -w realtime
>  }
>  
> 
