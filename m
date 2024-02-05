Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E0B671
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112828; cv=none; b=d4mwIklZW+AXGPnrTr1LwUawF61uqVz/tZ8rAbjoNWddd1Ja6Cc5fkF4FupKryFE4KNqcmyiebaZLNzfhNxD59dRgAZ2htJEHiJiHQ1rtPRwg/CBcKju91c4R+jPsAO11fyxl7izwLD6d4K8ceSvaqjumCMdgLFz7uf/RYO0IK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112828; c=relaxed/simple;
	bh=80NgZAR/sD216YvIci3F9gimtJJ0rtsOhyweeAUwdm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/MGMmdF1tY8OXv6p/EjoiyutPM7JsVegQoJcHOrm2PwiIv0ktiMqf8Ary64R1CZETQcCZcc71PfEhoXrfd9FZyDdNUBH46dVu/sX9d6FCXeC93h76/XVFMhAn07mpub2nohPHOIY1pN3/L43/OEwk6Jm1XpwRqYCurdNMsc/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hElWsb1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hElWsb1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707112824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oE7YrlaVpAnjcm2UkA77epFm2/gqJsyOxN/4JV3tU+0=;
	b=hElWsb1zMy+NWt/EmChJzKmyd3OOx8sfp97R2VVKFAFFwxU/WXtOVQq2v3/bhu2OKZ5iHW
	+QdkzWPdv/lFhYhp6EbvwDu8FlofnJyWNbf/rvm9Mm3OUzewD9VGMDnpZfCmiiKCC6vdyR
	klEh5zjBJ1d05hZrkto4xLkxr00Z7cM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Mr0ZckWcNu-b9Urokv8R0A-1; Mon, 05 Feb 2024 01:00:23 -0500
X-MC-Unique: Mr0ZckWcNu-b9Urokv8R0A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d98231a1f7so20129795ad.0
        for <fstests@vger.kernel.org>; Sun, 04 Feb 2024 22:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707112822; x=1707717622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE7YrlaVpAnjcm2UkA77epFm2/gqJsyOxN/4JV3tU+0=;
        b=qPFf/PSrFy8bClZrgzCpVH/mukxe5RPt3aelkyiSayq2hgLFKBm/guv6UxJSp+4TLr
         bzCLm2tG7qwzETx0hSMC434+QTdiAosmdMgwTsiahVdtzVT+3xo9f/2wt5g1zZClATX3
         5Or6T8ea5dV47Gq++HncnZ9W3wk/N0SySv4h4I/V4tU4YSXwn+JTO6VfFiN3Xf1JJBt2
         kE4jtkGebirw3dWwnJBjfVs+GoOJ1Tn88P8lpumfbhifm9iF69jKH4vpVz43GeQqVCkZ
         XN56HjqhJUXdHwNU1EsF8oMx+U2P4vFrL48l0t8pOO7s/zZKD5B+UrYZ+ThJMKwVKlV+
         v2eQ==
X-Gm-Message-State: AOJu0Yz0+CB1UN+gUt6yG3fCJaKVnk5lD1NPeMipm3ccBB1NHUKkmyR3
	JlnGeEq5ywTL4obCebagEIJMKUUjitOwauWVYIzz46ULkaGDtLk2H27CZXhKbJ7OnVvskWCoAKY
	ar992KNFlDSwPoi6Zl6GaEKrMALc6u3nobBLrI4Z4T1HCLQLjj8/gBpCjqMdDDHcXj9Vfzb+oS8
	Wt8QPA6Zlg9etnZx0jjz6uHAwaKmM6n2vV9n6/BA==
X-Received: by 2002:a17:902:e84e:b0:1d9:c17b:43ff with SMTP id t14-20020a170902e84e00b001d9c17b43ffmr495527plg.3.1707112821386;
        Sun, 04 Feb 2024 22:00:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSHJarNJ+KRGlhNWHUQjeUg6yDEBa/HhX7llQV38zsuQ224dttSPolZbAVlYTiwDj5PbEaQA==
X-Received: by 2002:a17:902:e84e:b0:1d9:c17b:43ff with SMTP id t14-20020a170902e84e00b001d9c17b43ffmr495472plg.3.1707112819830;
        Sun, 04 Feb 2024 22:00:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id mm4-20020a1709030a0400b001d8dbb867b1sm5470978plb.179.2024.02.04.22.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:00:19 -0800 (PST)
