Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950CF944E
	for <fstests@vger.kernel.org>; Sun, 22 Dec 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734877349; cv=none; b=EKbnJSUyRFpTTOFYekRbmR0KJsoc1zggt+Fd9g9UD8M4OmziU4H/KZGep/Pbbtf+E65hIOCoOvrb4RBaNaPqYYrtndDWn820io8YS5elb6vD8f7xOGaDk1RdpWIIeFHa3jYNsUWtfKnHZYg/ilrnP8ChXdeCGu4JpKzl5d7nOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734877349; c=relaxed/simple;
	bh=dter9x1G6WREFOotSTZjob8fHJllSCAUtwyTV2n7cYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ4+kgOFGE7vionlqYao1xzgUnz6o80JeI4m6ajFoRIwZmQvXaHojlCKtEt9QaPmc513tL8dGzqfCz4scBiIGnQJ4ANvHJrvuu5iTJZNfkXFIMfsJmQ0440uVWE1z3OGOEuD6GIi7B0fW4a+uYDrVvKv0hl+570s2aLBjgN1Lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDwoDY9h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDwoDY9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734877346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ePBqhXWic+/wZ8fLZkcQzaw7ikVKUTeX77F+x+kOPdI=;
	b=EDwoDY9h0n/h4O3Y9bazoMdcTLj+6At7007VdGfb/hX6tIDFmBwrw2s4MBzFZasyOb1Rd/
	h00Yf0Po+xK87NfFTkA95h2X4fN5+en9OtDN3PsmRL8QP9RdphcsXG9Rfd3qR4k+iigVwt
	HJTZQG1D73za0fGhqyFlIHrh56NNhNI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Yw7gC4G-NaK34Wlxep1P5A-1; Sun, 22 Dec 2024 09:22:25 -0500
X-MC-Unique: Yw7gC4G-NaK34Wlxep1P5A-1
X-Mimecast-MFC-AGG-ID: Yw7gC4G-NaK34Wlxep1P5A
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21661949f23so49107045ad.3
        for <fstests@vger.kernel.org>; Sun, 22 Dec 2024 06:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734877344; x=1735482144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePBqhXWic+/wZ8fLZkcQzaw7ikVKUTeX77F+x+kOPdI=;
        b=QIe2H2bpVLFHg5YqdZnxvmeQQsGdxvXBJQqiWSfFEd1JQdXEyFHr7EzcaAHk+nlVDZ
         Bu2pfXrmSpTsPkkGgjwXVyqEMdDBm2WAXAKf4HiTUU773zIVEIy57rAHfbyaSq6MctKl
         +FAhGfVIX5r1AK5kUGs9vBTZB+nv6grQx+HrE7xWfD+A1TSWAb2CoaXMgmcq49ar4UQ9
         fbdqSVnLeP+VfZ9PcGMeCr+BlbLuPpVkpaavTJuCrw6TtDRotGZDx7xnqGl2pGVwUh5l
         YxNIHvozD/B/Jr5xoGQ5an79H90mSIObXo7BzbbZEl5y7Ln0um4jYb25vKtgktXLRT1I
         53IA==
X-Forwarded-Encrypted: i=1; AJvYcCUWPeCdXlXapkb5WXZLZWt4aZuUCrF+lsljHKUewYcm2CO/NwnfRQLaU3fvz+YI/c3EV3OGarW/@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQpCLTYa4HFq9m00mUrP1jX/LT2OFIP5QFSQea0nEZjkB5IJJ
	O5ESnadwHlhzR5t/Qby5Gukg7SIIJHu40I1nJ/t0LM9pviPqYaoCjgcuTdMZg3+HgXKKYsOu/Lt
	lI09lXTN9dnleZmlVxYOPoEnF5t7zhY6Q24/GDVtYrVr39DEprSz5Uz4=
