Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF11E95A82
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Oct 2023 13:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjJHNbx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Oct 2023 09:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHNbw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Oct 2023 09:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94112B6
        for <fstests@vger.kernel.org>; Sun,  8 Oct 2023 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696771863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=0vZR71BZw3BtpydeeYoRRukSicxRJBfOiW+WC/G6e00=;
        b=LOzPM5trDPt+a7XGT1nZOQl4CcQZRNantHt7Ok9uh5QR9uNbot+37L2c/muttbMGz39LmM
        Few3AvGhPd/QJ/eVMWx+FlLjRXeh4BUgM8mermpvacEM47cnxSnrHzsw1S42i0GzkWOiib
        DRmAOAAnkeVS7sbctvhueCUu4Ljn/DE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201--GJkbbxTMVGJz1hZtB1XwA-1; Sun, 08 Oct 2023 09:31:01 -0400
X-MC-Unique: -GJkbbxTMVGJz1hZtB1XwA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27b31ea052dso2354508a91.3
        for <fstests@vger.kernel.org>; Sun, 08 Oct 2023 06:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696771860; x=1697376660;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vZR71BZw3BtpydeeYoRRukSicxRJBfOiW+WC/G6e00=;
        b=uCNddhcBZjZwI1veQMXpBd7BCjiPWMVrNgR4JjluW709tgNF1V+Zxj3g/Eoc4rHG6z
         NekMXtfkohP6lXS7WBCaadoJB4j75sWcsgLWSNciADthFUHILk/KC/3u2Y6k9IMDDYdf
         fZSo2i2A9Y0JNgr6qe8fqPG4RsLFagyJZEPbAi3huKYqfHY109I4t4B2ewr5qFbrzrRt
         C3YdeUtHxl5VieXntEc5BGFVfhTLJsP1TjgpVN9hJDFjFY74ExYqyaYlYNwvXDPOaYXQ
         4MoeQrR4kzz9/yVg2jHjnDRSiePzn/9vEREp/0UFsrxpAUdnZ+uo82JRy8sdwkEGM5u4
         /GUQ==
X-Gm-Message-State: AOJu0YxDbBJQ3qy75a6cM/aKAHDmMlbEfva9nwtvmmPW0M52m1khdLTA
        XvumZny7hJxnfU4lt/f9hWrtv/6GZvCRKvMx/NNzio5YngJf6ylX+dtwWWQb0qBFYnD50i0gMAc
        OW13C855S1ksoo50HdOfcTwGwipF32OtTWQduUlP0sJ5VMGV3kEnoRJ5+10Zf/Ov2rMa+V2TkVm
        b6nKE=
X-Received: by 2002:a17:90b:1a8c:b0:277:37fc:6e85 with SMTP id ng12-20020a17090b1a8c00b0027737fc6e85mr11751328pjb.0.1696771860500;
        Sun, 08 Oct 2023 06:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJnJhM2SAE5Wmb2kmlL+XvYZD+CjUCz/HdlNSqyMBMpYHv9psPy2BvOJhHM/vQX+H770rw0A==
X-Received: by 2002:a17:90b:1a8c:b0:277:37fc:6e85 with SMTP id ng12-20020a17090b1a8c00b0027737fc6e85mr11751310pjb.0.1696771860005;
        Sun, 08 Oct 2023 06:31:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b00278ff752eacsm7104364pji.50.2023.10.08.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 06:30:59 -0700 (PDT)
Date:   Sun, 8 Oct 2023 21:30:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.09.24 onto master branch
Message-ID: <20231008133055.m67n4iujmjgmrb6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.09.24 version.

Thanks,
Zorro

The new head of the master branch is commit:

2fddeb5c79ff btrfs/287: filter snapshot IDs to avoid failures when using some features

New commits:

Amir Goldstein (2):
      [6f5c1dcbb723] overlay: add test for persistent unique fsid
      [823613d66648] overlay: add test for rename of lower symlink with NOATIME attr

Anand Jain (5):
      [2da0d2692c94] fstests: use btrfs check repair for repairing btrfs filesystems
      [8abf8a203a9e] fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
      [1348ed0e256a] fstests: btrfs/185 update for single device pseudo device-scan
      [79650397e1d1] fstests: btrfs add more tests into the scrub group
      [e3121832fc2b] btrfs: add missing _fixed_by_kernel_commit for a few tests

Andrey Albershteyn (1):
      [566fc79138ef] common/rc: make _get_max_file_size find file size on mount point

Darrick J. Wong (2):
      [d79d44afac69] xfs/270: actually test file readability
      [5267463070c5] xfs/270: actually test log recovery with unknown rocompat features

Filipe Manana (4):
      [b1ad2f63105e] btrfs: add missing commit ids for a few tests using _fixed_by_kernel_commit
      [68b958f5dc4a] generic: test new directory entries are returned after rewinding directory
      [70ff4b82ea80] btrfs: use full subcommand name at _btrfs_get_subvolid()
      [2fddeb5c79ff] btrfs/287: filter snapshot IDs to avoid failures when using some features

Naohiro Aota (4):
      [f4c7dbbb4f16] btrfs/076: support smaller extent size limit
      [27f1089cf2e3] btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel commit
      [150670eb9216] btrfs/239: call fsync to create tree-log dedicated block group for zoned mode
      [d6ac854df754] btrfs/259: fix output's wrong word

Shiyang Ruan (1):
      [f738aca836ad] tools/mvtest: ensure testcase is executable (755)


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

