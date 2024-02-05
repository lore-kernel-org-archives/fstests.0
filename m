Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81687BE4A
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113796; cv=none; b=oaI30vmvgR1cpYrf4SGOC50JhEStCQIFsKIQAgYhvdX4nMa16j4TR7PGdSKyDo/RH73dmmdtMnAWcXDuKTVoIYpMblCUdfTtnWBQzkr+5LFEMWZB0EMfT+x+DeMmXig2zCTCCRzkQlmbNP6oW2m3RVr3oeKkWMAnborKRY0LCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113796; c=relaxed/simple;
	bh=tMITnD4qf0OA0+oaEd4Qsvk6Q1Xm/TJ/ae1/qWwOt+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNFEsTQO9slW1RDlYb1apXPplMuw0gRt09mYynOebz1nRF+1yiQ6HGFn6s3HRRkILRkxteltnORFGWw0DdVO00nmZCeya4ji+jvLoG1A7dnoZ8Vp2j5E2e1P/DCSVD26KCy2pkvVHS+8ijC654rHNX54AH3E4DtgjJEwRiN9yGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMxznWit; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMxznWit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707113793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDsZW2HLGTOn1PUXpa8FnL7iMBra3cFtWwEYFIG/nR4=;
	b=eMxznWity8MUePFs27MaXCHhrK2iq8V7n3yGcHF9kFhzYxPstSo6+8MwGyFoAuCkLkMxdv
	aJ9O+EJoYxyK8OKgIRhfcZ+lEqKIY+bD3nub65mzGybMGPfzZ7xMrogXdZgvuDlPiWufHA
	O0F6F/yj1HNd0Zfj2a/DsgKWT8X4X9U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-u_MjDTAhMWyUERkQHgD2qw-1; Mon, 05 Feb 2024 01:16:32 -0500
X-MC-Unique: u_MjDTAhMWyUERkQHgD2qw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so4824766a12.2
        for <fstests@vger.kernel.org>; Sun, 04 Feb 2024 22:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707113790; x=1707718590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDsZW2HLGTOn1PUXpa8FnL7iMBra3cFtWwEYFIG/nR4=;
        b=qGyPjYq9K7NzhFd2yX4ln9/TQbB1w2yjKymUeEGS9s7g8A6J8duN4ue2Ndqv7gv2/r
         cUVNXAGEBRp1tPW/GoZglACDbUeIq4v99cZMy3M6ehWk5Nee/euMutg+ZKWz3gjY1oBL
         pFUfgl4swyWLCfgUT3oxHXmnqNK60tUcu7tgH56ccP7qalBLsxXnlnMF7w7GcrJzB0YR
         6+znHtFd7hec8zM2u+3BA4E1QK7oPJbh4xWTwqv2Ntt7iyVWghNxgItL1Qii1gR4e40X
         vWZTW82avGXpn8x4G6dAPlsHPrt19u4v7MFKDT6ToWH4M0mBT0JtJhLWSbRPz1tw0Vq6
         r9Cg==
X-Gm-Message-State: AOJu0YygDezmXa1PZEBbRVmB6lmTgV1g9CVUuNL/5aI80VUtdSZ7HCq7
	Ersb/TMpSyZGQ7vQ5sG7pHytw3ej0nDMLtMFcWPEeH4dF7wf+kWB/jXJQ53nNsln8/xVC8rxq/m
	Ums5HPBhqr/gty2zI+QejfFZM7CupTaEvelhlSvNJDaJ5C+15dTP5VeKroQ2Gi703bBuqeEyQrg
	BdYf/yXvv81vl8/G7XUygXf0h/stAynxZSX5O3YQ==
X-Received: by 2002:a05:6a20:c90e:b0:19a:112e:89dc with SMTP id gx14-20020a056a20c90e00b0019a112e89dcmr10017595pzb.62.1707113790311;
        Sun, 04 Feb 2024 22:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtMMDWih5KJK0YvzgQ+Ki3KLa0fffJ03y/7FrqQZ657KnGAXk1aLi8qfogQnRlzZp6qaywhQ==
