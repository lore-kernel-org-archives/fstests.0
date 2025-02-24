Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126751448E3
	for <fstests@vger.kernel.org>; Mon, 24 Feb 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740376130; cv=none; b=CZ7ODYWGkY/IfRoPgUYgOXk2V4TPuPAkL/oPnLMg1+iAPCEwnMcdpPDVKmNGmoijS0pMCXm+4BYZqlavwJOPW2cpxbGxK/yrmZiua5swqCei1v3Qdj+S1QgHbd4VjkkWndJePsIBmlsq5kTBD5F3dWCLvymf6Zzvq0MnkBNyyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740376130; c=relaxed/simple;
	bh=wwiGFXGyJUI+8ngID3xjAzjXgUhNAc0jtVxR74pEyDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6X/sVDzAWYUfv397c+VSQx376URrO0mSElz6bR0PDpF593ltKscyjRZt6n9s8gZTo5kIcCkXXguOANmCJf/6NztIDw5aUDuBk8tv7m5QfXk3yWN+/EAwFQC/YrvHutQM3Um1q+RRbd+Y9v8wHXi7/GNC/mh4TKGSlL1HIOvGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7Yic/1v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7Yic/1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740376127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDd2HEV0zlu3I2wKZMpHSC5tuven4bcLzFcq27C3h8o=;
	b=R7Yic/1v7F2RLfnXigVJxlI4cGNEH5ih89bTSfy7KBDR/ioDxqpchw1xtKikpNJg9ZCmdm
	c7lYgHD3cP6Owzh4TqY5Zsbz6W5jCX9nUry7r7b+galqZCVJzD0EGysAMfLfbMsYYN8oUF
	pODf1AcNIRT2sWqGjUhfxbIH74cCt54=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-1DA-YMpWPcaKnyEhf34fTA-1; Mon, 24 Feb 2025 00:48:45 -0500
X-MC-Unique: 1DA-YMpWPcaKnyEhf34fTA-1
X-Mimecast-MFC-AGG-ID: 1DA-YMpWPcaKnyEhf34fTA_1740376124
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22107b29ac3so69116865ad.1
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2025 21:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740376124; x=1740980924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDd2HEV0zlu3I2wKZMpHSC5tuven4bcLzFcq27C3h8o=;
        b=lIjsA+Pf0hl5ZDtGZlUGg85p23+5NhfHq0+KmklB3MS+1+D1CHkYWjanFBALkf86ia
         gNR3CjCIXwMWA0N7CXy5JIk5LKE2BTTidlD9bRtm1vhBgXymhwYB+1rR8zbolESPz6Ml
         ce2n6YEms9hJSrV14a0/Xd1AaDH8RnOOk0xiLNpg3BWHvRvuPFeJU24s9/AnsAJKzMmc
         s/c3DFk2zBXWAWfBbXj5M/3VjJ9zbmV9F9w/vwun70w7d9xnj8FL1ti+Ke7r8lUQ90Y/
         hxeJoxaktgbL61odiwqWNW+8ltYG5sOzSF416faLx0gfg7ZE8+V5jPVUuKDKLpNe986B
         RuZw==
X-Forwarded-Encrypted: i=1; AJvYcCUUxV764SF4wi6QuwjeB6+6kIm+yU2S7aZjHoAWfsnZ5vT6o47wCi5tbSpXJ+6yT1bicpotcFtp@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjB1ihyaT6r56C3axk/K0EtHMV5CxMMfCDNq7LLCi3G0+UQR+
	YQLpP/718Ey6DoOvveGKo8ibmZnPB3iBIcsOVwsB9b7svWIaBM3Al4qkQMWocX+fJxqeQabMIzv
	SDPbz1TKvRS2czXvXQsP4jR01Jxrq1DTWHaRQngANnD5CgATgoth/wZ8=
X-Gm-Gg: ASbGncvqqHHlElA5AEM068cCjVMtgjhn3zQBlw91s4sZ/3E/8p8yH6EwEXPTnAUtr+J
	o19QKeo0XJzLc2dyFRjucUpsNIBT4yDhvbEOy2uZo30tW72dxEDOopW9hYMWaMwgafXS+HxDlP3
	DvWyDQNVMF4oSotpnMGMwFnrBy2sMtVOj6YJxIjGD/YykdH+fA25UfzBAP+U3kK4s5SEZTghmD1
	7vCyXfdJw5o+emMxIgt4HDeMaa545N2BGeFPem5r5FLaYsA723zZIudrQZ09qXjsQkhqQImkJly
	rOAdPvXQL1eTIl+43HIF23Z9nqf6PVQLmxaP4hLgb0PYT5XcXPFE0keV
