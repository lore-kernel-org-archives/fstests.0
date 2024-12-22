Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60EB17C68
	for <fstests@vger.kernel.org>; Sun, 22 Dec 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734870179; cv=none; b=NMIYbBTu25R5p6SUCeLvvdzK31X5ipbD+PiaRZwr7y7Q+eoZ6XgVbcPgqb7JoieOH1a15DEAqRBSDCtH//kb6oebZz8RrAuaZE3hBcAy+p04EqleTZBRPHi5dxgkPA/EZUkqNXDxk+YyMElD3K4hmzmW2juTxBvRVljLQgxm410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734870179; c=relaxed/simple;
	bh=bgS205GHYMGY/kHAuyHRy5O//7Kxfi9TEz+STRGfy30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEGDYWJiaADvUyoOZpNiwndTMBZ/Cgg+W+P+TkKnRJ0Wk0qPJwxuL3pndpJyD38t15szUf6WzL15mQ1aJC9fdBNl8Wjyn91GzB/zyrO5OA1ot0G4KbWwuPXJJpFRu2v2XTWPINlTs5rxG2VDEDg/8Gc8WGwsdyjr2XPrD5raDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwQWx+Iz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwQWx+Iz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734870175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0RHGaVKj9gYJsvMW07V++emouSd6CN2otZGKrle3FcQ=;
	b=AwQWx+Iz/IZ2vNRbMbXHCugDQVqQySFaUF/TaNng8owauuaUCj1fCy2dTRPGVDQAC7G1iU
	cSyFnLGn6ll97cvOBkTWVnWf9Pr/K1OfY0djwe4MiQ1FPCUTEkIJeF9adUle9cogstcuEs
	/EXMNVfRrf2lgQABHc8Bmwgb/A0H4Eg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-ju8x-ckjM5-MIw28Zuk9jw-1; Sun, 22 Dec 2024 07:22:53 -0500
X-MC-Unique: ju8x-ckjM5-MIw28Zuk9jw-1
X-Mimecast-MFC-AGG-ID: ju8x-ckjM5-MIw28Zuk9jw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so2988568a91.2
        for <fstests@vger.kernel.org>; Sun, 22 Dec 2024 04:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734870173; x=1735474973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RHGaVKj9gYJsvMW07V++emouSd6CN2otZGKrle3FcQ=;
        b=iGbcsNzVuH4zXaom9K89XGDhVa2bF0FYdpKTz8fDMyYILo2toRwPEorzNzXVbsO4Pf
         Zb2RNXDFJRBgXikhwYEdSub8QGd9VCOvooAwIaToZ/legtLffhX19FmcRlM9NWchgCKH
         YglGFB6mXb49ah6um4EfxG0Et5P2l+FOYjnYs5u9R9w0btC62jVAFwf9cBam2aVQAYkd
         R306qee4IeRsKLPx3jS8znFPk/vBB/9hcfOH4QKMnPaJDbE1dzFH8oHLia5+CMvdc2VJ
         DjkELlQt5fqXeaRwsRNd4EtyOtPnG2iub/efbb5w67TixZAWBi27/X9LUoPtsn7QdNhe
         PXpg==
X-Forwarded-Encrypted: i=1; AJvYcCVb1EF7IFqdDuYCXthlhrhZcM+dE6d2+d69OXR5oFthjCUosX3fDyoeDdghQPB/2PuHnhsZrwJ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkbRSJqWYCWtHLyGLH8s8Qb9C+u0W6BBtj8uscuZIXMzmQNxK
	XJmt2pNOdTXJ/HPoCuRwoyJxRx74GS5lVbnA4ZUCvLt2ay9YhtPpFicCn+Gu4JM37p4vv8kAFo4
	vbxP5jUT8RSv86E772SyX9yc8Tb0ncMmkrDFqToMGJqAh9LMbQT6qG0Q=
X-Gm-Gg: ASbGnctRcZO0rDc9D+20bbtkGms0oe8myxEzMOTLtYmImiYKN606iVwo1nXXl99lYnB
	sInp2AvOV0E3xEthP9gr4i5tfzaGwuPrGmBsIJRzJnxu6C91eSNM0eE+NqxTP+uFtM1ohPnVRHh
	AwxaGmBTgbe4/72w4uMioOKAVPgVkCAUypij2jpLgmeZFmiirQoYKDZLU7VABCxBvtGqrSitOIe
	wZiCF3AUgKMy0NARjHq0mPTqS7w+i4KyR3J+xhXmUH2t/ubing6K9ILzLgU/jkbNYs6Zji7I3Jp
	+8rrT8NQYPnUQ7TjrL5knA==
X-Received: by 2002:a17:90a:da8e:b0:2ee:f80c:688d with SMTP id 98e67ed59e1d1-2f452ec37a0mr12683788a91.25.1734870172568;
        Sun, 22 Dec 2024 04:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXA5xKGWfMpsd16kbf6D19kJN+Hhc5+ys5+dUYEd4/4jRrqQfdtc6HDuRu6RzfmPoz2suWrQ==
X-Received: by 2002:a17:90a:da8e:b0:2ee:f80c:688d with SMTP id 98e67ed59e1d1-2f452ec37a0mr12683765a91.25.1734870172195;
        Sun, 22 Dec 2024 04:22:52 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644846sm9235511a91.28.2024.12.22.04.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 04:22:51 -0800 (PST)
Date: Sun, 22 Dec 2024 20:22:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
	Shirley Ma <shirley.ma@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <20241222122246.3uvlvudchf2azmo3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
 <Z2OxMQACnMgmBR1a@infradead.org>
 <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241219163206.GD6160@frogsfrogsfrogs>
 <Z2SG2HsqgA46kuAz@dread.disaster.area>
 <20241219225331.GG6197@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219225331.GG6197@frogsfrogsfrogs>

