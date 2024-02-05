Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9E10A0F
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111912; cv=none; b=LtnR/G7kACrSgCLp4WJV6WzamjOTcaTyAA+BkvTr0Wt8OidkVR2cFHjATnVWRt0nwVgacMZ3mQ7TvKdwNXgz35/edlHOBaxhY9PKPQ9H+Xod1vN4hpo4I9KCLTw4OiQkgIGKQ+pRgL9hkJ5y/CP8l4+jEQ59hQYmpQshTSPHP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111912; c=relaxed/simple;
	bh=7x3tJk1tpo4rPxv3luJHhyNvLFCvHWsKnaMC18z3fzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu18iPvs2VlWrkqiZBP9QtpBhCdaEd19m+pT9SRMl+1P3TovQ/UdUMvUNLD9VEhfjAWw3cLzdqGl/zwVMN3R/Ic24FRXHifwdrB2Rrkmx2NaOIGdgUnsxushZlQJ1HwfZju42FsOp6N/KOeC1wtdgEdW49KwXDnYnR553ikADs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iih9MS6k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iih9MS6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707111909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OboSJedMobpNT4UbR9NU2LVor2NsKGd0w3VPpTYXmA=;
	b=iih9MS6kbtoNAgt8iRuf2O8V0oMY4jATJ6UQziPC/hgLjPla3nThq2OvySgplHHyrMbBUW
	e9k+vSTLIdrKjpp/K6B1eDIC+IAUNYc/wUY2aRDI3Hu4PTMFFJUk+2ihvlfjCWceWSVOCS
	VBLDkqjQIz++bn0KP9EJw6hBVQdgUfk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-w9CX5Eh8MqC3vJcPlVUoWA-1; Mon, 05 Feb 2024 00:45:07 -0500
X-MC-Unique: w9CX5Eh8MqC3vJcPlVUoWA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29608f00cbbso3368551a91.2
        for <fstests@vger.kernel.org>; Sun, 04 Feb 2024 21:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707111906; x=1707716706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OboSJedMobpNT4UbR9NU2LVor2NsKGd0w3VPpTYXmA=;
        b=Gprda850DSjDJqpwpYDe2lovvQjkJWFKTbyIVvO68Hv62h/QV8k4MTshRn5PDEdQQC
         ZEXIxMiLDMoi+VW7EHDl/5s/iA2V6pAzspo0x9ZnpW8Pz643Y4FKktstM6Hx0mJxMYKb
         oTPL3QMKI0+aDhg6LCQW2KbkGEX2JNayNlZbBiQA6+9Yc+JaK7M37sSTA/tS+BRFDxy8
         hjyJzBM2+f+FaSnoByOkInZneyoRDEAcn3L8uiS/QCWOmnr1q6vEFFNznQwItda9JzQS
         Hjltr0Upnjwq/wM1WFqIOXqmNJawEDJm/DSoy8OiE1coIdk+l7PTXZtjq+tuLoCXrgm5
         wcwg==
X-Gm-Message-State: AOJu0YxS/iYqfnJbwQhz0dyYDxBbUnCButQbUOOQ3nFR7YI++gLOg13G
	4p+cEvdq8AeJTSXLAN6DoxqOkPTp6UreoLFuxn5JI+KKTMokMzxe8bidoyCuh/lrneC5JmhCAK4
	tNYhGX9njSsK3OjQRDuH55Z6WBBP4MZ5A3mGz945NG7iqunXmwDxJcnzPIEBnZtwVqG31rsUaRp
	pWqZbokGgK39qhlaXwZ7U6VuUtN1y5pzjk/4jVtg==
X-Received: by 2002:a17:90a:8682:b0:296:e93:cdc with SMTP id p2-20020a17090a868200b002960e930cdcmr10213048pjn.16.1707111906489;
        Sun, 04 Feb 2024 21:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdRyij+HlmlzjVUK/iw1leY6btpP5Krxh/gUeeWX8KZL1IvqWyx7ghlDUL1a82uvFTbPC9HA==
X-Received: by 2002:a17:90a:8682:b0:296:e93:cdc with SMTP id p2-20020a17090a868200b002960e930cdcmr10213032pjn.16.1707111906048;
        Sun, 04 Feb 2024 21:45:06 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji7-20020a170903324700b001d8be6d1ec4sm5449592plb.39.2024.02.04.21.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 21:45:05 -0800 (PST)
Date: Mon, 5 Feb 2024 13:45:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
Message-ID: <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>

