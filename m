Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271F23F376
	for <fstests@vger.kernel.org>; Sat,  1 Mar 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847822; cv=none; b=BzNDch14OpYC57UEhQSyYEU7P2c2KXQmEnbjAd+GlFBzwJspIvC6TdZLcob5rI6xRStR6RGJdxYfYUSZpeAx9ZxRzgtf/vju0U2i3lGApn8M7xju81jEQ79bRfzOufjHaacrhzw4RGfPb3GVf4Rvywn7DNuRMimMvvYiXY46oA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847822; c=relaxed/simple;
	bh=eqAM31hUd7kP5p/GykRREFR0eqgwVu06jZzLqtQuPzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXh3jrH2nESsBLeJxA0A+fPDVDW+AX6Rv+HAGx/FxLnZ/5GVZTeAhtUOQizyUcLKDL4tKpIW7g60NoiSy5ZfD2iwRZCMYrWEDpirtslIiXXleb3Eki3MXwApnE5HxxrsInIwYe3+If4r1hYWpRmD0gJZkSg6t3hCaKfhvhpcHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz9ZY0KY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz9ZY0KY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740847818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hekbUD0EzLdyTJeQvBIn5qxHTALoLpTLAPuRS3pWXJ0=;
	b=Fz9ZY0KY/1RbMg++/M1iqfkolWmXGJ77QmRqrd4XiFowJlIhq2+Jn1qxZst6anzNNYeP9p
	A30N5txod45lVOAHn9js4CvAq84q3fHUuitMKYtT6WxITYzp7cicSFD8DgDOJAu3iuS5zv
	evy68oxsnFM0z/64zSbpw7Bu8I2DFNk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-go_7TXfaOO2MZWeapfb18A-1; Sat, 01 Mar 2025 11:50:17 -0500
X-MC-Unique: go_7TXfaOO2MZWeapfb18A-1
X-Mimecast-MFC-AGG-ID: go_7TXfaOO2MZWeapfb18A_1740847816
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2233b764fc8so56411235ad.3
        for <fstests@vger.kernel.org>; Sat, 01 Mar 2025 08:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847816; x=1741452616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hekbUD0EzLdyTJeQvBIn5qxHTALoLpTLAPuRS3pWXJ0=;
        b=ekFCm5wt1wBKevGYvMU15UJGyoDVK3m8US21exYTEsoM1RQIvPJHPp7wOIX7RmHYAD
         xI62NEHXme0ZEe3ZFNnHwmfhrUI2BOCeqy76YOAWniZqbvAyUzhwdB+ctQ59koepPx8e
         inX0S0tSMb/pEJZnY/STqJxMR57wo/0OmPnNfUscXuUPn2kOH9KxaWxh8ybBdKaKwh3Q
         Zepgv2L6EVrEuzgtucNmvqtUydN49Is7NgKk+9RU6U8olOLWWFnWOWRJoQLtDeIkmk56
         sEMCrfWPEWG+hqQYXpVEyFg7mN6a/hy0joqqYgCqa/cpDmVTiewJ9ADrWJhKdEBrbOmT
         ZKNg==
X-Forwarded-Encrypted: i=1; AJvYcCXZi/p9LrVHCyBuwsHKjiI1bXP4zdX0lWPBnjpAJCsgL4myV88cJq8lwGGUJfzbKlCp1Mngn5cE@vger.kernel.org
X-Gm-Message-State: AOJu0YxDT5+5NyygQwPP1JbnLE0de6CLW8n3g/0oqBAxO5Y5bxyuqwrM
	YfOS+vsuM6nB1WnHjGjHeoTiRci1jk0NW3tg38VFLUeqLaatTMsHs/0uUT3aiU+75QSsTFLVBt2
	Nn7Cpp944ySS/WRZzZnXtxmBuAopj29wW9LNDyYiBg2IcMfd3MiFdo1k=
