Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5311188
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116212; cv=none; b=jkC7OD2Bw81hgs3dyDdjJHA6DaFvh90gYpECNhc+89z9pJ7/biYt7WDcrQg1po1wr3OMlWM7/fbzouwAZ9Lvz0kXKdM5NsSeK9wQU8XVqybNXhKjpyO98Qw4Zh1QZ4vfMpll1oZthUIA3uO/x9+16QzgVQiwEva9PJZrCbqnpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116212; c=relaxed/simple;
	bh=kPTxnOUs00xod7SvOA0MjY1iQVs8vACJVhAavlJo42k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmntIbikc4UvHJUi3tSgfCEZFhVp3FqxgBzL+nmFSOFWxzbSu0CoaxUXgUhMn8kOelvlNFv4OYO0NvhivpTUsQpbLvymw1WofYz66m5novzrXudLiknBBZAhwrkf3aysk+o8TF9XxVI4y8TKrJTuzBAJ56+96df0ckbDvcxBYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWErVhr4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWErVhr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707116209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eplNaChWkKbc4FGOknZEiT+FIvGfuXNmIOc00IzYfU8=;
	b=XWErVhr4YMmpkepLAUwVDeArmMmF3ENYblEciUTpbI3bCX1GM2aHlKFYXfiyKT7qNm0Xbw
	W45CaHnak2iBa1ergB+R3ugSKIHTGYTREcKtTaT2H0062vKFgP28qecJH60loZXIkfZwPX
	OnUsDIzdy8UQvUjWUlzB5vI0qP7vz3Y=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-MQtNulPcNK2I5aluYqu21g-1; Mon, 05 Feb 2024 01:56:47 -0500
X-MC-Unique: MQtNulPcNK2I5aluYqu21g-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5993598d215so4647256eaf.1
        for <fstests@vger.kernel.org>; Sun, 04 Feb 2024 22:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116206; x=1707721006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eplNaChWkKbc4FGOknZEiT+FIvGfuXNmIOc00IzYfU8=;
        b=IzmV0T+vJ/XgpLaEW7yCvlu9gMip7avEJ8u+LkXVsjuj2fH3W/76JL7k0UT6HK71OF
         pooyjuhpJC+7Np85VR94BqqQtcF732ISjJJNA9nwq9JeJ3SPuSjtee3b8oPP1lCPfyAR
         qfRKveJIozHOiHE6s0MqZCbFCH33A++DO1aXt5JRyNmKcvd4k2gTeUEguTVitUNl6htB
         n9nOD5aOaqOuj/v0zp0grsBeUVyHhBEzQATYWm1Eyqef4CvPQOJnsvDg+UNPhPqxHFNQ
         zc2DykVbcoiwYtRU1U5NRL5ay8Juq2q3gPU1ncd1kYtrQ0h1vYbTqh536bekQ6ph9SqS
         sjoA==
X-Gm-Message-State: AOJu0YwkL0WIE0KXm1ku1dGh6TkJFmIuFRBMKBVAlqfQPxx2FN2tJHfs
	oT+HAm3P70SD4ZBXgPGIdDYLXguHXP/+YD8CgTLgS5WRSpg9+kbSltICkVMFudTWZWptN437Xc8
	teIgwiNjSjrfstCFdibASpZerAc+/54NFYi4RK8Y/SD7Oxq89aOIZX/94unHsBzUPri+ZyZhT8+
	8Xi7Lw620KafBhkNg+DMTbWmc0bIQbabDx8TLgkg==
X-Received: by 2002:a05:6358:3408:b0:176:55c4:ad94 with SMTP id h8-20020a056358340800b0017655c4ad94mr10115161rwd.8.1707116206525;
        Sun, 04 Feb 2024 22:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgE21wz4kHjS+gT2EcDgtZioExJq8idlHiD48aydQJbQHAJXAdjXJfbPxeScS2dnadKVZ6+Q==
X-Received: by 2002:a05:6358:3408:b0:176:55c4:ad94 with SMTP id h8-20020a056358340800b0017655c4ad94mr10115150rwd.8.1707116206097;
        Sun, 04 Feb 2024 22:56:46 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c37-20020a631c25000000b005d8b8efac4csm6292396pgc.85.2024.02.04.22.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:56:45 -0800 (PST)