X-Received: by 2002:a05:6a20:c90e:b0:19a:112e:89dc with SMTP id gx14-20020a056a20c90e00b0019a112e89dcmr10017579pzb.62.1707113789828;
        Sun, 04 Feb 2024 22:16:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fd4-20020a056a002e8400b006d98505dacasm5722579pfb.132.2024.02.04.22.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:16:29 -0800 (PST)
Date: Mon, 5 Feb 2024 14:16:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
Message-ID: <20240205061626.mve2cp5btbpiijgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Feb 05, 2024 at 02:00:16PM +0800, Zorro Lang wrote:
> On Mon, Feb 05, 2024 at 01:45:02PM +0800, Zorro Lang wrote:
> > On Sun, Feb 04, 2024 at 10:48:47PM +0800, Zorro Lang wrote:
> > > Hi all,
> > > 
> > > The for-next branch of the xfstests repository at:
> > > 
> > > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > 
> > > has just been updated and tagged as v2024.02.04 release.
> > > 
> > > Release Notes:
> > > 1) There's 4 new test cases in this release -- btrfs/310, generic/740, xfs/601,
> > >    and xfs/606.
> > > 2) btrfs/303 is removed.
> > > 3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_metadump_tests
> > >    new file (might be renamed to common/metadump if more other fs need).
> > > 4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, welcome more
> > >    updates for more filesystems.
> > > 5) Some updates/fixes for source building, if anyone find building issues in
> > >    this release, please report to us.
> > > 
> > > More details refer to below, thanks for all your contributions!
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > The new head of the for-next branch is commit:
> > > 
> > > 9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > > 
> > > New commits ([N]ew, [U]pdate, [D]elete):
> > > 
> > > Alexander Aring (1):
> > > [N]      [56625c897fd9] generic: add fcntl lock corner cases tests
> > > 
> > > Anthony Iliopoulos (2):
> > > [U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro definition
> > > [U]      [79d98d94e58c] build: remove unused m4 macros
> > > 
> > > Boris Burkov (1):
> > > [D]      [a6e196af46cc] btrfs: Remove btrfs/303
> > > 
> > > Darrick J. Wong (10):
> > > [U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_FACTOR
> > > [U]      [8c8be04c1065] common/xfs: simplify maximum metadump format detection
> > > [U]      [42f797643529] common/populate: always metadump full metadata blocks
> > > [U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadump call
> > > [N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
> > > [U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
> > > [U]      [329671426287] xfs/503: test metadump obfuscation, not progressbars
> > > [N]      [c31a500edc04] xfs/503: split copy and metadump into two tests
> > > [U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
> > > [U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform removal in 6.8
> > 
> > Note: A regression problem on this release sometimes after running xfs/605 or
> > xfs/129, it only affect XFS testing, it might kill all later testing, I'm
> > looking into it, and fix ASAP, please linux-xfs don't not update to this
> > release temporarily, wait for a fix. Sorry for this trouble.
> 
> !!! It's a critical dangerous bug! Please don't use this release on xfs testing, it might
> kill your system!
> 
> The problem comes from common/xfs_metadump_tests:_cleanup_verify_metadump():
> 
>    rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*
> 
> The XFS_METADUMP_FILE and XFS_METADUMP_IMG are set in _setup_verify_metadump(), but
> if the _setup_verify_metadump isn't called due to someone case _notrun before calling
> it, its _cleanup will still do _cleanup_verify_metadump, likes this:
> 
>   _cleanup()
>   {
>         cd /
>         rm -r -f $tmp.*
>         _cleanup_verify_metadump
> 
> Then boooomb, it does "rm -f *" in "/" .... The "*" after "rm" must be written
> carefully. I'll send a patch to fix this problem soon, please don't update
> fstests until the fix be merged.

I decide to make a respin, I think this bug is dangerous enough due to it might kill
the whole testing system. If someone use fstests without the fix, that's too dangerous.

I think most of people haven't shifted to the new release, and this version hasn't
been merged into master branch. So I decide to do a respin with a manually fix to
avoid this problem ASAP. Then we can do more jobs later. Sorry for this trouble,
hope it hasn't affected you.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Jeff Layton (2):
> > > [U]      [ab217141c2fb] common/rc: NFSv2/3 do not support negative timestamps
> > > [U]      [6c7f9b29e71d] src/t_mtab.c: increase the lock timeout to 120s
> > > 
> > > Li Zhijian (1):
> > > [U]      [0160ab05979d] gitignore: Add missing /src/t_reflink_read_race
> > > 
> > > Pavel Reichl (1):
> > > [U]      [f681ebf32b24] xfs/598: Add missing "fixed_by" hints
> > > 
> > > Qu Wenruo (1):
> > > [N]      [dfdd248c648a] btrfs: verify the read behavior of compressed inline extent
> > > 
> > > Richard Weinberger (2):
> > > [U]      [98dcd8c239d8] generic/020: Compute correct max_attrs for UBIFS
> > > [U]      [1cf74a17a74e] generic/597,598: Require groups
> > > 
> > > Ritesh Harjani (IBM) (1):
> > > [U]      [4cc6188cd89f] xfs/604: Make test as _notrun for higher blocksizes filesystem
> > > 
> > > Su Yue (2):
> > > [U]      [eca4b512935a] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
> > > [U]      [cbde2e1269dc] common/rc: improve block_size support for bcachefs
> > > 
> > > Yang Xu (1):
> > > [U]      [9b63adb69add] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > > 
> > > Zorro Lang (1):
> > > [N]      [fb013bd945b8] xfs: test xfs_growfs with too-small size expansion
> > > 
> > > 
> > > Code Diffstat:
> > > 
> > >  .gitignore                         |   1 +
> > >  acinclude.m4                       |   5 -
> > >  common/config                      |   4 +-
> > >  common/populate                    |   2 +-
> > >  common/rc                          |  63 ++++++--
> > >  common/ubifs                       |   9 ++
> > >  common/xfs                         |  51 +++++-
> > >  common/xfs_metadump_tests          | 138 ++++++++++++++++
> > >  configure.ac                       |   2 +-
> > >  m4/manual_format.m4                |  17 --
> > >  m4/package_libcdev.m4              |  95 -----------
> > >  m4/package_ncurses.m4              |  27 ----
> > >  m4/package_pthread.m4              |  19 ---
> > >  m4/package_types.m4                |  50 ------
> > >  m4/package_xfslibs.m4              |  28 ----
> > >  m4/visibility_hidden.m4            |  22 ---
> > >  src/Makefile                       |   2 +-
> > >  src/af_unix.c                      |   2 -
> > >  src/fcntl_lock_corner_tests.c      | 322 +++++++++++++++++++++++++++++++++++++
> > >  src/t_mtab.c                       |   2 +-
> > >  src/t_snapshot_deleted_subvolume.c |  10 +-
> > >  tests/btrfs/303                    |  77 ---------
> > >  tests/btrfs/303.out                |   2 -
> > >  tests/btrfs/310                    |  83 ++++++++++
> > >  tests/btrfs/310.out                |   2 +
> > >  tests/generic/020                  |   6 +
> > >  tests/generic/256                  |   7 +
> > >  tests/generic/597                  |   2 +
> > >  tests/generic/598                  |   2 +
> > >  tests/generic/740                  |  27 ++++
> > >  tests/generic/740.out              |   2 +
> > >  tests/xfs/122.out                  |   2 +
> > >  tests/xfs/129                      |  91 +----------
> > >  tests/xfs/234                      |  92 +----------
> > >  tests/xfs/253                      |  90 +----------
> > >  tests/xfs/284                      |   4 +-
> > >  tests/xfs/291                      |  32 ++--
> > >  tests/xfs/336                      |   2 +-
> > >  tests/xfs/432                      |  31 +---
> > >  tests/xfs/503                      |  82 ++--------
> > >  tests/xfs/503.out                  |   6 +-
> > >  tests/xfs/598                      |   5 +
> > >  tests/xfs/601                      |  54 +++++++
> > >  tests/xfs/601.out                  |   4 +
> > >  tests/xfs/604                      |   4 +-
> > >  tests/xfs/605                      |  92 +----------
> > >  tests/xfs/606                      |  56 +++++++
> > >  tests/xfs/606.out                  |   2 +
> > >  48 files changed, 887 insertions(+), 843 deletions(-)
> > > --
> > > Zorro Lang
> > > zlang@kernel.org
> > 
> > 

