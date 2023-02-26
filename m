Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D702FC6FA8E
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Feb 2023 15:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBZPaU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Feb 2023 10:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBZPaG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Feb 2023 10:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1CCC29
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677425045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=1p9GZikoR7dTXd5VlVI0alhuXQK4rIWsUNO6ChfGWoA=;
        b=aNF8XNiNxpIvqLMmXSFLkhqydaLbi9dFxWEMXJjhuxu0p5WgIKadupNRcQ4f0d0J0MRjpJ
        TDwmhkmSSTw7fmGSsUB3hSh+Hgf979P/8mdiuSYpTQJWhkVCfBN4BhkNOdjoR4V//f9pHm
        GpuTRcCTfAtZVg5WtKiSHi4Pdv/LxQk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-Cf4SOysmODa5wxjgwPmZyw-1; Sun, 26 Feb 2023 10:24:03 -0500
X-MC-Unique: Cf4SOysmODa5wxjgwPmZyw-1
Received: by mail-pg1-f200.google.com with SMTP id 10-20020a63030a000000b004fb64e929f2so843986pgd.7
        for <fstests@vger.kernel.org>; Sun, 26 Feb 2023 07:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p9GZikoR7dTXd5VlVI0alhuXQK4rIWsUNO6ChfGWoA=;
        b=apbF/fbOwAMUDtdUajwRMr/MXtFZTYmd8ii/0A/tAwQckNKzxiEmIVkQho4ybBOibw
         insWlOKq485nzMyaD8hTIxCwINZpkzmuMIkGVq8678aQ1bQ1lp/wzvlV92A4zDBb46Gb
         bmWsKoF5FmxjL5TVQsiZcHpYKrgGn7Z4SQc43jzHX5ZgPkdym03JhKBRpCLNmyNyxg9I
         IYZyyKz0WfIl7u8OhBA8vo2n3rz1ZGhpsw2Z5B6uHYXxfaP5rU6Ga9/FT8pFG1vWnven
         zMN51EMytok0NIjBVFwPwFLVEAX+F91Rhh8VC6GhjWr6gTJJX5qAAMXM0Ga+jtpj1bBy
         GluQ==
X-Gm-Message-State: AO0yUKWS5MR8cuvlSdRMZMkTeAJMu/FP3qGt/7pUpmZ72lX4MYoaqVDI
        xE135e7roCrz+JozTk95Qrj/L9DpX8OrAc5wJbIxE90ByAo2ZCBPMyw7pLfjyvBZeBSL0owQVL8
        SpPpfUXKuMxMzQQw1achZUHwgaA6wr3/D+9pJWmTh74/Ma1N+lLpELinp7EGJSv41pAoGU1/5qw
        ==
X-Received: by 2002:a05:6a20:1585:b0:bf:a1c:3ff0 with SMTP id h5-20020a056a20158500b000bf0a1c3ff0mr22328386pzj.52.1677425041809;
        Sun, 26 Feb 2023 07:24:01 -0800 (PST)
X-Google-Smtp-Source: AK7set+fNagOM6UxDI+lkB4yWPw92SPtXeVpeowIZebvTsIeyq16l4f3yUAgafrZwIReHxUp/l0Jig==
X-Received: by 2002:a05:6a20:1585:b0:bf:a1c:3ff0 with SMTP id h5-20020a056a20158500b000bf0a1c3ff0mr22328364pzj.52.1677425041337;
        Sun, 26 Feb 2023 07:24:01 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x10-20020aa784ca000000b005df98092e84sm2602929pfn.22.2023.02.26.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 07:24:00 -0800 (PST)
Date:   Sun, 26 Feb 2023 23:23:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.02.26
Message-ID: <20230226152357.mi3scgk52yfl7ydi@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.02.26 release.

Release notes:
1) There're 64 new test cases in this release, include ...
    - The generic/708 and btrfs/286 are in auto group.
    - The selftest/001~006 are for fstests selftest, they're not used for fs
      testing, won't be run with other cases together.
    - The xfs/733~788 are not in auto group, they're xfs fuzzy test cases.
2) README file is updated, about how to install fstests on SUSE system.
3) A new README.selftest file is about how to run fstests selftest.

More updates refer to below, thanks for all these contribution.

Thanks,
Zorro

The new head of the for-next branch is commit:

b90914dfe3f6 btrfs: add test case for NODATASUM dev-replace

New commits:

Boris Burkov (1):
[N]      [744a8a6be38f] generic: add test for direct io partial writes

