Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0E33EA
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867770; cv=none; b=rrNEm6a8ma2R30E5340ukgWkIYRz9u/OZKWMEVmUee49xmYlzFsSWYu1HGXfT722zCD1mh6adK1iXV5UtL57kXDez235/Mj0RLKiKlS4rE8tpN4nzXfcGNv0cdY+vq6abcwzsVV6IECHtgxMt2DRd/BIhKfgJE50EcvW8egASpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867770; c=relaxed/simple;
	bh=z/Ha3QTzkXWTQYlGceCYS2roBHx58M5dZcAShDw9J+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6abrhncOiXK78AUYlDcnebznNRPJq/RmsMo33ugf0Eq/kLZ+NNKBPdbrqR6GrmMaYuYOgaOSyR66/bPwbpFqLkGwk4huHsbwI+gWjUefAP8PSZ6uionJGJn0a9FTQrHf+hbWR+7o8bEY7sT+waraDE5XvoVblIU6fSufVD/9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6YqNUUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6YqNUUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A68C4CEE4;
	Wed, 21 May 2025 22:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867770;
	bh=z/Ha3QTzkXWTQYlGceCYS2roBHx58M5dZcAShDw9J+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6YqNUUce0h/czpm1d455BwVubR6qlHq3Fd/wrGzR5WVu9ddfnTAsZLhGYj3xsokF
	 T3zWkolpw4ebxoGxXQfBOzIVdD+ixsr1If1pBTRdzTtHvvaMCfCCIEWyMfnfl2o8Dh
	 coHbnEfClDxwCdng+l6RQoB7PXaKA0stdHWZbl5t1PXyTyAg12f6zGyeCsbsq2CclS
	 baBcVL+DT34xVKvhybtMAAwZOrPsbEqVydTd49EGT/AFmQhj1yniclkZrto1cOWPeK
	 S9y5We1dCuI/AUTWx1pAYztyjlO3X3Fwm9fCloPLqAgQYjvO2Hnpu7dlqUv+D2PFMS
	 0hhi5L+ACfXBQ==
Date: Wed, 21 May 2025 15:49:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: xfs/566 execution time
Message-ID: <20250521224929.GA3203850@frogsfrogsfrogs>
References: <aCyM-p06c99rJ04g@infradead.org>
 <20250521031940.GF9730@frogsfrogsfrogs>
 <b7vls4sjlx556wax6uagfkey6y5u2t652qu5ne2a6sxpofowdt@3annzxxqdmwq>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7vls4sjlx556wax6uagfkey6y5u2t652qu5ne2a6sxpofowdt@3annzxxqdmwq>

On Wed, May 21, 2025 at 09:37:53AM +0000, Shinichiro Kawasaki wrote:
> On May 20, 2025 / 20:19, Darrick J. Wong wrote:
> > On Tue, May 20, 2025 at 07:08:58AM -0700, Christoph Hellwig wrote:
> > > Hi Darrick,
> > > 
> > > we regularly see execution times of more than half a day for xfs/566
> > > on a 30ish TB SMR HDD.  Do you think there might be a useful way to
> > > scale down the load on rotational devices?
> > 
> > Hrmm.  Is that the only one that does that, or do the other scrub tests
> > take a while too?
> 
> As to the test with SMR HDDs, I observed very long test run on two test cases:
> xfs/566 and xfs/732.
> 
> > If it's just that one, and setting SOAK_DURATION=2m
> > results in the test cutting off after 2min, then I'll craft some sort of
> > fix to constrain the runtime.
> 
> I added,
> 
>  "export SOAK_DURATION=2m"
> 
> to local.config and ran xfs/566, but that setting does not look working.
> The test case rusn more than a half an hour...

Huh, that's /very/ strange.  In the absence of a SOAK_DURATION, the test
should only run itself for 30 seconds.  From common/fuzzy,
_scratch_xfs_stress_scrub does this to set the end-time:

	if [ -n "$SOAK_DURATION" ]; then
		end="$((start + SOAK_DURATION))"
	else
		end="$((start + (30 * TIME_FACTOR) ))"
	fi

and then __stress_scrub_fsx_loop does:

	while __stress_scrub_running "$end" "$runningfile"; do
		# Need to recheck running conditions if we cleared anything
		__stress_scrub_clean_scratch && continue
		duration=$(___stress_scrub_duration "$end" "$remount_period")
		___scrub_run_fsx $duration $d_args &

which should be sufficient to exit the fsx loop.  Then we go back to
_scratch_xfs_stress_scrub and:

	# Wait until the designated end time or fsstress dies, then kill all of
	# our background processes.
	while __stress_scrub_running "$end" "$runningfile"; do
		sleep 1
	done
	_scratch_xfs_stress_scrub_cleanup

which just waits for fsx and scrub to exit.  If you start this test and
wait about 45 seconds or so, can you send me the ps output so I can try
to figure out which component(s) aren't stopping in time?

--D