X-Gm-Gg: ASbGncvN/7HjB6dVYjLK7If0ACytdDoQTBk/u8HsqY6dblfEdBsmqY4rIaSwacioBoZ
	GG5EgwdQBFwdOViXNc9HyoTcusMkZyKZX+Xjn8mH1oBt8Xp9VzCUZzn9jpGAhEjX3VVkLjERhIo
	MmOQswkEvoRVVa78CpQ6z95+40BNC8ouq42Lx0xlub/bZJoDM1bz2ocKllZmVrwSpLL0nn8pujG
	AlRjwedndnrfky56ID9xWMtBEPLKhZ7zPXYXRRgtKKom+meqODWEtCfYSXqGGHI2wlDz+yrrVJI
	88OquIYux9tIj8GIzRDiQA==
X-Received: by 2002:a17:903:41c5:b0:216:6901:6847 with SMTP id d9443c01a7336-219e6f26053mr112742405ad.42.1734877344150;
        Sun, 22 Dec 2024 06:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZGeJh8kf79SZKkfWA3rVRO9ylZ5512AN1kVIhkfmohLp3CQ7QmIAL2YnjYVTeeKOnkRCE1g==
X-Received: by 2002:a17:903:41c5:b0:216:6901:6847 with SMTP id d9443c01a7336-219e6f26053mr112742215ad.42.1734877343776;
        Sun, 22 Dec 2024 06:22:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm57607625ad.58.2024.12.22.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 06:22:23 -0800 (PST)
Date: Sun, 22 Dec 2024 22:22:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
	Shirley Ma <shirley.ma@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <20241222142218.ok6mpap2bhr5r2sw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
 <Z2OxMQACnMgmBR1a@infradead.org>
 <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241219163206.GD6160@frogsfrogsfrogs>
 <Z2SG2HsqgA46kuAz@dread.disaster.area>
 <20241219225331.GG6197@frogsfrogsfrogs>
 <20241222122246.3uvlvudchf2azmo3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241222122246.3uvlvudchf2azmo3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Dec 22, 2024 at 08:22:46PM +0800, Zorro Lang wrote:
