Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E96FC3
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897644; cv=none; b=LlxdU922EbYHiyroQbTY6uwwtUNd8KkOwGXiCRlQf5/W2HEYXgnNg84gBKzQWLPyBIEhXNQtTWj631r0dU8x9wi0cvjBtf8Wqh75iiepVaQNn0e/9WGiKez9HLASNaZK91BqVAongIqbJ5GkaiFWTBN+Sq+1bXatdQfW6Ev0xB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897644; c=relaxed/simple;
	bh=mRtEKanQvbBvRR8dPnS+hUrOpdupYCgp4TUP30XJdr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPvYgpNcmLiYbqCder8jvh73/Cbj+xwM7i6la6k0wFXWvZM/eeol6ELNdHbpp8zt6wMc/b7qANqWQ3zhnFzy7Y/2qPEGyV6DJ6rSLC/tq2gilXsbqsc7W/iu6Im62T70FPEu73n0ZbY4EpFD6dzkc4qgneRfGE2YxNb5aAm2SK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhbJptic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhbJptic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60455C433C7;
	Wed, 20 Mar 2024 01:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710897643;
	bh=mRtEKanQvbBvRR8dPnS+hUrOpdupYCgp4TUP30XJdr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhbJpticyAq8blOk4SVoolINKoU5ivnRiprjElkN27BCEwGHz164/T20YZT97Ntkg
	 BBZZYvBBMvcKLdBVaD0XGueNxLiBsEeg4ezMGbN/leQiOJT1W8q3qSN60O7ROu/+uv
	 Opnp6QGQP31jjttFFSAMp6g32RhvVzMPKoDWaTlKTh8HOx6124uWStcDOPJMvooiVz
	 JJSSokhNizFlKu/53/umB00dElJ0Er8TOJcv0/ZDxoh1YrYWOGWnoMEe12vPRFBf9P
	 S2ZZEPuS0HH1HqgplEuggu7cXYSfnbuWb62vrCnr3BAO6efK5Is9FGqoke6mcH3/U/
	 rWNmKdm22nu5w==
Date: Tue, 19 Mar 2024 18:20:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common/fuzzy: make _scratch_fuzz_modify work for
 non-xfs filesystems
Message-ID: <20240320012042.GM6188@frogsfrogsfrogs>
References: <20240315171325.2885-1-luis.henriques@linux.dev>
 <20240315171325.2885-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315171325.2885-2-luis.henriques@linux.dev>

On Fri, Mar 15, 2024 at 05:13:24PM +0000, Luis Henriques (SUSE) wrote:
> Since commit 9bab148bb3c7 ("common/fuzzy: exercise the filesystem a little
> harder after repairing") funtion _scratch_fuzz_modify() has become
> xfs-specific due to the use of some functions that assume this filesytem,
> namely _xfs_force_bdev() and _xfs_has_feature().
> 
> Ensure _scratch_fuzz_modify() works again with other filesystems by using
> these functions only when testing xfs.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Still looks ok,
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
