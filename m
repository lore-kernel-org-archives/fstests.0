Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90B43F8CB
	for <fstests@vger.kernel.org>; Thu, 30 Jul 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425578; cv=none; b=qFIA+sldwe+X5dbkgbBM4griMY4iF4PCxut3GE0FgW1tPo0gMKALsW5hQvDRvRUSp94LDsz2Aq+BHusZalxR5j8M1ct1/JTKyk3U697ewpBtfZjSQzjqbvfhgb4ZXS+fFjJxyxqqL/A7i3ubnnm2p12COoyQVTYMeWG5E4gn4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425578; c=relaxed/simple;
	bh=6cbOXHxCKMl73fQ5yZ+PcB/SbS2RUmJJN8vTzHWkvc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiWdkiajHxmmGGUlb/rFLTp2PFXmMRb7fzElzJQk4vyh199uCowcDNAaI18Beo37Bs8focIb4ssnJj67JMZoqYP8hQxI8KS7CB9xAMFWcMN2rfKlv3VpGMXev8lUVfovGOOc+vjFhaUz91E3TpgX55o8fr0y9b0S2cZaAtRU7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kews2Ert; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kews2Ert"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 58B351F00A3A;
	Thu, 30 Jul 2026 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785425577;
	bh=p1DPIF/Ps6IuvIPFGGVMbS/DW69QIQ47urdUCgZZ9PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kews2Ert5Er2EZ6+AC3A3FCnhrLSwvPT9/chwc+4zU3wbIGOX9/d4lVCiOGJpgtzq
	 wo8/fZP9Oy6u1fpiwCdyRklv9buVXdVj+0aRPSmp9iZVB7utmm6uA9QTEQeeN9Zx/W
	 vIU3KcPdXk6CGSeevhiBwWyZM2tWP1Gk5f1cTW/4EeEqfLL9lGgA7XPMgp9IRkKYk3
	 uMWTD53xT4JRcU/A/3Hr3Ai4Zh4dGX3Kn2i0nL6F/JpEtzSsKbVnRMQGCCvTKXUknW
	 nJpmoFuamDYub6kOtOYjuh1w0Ospz+7mJO7eJ/yw5f7It0xKVr032pxRJ3e387RpP8
	 4TR+AdWcNy+Hw==
Date: Thu, 30 Jul 2026 08:32:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/645: Confirm availability of free inodes
Message-ID: <20260730153256.GJ7398@frogsfrogsfrogs>
References: <20260617054216.3186441-1-ojaswin@linux.ibm.com>
 <20260625184259.GP6070@frogsfrogsfrogs>
 <ammQvzfsFTx9EEmm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20260729154451.GB7371@frogsfrogsfrogs>
 <amsviaOypNwLCtnM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amsviaOypNwLCtnM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Jul 30, 2026 at 04:33:37PM +0530, Ojaswin Mujoo wrote:
> On Wed, Jul 29, 2026 at 08:44:51AM -0700, Darrick J. Wong wrote:
> > On Wed, Jul 29, 2026 at 11:06:57AM +0530, Ojaswin Mujoo wrote:
> > > On Thu, Jun 25, 2026 at 11:42:59AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Jun 17, 2026 at 11:12:16AM +0530, Ojaswin Mujoo wrote:
> > > > > When running generic/645 with ext4 using 64k block size + bigalloc, the
> > > > > test fails with ENOSPC because the filesystem runs out of inodes before
> > > > > the test completes.
> > > > > 
> > > > > The test creates approximately 10,001 files, however, in this particular
> > > > > configuration a standard 5G FS only has around ~5100 inodes resulting in
> > > > > the ENOSPC failure.
> > > > > 
> > > > > Add a check using _get_free_inode() to verify sufficient inodes are
> > > > > available before running the test, else skip it.
> > > > > 
> > > > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > ---
> > > > >  tests/generic/645 | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/tests/generic/645 b/tests/generic/645
> > > > > index d6eb75e6..944b33db 100755
> > > > > --- a/tests/generic/645
> > > > > +++ b/tests/generic/645
> > > > > @@ -19,6 +19,12 @@ _require_chown
> > > > >  _wants_kernel_commit dacfd001eaf2 \
> > > > >  	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
> > > > >  
> > > > > +_free_inodes=$(_get_free_inode $TEST_DIR)
> > > > > +if [ $_free_inodes -ne 0 ] && [ $_free_inodes -lt 10001 ]; then
> > > > 
> > > > I'm assuming the > 0 check here is to cover weird filesystems like fat
> > > > that don't advertise any inodes?  /me wonders if that ought to be a
> > > 
> > > Hey Darrick, sorry I missed this email earlier. Yes that's the idea. I
> > > see there is a helper already
> > > 
> > > _require_inode_limits()
> > > {
> > > 	if [ $(_get_free_inode $TEST_DIR) -eq 0 ]; then
> > > 		_notrun "$FSTYP does not have a fixed number of inodes available"
> > > 	fi
> > > }
> > > 
> > > But this will end up skipping the FSes that don't have a concept of
> > > free inodes.
> > > 
> > > > common helper where we can record that justification:
> > > > 
> > > > _require_free_inodes() {
> > > > 	local path="$1"
> > > > 	local nr="$2"
> > > > 
> > > > 	local _free_inodes=$(_get_free_inode "$path")
> > > > 
> > > > 	# Weird filesystems like vfat don't report any inodes, so we
> > > > 	# can't check for sufficient free inodes; IOWs, FAFO.
> > > > 	test "$_free_inodes" -eq 0 && return
> > > 
> > > If we do this, won't we pass the check for the case where say xfs has 0
> > > free inodes. It's a rare chance IMObut still wondering if we want to
> > > keep that edge case open.
> > > 
> > > What do you think in these options:
> > > - use the above check
> > > - use _require_free_inodes which will cause notruns on some FSes
> > > - Maybe have a new helper to check if FS advertises free inodes and then
> > >   use somthing like
> > > 
> > >   if ! __fs_advertises_free_inodes
> > >     return
> > >   else
> > >     test "$_free_inodes" -lt "$nr" && \
> > >     _notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> > > 
> > 
> > Hmmm.  This is getting complicated, because generic tests can run on any
> > filesystem and we have no idea how much space an inode actually
> > consumes, or if the filesystem even has any real concept of inodes.
> > 
> > Can we instead check the vfstest output for the ENOSPC error message and
> > _notrun it if that is found?
> 
> Yes this sounds simple enough. The below diff works for me:
> 
>   diff --git a/tests/generic/645 b/tests/generic/645
>   index d6eb75e6..3d8ca905 100755
>   --- a/tests/generic/645
>   +++ b/tests/generic/645
>   @@ -22,7 +22,14 @@ _wants_kernel_commit dacfd001eaf2 \
>    echo "Silence is golden"
>   
>    $here/src/vfs/vfstest --test-nested-userns \
>   -       --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
>   +       --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP" \
>   +       > $tmp.vfstest 2>&1
>   
>   +if grep -q "No space left on device" $tmp.vfstest; then
>   +       _notrun "No space left on device"
>   +fi
>   +
>   +cat $tmp.vfstest
>    status=$?
> 
> If this looks good I cans send a formal patch.

Yes! :)

--D

> 
> Regards,
> ojaswin 
> 
> > 
> > --D
> > 
> > > Regards,
> > > ojaswin
> > > 
> > > > 
> > > > 	test "$_free_inodes" -lt "$nr" && \
> > > > 		_notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> > > > }
> > > > 
> > > > 
> > > > _require_free_inodes $TEST_DIR 10001
> > > > 
> > > > (maybe clean up the comment a bit)
> > > 
> > > > 
> > > > --D
> > > > 
> > > > > +	_notrun "Insufficient free inodes ($_free_inodes), need at least 10001"
> > > > > +fi
> > > > > +
> > > > >  echo "Silence is golden"
> > > > >  
> > > > >  $here/src/vfs/vfstest --test-nested-userns \
> > > > > -- 
> > > > > 2.53.0
> > > > > 
> > > > > 
> > > 