On Thu, Dec 19, 2024 at 02:53:31PM -0800, Darrick J. Wong wrote:
> On Fri, Dec 20, 2024 at 07:49:28AM +1100, Dave Chinner wrote:
> > On Thu, Dec 19, 2024 at 08:32:06AM -0800, Darrick J. Wong wrote:
> > > On Thu, Dec 19, 2024 at 06:16:26PM +0800, Zorro Lang wrote:
> > > > On Wed, Dec 18, 2024 at 09:37:53PM -0800, Christoph Hellwig wrote:
> > > > > On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> > > > > > On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > > > > > > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > > > > > > +if [ $FSTYP = "xfs" ]; then
> > > > > > > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > > > > > > +else
> > > > > > > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > > > > > > +fi
> > > > > > > 
> > > > > > > We really need to document why generic tests have file system specific
> > > > > > > hacks.  And yes, that's a request for Dave who originally added it
> > > > > > > without any explanation and not Ted.
> > > > > > 
> > > > > > Creating and then unlinking 50000 files is journal space bound
> > > > > > when using default 64MB logs on small test filesystems. Increasing
> > > > > > the journal size to 256MB halved the runtime of this test.
> > > > > 
> > > > > Please explain this in thet test.  And you probably also want to
> > > > > ensure that you don't force the log smaller than 256 either, otherwise
> > > > > people in 10 or 20 years will wonder why this test forces logs to
> > > > > be so small.
> > > > 
> > > > I'll help to add this comment when I merge this patch, if Dave hope to
> > > > keep "-l size=256m" for xfs.
> > > 
> > > What happens if someone runs fstests with a 128M external log device?
> > 
> > It fails, then drops MKFS_OPTIONS.  The simple solution for this is
> > to simply to use a larger external log device....
> > 
> > > Is this one of those cases where _scratch_mkfs notices the mkfs failure
> > > and formats without MKFS_OPTIONS? 
> > 
> > More than likely.
> > 
> > > And if that's true, what about my
> > > test configs that set MKFS_OPTIONS to test new non-default features?
> > 
> > Changing existing infrastructure behaviour to better suit *your*
> > test environments is *your* responsibility to address, not mine.
> > I don't care if MKFS_OPTIONS get dropped in occasional tests, it's
> > more important to me that the tests run fast so I can iterate
> > my modify-build-test development cycle faster.
> 
> I don't agree that your personal development velocity is more important
> than silent loss of code coverage of everyone who happens to be testing
> external log devices.  That at least covers myself, our QA department,
> and everyone who uses the prepackaged configurations in kdevops and
> xfstests-bld.
> 
> > It should be trivial for you to address, though. Add a function
> > like:
> > 
> > _scratch_mkfs_try_option "-l size=256M" 
> 
> Or instead:
> 
> # Pushing 50000 unlinked inode inactivations through a small xfs log can
> # result in bottlenecks on the log grant heads, so try to make the log
> # larger to reduce runtime.
> if [ $FSTYP = xfs ] && [ -z "$SCRATCH_LOGDEV ]; then
> 	_scratch_mkfs -l size=256M

Maybe better to use "_has_logdev", due to there's "$USE_EXTERNAL".
I can change this patch as:

  # Pushing 50000 unlinked inode inactivations through a small xfs log can
  # result in bottlenecks on the log grant heads, so try to make the log
  # larger to reduce runtime.
  if [ "$FSTYP" = "xfs" ] && _has_logdev; then
  	_scratch_mkfs -l size=256M
  else
  	_scratch_mkfs
  fi

when I merge it, if you all agree :)

Thanks,
Zorro

> else
> 	_scratch_mkfs
> fi
> 
> > which has the opposite fallback behaviour of dropping the test
> > supplied option and using MKFS_OPTIONS instead, and I'll use it for
> > all these "test go faster" modifications that we badly need to
> > address...
> > 
> > FWIW, this would also get rid of the need for the FSTYP checks in
> > the test, too, because passing "-l size=256M" will fail on btrfs,
> > ext4, etc and then they fall back to the specific test config...
> 
> Huh?  And what happens when btrfs want their own try option?
> 
> > So, provide me with the infrastructure that makes stuff like this
> > work properly in *your test environment*, and I'll use it
> > appropriately.
> 
> Dave.
> 
> You're the one who made the changes to generic/53*.  It worked before.
> 
> Like any other code change, it's /your/ responsibility to try not to
> cause regressions for everyone else using the same code.  If other
> people have problems with a change, it's longstanding community
> expectation that the author should help resolve the problem.
> 
> It is /not/ standard practice to lecture the affected people about how
> they should embark on a treewide change to fix a problem that didn't
> exist previously.  The maintainer reverts the offending commit and the
> author redrafts the patch.  You're well aware of this, because you've
> said as much about other patches (e.g. iomap zeroing cleanups).
> 
> It is not everyone else's (Ted, Christoph, Zorro) role to clean up after
> you.
> 
> I do not appreciate the condescending behavior you have shown towards me
> this year and last.  Next year I will take more steps to insulate my
> team from you and other community members as needed because I don't want
> them to continue to deal with such conduct[1][2].
> 
> --D
> 
> [1] https://lore.kernel.org/fstests/Z0pBKWBlXLBxwK3D@dread.disaster.area/
> [2] https://lore.kernel.org/linux-xfs/Z1FQdYEXLR5BoOE-@redhat.com/
> 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> 