> On Thu, Dec 19, 2024 at 02:53:31PM -0800, Darrick J. Wong wrote:
> > On Fri, Dec 20, 2024 at 07:49:28AM +1100, Dave Chinner wrote:
> > > On Thu, Dec 19, 2024 at 08:32:06AM -0800, Darrick J. Wong wrote:
> > > > On Thu, Dec 19, 2024 at 06:16:26PM +0800, Zorro Lang wrote:
> > > > > On Wed, Dec 18, 2024 at 09:37:53PM -0800, Christoph Hellwig wrote:
> > > > > > On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> > > > > > > On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > > > > > > > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > > > > > > > +if [ $FSTYP = "xfs" ]; then
> > > > > > > > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > > > > > > > +else
> > > > > > > > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > > > > > > > +fi
> > > > > > > > 
> > > > > > > > We really need to document why generic tests have file system specific
> > > > > > > > hacks.  And yes, that's a request for Dave who originally added it
> > > > > > > > without any explanation and not Ted.
> > > > > > > 
> > > > > > > Creating and then unlinking 50000 files is journal space bound
> > > > > > > when using default 64MB logs on small test filesystems. Increasing
> > > > > > > the journal size to 256MB halved the runtime of this test.
> > > > > > 
> > > > > > Please explain this in thet test.  And you probably also want to
> > > > > > ensure that you don't force the log smaller than 256 either, otherwise
> > > > > > people in 10 or 20 years will wonder why this test forces logs to
> > > > > > be so small.
> > > > > 
> > > > > I'll help to add this comment when I merge this patch, if Dave hope to
> > > > > keep "-l size=256m" for xfs.
> > > > 
> > > > What happens if someone runs fstests with a 128M external log device?
> > > 
> > > It fails, then drops MKFS_OPTIONS.  The simple solution for this is
> > > to simply to use a larger external log device....
> > > 
> > > > Is this one of those cases where _scratch_mkfs notices the mkfs failure
> > > > and formats without MKFS_OPTIONS? 
> > > 
> > > More than likely.
> > > 
> > > > And if that's true, what about my
> > > > test configs that set MKFS_OPTIONS to test new non-default features?
> > > 
> > > Changing existing infrastructure behaviour to better suit *your*
> > > test environments is *your* responsibility to address, not mine.
> > > I don't care if MKFS_OPTIONS get dropped in occasional tests, it's
> > > more important to me that the tests run fast so I can iterate
> > > my modify-build-test development cycle faster.
> > 
> > I don't agree that your personal development velocity is more important
> > than silent loss of code coverage of everyone who happens to be testing
> > external log devices.  That at least covers myself, our QA department,
> > and everyone who uses the prepackaged configurations in kdevops and
> > xfstests-bld.
> > 
> > > It should be trivial for you to address, though. Add a function
> > > like:
> > > 
> > > _scratch_mkfs_try_option "-l size=256M" 
> > 
> > Or instead:
> > 
> > # Pushing 50000 unlinked inode inactivations through a small xfs log can
> > # result in bottlenecks on the log grant heads, so try to make the log
> > # larger to reduce runtime.
> > if [ $FSTYP = xfs ] && [ -z "$SCRATCH_LOGDEV ]; then
> > 	_scratch_mkfs -l size=256M
> 
> Maybe better to use "_has_logdev", due to there's "$USE_EXTERNAL".
> I can change this patch as:
> 
>   # Pushing 50000 unlinked inode inactivations through a small xfs log can
>   # result in bottlenecks on the log grant heads, so try to make the log
>   # larger to reduce runtime.
>   if [ "$FSTYP" = "xfs" ] && _has_logdev; then

Sorry, should be "! _has_logdev".

>   	_scratch_mkfs -l size=256M
>   else
>   	_scratch_mkfs
>   fi
> 
> when I merge it, if you all agree :)
> 
> Thanks,
> Zorro
> 
> > else
> > 	_scratch_mkfs
> > fi
> > 
> > > which has the opposite fallback behaviour of dropping the test
> > > supplied option and using MKFS_OPTIONS instead, and I'll use it for
> > > all these "test go faster" modifications that we badly need to
> > > address...
> > > 
> > > FWIW, this would also get rid of the need for the FSTYP checks in
> > > the test, too, because passing "-l size=256M" will fail on btrfs,
> > > ext4, etc and then they fall back to the specific test config...
> > 
> > Huh?  And what happens when btrfs want their own try option?
> > 
> > > So, provide me with the infrastructure that makes stuff like this
> > > work properly in *your test environment*, and I'll use it
> > > appropriately.
> > 
> > Dave.
> > 
> > You're the one who made the changes to generic/53*.  It worked before.
> > 
> > Like any other code change, it's /your/ responsibility to try not to
> > cause regressions for everyone else using the same code.  If other
> > people have problems with a change, it's longstanding community
> > expectation that the author should help resolve the problem.
> > 
> > It is /not/ standard practice to lecture the affected people about how
> > they should embark on a treewide change to fix a problem that didn't
> > exist previously.  The maintainer reverts the offending commit and the
> > author redrafts the patch.  You're well aware of this, because you've
> > said as much about other patches (e.g. iomap zeroing cleanups).
> > 
> > It is not everyone else's (Ted, Christoph, Zorro) role to clean up after
> > you.
> > 
> > I do not appreciate the condescending behavior you have shown towards me
> > this year and last.  Next year I will take more steps to insulate my
> > team from you and other community members as needed because I don't want
> > them to continue to deal with such conduct[1][2].
> > 
> > --D
> > 
> > [1] https://lore.kernel.org/fstests/Z0pBKWBlXLBxwK3D@dread.disaster.area/
> > [2] https://lore.kernel.org/linux-xfs/Z1FQdYEXLR5BoOE-@redhat.com/
> > 
> > > -Dave.
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
> > 

