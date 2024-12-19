Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0978F4A
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648812; cv=none; b=I3I/1/wN596I/MUryECdkJ+l2dXNJmZ4Yc7OE2lWiswegYUHxUJl6ro4Mm3PNPgIMvNZQe/X3NQ4QFPYkAF6VsRL4+0HeztDTzqooCkqAGM0p/9WXLzCPDLQxa9zvXah49AZsKjjICVwh/HzXw/Xk+y3dREPKyQEIOhpkQ4TOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648812; c=relaxed/simple;
	bh=HP96GFEoxuPEj59zXlJavvPBj7t9OCTm+G+z6j8JcDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCRL3/6QTAqIPFjGp0TZKi1ejRYGBs0Vj2D5kL/fzEyXLRP1WZGNhuWdYeQBx09P8+OzWf1D2B85nnwIpepX2++EyqWrbX2fDqI6fSxVDwco/DQGhisALwjlxLRm2iJ0b78A5SxGClqSmwfLsC2/0GLs3BgCm6WsMuTl0eyBcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwBRvS9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwBRvS9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFC0C4CECE;
	Thu, 19 Dec 2024 22:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734648811;
	bh=HP96GFEoxuPEj59zXlJavvPBj7t9OCTm+G+z6j8JcDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwBRvS9buXXt5TE56W6CISL1AzJ+sirKCdsu0mB8dEegpMtfRhqbQsVZTsi6rvMhG
	 PznK6h/qYGhv7mD4frGfyzdgcBftMyUhZ/IgX/0NgJ3SpSq498RlV2naAtyvH0GzkY
	 q4+t8YZ72SdqX6O79bsV/Ya07/cyW8fdMYcp/KAQ8zS1D1d3qH/0uPW8da8TxGP3PT
	 Imyhy38Z/PNHcw1uCgM5KxuLM9+SkwH1397BsPsZPGV09kBIOA7xeyO3d4NTe7yvQ9
	 G+ZxTnNqVZ258ZktFQrwCb1T3K53mrheV3m8M9QgX+9zVLVKI+EH2h07AVsooKjfcM
	 QQXXSbKHs0GTA==
Date: Thu, 19 Dec 2024 14:53:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
	Shirley Ma <shirley.ma@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <20241219225331.GG6197@frogsfrogsfrogs>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
 <Z2OxMQACnMgmBR1a@infradead.org>
 <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241219163206.GD6160@frogsfrogsfrogs>
 <Z2SG2HsqgA46kuAz@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2SG2HsqgA46kuAz@dread.disaster.area>

On Fri, Dec 20, 2024 at 07:49:28AM +1100, Dave Chinner wrote:
> On Thu, Dec 19, 2024 at 08:32:06AM -0800, Darrick J. Wong wrote:
> > On Thu, Dec 19, 2024 at 06:16:26PM +0800, Zorro Lang wrote:
> > > On Wed, Dec 18, 2024 at 09:37:53PM -0800, Christoph Hellwig wrote:
> > > > On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> > > > > On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > > > > > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > > > > > +if [ $FSTYP = "xfs" ]; then
> > > > > > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > > > > > +else
> > > > > > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > > > > > +fi
> > > > > > 
> > > > > > We really need to document why generic tests have file system specific
> > > > > > hacks.  And yes, that's a request for Dave who originally added it
> > > > > > without any explanation and not Ted.
> > > > > 
> > > > > Creating and then unlinking 50000 files is journal space bound
> > > > > when using default 64MB logs on small test filesystems. Increasing
> > > > > the journal size to 256MB halved the runtime of this test.
> > > > 
> > > > Please explain this in thet test.  And you probably also want to
> > > > ensure that you don't force the log smaller than 256 either, otherwise
> > > > people in 10 or 20 years will wonder why this test forces logs to
> > > > be so small.
> > > 
> > > I'll help to add this comment when I merge this patch, if Dave hope to
> > > keep "-l size=256m" for xfs.
> > 
> > What happens if someone runs fstests with a 128M external log device?
> 
> It fails, then drops MKFS_OPTIONS.  The simple solution for this is
> to simply to use a larger external log device....
> 
> > Is this one of those cases where _scratch_mkfs notices the mkfs failure
> > and formats without MKFS_OPTIONS? 
> 
> More than likely.
> 
> > And if that's true, what about my
> > test configs that set MKFS_OPTIONS to test new non-default features?
> 
> Changing existing infrastructure behaviour to better suit *your*
> test environments is *your* responsibility to address, not mine.
> I don't care if MKFS_OPTIONS get dropped in occasional tests, it's
> more important to me that the tests run fast so I can iterate
> my modify-build-test development cycle faster.

I don't agree that your personal development velocity is more important
than silent loss of code coverage of everyone who happens to be testing
external log devices.  That at least covers myself, our QA department,
and everyone who uses the prepackaged configurations in kdevops and
xfstests-bld.

> It should be trivial for you to address, though. Add a function
> like:
> 
> _scratch_mkfs_try_option "-l size=256M" 

Or instead:

# Pushing 50000 unlinked inode inactivations through a small xfs log can
# result in bottlenecks on the log grant heads, so try to make the log
# larger to reduce runtime.
if [ $FSTYP = xfs ] && [ -z "$SCRATCH_LOGDEV ]; then
	_scratch_mkfs -l size=256M
else
	_scratch_mkfs
fi

> which has the opposite fallback behaviour of dropping the test
> supplied option and using MKFS_OPTIONS instead, and I'll use it for
> all these "test go faster" modifications that we badly need to
> address...
> 
> FWIW, this would also get rid of the need for the FSTYP checks in
> the test, too, because passing "-l size=256M" will fail on btrfs,
> ext4, etc and then they fall back to the specific test config...

Huh?  And what happens when btrfs want their own try option?

> So, provide me with the infrastructure that makes stuff like this
> work properly in *your test environment*, and I'll use it
> appropriately.

Dave.

You're the one who made the changes to generic/53*.  It worked before.

Like any other code change, it's /your/ responsibility to try not to
cause regressions for everyone else using the same code.  If other
people have problems with a change, it's longstanding community
expectation that the author should help resolve the problem.

It is /not/ standard practice to lecture the affected people about how
they should embark on a treewide change to fix a problem that didn't
exist previously.  The maintainer reverts the offending commit and the
author redrafts the patch.  You're well aware of this, because you've
said as much about other patches (e.g. iomap zeroing cleanups).

It is not everyone else's (Ted, Christoph, Zorro) role to clean up after
you.

I do not appreciate the condescending behavior you have shown towards me
this year and last.  Next year I will take more steps to insulate my
team from you and other community members as needed because I don't want
them to continue to deal with such conduct[1][2].

--D

[1] https://lore.kernel.org/fstests/Z0pBKWBlXLBxwK3D@dread.disaster.area/
[2] https://lore.kernel.org/linux-xfs/Z1FQdYEXLR5BoOE-@redhat.com/

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
