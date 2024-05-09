Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68656147C83
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259726; cv=none; b=aFi39zVOtw716KLqWVK8AdHzZd1siWzZoLhRA5W5XaHdE9Mi1iXPgU8T6KnkPYskF6JVBQLanDFHjDHBovjf5mXUFeqkewalDfnSQfvqyBWwACVmx53rOJRe/RAKiKVoPByKKzJoOWfAegGu03QTKQwhM1yQhK+nzB5mBWfHDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259726; c=relaxed/simple;
	bh=/R57Hajqs9XsLyz7ym3lpiwgwNYyfoojtjtAcnhjhX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k81+XQhsrfRaWb9Yp/7ZH0tTOanrhCN4eqM7tghEhd+XZaeRKTRmq5xZ1Uf0/xbhvGFwVvDzN/2u6lnASEdvu86I16szG5LN+Q+bHznhyNnS41nIB7snvk/6nNjsHn6VhEt4eXlioWjKuFE7RNVyrEPi/suAzhUCHgUH6IzUYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Udb+nB2+; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Udb+nB2+"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VZsbr47y9z9sjZ;
	Thu,  9 May 2024 15:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715259720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWCsqot6JgO4J0wuikn2BX5l7pHlt4TjhOXbh4AwMNU=;
	b=Udb+nB2+tTIMO3uxEKor4cjqE7AtZ7dLEgdaE1LaWpkCwtsmyH3CgHTyzlunBfJviqPyy2
	hXJPf/F7sDHx3vP2NyTKPxfR/7ymZVdoRmLF6hhhF654dsAgyo4NsoU2XMCXRq7C+Is2sL
	3hdYit4ElnehXuXtrx17JjEmn5w1KzK5cpXTOjaB0gKAZIJkxH1utPUjQPKduTgcXz+6pd
	q6lCZsOLS/eSh+fz7slxtiI02vhUx07wzpgGYj90FoMFSc/tqA2c7wkP/M+4YDupQWRjWQ
	cvd92hul9A+0Sqot8kHIgCuKtX6rYzNrYJCENZyI3u3LrLRefK8K06WhEJ7SfA==
Date: Thu, 9 May 2024 13:01:58 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, fstests@vger.kernel.org,
	gost.dev@samsung.com, mcgrof@kernel.org, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Message-ID: <20240509130158.hfspakvd32i2rp5j@quentin>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-2-kernel@pankajraghav.com>
 <20240507222323.GC2049409@frogsfrogsfrogs>
 <CALk7dXqCD2MDPavit0mkD061bEHTswFxuwbfPZuAuCtNcFAPFA@mail.gmail.com>
 <20240508160627.GG360908@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508160627.GG360908@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4VZsbr47y9z9sjZ

On Wed, May 08, 2024 at 09:06:27AM -0700, Darrick J. Wong wrote:
> On Wed, May 08, 2024 at 08:20:01AM +0530, Ritesh Harjani wrote:
> > On Wed, May 8, 2024 at 3:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Mon, May 06, 2024 at 05:01:17PM +0200, Pankaj Raghav (Samsung) wrote:
> > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > >
> > > > This test fails when xfs is formatted with 64k filesystem block size*.
> > > > It fails because the soft quota is not exceeded with the hardcoded 64k
> > > > pwrite, thereby, the grace time is not set. Even though soft quota is
> > > > set to 12k for uid1, it is rounded up to the nearest blocksize.
> > > >
> > > > *** Report for user quotas on device /dev/sdb3
> > > > Block grace time: 7days; Inode grace time: 7days
> > > >                         Block limits                File limits
> > > > User            used    soft    hard  grace    used  soft  hard  grace
> > > > ----------------------------------------------------------------------
> > > > 0        --       0       0       0      0       3     0     0      0
> > > > 1        --      64      64    1024      0       1     0     0      0
> > > > 2        --      64       0       0      0       1     0     0      0
> > > >
> > > > Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.
> > > >
> > > > Cap the blksz to be at least 64k to retain the same behaviour as before
> > > > for smaller filesystem blocksizes.
> > > >
> > > > * This happens even on a 64k pagesize system and it is not related to
> > > >   LBS effort.
> > > >
> > > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > > ---
> > > >  tests/xfs/161 | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tests/xfs/161 b/tests/xfs/161
> > > > index 486fa6ca..94290f18 100755
> > > > --- a/tests/xfs/161
> > > > +++ b/tests/xfs/161
> > > > @@ -38,9 +38,15 @@ _qmount_option "usrquota"
> > > >  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
> > > >  _scratch_mount >> $seqres.full
> > > >
> > > > +min_blksz=65536
> > > > +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> > > > +# Write more than one block to exceed the soft block quota limit.
> > 
> > Maybe we should improve this comment to -
> > 
> > # Write more than the soft block quota limit of 12k which is set later
> > via xfs_quota
> > # On 64k bs this will get rounded to the nearest blocksize which is 64k
> > 
> > > > +blksz=$(( 2 * $file_blksz))
> > > > +
> > > > +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
> > >
> > > If we don't set $min_blksize and always write (2 * $file_blksz) does the
> > > test still work?
> > 
> > I guess it won't (even for bs=4k), because we set the bsoft=12k via xfs_quota.
> > So we have to write more than 12k to trigger the grace timer.
> 
> Ah, ok.  Yes, that makes sense with the improved comment. :)

@ritesh and @darrick: I think we can also change the bsoft right? In
the follow up email [1], I made pwrite to 2 fs block and bsoft to be 1
fsblock.


That looks like a cleaner solution than having hardcoded values. Let me
know what you all think.


[1] https://lore.kernel.org/fstests/20240508105852.nfjtlp53v24xb3tw@quentin/
> 
> --D
> 
> > -ritesh
> > 

-- 
Pankaj Raghav