Date: Mon, 5 Feb 2024 14:00:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
Message-ID: <20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Feb 05, 2024 at 01:45:02PM +0800, Zorro Lang wrote:
> On Sun, Feb 04, 2024 at 10:48:47PM +0800, Zorro Lang wrote:
> > Hi all,
> > 
> > The for-next branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > has just been updated and tagged as v2024.02.04 release.
> > 
> > Release Notes:
> > 1) There's 4 new test cases in this release -- btrfs/310, generic/740, xfs/601,
> >    and xfs/606.
> > 2) btrfs/303 is removed.
> > 3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_metadump_tests
> >    new file (might be renamed to common/metadump if more other fs need).
> > 4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, welcome more
> >    updates for more filesystems.
> > 5) Some updates/fixes for source building, if anyone find building issues in
> >    this release, please report to us.
> > 
> > More details refer to below, thanks for all your contributions!
> > 
> > Thanks,
> > Zorro
> > 
> > The new head of the for-next branch is commit:
> > 
> > 9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > 
> > New commits ([N]ew, [U]pdate, [D]elete):
> > 
> > Alexander Aring (1):
> > [N]      [56625c897fd9] generic: add fcntl lock corner cases tests
> > 
> > Anthony Iliopoulos (2):
> > [U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro definition
> > [U]      [79d98d94e58c] build: remove unused m4 macros
> > 
> > Boris Burkov (1):
> > [D]      [a6e196af46cc] btrfs: Remove btrfs/303
> > 
> > Darrick J. Wong (10):
> > [U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_FACTOR
> > [U]      [8c8be04c1065] common/xfs: simplify maximum metadump format detection
> > [U]      [42f797643529] common/populate: always metadump full metadata blocks
> > [U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadump call
> > [N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
> > [U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
> > [U]      [329671426287] xfs/503: test metadump obfuscation, not progressbars
> > [N]      [c31a500edc04] xfs/503: split copy and metadump into two tests
> > [U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
> > [U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform removal in 6.8
> 
> Note: A regression problem on this release sometimes after running xfs/605 or
> xfs/129, it only affect XFS testing, it might kill all later testing, I'm
> looking into it, and fix ASAP, please linux-xfs don't not update to this
> release temporarily, wait for a fix. Sorry for this trouble.

!!! It's a critical dangerous bug! Please don't use this release on xfs testing, it might
kill your system!

The problem comes from common/xfs_metadump_tests:_cleanup_verify_metadump():

   rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*

The XFS_METADUMP_FILE and XFS_METADUMP_IMG are set in _setup_verify_metadump(), but
if the _setup_verify_metadump isn't called due to someone case _notrun before calling
it, its _cleanup will still do _cleanup_verify_metadump, likes this:

  _cleanup()
  {
        cd /
        rm -r -f $tmp.*
        _cleanup_verify_metadump

Then boooomb, it does "rm -f *" in "/" .... The "*" after "rm" must be written
carefully. I'll send a patch to fix this problem soon, please don't update
fstests until the fix be merged.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > 
> > Jeff Layton (2):
> > [U]      [ab217141c2fb] common/rc: NFSv2/3 do not support negative timestamps
> > [U]      [6c7f9b29e71d] src/t_mtab.c: increase the lock timeout to 120s
> > 
> > Li Zhijian (1):
> > [U]      [0160ab05979d] gitignore: Add missing /src/t_reflink_read_race
> > 
> > Pavel Reichl (1):
> > [U]      [f681ebf32b24] xfs/598: Add missing "fixed_by" hints
> > 
> > Qu Wenruo (1):
> > [N]      [dfdd248c648a] btrfs: verify the read behavior of compressed inline extent
> > 
> > Richard Weinberger (2):
> > [U]      [98dcd8c239d8] generic/020: Compute correct max_attrs for UBIFS
> > [U]      [1cf74a17a74e] generic/597,598: Require groups
> > 
> > Ritesh Harjani (IBM) (1):
> > [U]      [4cc6188cd89f] xfs/604: Make test as _notrun for higher blocksizes filesystem
> > 
> > Su Yue (2):
> > [U]      [eca4b512935a] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
> > [U]      [cbde2e1269dc] common/rc: improve block_size support for bcachefs
> > 
> > Yang Xu (1):
> > [U]      [9b63adb69add] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > 
> > Zorro Lang (1):
> > [N]      [fb013bd945b8] xfs: test xfs_growfs with too-small size expansion
> > 
> > 
> > Code Diffstat:
> > 
> >  .gitignore                         |   1 +
> >  acinclude.m4                       |   5 -
> >  common/config                      |   4 +-
> >  common/populate                    |   2 +-
> >  common/rc                          |  63 ++++++--
> >  common/ubifs                       |   9 ++
> >  common/xfs                         |  51 +++++-
> >  common/xfs_metadump_tests          | 138 ++++++++++++++++
> >  configure.ac                       |   2 +-
> >  m4/manual_format.m4                |  17 --
> >  m4/package_libcdev.m4              |  95 -----------
> >  m4/package_ncurses.m4              |  27 ----
> >  m4/package_pthread.m4              |  19 ---
> >  m4/package_types.m4                |  50 ------
> >  m4/package_xfslibs.m4              |  28 ----
> >  m4/visibility_hidden.m4            |  22 ---
> >  src/Makefile                       |   2 +-
> >  src/af_unix.c                      |   2 -
> >  src/fcntl_lock_corner_tests.c      | 322 +++++++++++++++++++++++++++++++++++++
> >  src/t_mtab.c                       |   2 +-
> >  src/t_snapshot_deleted_subvolume.c |  10 +-
> >  tests/btrfs/303                    |  77 ---------
> >  tests/btrfs/303.out                |   2 -
> >  tests/btrfs/310                    |  83 ++++++++++
> >  tests/btrfs/310.out                |   2 +
> >  tests/generic/020                  |   6 +
> >  tests/generic/256                  |   7 +
> >  tests/generic/597                  |   2 +
> >  tests/generic/598                  |   2 +
> >  tests/generic/740                  |  27 ++++
> >  tests/generic/740.out              |   2 +
> >  tests/xfs/122.out                  |   2 +
> >  tests/xfs/129                      |  91 +----------
> >  tests/xfs/234                      |  92 +----------
> >  tests/xfs/253                      |  90 +----------
> >  tests/xfs/284                      |   4 +-
> >  tests/xfs/291                      |  32 ++--
> >  tests/xfs/336                      |   2 +-
> >  tests/xfs/432                      |  31 +---
> >  tests/xfs/503                      |  82 ++--------
> >  tests/xfs/503.out                  |   6 +-
> >  tests/xfs/598                      |   5 +
> >  tests/xfs/601                      |  54 +++++++
> >  tests/xfs/601.out                  |   4 +
> >  tests/xfs/604                      |   4 +-
> >  tests/xfs/605                      |  92 +----------
> >  tests/xfs/606                      |  56 +++++++
> >  tests/xfs/606.out                  |   2 +
> >  48 files changed, 887 insertions(+), 843 deletions(-)
> > --
> > Zorro Lang
> > zlang@kernel.org
> 
> 

