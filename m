Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA11CA4E
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470965; cv=none; b=mWAhUu2CGQT7plcWrsUTbeXC0ED55GNnrP7ZeVckTnCD0TseSUn2CRZtFoEAXh56ChN7UskkI2VZJEhMVEg8gVqFoxDKq6A5NSl5GEph1HnRKFXlZFyk24sfqdOSIzQs9uPpJEgcEeBCbSg4/eDs0UenHBuJe/VIioW8X5b5tEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470965; c=relaxed/simple;
	bh=5i/c6GayHjy0PokdUvTmAvKMPpi26IeaBaFV3jKxmpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWh7ln2XBidWA1sGjBag4RS5Hz9ORBGCjygieylTo8KMFOVjmaYbsCWMJZOiJIxbFcwyt4ITNA3QJOkYR3YjaHU/nhqY072rqLl/mB9GoyhFu2GHG4JZJiXe45GR28mevv2fYgO9NffYOHZFABpk8qS1VIOgoxWIo9eR9RQYbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwCgUvPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwCgUvPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5426DC433C7;
	Fri, 15 Mar 2024 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710470965;
	bh=5i/c6GayHjy0PokdUvTmAvKMPpi26IeaBaFV3jKxmpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwCgUvPeCWI5NTaeeanIua3JV+9Cvu9QN26buoXv9e3MlM+3QLJMnUZ1XSfHXvRQn
	 /t2w3AJZlmdEayo6aBnprXPpUcHyaOe8KQLEqKh57GGLU30XN3VHeMeEezfv3ssrf/
	 CYPOoUY0yGCEsvpFXwlMf0BKVAadndVpXVzZmjuQiTBwbCQbWH/W7vRrpBmkM5B4df
	 AVFyYYAZMjWxT/VBFxsYUFj/1DqzU0m8SrwzyNa7HffYWnSDcxykSOQYwIEo6L9xT0
	 LUKii6Fg/Fb4vau3zhZAzpI8RxgRxMisqWCTgnq/lQA1HYgDxCnFnKl+4QurZJVuh+
	 KdTEn5yRtVG4A==
Date: Thu, 14 Mar 2024 19:49:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/fuzzy: make _scratch_fuzz_modify work for
 non-xfs filesystems
Message-ID: <20240315024924.GF6188@frogsfrogsfrogs>
References: <20240314172512.28293-1-luis.henriques@linux.dev>
 <20240314172512.28293-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314172512.28293-2-luis.henriques@linux.dev>

On Thu, Mar 14, 2024 at 05:25:11PM +0000, Luis Henriques (SUSE) wrote:
> Since commit 9bab148bb3c7 ("common/fuzzy: exercise the filesystem a little
> harder after repairing") funtion _scratch_fuzz_modify() has become
> xfs-specific due to the use of some functions that assume this filesytem,
> namely _xfs_force_bdev() and _xfs_has_feature().
> 
> Ensure _scratch_fuzz_modify() works again with other filesystems by using
> these functions only when testing xfs.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Oooooops sorry about that. :(
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/fuzzy | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index f5d45cb28f07..218fe1654386 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -8,15 +8,17 @@
>  _scratch_fuzz_modify() {
>  	echo "+++ stressing filesystem"
>  	mkdir -p $SCRATCH_MNT/data
> -	_xfs_force_bdev data $SCRATCH_MNT/data
> +	[ "$FSTYP" == "xfs" ] && _xfs_force_bdev data $SCRATCH_MNT/data
>  	$FSSTRESS_PROG -n $((TIME_FACTOR * 10000)) -p $((LOAD_FACTOR * 4)) -d $SCRATCH_MNT/data
>  
> -	if _xfs_has_feature "$SCRATCH_MNT" realtime; then
> -		mkdir -p $SCRATCH_MNT/rt
> -		_xfs_force_bdev realtime $SCRATCH_MNT/rt
> -		$FSSTRESS_PROG -n $((TIME_FACTOR * 10000)) -p $((LOAD_FACTOR * 4)) -d $SCRATCH_MNT/rt
> -	else
> -		echo "+++ xfs realtime not configured"
> +	if [ "$FSTYP" = "xfs" ]; then
> +		if _xfs_has_feature "$SCRATCH_MNT" realtime; then
> +			mkdir -p $SCRATCH_MNT/rt
> +			_xfs_force_bdev realtime $SCRATCH_MNT/rt
> +			$FSSTRESS_PROG -n $((TIME_FACTOR * 10000)) -p $((LOAD_FACTOR * 4)) -d $SCRATCH_MNT/rt
> +		else
> +			echo "+++ xfs realtime not configured"
> +		fi
>  	fi
>  }
>  
> 
