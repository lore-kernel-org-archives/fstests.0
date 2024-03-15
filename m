Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2512E47
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471099; cv=none; b=pmeP8RzsbZmylBejA7Y2DOvAWXTOozoxzrUw5sv+mNjxJXdAJN8gDmXanQOMp9y3dKSVVXH2ukIkj6Javrqt8vW2vI+//kQ4/V19VH1+WxWNj2GgSdhBd981MkeWjb3XeI3NeX0GdsrBGXnw80J3JJ5J3vqUXzSegNZ/MGiXOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471099; c=relaxed/simple;
	bh=WoFPsGsNiUGOEaSLZRnO4a0w0dtn7FylOlFKSCjc4Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7SF7pZdqpFNNcR4c7L5K0XSxI/P5O3rXFDKS2M3WYWFmIIiwdC1sF1OnSCbeTUnH+Y854x6YH+8nJ5hdaKa88TOcXZPFlxgKYEOCIxgSwhekxNQvJtoK5ht+eapn9SM9yLSeM8kketIZZM+Bx5JNjK0z/f6DGinZ//dsDkCQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn6jBqlp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn6jBqlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C828C433C7;
	Fri, 15 Mar 2024 02:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710471099;
	bh=WoFPsGsNiUGOEaSLZRnO4a0w0dtn7FylOlFKSCjc4Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gn6jBqlpR6zzIBw47Bu8JujBRlP23w7Lncy+vx9e9wO2zPBMpFez9PD8JUr5Ucp88
	 XY/nwJ83Cl4ediRkTT6eTVA0/mGO/gA0ghMMRauz827XUHJMSRUz5e1XY70XeJvpJ7
	 /8lG68bkpq0x8L5x0ummBpicCa6I2J+h/PU2nYA+6LpMnMDlIVpw4OJnLynG015AuS
	 ykTm5VN6Ni+ZOGexa7+vIRgjcfARxaLRSInu6zb/JjPFS+nDCBBHJcWh1BTcvi5yLQ
	 AR/NTejeGB1fUEZbkENBtDaBqbjFzs2LcSZndirRzY5MY+SA7Dsjt1wjfesBsUHjf3
	 QiC25gBSRkpfA==
Date: Thu, 14 Mar 2024 19:51:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4/006: take into account updates to
 _scratch_fuzz_modify()
Message-ID: <20240315025138.GG6188@frogsfrogsfrogs>
References: <20240314172512.28293-1-luis.henriques@linux.dev>
 <20240314172512.28293-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314172512.28293-3-luis.henriques@linux.dev>

On Thu, Mar 14, 2024 at 05:25:12PM +0000, Luis Henriques (SUSE) wrote:
> Since function _scratch_fuzz_modify() has been updated, its output has
> changed.  Modify test ext4/006 to take this change into account.

Now that you've blocked off the XFS stuff, what line changed?

--D

> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
>  tests/ext4/006 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 8792167bd9c2..b73692aa5b81 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -131,7 +131,7 @@ echo "++ check fs (2)" >> $seqres.full
>  _check_scratch_fs >> $seqres.full 2>&1
>  
>  grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2fsck failed" | tee -a $seqres.full
> -if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
> +if [ "$(wc -l < "$ROUND2_LOG")" -ne 7 ]; then
>  	echo "e2fsck did not fix everything" | tee -a $seqres.full
>  fi
>  echo "finished fuzzing" | tee -a "$seqres.full"
> 