Date: Mon, 5 Feb 2024 14:56:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
Message-ID: <20240205065642.3hqhipmnxkg442kg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205061626.mve2cp5btbpiijgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205061626.mve2cp5btbpiijgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Feb 05, 2024 at 02:16:26PM +0800, Zorro Lang wrote:
> On Mon, Feb 05, 2024 at 02:00:16PM +0800, Zorro Lang wrote:
> > On Mon, Feb 05, 2024 at 01:45:02PM +0800, Zorro Lang wrote:
> > > On Sun, Feb 04, 2024 at 10:48:47PM +0800, Zorro Lang wrote:
> > > > Hi all,
> > > > 
> > > > The for-next branch of the xfstests repository at:
> > > > 
> > > > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > > 
> > > > has just been updated and tagged as v2024.02.04 release.
> > > > 
> > > > Release Notes:
> > > > 1) There's 4 new test cases in this release -- btrfs/310, generic/740, xfs/601,
> > > >    and xfs/606.
> > > > 2) btrfs/303 is removed.
> > > > 3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_metadump_tests
> > > >    new file (might be renamed to common/metadump if more other fs need).
> > > > 4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, welcome more
> > > >    updates for more filesystems.
> > > > 5) Some updates/fixes for source building, if anyone find building issues in
> > > >    this release, please report to us.
> > > > 
> > > > More details refer to below, thanks for all your contributions!
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > The new head of the for-next branch is commit:
> > > > 
> > > > 9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > > > 
> > > > New commits ([N]ew, [U]pdate, [D]elete):
> > > > 
> > > > Alexander Aring (1):
> > > > [N]      [56625c897fd9] generic: add fcntl lock corner cases tests
> > > > 
> > > > Anthony Iliopoulos (2):
> > > > [U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro definition
> > > > [U]      [79d98d94e58c] build: remove unused m4 macros
> > > > 
> > > > Boris Burkov (1):
> > > > [D]      [a6e196af46cc] btrfs: Remove btrfs/303
> > > > 
> > > > Darrick J. Wong (10):
> > > > [U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_FACTOR
> > > > [U]      [8c8be04c1065] common/xfs: simplify maximum metadump format detection
> > > > [U]      [42f797643529] common/populate: always metadump full metadata blocks
> > > > [U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadump call
> > > > [N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
> > > > [U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v1 testing with external devices
> > > > [U]      [329671426287] xfs/503: test metadump obfuscation, not progressbars
> > > > [N]      [c31a500edc04] xfs/503: split copy and metadump into two tests
> > > > [U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestore for v2 metadumps
> > > > [U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform removal in 6.8
> > > 
> > > Note: A regression problem on this release sometimes after running xfs/605 or
> > > xfs/129, it only affect XFS testing, it might kill all later testing, I'm
> > > looking into it, and fix ASAP, please linux-xfs don't not update to this
> > > release temporarily, wait for a fix. Sorry for this trouble.
> > 
> > !!! It's a critical dangerous bug! Please don't use this release on xfs testing, it might
> > kill your system!
> > 
> > The problem comes from common/xfs_metadump_tests:_cleanup_verify_metadump():
> > 
> >    rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*
> > 
> > The XFS_METADUMP_FILE and XFS_METADUMP_IMG are set in _setup_verify_metadump(), but
> > if the _setup_verify_metadump isn't called due to someone case _notrun before calling
> > it, its _cleanup will still do _cleanup_verify_metadump, likes this:
> > 
> >   _cleanup()
> >   {
> >         cd /
> >         rm -r -f $tmp.*
> >         _cleanup_verify_metadump
> > 
> > Then boooomb, it does "rm -f *" in "/" .... The "*" after "rm" must be written
> > carefully. I'll send a patch to fix this problem soon, please don't update
> > fstests until the fix be merged.
> 
> I decide to make a respin, I think this bug is dangerous enough due to it might kill
> the whole testing system. If someone use fstests without the fix, that's too dangerous.
> 
> I think most of people haven't shifted to the new release, and this version hasn't
> been merged into master branch. So I decide to do a respin with a manually fix to
> avoid this problem ASAP. Then we can do more jobs later. Sorry for this trouble,
> hope it hasn't affected you.

I've reset the for-next branch to last v2024.01.14 version. Please don't worry, the
patches already got RVBs are in my local branch, I'll make a new release in this
week soon, after some discussion and testing.

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
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > Jeff Layton (2):
> > > > [U]      [ab217141c2fb] common/rc: NFSv2/3 do not support negative timestamps
> > > > [U]      [6c7f9b29e71d] src/t_mtab.c: increase the lock timeout to 120s
> > > > 
> > > > Li Zhijian (1):
> > > > [U]      [0160ab05979d] gitignore: Add missing /src/t_reflink_read_race
> > > > 
> > > > Pavel Reichl (1):
> > > > [U]      [f681ebf32b24] xfs/598: Add missing "fixed_by" hints
> > > > 
> > > > Qu Wenruo (1):
> > > > [N]      [dfdd248c648a] btrfs: verify the read behavior of compressed inline extent
> > > > 
> > > > Richard Weinberger (2):
> > > > [U]      [98dcd8c239d8] generic/020: Compute correct max_attrs for UBIFS
> > > > [U]      [1cf74a17a74e] generic/597,598: Require groups
> > > > 
> > > > Ritesh Harjani (IBM) (1):
> > > > [U]      [4cc6188cd89f] xfs/604: Make test as _notrun for higher blocksizes filesystem
> > > > 
> > > > Su Yue (2):
> > > > [U]      [eca4b512935a] fstests: introduce MKFS_BCACHEFS_PROG for bcachefs
> > > > [U]      [cbde2e1269dc] common/rc: improve block_size support for bcachefs
> > > > 
> > > > Yang Xu (1):
> > > > [U]      [9b63adb69add] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
> > > > 
> > > > Zorro Lang (1):
> > > > [N]      [fb013bd945b8] xfs: test xfs_growfs with too-small size expansion
> > > > 
> > > > 
> > > > Code Diffstat:
> > > > 
> > > >  .gitignore                         |   1 +
> > > >  acinclude.m4                       |   5 -
> > > >  common/config                      |   4 +-
> > > >  common/populate                    |   2 +-
> > > >  common/rc                          |  63 ++++++--
> > > >  common/ubifs                       |   9 ++
> > > >  common/xfs                         |  51 +++++-
> > > >  common/xfs_metadump_tests          | 138 ++++++++++++++++
> > > >  configure.ac                       |   2 +-
> > > >  m4/manual_format.m4                |  17 --
> > > >  m4/package_libcdev.m4              |  95 -----------
> > > >  m4/package_ncurses.m4              |  27 ----
> > > >  m4/package_pthread.m4              |  19 ---
> > > >  m4/package_types.m4                |  50 ------
> > > >  m4/package_xfslibs.m4              |  28 ----
> > > >  m4/visibility_hidden.m4            |  22 ---
> > > >  src/Makefile                       |   2 +-
> > > >  src/af_unix.c                      |   2 -
> > > >  src/fcntl_lock_corner_tests.c      | 322 +++++++++++++++++++++++++++++++++++++
> > > >  src/t_mtab.c                       |   2 +-
> > > >  src/t_snapshot_deleted_subvolume.c |  10 +-
> > > >  tests/btrfs/303                    |  77 ---------
> > > >  tests/btrfs/303.out                |   2 -
> > > >  tests/btrfs/310                    |  83 ++++++++++
> > > >  tests/btrfs/310.out                |   2 +
> > > >  tests/generic/020                  |   6 +
> > > >  tests/generic/256                  |   7 +
> > > >  tests/generic/597                  |   2 +
> > > >  tests/generic/598                  |   2 +
> > > >  tests/generic/740                  |  27 ++++
> > > >  tests/generic/740.out              |   2 +
> > > >  tests/xfs/122.out                  |   2 +
> > > >  tests/xfs/129                      |  91 +----------
> > > >  tests/xfs/234                      |  92 +----------
> > > >  tests/xfs/253                      |  90 +----------
> > > >  tests/xfs/284                      |   4 +-
> > > >  tests/xfs/291                      |  32 ++--
> > > >  tests/xfs/336                      |   2 +-
> > > >  tests/xfs/432                      |  31 +---
> > > >  tests/xfs/503                      |  82 ++--------
> > > >  tests/xfs/503.out                  |   6 +-
> > > >  tests/xfs/598                      |   5 +
> > > >  tests/xfs/601                      |  54 +++++++
> > > >  tests/xfs/601.out                  |   4 +
> > > >  tests/xfs/604                      |   4 +-
> > > >  tests/xfs/605                      |  92 +----------
> > > >  tests/xfs/606                      |  56 +++++++
> > > >  tests/xfs/606.out                  |   2 +
> > > >  48 files changed, 887 insertions(+), 843 deletions(-)
> > > > --
> > > > Zorro Lang
> > > > zlang@kernel.org
> > > 
> > > 

