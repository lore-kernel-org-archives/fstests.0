Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D07CE7A8A
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Sep 2023 15:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjIXPQt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Sep 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIXPQs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Sep 2023 11:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A2FFD
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2023 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695568601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=9GwWvlXYkgcC89ljX5OuVItnEqMAYozS6l7LsuY5VUA=;
        b=VQcQMk7dH6l2lPN6FuUGyRl4xoqmEaCyec2gCj3Bj4C/4Hv+wCQEVW02VSgHZUHRFygygs
        YPG1pJLopjjZFLZ6cCzyxLLhnxhnec+AqJKlUE+EgEF6ewKGmDBiGfxRVasqAe+ypQKS7e
        w3CgCBq3d8Y5p7a6Kq7K3vwSXaAMNkY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-eBuPb7IcMWaVLdmpa2cvqA-1; Sun, 24 Sep 2023 11:16:38 -0400
X-MC-Unique: eBuPb7IcMWaVLdmpa2cvqA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3aa1254fb00so10843679b6e.1
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2023 08:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695568597; x=1696173397;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GwWvlXYkgcC89ljX5OuVItnEqMAYozS6l7LsuY5VUA=;
        b=PM0ItvybUl4UYHlP0SQddKCKtCA2XHroPVM0u7hRcXcE7TZ3scWMZ6LMpv1Als3Yx5
         gT5iLk4oRYGhWG1kwtOheQFyNfbnI0SESDb4GDL9Mnx5sJ8WPezNC1C2ZggCdhlwsBfW
         V2YqUrYrLoOdVX6jsLcfJofdJCIwWlfVGSqyjRFP4K1xSTQE8YuXbcWSwZUwF9k5eI/H
         WZcMbu7VCYbaTJtoiRg+pLdfgTqanYl6qJD5sEmneCiwmulQmZvzH5dFY85pOpB1X0r6
         sBqgxCN60Qb84mRXDosaJMqXX4YZc+16Vg20YdPD3blZOqPtWILghEL+iBaPftSs27dj
         rWWg==
X-Gm-Message-State: AOJu0YyWZg5Hp4hKJy97jiWMISRU47YUaklVj6oJ16Nep36iPYXK8Ye8
        9IL0UTYFT0O4DcKt1+ryPaX0mTEAFTsM1gcRhdf8c7zGkKvvjLL8aRT9ENQcdlCgXdLFFK5TsDZ
        6FNmlKvwxl3iD7l1OOrkVAGaNWxww2TInA7oaiFJnmF+ldNgA/R/hzeFSyO9qMR3OKZriy8cu2d
        KW
X-Received: by 2002:a54:449a:0:b0:3ad:ffa4:e003 with SMTP id v26-20020a54449a000000b003adffa4e003mr5284835oiv.33.1695568597233;
        Sun, 24 Sep 2023 08:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLZxgt/KjAp6Ynx8pGgX++2f5OifJUicoJwPgBKjnfysxHS/6iXbGczIH7Rjz8scb4l/oKrw==
X-Received: by 2002:a54:449a:0:b0:3ad:ffa4:e003 with SMTP id v26-20020a54449a000000b003adffa4e003mr5284820oiv.33.1695568596908;
        Sun, 24 Sep 2023 08:16:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm6380364pff.1.2023.09.24.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 08:16:36 -0700 (PDT)
Date:   Sun, 24 Sep 2023 23:16:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.09.24
Message-ID: <20230924151633.s2hvilhahqaykods@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.09.24 release.

Release Notes:
1) There's 3 new cases in this release -- overlay/081, overlay/082 and
   generic/471. They're all regression test cases for known overlay or
   btrfs issue. They'll fail on old downstream kernel, but won't crash.
2) Besides new test cases, xfs/270 has new bug coverage, so it'll fail
   on unfixed kernel, note that it's not a regression, don't panic.
3) Btrfs fixes some test failures, and update some known kernel commit id
   in cases.

More details refer to below, thanks for these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

2fddeb5c79ff btrfs/287: filter snapshot IDs to avoid failures when using some features

New commits:

Amir Goldstein (2):
[N]      [6f5c1dcbb723] overlay: add test for persistent unique fsid
[N]      [823613d66648] overlay: add test for rename of lower symlink with NOATIME attr

Anand Jain (5):
[U]      [2da0d2692c94] fstests: use btrfs check repair for repairing btrfs filesystems
[U]      [8abf8a203a9e] fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
[U]      [1348ed0e256a] fstests: btrfs/185 update for single device pseudo device-scan
[U]      [79650397e1d1] fstests: btrfs add more tests into the scrub group
[U]      [e3121832fc2b] btrfs: add missing _fixed_by_kernel_commit for a few tests

Andrey Albershteyn (1):
[U]      [566fc79138ef] common/rc: make _get_max_file_size find file size on mount point

Darrick J. Wong (2):
[U]      [d79d44afac69] xfs/270: actually test file readability
[U]      [5267463070c5] xfs/270: actually test log recovery with unknown rocompat features

Filipe Manana (4):
[U]      [b1ad2f63105e] btrfs: add missing commit ids for a few tests using _fixed_by_kernel_commit
[N]      [68b958f5dc4a] generic: test new directory entries are returned after rewinding directory
[U]      [70ff4b82ea80] btrfs: use full subcommand name at _btrfs_get_subvolid()
[U]      [2fddeb5c79ff] btrfs/287: filter snapshot IDs to avoid failures when using some features

Naohiro Aota (4):
[U]      [f4c7dbbb4f16] btrfs/076: support smaller extent size limit
[U]      [27f1089cf2e3] btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel commit
[U]      [150670eb9216] btrfs/239: call fsync to create tree-log dedicated block group for zoned mode
[U]      [d6ac854df754] btrfs/259: fix output's wrong word

Shiyang Ruan (1):
[U]      [f738aca836ad] tools/mvtest: ensure testcase is executable (755)


Code Diffstat:

 .gitignore            |   1 +
 common/btrfs          |   6 +-
 common/rc             |  24 +++++++-
 src/Makefile          |   2 +-
 src/rewinddir-test.c  | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/011       |   2 +-
 tests/btrfs/027       |   2 +-
 tests/btrfs/060       |   2 +-
 tests/btrfs/062       |   2 +-
 tests/btrfs/063       |   2 +-
 tests/btrfs/064       |   2 +-
 tests/btrfs/065       |   2 +-
 tests/btrfs/067       |   2 +-
 tests/btrfs/068       |   2 +-
 tests/btrfs/070       |   2 +-
 tests/btrfs/071       |   2 +-
 tests/btrfs/074       |   2 +-
 tests/btrfs/076       |  29 +++++++--
 tests/btrfs/076.out   |   3 +-
 tests/btrfs/148       |   2 +-
 tests/btrfs/185       |   5 +-
 tests/btrfs/195       |   2 +-
 tests/btrfs/199       |   6 +-
 tests/btrfs/216       |   4 +-
 tests/btrfs/218       |   6 +-
 tests/btrfs/225       |   4 +-
 tests/btrfs/238       |   5 +-
 tests/btrfs/239       |  12 ++++
 tests/btrfs/259       |   2 +-
 tests/btrfs/261       |   6 +-
 tests/btrfs/287       |  24 ++++++--
 tests/btrfs/287.out   |  56 +++++++++---------
 tests/btrfs/288       |   2 +-
 tests/btrfs/289       |   2 +-
 tests/btrfs/300       |   2 +-
 tests/generic/299     |   2 +-
 tests/generic/471     |  39 +++++++++++++
 tests/generic/471.out |   2 +
 tests/generic/485     |   2 +-
 tests/generic/692     |   2 +-
 tests/overlay/081     | 128 ++++++++++++++++++++++++++++++++++++++++
 tests/overlay/081.out |   2 +
 tests/overlay/082     |  67 +++++++++++++++++++++
 tests/overlay/082.out |   2 +
 tests/xfs/270         |  82 ++++++++++++++++++--------
 tests/xfs/270.out     |   2 +
 tools/mvtest          |   2 +
 47 files changed, 612 insertions(+), 108 deletions(-)
--
Zorro Lang
zlang@kernel.org