X-Received: by 2002:a17:902:ce11:b0:21f:6167:183a with SMTP id d9443c01a7336-2218c3f434fmr269163255ad.15.1740376123939;
        Sun, 23 Feb 2025 21:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnKCU8hKbhqZCBU+drWw3RXqXfiTlDYq+KEdVdA9MfHsQStvj9GVxl2ldBZEPdDIlUSHtxJw==
X-Received: by 2002:a17:902:ce11:b0:21f:6167:183a with SMTP id d9443c01a7336-2218c3f434fmr269163015ad.15.1740376123576;
        Sun, 23 Feb 2025 21:48:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53494c0sm171384545ad.6.2025.02.23.21.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:48:43 -0800 (PST)
Date: Mon, 24 Feb 2025 13:48:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250224054839.zne2pykkrm2nll5d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250223193040.GA21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223193040.GA21799@frogsfrogsfrogs>

On Sun, Feb 23, 2025 at 11:30:40AM -0800, Darrick J. Wong wrote:
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
> 
> Thanks, Zorro.  I know the last few months have been rough. :/

Thank *you* help a lot, and always be patiented to take review points to
your patchset, finally we got these patches in :)

Next, I'm going to deal with your 10 PRs (73 patches), and another patchset
about the check-parallel ([PATCH 0/5]: CLI and feature improvements for
check-parallel). Will talk details with you after my testing.

I've pushed back the reviewing for some patches, now we can move on. Please
feel free to remind me if I missed anyone's patch long time :)

Thanks,
Zorro

