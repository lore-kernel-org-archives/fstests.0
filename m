Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17658369208
	for <fstests@vger.kernel.org>; Wed, 29 Jul 2026 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339893; cv=none; b=YcAi6L6Dta/lu166JN4ncPFQywIKkdRewB/myYsPTy4tiN2OjHKZsHr0aVAMlUfB39VHACxHbOZjrwb3GRYVD0R0h1K6wbgn8yefwn7D4gGIBH7RmPla/Z0frVfZhhy56bLGrLBezoAzwhv969No12meHKIBodpB/Bpuv27/pHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339893; c=relaxed/simple;
	bh=Gv85ANulPhVxpTTPz2oD4TXHfv3jW8DkflKmWBqObZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuqN9r5bdqNF6kQ3ji+FEAOijcg7pIlplAoYgaQ/seGw0OmboJuDhwGjDX9YJIl+7M3V/ZRe6giws2DmKsf7skOzhVFxWMyyN8cTBc1AgIH368nI5JVSjhgONGtl1rGPg766wyEdaWYoCHFsK4ZTjh0wYYDB1ul0V4EOnD5QuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvqhG5eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvqhG5eu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 85C1D1F000E9;
	Wed, 29 Jul 2026 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785339891;
	bh=cVxV8Yggxnf6+wlDlgAMbKatlm5KRx7k4PtgnCzItu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jvqhG5euHVBqtfT+HLi/hLdJEQwTSYIuw4THXXksSm37YEaQIP+yqoB+YHRqhfsPz
	 XwcRZA0KUE6oIQlGpPdzZc1qrRxh3bANyQj1UDA/WFutulat6x42poasctFsH6ioMT
	 Y/9CcALwlHmfsB98Rl7VMpRVYSQEmSbtH/8OYkvTzMA68EdGaz+DO2avky+mp5606X
	 foBwiHVG8VEGbqlk7nl3Hty9zphjUUJT4Th5dS5l4mffPCigS/ntmi4F3cJiF4INMQ
	 mF3VzMuQtFFiuBHm0Ukz31zu1bxw4sjETPt15oVbcC5h821m74CGDM3t6de1W36gro
	 5jufC7m6AwyoQ==
Date: Wed, 29 Jul 2026 08:44:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/645: Confirm availability of free inodes
Message-ID: <20260729154451.GB7371@frogsfrogsfrogs>
References: <20260617054216.3186441-1-ojaswin@linux.ibm.com>
 <20260625184259.GP6070@frogsfrogsfrogs>
 <ammQvzfsFTx9EEmm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ammQvzfsFTx9EEmm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Wed, Jul 29, 2026 at 11:06:57AM +0530, Ojaswin Mujoo wrote:
> On Thu, Jun 25, 2026 at 11:42:59AM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 17, 2026 at 11:12:16AM +0530, Ojaswin Mujoo wrote:
> > > When running generic/645 with ext4 using 64k block size + bigalloc, the
> > > test fails with ENOSPC because the filesystem runs out of inodes before
> > > the test completes.
> > > 
> > > The test creates approximately 10,001 files, however, in this particular
> > > configuration a standard 5G FS only has around ~5100 inodes resulting in
> > > the ENOSPC failure.
> > > 
> > > Add a check using _get_free_inode() to verify sufficient inodes are
> > > available before running the test, else skip it.
> > > 
> > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/645 | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/tests/generic/645 b/tests/generic/645
> > > index d6eb75e6..944b33db 100755
> > > --- a/tests/generic/645
> > > +++ b/tests/generic/645
> > > @@ -19,6 +19,12 @@ _require_chown
> > >  _wants_kernel_commit dacfd001eaf2 \
> > >  	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
> > >  
> > > +_free_inodes=$(_get_free_inode $TEST_DIR)
> > > +if [ $_free_inodes -ne 0 ] && [ $_free_inodes -lt 10001 ]; then
> > 
> > I'm assuming the > 0 check here is to cover weird filesystems like fat
> > that don't advertise any inodes?  /me wonders if that ought to be a
> 
> Hey Darrick, sorry I missed this email earlier. Yes that's the idea. I
> see there is a helper already
> 
> _require_inode_limits()
> {
> 	if [ $(_get_free_inode $TEST_DIR) -eq 0 ]; then
> 		_notrun "$FSTYP does not have a fixed number of inodes available"
> 	fi
> }
> 
> But this will end up skipping the FSes that don't have a concept of
> free inodes.
> 
> > common helper where we can record that justification:
> > 
> > _require_free_inodes() {
> > 	local path="$1"
> > 	local nr="$2"
> > 
> > 	local _free_inodes=$(_get_free_inode "$path")
> > 
> > 	# Weird filesystems like vfat don't report any inodes, so we
> > 	# can't check for sufficient free inodes; IOWs, FAFO.
> > 	test "$_free_inodes" -eq 0 && return
> 
> If we do this, won't we pass the check for the case where say xfs has 0
> free inodes. It's a rare chance IMObut still wondering if we want to
> keep that edge case open.
> 
> What do you think in these options:
> - use the above check
> - use _require_free_inodes which will cause notruns on some FSes
> - Maybe have a new helper to check if FS advertises free inodes and then
>   use somthing like
> 
>   if ! __fs_advertises_free_inodes
>     return
>   else
>     test "$_free_inodes" -lt "$nr" && \
>     _notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> 

Hmmm.  This is getting complicated, because generic tests can run on any
filesystem and we have no idea how much space an inode actually
consumes, or if the filesystem even has any real concept of inodes.

Can we instead check the vfstest output for the ENOSPC error message and
_notrun it if that is found?

--D

> Regards,
> ojaswin
> 
> > 
> > 	test "$_free_inodes" -lt "$nr" && \
> > 		_notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> > }
> > 
> > 
> > _require_free_inodes $TEST_DIR 10001
> > 
> > (maybe clean up the comment a bit)
> 
> > 
> > --D
> > 
> > > +	_notrun "Insufficient free inodes ($_free_inodes), need at least 10001"
> > > +fi
> > > +
> > >  echo "Silence is golden"
> > >  
> > >  $here/src/vfs/vfstest --test-nested-userns \
> > > -- 
> > > 2.53.0
> > > 
> > > 
> 
