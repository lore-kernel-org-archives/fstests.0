Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54528EA4;
	Fri, 21 Jun 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945544; cv=none; b=fvVcdnzOdyVpWkageM9UWDPFNCtoUer6SCm45hriTnRJ27iF8gMoobI90SllW8heTKuPiaTfxHhEBl1oLleW5/RIl+3lClN0YmMOIDtAFDKKvH+S7PrIVJTfgfk/Pnxt4tmIXZN4P0HxmqP1bj2z3v/3cFUv+u9J4aWuzOtRmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945544; c=relaxed/simple;
	bh=ajy+KLxY/ieI/yLzejIbvCWPXMBqncPl8RSV/M5PEm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0RQhdgKNGEwpcSniv19eyPuhnnaRek8yeykmq+jxkGWRCDEoUUISw9HLyPiZck0+6Nbkj6NIUAOMiKPuX5hWTihIgJM1Q6AZaujpeZBVfNKp//fDiDWEGUP7ABAZkUmqGUc7oZF/01lckqqBIHxiQjlxFt5iyPIW4T1q9sQspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1YHXbNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1YHXbNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D66C2BBFC;
	Fri, 21 Jun 2024 04:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718945543;
	bh=ajy+KLxY/ieI/yLzejIbvCWPXMBqncPl8RSV/M5PEm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1YHXbNLBEluxtOo7FqssS+id8P35oyQtU4uiVJg1FAJLnuETPowLfVlon93zt1RG
	 YONC7FKMeT8kMvv+VoSDqtRNklctn6cW05dICA7RMNXM1t53FGhsXp0lVevQ8mpT8W
	 aav2Ez3sAoDHi0ebXENyRHWYQywV0rDhFZirsbfmwkpDOkKdXKOGcvS6DHdwkYKtDX
	 FVYXtVBsNr238ZLkBDlWdh7j0rISnpwB4O4/ohh8Fz0q9T4OCPNs/VS1Z8muj7+W6O
	 LwAEBGU1TuDdrVEqsZjaPSPIsdRbhqDMfBWkcd53lsJuVrp2544Ig/bQ2K3FLOYiJ9
	 WWnLPc7tPK88w==
Date: Thu, 20 Jun 2024 21:52:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [xfstests PATCH] generic/574: test corruption at more offsets
Message-ID: <20240621045222.GD4362@sol.localdomain>
References: <20240612035334.134434-1-ebiggers@kernel.org>
 <rgy632iwsrbmwoiquqosutpj6wsfua3jzhcgb4eac4hz2zuqm5@f5qbqkh4qjae>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rgy632iwsrbmwoiquqosutpj6wsfua3jzhcgb4eac4hz2zuqm5@f5qbqkh4qjae>

On Wed, Jun 19, 2024 at 02:49:23PM +0200, Andrey Albershteyn wrote:
> On 2024-06-11 20:53:34, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Expand generic/574 to test for corruption in more different parts of the
> > file to try to exercise any hashing optimizations that might be used.
> > 
> > There is no existing bug that this finds.  This is just to prevent
> > future bugs, considering optimizations along the lines of
> > https://lore.kernel.org/fsverity/20240611034822.36603-7-ebiggers@kernel.org/
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  tests/generic/574 | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/tests/generic/574 b/tests/generic/574
> > index cb42baaa..72440d49 100755
> > --- a/tests/generic/574
> > +++ b/tests/generic/574
> > @@ -194,10 +194,25 @@ test_block_size()
> >  	corruption_test $block_size 131072 0 5
> >  	corruption_test $block_size 131072 4091 5
> >  	corruption_test $block_size 131072 65536 65536
> >  	corruption_test $block_size 131072 131067 5
> >  
> > +	# Test corrupting a block in files of length 1..4 blocks, and test
> > +	# corrupting each block of a 4-block file.  This ensures that all code
> > +	# paths that might exist due to multi-block hashing optimizations the
> > +	# fsverity implementation may use get covered, assuming no more than 4
> > +	# blocks are hashed at once.  E.g., consider an fsverity implementation
> > +	# that verifies sets of blocks but has a bug when given a single block,
> > +	# or that has a bug that makes it not verify all the blocks of each set.
> > +	local i
> > +	for i in $(seq 1 4); do
> > +		corruption_test $block_size $((i*block_size)) $((block_size/2)) 5
> > +	done
> > +	for i in $(seq 0 3); do
> > +		corruption_test $block_size $((4*block_size)) $((i*block_size)) 5
> > +	done
> > +
> >  	corrupt_eof_block_test $block_size 130999 72
> >  
> >  	# Merkle tree corruption.
> >  	corruption_test $block_size 200000 100 10 true
> >  
> > 
> > base-commit: e46fa3a7dae4a65fd80128bf381dba4fd5036ebb
> > -- 
> > 2.45.2
> > 
> > 
> 
> The addition looks fine to me, why is it 4 blocks though, isn't 2
> enough?
> 
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
> 

For the currently proposed fsverity patch, 2 is enough.  The same approach could
be extended to more blocks later, though.  So using something a bit higher in
the test from the beginning makes sense.

- Eric
