Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DF1D61B1
	for <fstests@vger.kernel.org>; Tue, 28 Jan 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092308; cv=none; b=sK4iyAm/jtF8E35aVr8h/gia1SJZtvtaLpw/Jo0XbbgBedRTb7ZdnLsIs4Ba/uuS07+4Cp0qh2jRSBlt88WvYdkWRPF8vLP767zeJjEE6ZZRZiNVcqKOekYPqMUX1UzjUnAR4WJq+rOw6gsL9lPpukGpAA5hxv8DH8jAlm1GH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092308; c=relaxed/simple;
	bh=KL2QHoHHux7MVQ8z79/Nb5/Jo2xMrMcrY56yxQRTQ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeH5R/IAon+/yX+I76syyM56GcoskrgTtJYSRaMvWo9nNcPAF5yCpv9MPVf6q8R4bHxu98kU4q4rIPU62qx0jEAUo/5DOD3u+cxMXxaCfYTlkPUnMcmuhskE+6KsMeGfvLRo2DgIimhl65NI2LpgS5fIudT9QarpjQfjSPlEd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTWuR7PK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTWuR7PK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C0FC4CED3;
	Tue, 28 Jan 2025 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738092307;
	bh=KL2QHoHHux7MVQ8z79/Nb5/Jo2xMrMcrY56yxQRTQ8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTWuR7PKeVaTzQ7EqDUotsXEvzToMGbQ/ILowt00KE69BT5XE/S2O9p+iU/aq/pwx
	 dbEwgR0WG6+ljcHBaxd0r5JwkTlgd1WMzr90jANLxNgFtdKFo5nP1RxJ+Jm7MDiVBi
	 VHyFsQS4l9DIQ9FIQz1CuuMyfAc/e0n0DAjoau0xYc6sYah/cmMaAmTN3eGUPFJdf+
	 iovUi9Dr0ncc93jMM9/1HxLEg8hpAuh0t1phfiC5BQ/hu2NLs079QW0icHnF6a4BJY
	 B6JJWnfvcY5rh041IZwyrqz8OhQXATV7L9hQ4g+zsjxArEhUKBQlH2QljHFJvcng2D
	 lYwLempji9OKw==
Date: Tue, 28 Jan 2025 11:25:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/541: _notrun if the file system can't mount
Message-ID: <20250128192506.GT3557695@frogsfrogsfrogs>
References: <20250128071449.676462-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128071449.676462-1-hch@lst.de>

On Tue, Jan 28, 2025 at 08:14:48AM +0100, Christoph Hellwig wrote:
> A file system created without an RT section might not be able to mount
> with an rtdev specified if the RT device has a larger LBA size.

Where does the mount failure occur?  The initial mount (where we specify
-o rtdev but sb_rblocks is still zero) should succeed because
xfs_rtmount_init ignores m_rtdev_targp if !rblocks, right?  So it's only
when you get to growfs and we try to read the device that things fail?

--D

> Instead of letting the test fail, _notrun it for that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/541 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/541 b/tests/xfs/541
> index 42bcd95802c5..c8b312fddc92 100755
> --- a/tests/xfs/541
> +++ b/tests/xfs/541
> @@ -26,7 +26,7 @@ _require_scratch
>  
>  # Format scratch fs with no realtime section.
>  SCRATCH_RTDEV="" _scratch_mkfs | _filter_mkfs 2> $tmp.mkfs >> $seqres.full
> -_scratch_mount
> +_try_scratch_mount || _notrun "Can't mount file system"
>  
>  # Zoned file systems don't support rtextsize > 1
>  _require_xfs_scratch_non_zoned
> -- 
> 2.45.2
> 
> 