Darrick J. Wong (29):
[U]      [d2d5c14fd903] fuzzy: disable per-field random fuzzing by default
[U]      [f55dcea33c74] fuzzy: disable timstamp fuzzing by default
[U]      [2f1f8b021962] fuzzy: don't fuzz the log sequence number
[U]      [a43c716cef2f] fuzzy: don't fuzz obsolete inode fields
[U]      [d770ca9284ba] fuzzy: don't fuzz inode generation numbers
[U]      [c749874cf664] fuzzy: don't fuzz user-controllable inode flags
[U]      [570bd5166512] fuzzy: don't fuzz xattr namespace flags and values
[U]      [bb43106508f4] common/fuzzy: split out each repair strategy into a separate helper
[U]      [19327c1a0ed3] common/fuzzy: add an underline to the full log between sections
[U]      [11c44462c122] common/fuzzy: hoist the post-repair fs modification step
[U]      [d60448eb283c] common/fuzzy: fix some problems with the online repair strategy
[U]      [c3f3b3514831] common/fuzzy: fix some problems with the offline repair strategy
[U]      [7a274f7626c0] common/fuzzy: fix some problems with the no-repair strategy
[U]      [3a564b1f41d3] common/fuzzy: fix some problems with the online-then-offline repair strategy
[U]      [f23ca0f1fa1a] common/fuzzy: fix some problems with the post-repair fs modification code
[U]      [f32c97fc8227] xfs/{35[45],455}: fix bogus corruption errors
[U]      [ac214bb2ddbe] common/fuzzy: evaluate xfs_check vs xfs_repair
[U]      [a27e6e6f4c18] common: check xfs health after doing an online scrub
[U]      [9bab148bb3c7] common/fuzzy: exercise the filesystem a little harder after repairing
[U]      [b2ebcdb1142a] fuzzy: dump metadata state before fuzzing
[U]      [94b5a2d3e563] fuzzy: compress coredumps created while fuzzing
[U]      [8dfdfd75ea7e] fuzzy: report the fuzzing repair strategy in seqres.full
[U]      [6b5b9b1e6fc2] xfs: improve metadata array field handling when fuzzing
[U]      [c63c8677b97a] fuzzy: for fuzzing ag btrees, find the path to the AG header
[N]      [4e68804d55f7] fuzzy: test fuzzing directory block mappings
[N]      [0c8d58ca30e1] fuzzy: test fuzzing xattr block mappings
[N]      [58a1bf3c0c52] fuzzy: test fuzzing realtime free space metadata
[N]      [53065fa4dccc] xfs: fuzz test both repair strategies
[N]      [84755fddc8bd] fuzzy: fuzz test key/pointers of inode btrees

Gabriel Niebler (1):
[U]      [d33bf05dd985] README: Add section to install required packages on (open)SUSE

Leah Rumancik (1):
[N]      [e4561119eb12] selftest: add tests for debugging testing setup

Qu Wenruo (1):
[N]      [b90914dfe3f6] btrfs: add test case for NODATASUM dev-replace