> 
> --D
> 
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
> >       [af0f1090e240] common/rc: don't copy fsstress to $TEST_DIR
> >       [f43da58ef936] unmount: resume logging of stdout and stderr for filtering
> >       [5dc27fd20f80] mkfs: don't hardcode log size
> >       [dba402b7e3ae] common/rc: return mount_ret in _try_scratch_mount
> >       [9505d04b8073] preamble: fix missing _kill_fsstress
> >       [4d9aeeb79f9c] generic/650: revert SOAK DURATION changes
> >       [1bb15a27573e] generic/032: fix pinned mount failure
> >       [b816737426bf] fuzzy: stop __stress_scrub_fsx_loop if fsx fails
> >       [040e74c89192] fuzzy: don't use readarray for xfsfind output
> >       [0dfe1fac98d2] fuzzy: always stop the scrub fsstress loop on error
> >       [336d73c96a96] fuzzy: port fsx and fsstress loop to use --duration
> >       [96d29207c126] fix _require_scratch_duperemove ordering
> >       [a8268531ca8b] fsstress: fix a memory leak
> >       [e8e29e028faa] fsx: fix leaked log file pointer
> >       [4a9e82863917] misc: don't put nr_cpus into the fsstress -n argument
> >       [c475ff6ff6d7] common/config: add $here to FSSTRESS_PROG
> >       [1c67e8b191fe] config: add FSX_PROG variable
> >       [a553e7eba1cf] build: initialize stack variables to zero by default
> > 
> > David Sterba (2):
> >       [9049250b4042] fstests: remove ltp/growfiles
> >       [5b56a2d88819] fstests: remove reiserfs support
> > 
> > Filipe Manana (2):
> >       [7122c0315a08] btrfs/254: don't leave mount on test fs in case of failure/interruption
> >       [535b72a63a28] btrfs/254: fix test failure in case scratch devices are larger than 50G
> > 
> > Jeff Layton (1):
> >       [bd6e01c81e21] generic/126: run it inside its own subdirectory
> > 
> > 
> > Code Diffstat:
> > 
> >  .gitignore            |    1 -
> >  Makefile              |    2 +-
> >  check                 |   91 +-
> >  common/config         |   12 +-
> >  common/dump           |    1 -
> >  common/fuzzy          |  104 +-
> >  common/metadump       |   42 +-
> >  common/populate       |   13 +-
> >  common/preamble       |    2 +-
> >  common/quota          |    6 +-
> >  common/rc             |  146 ++-
> >  common/reflink        |    2 +-
> >  configure.ac          |    1 +
> >  include/builddefs.in  |    3 +-
> >  lib/tlibio.c          |    2 +-
> >  ltp/Makefile          |    2 +-
> >  ltp/fsstress.c        |    1 +
> >  ltp/fsx.c             |    8 +-
> >  ltp/growfiles.c       | 2607 -------------------------------------------------
> >  m4/package_libcdev.m4 |   14 +
> >  src/nsexec.c          |   18 +-
> >  src/xfsfind.c         |   14 +-
> >  tests/btrfs/254       |    8 +-
> >  tests/generic/019     |    2 +-
> >  tests/generic/032     |    9 +
> >  tests/generic/050     |    2 +-
> >  tests/generic/075     |    2 +-
> >  tests/generic/085     |    2 +-
> >  tests/generic/093     |    2 +-
> >  tests/generic/112     |    2 +-
> >  tests/generic/125     |    2 +-
> >  tests/generic/126     |   17 +-
> >  tests/generic/127     |   16 +-
> >  tests/generic/128     |    2 +-
> >  tests/generic/193     |   36 +-
> >  tests/generic/230     |   14 +-
> >  tests/generic/231     |    4 +-
> >  tests/generic/233     |    2 +-
> >  tests/generic/270     |   12 +-
> >  tests/generic/310     |    6 +-
> >  tests/generic/314     |    2 +-
> >  tests/generic/327     |    2 +-
> >  tests/generic/328     |    4 +-
> >  tests/generic/355     |    2 +-
> >  tests/generic/361     |    4 +-
> >  tests/generic/370     |   10 +-
> >  tests/generic/453     |    6 +-
> >  tests/generic/455     |    2 +-
> >  tests/generic/456     |    2 +-
> >  tests/generic/457     |    2 +-
> >  tests/generic/469     |    2 +-
> >  tests/generic/476     |    4 +-
> >  tests/generic/499     |    2 +-
> >  tests/generic/504     |   15 +-
> >  tests/generic/511     |    2 +-
> >  tests/generic/514     |    2 +-
> >  tests/generic/530     |    6 +-
> >  tests/generic/531     |    6 +-
> >  tests/generic/561     |    2 +-
> >  tests/generic/573     |    2 +-
> >  tests/generic/590     |    2 +-
> >  tests/generic/600     |    2 +-
> >  tests/generic/601     |    2 +-
> >  tests/generic/603     |   10 +-
> >  tests/generic/642     |    2 +-
> >  tests/generic/650     |    6 +-
> >  tests/generic/673     |    2 +-
> >  tests/generic/674     |    2 +-
> >  tests/generic/675     |    2 +-
> >  tests/generic/680     |    2 +-
> >  tests/generic/681     |    2 +-
> >  tests/generic/682     |    2 +-
> >  tests/generic/683     |    2 +-
> >  tests/generic/684     |    2 +-
> >  tests/generic/685     |    2 +-
> >  tests/generic/686     |    2 +-
> >  tests/generic/687     |    2 +-
> >  tests/generic/688     |    2 +-
> >  tests/generic/691     |    8 +-
> >  tests/generic/721     |   10 +-
> >  tests/generic/726     |    2 +-
> >  tests/generic/727     |    2 +-
> >  tests/generic/740     |    2 +-
> >  tests/generic/746     |    2 +-
> >  tests/generic/750     |    2 +-
> >  tests/generic/759     |    7 +-
> >  tests/generic/760     |    7 +-
> >  tests/xfs/149         |    2 +-
> >  tests/xfs/501         |    2 +-
> >  tests/xfs/502         |    2 +-
> >  tests/xfs/530         |    2 +-
> >  tests/xfs/720         |    2 +-
> >  tests/xfs/795         |    2 +-
> >  tests/xfs/803         |    2 +-
> >  tools/Makefile        |   21 +
> >  tools/run_privatens   |   28 +
> >  tools/run_setsid      |   22 +
> >  97 files changed, 596 insertions(+), 2890 deletions(-)
> > --
> > Zorro Lang
> > zlang@kernel.org
> 
> 
> 