X-Gm-Gg: ASbGnctaA/jjkG2jeFoUahyg7ct6Ttu4wOqLpS1U9xFGKWpq45o4pJ6yLfvGO6pJLrm
	+quo4AHCuoeMEz2BQ74c5x3mGAG8pObAtgryUcl+sWMmpGW7FKWqtw3uwLce/eMkwfR7A7hrDfm
	6t0y05p8UnC819M0bgScFszvT+BViX0r9K+FrdZpjjUT4x7q19OI3+dfglwPQchqIDmtajhPyUi
	FAz0FS4P/qB3FSLkVwNuG/VDG7KYmlST6egb+SziKiApS3kq8hOOkVtu5v+yL/qlBGWyIXQ53Xf
	irJ83yDQYHweXn7kMdeLs/ccZ+gXb9+bdrq6WwprkWk+qrDnfejEaFaF
X-Received: by 2002:a05:6a20:7490:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-1f2f4cacc91mr14016845637.8.1740847816511;
        Sat, 01 Mar 2025 08:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7P/4jXS8iEzyU/8toRz65G0O6mK4fRGTboC8vzKg+IGbMxNC3b1P6OScTNH1D/RMx13xdqQ==
X-Received: by 2002:a05:6a20:7490:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-1f2f4cacc91mr14016827637.8.1740847816129;
        Sat, 01 Mar 2025 08:50:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73632e76e1dsm1779128b3a.89.2025.03.01.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 08:50:15 -0800 (PST)
Date: Sun, 2 Mar 2025 00:50:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250301165012.mm2yuyobrh2cogg5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228123354.GE5777@twin.jikos.cz>

On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > Hi all,
> > 
> > The for-next branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > has just been updated and tagged as v2025.02.23 release.
> > 
> > Release Notes:
> > 1) There's not new test cases in this release, this's a release for bug fixes
> >    particularly.
> > 2) Reiserfs part is removed from fstests.
> > 3) ltp/growfiles is removed too, I think no one needs it.
> > 
> > I can't list all updates at here, more details please refer to below.
> > Thanks for all these contributions!
> > 
> > Thanks,
> > Zorro
> > 
> > The new head of the for-next branch is commit:
> > 
> > 5b56a2d88819 fstests: remove reiserfs support
> > 
> > New commits:
> > 
> > Christoph Hellwig (1):
> >       [04d0cf3f8909] generic/370: don't exclude XFS
> > 
> > Darrick J. Wong (35):
> >       [cc379f50f3bd] generic/476: fix fsstress process management
> >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> >       [777732b27e62] common/dump: don't replace pids arbitrarily
> >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> >       [77548e6066fd] common/rc: create a wrapper for the su command
> >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> >       [c71349150d34] common/rc: hoist pkill to a helper function
> >       [91d2880aa029] tools: add a Makefile
> >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> >       [247ab01fa227] check: run tests in a private pid/mount namespace
> >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> 
> I'm using a setup with a minimal VM system without systemd and such and
> dedicate the whole machine to one instance. I'm not interested in the
> check-parallel updates and test case separation. All fine if it is
> supported and lets me continue using single instance.
> 
> But as I read it and the deprecation it's not going to be the supported
> use case. After last week update of fstests 100% of cases failed in the
> test setup (_seq_run). My workaround is to simply disable it by
> 
> check:
> HAVE_PRIVATENS=
> HAVE_SYSTEMD_SCOPES=

BTW, HAVE_SYSTEMD_SCOPES has been there several years, so if it works for
you before, it's not the problem of HAVE_SYSTEMD_SCOPES, even if your VM
doesn't have systemd.

So if it works for you by setting HAVE_PRIVATENS=(null), then the problem
maybe from the `./tools/run_privatens "./$seq"` part, and also means the
`./tools/run_setsid "./$seq"` part is good to you. Sorry I didn't hit
this failure even with btrfs, so if you can provide some details, we'll
look into it.

Thanks,
Zorro

> 
> so I don't have to debug changes to the detection of the scope and
> namespaces and after each for-next update. I understand that with a
> custom system setup I'm on my own but until recently things have been
> fine but now after each update either test cases fail or the whole test
> infrastructure does not work.
> 
> It's not just me who observes that. It seems that BTRFS is not tested
> before release as thoroughly as other filesystems (probably just XFS).
> 

