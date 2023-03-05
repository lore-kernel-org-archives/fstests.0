Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F940C678DB
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Mar 2023 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjCEPUL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Mar 2023 10:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCEPUK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Mar 2023 10:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDC12076
        for <fstests@vger.kernel.org>; Sun,  5 Mar 2023 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678029561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=QDdw0wOFTcUnvxZw5pOTmCkFxGA+pIiWCbIuIen6I2k=;
        b=Lj28lg7Ma89HtJRhHtTY7oDXLi2O8/DPeHF3k8CK4zI1cdUdKZkeHFIqjy0zuxne7a78W0
        mnEHMjyJ8PwcZhwWJ0sv60qWKP9BQwD/l2NFSHbSoaTI33uAC82rymNK10zTLqKUpd8aCT
        t19YveGpYyJAZteT2iyc6RbaL62GA0Q=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-CNogQmDpMpCSEizJNC1Riw-1; Sun, 05 Mar 2023 10:19:20 -0500
X-MC-Unique: CNogQmDpMpCSEizJNC1Riw-1
Received: by mail-pf1-f200.google.com with SMTP id h1-20020a62de01000000b005d943b97706so4039021pfg.0
        for <fstests@vger.kernel.org>; Sun, 05 Mar 2023 07:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678029559;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDdw0wOFTcUnvxZw5pOTmCkFxGA+pIiWCbIuIen6I2k=;
        b=1kTl7K0Ba/v228CiKxPD2k/Pd4vMWWfdUkvcRw++i9EEpUF13305bpxWjFbdixMWnv
         ocDeWPGuxr5uUTVkBZBUDksvngkShIk1Io4s8rU64VC4EAnXjPyOCjTzxk4S5fT005ni
         miTca1dtZybI7HRdinocLIwILeUHSMQH4VMMrQ4SxA37yiEWSib1Gc8ZvYk1dnzCao1X
         Hhu6Gps7mmlrU1oCFdW1Crm2PUo2YfA3Of1e6zU4ULMVk/zE2NfKdzoM1BGzUIN64ku+
         KBgnqlaxeQWoSGZ3juVDpXUATsP+6jHpi1wACzr5N+iw/VnT0pTCuP7IkwGCW+CTqTGR
         0fWQ==
X-Gm-Message-State: AO0yUKUKZEVoCeajw5A2pew9QFPB2010l8EsXtE5jzPydcr7QoJJcIyt
        LKX+cLjZafJmi3NzjccW1y4p1Qqsm/VuHR+Et5cJJ7o0lCfTfpRDa4bvjx5y2eafRLwm76q/kne
        YdAZAiGO6bQH/wjCE6bdZEzmAtS6AXNAdsyzBnKaP0/wmHvOwZWh58jN5MX0XGQxfFSSnjRDmp6
        ag
X-Received: by 2002:a17:903:1245:b0:19b:fed:2257 with SMTP id u5-20020a170903124500b0019b0fed2257mr8091227plh.26.1678029558927;
        Sun, 05 Mar 2023 07:19:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8H9Z0VAeWHuST2BHXD0of/0ZCIe/NtLhyDGq2nM1T0K4xR77wYR3FvPCMuWAvLzE519MoBIw==
X-Received: by 2002:a17:903:1245:b0:19b:fed:2257 with SMTP id u5-20020a170903124500b0019b0fed2257mr8091204plh.26.1678029558450;
        Sun, 05 Mar 2023 07:19:18 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id km12-20020a17090327cc00b0019e30e3068bsm4903620plb.168.2023.03.05.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:19:17 -0800 (PST)
Date:   Sun, 5 Mar 2023 23:19:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.02.26 onto master branch
Message-ID: <20230305151914.b3xiswmj3e3ocy5n@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

        git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.02.26 version.

Thanks,
Zorro

The new head of the master branch is commit:

b90914dfe3f6 btrfs: add test case for NODATASUM dev-replace

New commits:

Boris Burkov (1):
      [744a8a6be38f] generic: add test for direct io partial writes

Darrick J. Wong (29):
      [d2d5c14fd903] fuzzy: disable per-field random fuzzing by default
      [f55dcea33c74] fuzzy: disable timstamp fuzzing by default
      [2f1f8b021962] fuzzy: don't fuzz the log sequence number
      [a43c716cef2f] fuzzy: don't fuzz obsolete inode fields
      [d770ca9284ba] fuzzy: don't fuzz inode generation numbers
      [c749874cf664] fuzzy: don't fuzz user-controllable inode flags
      [570bd5166512] fuzzy: don't fuzz xattr namespace flags and values
      [bb43106508f4] common/fuzzy: split out each repair strategy into a separate helper
      [19327c1a0ed3] common/fuzzy: add an underline to the full log between sections
      [11c44462c122] common/fuzzy: hoist the post-repair fs modification step
      [d60448eb283c] common/fuzzy: fix some problems with the online repair strategy
      [c3f3b3514831] common/fuzzy: fix some problems with the offline repair strategy
      [7a274f7626c0] common/fuzzy: fix some problems with the no-repair strategy
      [3a564b1f41d3] common/fuzzy: fix some problems with the online-then-offline repair strategy
      [f23ca0f1fa1a] common/fuzzy: fix some problems with the post-repair fs modification code
      [f32c97fc8227] xfs/{35[45],455}: fix bogus corruption errors
      [ac214bb2ddbe] common/fuzzy: evaluate xfs_check vs xfs_repair
      [a27e6e6f4c18] common: check xfs health after doing an online scrub
      [9bab148bb3c7] common/fuzzy: exercise the filesystem a little harder after repairing
      [b2ebcdb1142a] fuzzy: dump metadata state before fuzzing
      [94b5a2d3e563] fuzzy: compress coredumps created while fuzzing
      [8dfdfd75ea7e] fuzzy: report the fuzzing repair strategy in seqres.full
      [6b5b9b1e6fc2] xfs: improve metadata array field handling when fuzzing
      [c63c8677b97a] fuzzy: for fuzzing ag btrees, find the path to the AG header
      [4e68804d55f7] fuzzy: test fuzzing directory block mappings
      [0c8d58ca30e1] fuzzy: test fuzzing xattr block mappings
      [58a1bf3c0c52] fuzzy: test fuzzing realtime free space metadata
      [53065fa4dccc] xfs: fuzz test both repair strategies
      [84755fddc8bd] fuzzy: fuzz test key/pointers of inode btrees

Gabriel Niebler (1):
      [d33bf05dd985] README: Add section to install required packages on (open)SUSE

Leah Rumancik (1):
      [e4561119eb12] selftest: add tests for debugging testing setup

Qu Wenruo (1):
      [b90914dfe3f6] btrfs: add test case for NODATASUM dev-replace


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