On Sun, Feb 04, 2024 at 10:48:47PM +0800, Zorro Lang wrote:
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2024.02.04 release.
> 
> Release Notes:
> 1) There's 4 new test cases in this release -- btrfs/310, generic/740, xfs/601,
>    and xfs/606.
> 2) btrfs/303 is removed.
> 3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_metadump_tests
>    new file (might be renamed to common/metadump if more other fs need).
> 4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, welcome more
>    updates for more filesystems.
> 5) Some updates/fixes for source building, if anyone find building issues in
>    this release, please report to us.
> 
> More details refer to below, thanks for all your contributions!
> 
> Thanks,
> Zorro
> 
> The new head of the for-next branch is commit:
> 
> 9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> 
> New commits ([N]ew, [U]pdate, [D]elete):
> 
> Alexander Aring (1):
> [N]      [56625c897fd9] generic: add fcntl lock corner cases tests
> 
> Anthony Iliopoulos (2):
> [U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro definition
> [U]      [79d98d94e58c] build: remove unused m4 macros
> 
> Boris Burkov (1):
> [D]      [a6e196af46cc] btrfs: Remove btrfs/303
> 
> Darrick J. Wong (10):
> [U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_FACTOR
> [U]      [8c8be04c1065] common/xfs: simplify maximum metadump format detection
> [U]      [42f797643529] common/populate: always metadump full metadata blocks
> [U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadump call
> [N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
> [U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
> [U]      [329671426287] xfs/503: test metadump obfuscation, not progressbars
> [N]      [c31a500edc04] xfs/503: split copy and metadump into two tests
> [U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
> [U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform removal in 6.8

Note: A regression problem on this release sometimes after running xfs/605 or
xfs/129, it only affect XFS testing, it might kill all later testing, I'm
looking into it, and fix ASAP, please linux-xfs don't not update to this
release temporarily, wait for a fix. Sorry for this trouble.

Thanks,
Zorro

> 
> Jeff Layton (2):
> [U]      [ab217141c2fb] common/rc: NFSv2/3 do not support negative timestamps
> [U]      [6c7f9b29e71d] src/t_mtab.c: increase the lock timeout to 120s
> 
> Li Zhijian (1):
> [U]      [0160ab05979d] gitignore: Add missing /src/t_reflink_read_race
> 
> Pavel Reichl (1):
> [U]      [f681ebf32b24] xfs/598: Add missing "fixed_by" hints
> 
> Qu Wenruo (1):
> [N]      [dfdd248c648a] btrfs: verify the read behavior of compressed inline extent
> 
> Richard Weinberger (2):
> [U]      [98dcd8c239d8] generic/020: Compute correct max_attrs for UBIFS
> [U]      [1cf74a17a74e] generic/597,598: Require groups
> 
> Ritesh Harjani (IBM) (1):
> [U]      [4cc6188cd89f] xfs/604: Make test as _notrun for higher blocksizes filesystem
> 
> Su Yue (2):
> [U]      [eca4b512935a] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
> [U]      [cbde2e1269dc] common/rc: improve block_size support for bcachefs
> 
> Yang Xu (1):
> [U]      [9b63adb69add] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> 
> Zorro Lang (1):
> [N]      [fb013bd945b8] xfs: test xfs_growfs with too-small size expansion
> 
> 
> Code Diffstat:
> 
>  .gitignore                         |   1 +
>  acinclude.m4                       |   5 -
>  common/config                      |   4 +-
>  common/populate                    |   2 +-
>  common/rc                          |  63 ++++++--
>  common/ubifs                       |   9 ++
>  common/xfs                         |  51 +++++-
>  common/xfs_metadump_tests          | 138 ++++++++++++++++
>  configure.ac                       |   2 +-
>  m4/manual_format.m4                |  17 --
>  m4/package_libcdev.m4              |  95 -----------
>  m4/package_ncurses.m4              |  27 ----
>  m4/package_pthread.m4              |  19 ---
>  m4/package_types.m4                |  50 ------
>  m4/package_xfslibs.m4              |  28 ----
>  m4/visibility_hidden.m4            |  22 ---
>  src/Makefile                       |   2 +-
>  src/af_unix.c                      |   2 -
>  src/fcntl_lock_corner_tests.c      | 322 +++++++++++++++++++++++++++++++++++++
>  src/t_mtab.c                       |   2 +-
>  src/t_snapshot_deleted_subvolume.c |  10 +-
>  tests/btrfs/303                    |  77 ---------
>  tests/btrfs/303.out                |   2 -
>  tests/btrfs/310                    |  83 ++++++++++
>  tests/btrfs/310.out                |   2 +
>  tests/generic/020                  |   6 +
>  tests/generic/256                  |   7 +
>  tests/generic/597                  |   2 +
>  tests/generic/598                  |   2 +
>  tests/generic/740                  |  27 ++++
>  tests/generic/740.out              |   2 +
>  tests/xfs/122.out                  |   2 +
>  tests/xfs/129                      |  91 +----------
>  tests/xfs/234                      |  92 +----------
>  tests/xfs/253                      |  90 +----------
>  tests/xfs/284                      |   4 +-
>  tests/xfs/291                      |  32 ++--
>  tests/xfs/336                      |   2 +-
>  tests/xfs/432                      |  31 +---
>  tests/xfs/503                      |  82 ++--------
>  tests/xfs/503.out                  |   6 +-
>  tests/xfs/598                      |   5 +
>  tests/xfs/601                      |  54 +++++++
>  tests/xfs/601.out                  |   4 +
>  tests/xfs/604                      |   4 +-
>  tests/xfs/605                      |  92 +----------
>  tests/xfs/606                      |  56 +++++++
>  tests/xfs/606.out                  |   2 +
>  48 files changed, 887 insertions(+), 843 deletions(-)
> --
> Zorro Lang
> zlang@kernel.org