Code Diffstat:

 .gitignore              |   1 +
 README                  |  20 ++
 README.selftest         |  29 +++
 common/fuzzy            | 636 +++++++++++++++++++++++++++++++++++++++---------
 common/xfs              |  80 ++++++
 doc/group-names.txt     |   2 +
 src/Makefile            |   2 +-
 src/dio-buf-fault.c     |  83 +++++++
 tests/btrfs/286         |  78 ++++++
 tests/btrfs/286.out     |   2 +
 tests/generic/708       |  37 +++
 tests/generic/708.out   |   2 +
 tests/selftest/001      |  13 +
 tests/selftest/001.out  |   2 +
 tests/selftest/002      |  13 +
 tests/selftest/002.out  |   2 +
 tests/selftest/003      |  15 ++
 tests/selftest/003.out  |   2 +
 tests/selftest/004      |  15 ++
 tests/selftest/004.out  |   2 +
 tests/selftest/005      |  16 ++
 tests/selftest/005.out  |   2 +
 tests/selftest/006      |  19 ++
 tests/selftest/006.out  |   2 +
 tests/selftest/Makefile |  24 ++
 tests/xfs/354           |   7 +-
 tests/xfs/355           |   7 +-
 tests/xfs/358           |   5 +-
 tests/xfs/359           |   5 +-
 tests/xfs/360           |   5 +-
 tests/xfs/361           |   5 +-
 tests/xfs/362           |   5 +-
 tests/xfs/363           |   5 +-
 tests/xfs/364           |   5 +-
 tests/xfs/365           |   5 +-
 tests/xfs/366           |   5 +-
 tests/xfs/367           |   5 +-
 tests/xfs/368           |   5 +-
 tests/xfs/369           |   5 +-
 tests/xfs/370           |   5 +-
 tests/xfs/371           |   5 +-
 tests/xfs/372           |   5 +-
 tests/xfs/373           |   7 +-
 tests/xfs/410           |   5 +-
 tests/xfs/411           |   5 +-
 tests/xfs/455           |   7 +-
 tests/xfs/457           |   5 +-
 tests/xfs/458           |   5 +-
 tests/xfs/459           |   5 +-
 tests/xfs/460           |   5 +-
 tests/xfs/461           |   5 +-
 tests/xfs/462           |   5 +-
 tests/xfs/463           |   5 +-
 tests/xfs/464           |   7 +-
 tests/xfs/483           |   5 +-
 tests/xfs/733           |  48 ++++
 tests/xfs/733.out       |  10 +
 tests/xfs/734           |  48 ++++
 tests/xfs/734.out       |  10 +
 tests/xfs/735           |  48 ++++
 tests/xfs/735.out       |  10 +
 tests/xfs/736           |  48 ++++
 tests/xfs/736.out       |  10 +
 tests/xfs/737           |  48 ++++
 tests/xfs/737.out       |  10 +
 tests/xfs/738           |  48 ++++
 tests/xfs/738.out       |  10 +
 tests/xfs/739           |  41 ++++
 tests/xfs/739.out       |   4 +
 tests/xfs/740           |  41 ++++
 tests/xfs/740.out       |   4 +
 tests/xfs/741           |  41 ++++
 tests/xfs/741.out       |   4 +
 tests/xfs/742           |  41 ++++
 tests/xfs/742.out       |   4 +
 tests/xfs/743           |  42 ++++
 tests/xfs/743.out       |   4 +
 tests/xfs/744           |  42 ++++
 tests/xfs/744.out       |   4 +
 tests/xfs/745           |  41 ++++
 tests/xfs/745.out       |   4 +
 tests/xfs/746           |  41 ++++
 tests/xfs/746.out       |   4 +
 tests/xfs/747           |  35 +++
 tests/xfs/747.out       |   4 +
 tests/xfs/748           |  35 +++
 tests/xfs/748.out       |   4 +
 tests/xfs/749           |  45 ++++
 tests/xfs/749.out       |   6 +
 tests/xfs/750           |  35 +++
 tests/xfs/750.out       |   4 +
 tests/xfs/751           |  38 +++
 tests/xfs/751.out       |   4 +
 tests/xfs/752           |  38 +++
 tests/xfs/752.out       |   4 +
 tests/xfs/753           |  38 +++
 tests/xfs/753.out       |   4 +
 tests/xfs/754           |  38 +++
 tests/xfs/754.out       |   4 +
 tests/xfs/755           |  39 +++
 tests/xfs/755.out       |   4 +
 tests/xfs/756           |  39 +++
 tests/xfs/756.out       |   4 +
 tests/xfs/757           |  39 +++
 tests/xfs/757.out       |   4 +
 tests/xfs/758           |  40 +++
 tests/xfs/758.out       |   4 +
 tests/xfs/759           |  40 +++
 tests/xfs/759.out       |   5 +
 tests/xfs/760           |  40 +++
 tests/xfs/760.out       |   5 +
 tests/xfs/761           |  40 +++
 tests/xfs/761.out       |   5 +
 tests/xfs/762           |  42 ++++
 tests/xfs/762.out       |   5 +
 tests/xfs/763           |  40 +++
 tests/xfs/763.out       |   5 +
 tests/xfs/764           |  40 +++
 tests/xfs/764.out       |   5 +
 tests/xfs/765           |  40 +++
 tests/xfs/765.out       |   5 +
 tests/xfs/766           |  41 ++++
 tests/xfs/766.out       |   5 +
 tests/xfs/767           |  42 ++++
 tests/xfs/767.out       |   5 +
 tests/xfs/768           |  42 ++++
 tests/xfs/768.out       |   5 +
 tests/xfs/769           |  42 ++++
 tests/xfs/769.out       |   5 +
 tests/xfs/770           |  42 ++++
 tests/xfs/770.out       |   5 +
 tests/xfs/771           |  40 +++
 tests/xfs/771.out       |   5 +
 tests/xfs/772           |  40 +++
 tests/xfs/772.out       |   5 +
 tests/xfs/773           |  40 +++
 tests/xfs/773.out       |   5 +
 tests/xfs/774           |  40 +++
 tests/xfs/774.out       |   5 +
 tests/xfs/775           |  40 +++
 tests/xfs/775.out       |   4 +
 tests/xfs/776           |  40 +++
 tests/xfs/776.out       |   5 +
 tests/xfs/777           |  40 +++
 tests/xfs/777.out       |   5 +
 tests/xfs/778           |  40 +++
 tests/xfs/778.out       |   5 +
 tests/xfs/779           |  38 +++
 tests/xfs/779.out       |   4 +
 tests/xfs/780           |  38 +++
 tests/xfs/780.out       |   4 +
 tests/xfs/781           |  38 +++
 tests/xfs/781.out       |   4 +
 tests/xfs/782           |  41 ++++
 tests/xfs/782.out       |   5 +
 tests/xfs/783           |  49 ++++
 tests/xfs/783.out       |  10 +
 tests/xfs/784           |  49 ++++
 tests/xfs/784.out       |  10 +
 tests/xfs/785           |  36 +++
 tests/xfs/785.out       |   4 +
 tests/xfs/786           |  36 +++
 tests/xfs/786.out       |   4 +
 tests/xfs/787           |  38 +++
 tests/xfs/787.out       |   4 +
 tests/xfs/788           |  37 +++
 tests/xfs/788.out       |   4 +
 167 files changed, 3697 insertions(+), 144 deletions(-)
--
Zorro Lang
zlang@kernel.org

