Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0526FDAF
	for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900353; cv=none; b=NEU34WqDAD2uklak+SDU8BGwPdmdr0kyxRkYgZJGywaNAkvrMnJJ2prGgdmxkOzYs3ghgUfhRZsBktTcomLrpeKkN7EMTeuKso7QcEsnIwD3jW7zZJLuCkQGrF8/vq+WAAjmnmDfKj0bTiQ8zCZKuoQD9n6oJ1Zq8/5goCA4BtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900353; c=relaxed/simple;
	bh=SCa73ARiDlTWtB5J+teLyrxsg4/XqUCzvhPNI60zKyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9erg7TMSNUpUzITi4NnU3DEMxmxicFMlMg5YUOoFp/DH7tGuWUbLOZL8GQmWsnWONuAr9AiSErh+xgQ12NQEyGt3GpcktxqOVrC3/yRySXKKWYLQNnrxYTcFQ2u9jyFwi+n+StAIJTmU1y50+EADoqDJE4bClqUhTEb3qQillg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDo9uyX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDo9uyX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC5C4CEE2;
	Tue, 18 Feb 2025 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900352;
	bh=SCa73ARiDlTWtB5J+teLyrxsg4/XqUCzvhPNI60zKyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDo9uyX6eUnWifMbxnSpmDS3YjhGWzc0xx7bteFKA4Qm8gScB9BdKlUE+2c/SRwyD
	 eiFrfS92+Dg8vXUeCfzhBzuRPdOB8VzdRODxHjLO7zl+e9kGyprfLB6HxOk1LcwD+x
	 0nD6NVeGLzRe/sde/Q/RBtYGOMIm/WINS4Z/BBmqYReEZrOQdq4F92tsxYWKopMHNj
	 GJkVmbZc1Xh6ccuwyotG4ikfFMjI9touumVHTRleSY5rX54KT/pDNa6+SnMuuTeN6A
	 cRZ3bKPaI21w9vhvdVbV1IgndWDUCh/GafOGZoD1jSwMJ1KsY/8z39cEdaJstTHYIN
	 FqXdEbo7m6y+A==
Date: Tue, 18 Feb 2025 09:39:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/370: don't exclude XFS
Message-ID: <20250218173912.GK21799@frogsfrogsfrogs>
References: <20250217063135.3728305-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217063135.3728305-1-hch@lst.de>

On Mon, Feb 17, 2025 at 07:31:35AM +0100, Christoph Hellwig wrote:
> Skipping tests just because a file system is broken is always a bad idea
> as it hides bugs.
> 
> (Fortunately despite hiding the bug this is now getting fixed in XFS as
>  well).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/370 | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tests/generic/370 b/tests/generic/370
> index 8adffd2e9650..8101ef42724e 100755
> --- a/tests/generic/370
> +++ b/tests/generic/370
> @@ -22,14 +22,6 @@ _cleanup()
>  [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
>      "btrfs: fix swap file activation failure due to extents that used to be shared"
>  
> -# Skip XFS for now because this exposes an issue that is hard to fix.
> -# See the following threads for details about it:
> -#
> -# https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> -# https://lore.kernel.org/fstests/dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com/
> -#
> -_exclude_fs xfs

Needs a _fixed_by_xfs_commit XXXXXXXX "xfs: flush inodegc before swapon"

--D

> -
>  _require_scratch_swapfile
>  _require_scratch_reflink
>  _require_cp_reflink
> -- 
> 2.45.2
> 
> 
