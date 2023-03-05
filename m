Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1595CC678DB
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Mar 2023 15:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCEPZb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Mar 2023 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCEPZa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Mar 2023 10:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5211C664
        for <fstests@vger.kernel.org>; Sun,  5 Mar 2023 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678029887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=KcO9mUNgy5+SLOCS1MKgMZ+aFKQ61EcubKz652VbAKg=;
        b=QvNmtbyaHPEt73rEMsgKw2PW4i4OdzIaEohRr7UQESzO+NEAXsFN21pCvcmgon/fpMWDFd
        COyHr+71IVkPMzHnAFSkdWFkandO1JvzHgHQ7M+vr+Ggvq4XGSRSjPhRfVgWzZXm+AcAkB
        IAb8arYHQSMVu0bFPCpuY0mn47GbzCQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-LVNLbMDmOVSnzz8cMdzGSQ-1; Sun, 05 Mar 2023 10:24:46 -0500
X-MC-Unique: LVNLbMDmOVSnzz8cMdzGSQ-1
Received: by mail-pf1-f198.google.com with SMTP id h14-20020aa786ce000000b005a89856900eso4061872pfo.14
        for <fstests@vger.kernel.org>; Sun, 05 Mar 2023 07:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678029885;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcO9mUNgy5+SLOCS1MKgMZ+aFKQ61EcubKz652VbAKg=;
        b=RcG8YAgJcgsPlrht6tNT3ceHxe+LW5KVLLLG6LbB9ZU3Vaep18PsA4wYjUTkzucp+r
         zy7RfnM5n8SSDEBJgsPuTtJNtBAeA9lSiB/HOGBqD1jfzLXn3F1oUnaLo0q9q8+HG5XB
         2p7dttW8Wql+GnSMRrx2Jdq/h7k47ZV0UdbTMv5qABE/Aj2cvH0zS+K9Qp349mcRHPVw
         N/iC1gLsIMiPHq6IUwqh2Lxwrctm6h78sklgIDaM4WaoSqjmb0t9bCaTuvlTuxDdttaz
         jHA4jqM0EPGcyb78VK9uUeJL2dsPsY/okZMRzH9xrZi9yD/lXUjK9O+2wpZdYshvvJZ9
         d8Iw==
X-Gm-Message-State: AO0yUKUI6mMMJq28rgew8jTsTzGloXzASoAqxVAUS1RcobnW6kSjN3vS
        S4ogU0BQIGxad+lC9Y3XmtG57itODTtoxwJKuYRgQNsfZvoX/FeiSOJU0f2a/+ag5loiGjD/wDz
        wGH5KdxNXyqMShkYfG2+zBA4vWmsK8tqx9yD6fn2kDyQtnQbT5+OpS7Yr33tfxsfPswo5oSA8je
        Qn
X-Received: by 2002:a17:903:11cc:b0:19c:b7da:fbe0 with SMTP id q12-20020a17090311cc00b0019cb7dafbe0mr9572328plh.16.1678029885169;
        Sun, 05 Mar 2023 07:24:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/vqCajHDDrF0Rybxg/3768itTOZEP+VuwgFRj7gnbvQmX+Rd4AkHtYK1Y51mhwG52dw4GMDw==
X-Received: by 2002:a17:903:11cc:b0:19c:b7da:fbe0 with SMTP id q12-20020a17090311cc00b0019cb7dafbe0mr9572305plh.16.1678029884692;
        Sun, 05 Mar 2023 07:24:44 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b0019934030f46sm4869297plf.132.2023.03.05.07.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:24:44 -0800 (PST)
Date:   Sun, 5 Mar 2023 23:24:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.03.05
Message-ID: <20230305152440.zl4pekdo3qjgxxye@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.03.05 release.

Release Notes:
1) There're 29 new cases in this release -- generic/709~727, xfs/789~798.
2) xfs/793~798 are about xfs online_repair test. Besides these cases, others
   are about fiexchange and swapext testing, and all in auto group, but
   need new features of kernel and xfsprogs, so will notrun on old kernel.
3) New FIEXCHANGE_RANGE supporting in fsx and fsstress.

More updates refer to below, thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

f7765774a1b5 generic/020: fix really long attr test failure for ceph

New commits:

Darrick J. Wong (12):
      [e19c99400cfe] xfs/122: fix for swapext log items
      [5d2aea2b1f6d] generic: test old xfs extent swapping ioctl
      [815ea9365230] generic: test new vfs swapext ioctl
      [81cbafc4597a] generic, xfs: test scatter-gather atomic file updates
      [f02d41a7b5ca] generic: test that file privilege gets dropped with FIEXCHANGE_RANGE
      [bf183828b8f4] fsx: support FIEXCHANGE_RANGE
      [ae5ac04996c5] fsstress: update for FIEXCHANGE_RANGE
      [d8cf497797b0] xfs: race fsstress with online repair of realtime summary files
      [a199f989b6f1] xfs: race fsstress with online repair of extended attribute data
      [249f5a78d309] xfs: ensure that online directory repairs don't hit EDQUOT
      [0999380268ab] xfs: race fsstress with online repair of dirs and parent pointers
      [fc0a397e3ec4] xfs: test xfs_scrub dry run, preen, and repair mode

Johannes Thumshirn (1):
      [b3096c996a48] common/rc: don't clear superblock for zoned scratch pools

Xiubo Li (1):
      [f7765774a1b5] generic/020: fix really long attr test failure for ceph


Code Diffstat:

 common/rc             |  36 ++++++++++-
 common/reflink        |  33 ++++++++++
 common/xfs            |  19 ++++++
 configure.ac          |   1 +
 doc/group-names.txt   |   2 +
 include/builddefs.in  |   1 +
 ltp/Makefile          |   4 ++
 ltp/fsstress.c        | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
 ltp/fsx.c             | 160 ++++++++++++++++++++++++++++++++++++++++++++++-
 m4/package_libcdev.m4 |  20 ++++++
 src/fiexchange.h      | 101 ++++++++++++++++++++++++++++++
 src/global.h          |   6 ++
 tests/generic/020     |   6 +-
 tests/generic/709     |  55 +++++++++++++++++
 tests/generic/709.out |   3 +
 tests/generic/710     |  53 ++++++++++++++++
 tests/generic/710.out |   4 ++
 tests/generic/711     |  47 ++++++++++++++
 tests/generic/711.out |   2 +
 tests/generic/712     |  58 +++++++++++++++++
 tests/generic/712.out |   2 +
 tests/generic/713     | 100 ++++++++++++++++++++++++++++++
 tests/generic/713.out |  86 ++++++++++++++++++++++++++
 tests/generic/714     | 116 ++++++++++++++++++++++++++++++++++
 tests/generic/714.out |  90 +++++++++++++++++++++++++++
 tests/generic/715     |  76 +++++++++++++++++++++++
 tests/generic/715.out |  32 ++++++++++
 tests/generic/716     | 122 ++++++++++++++++++++++++++++++++++++
 tests/generic/716.out |  48 +++++++++++++++
 tests/generic/717     | 101 ++++++++++++++++++++++++++++++
 tests/generic/717.out |  33 ++++++++++
 tests/generic/718     |  48 +++++++++++++++
 tests/generic/718.out |   6 ++
 tests/generic/719     | 105 +++++++++++++++++++++++++++++++
 tests/generic/719.out |  40 ++++++++++++
 tests/generic/720     |  58 +++++++++++++++++
 tests/generic/720.out |   2 +
 tests/generic/721     | 126 +++++++++++++++++++++++++++++++++++++
 tests/generic/721.out |  48 +++++++++++++++
 tests/generic/722     |  63 +++++++++++++++++++
 tests/generic/722.out |   2 +
 tests/generic/723     |  70 +++++++++++++++++++++
 tests/generic/723.out |   2 +
 tests/generic/724     |  53 ++++++++++++++++
 tests/generic/724.out |   6 ++
 tests/generic/725     |  56 +++++++++++++++++
 tests/generic/725.out |   4 ++
 tests/generic/726     | 115 ++++++++++++++++++++++++++++++++++
 tests/generic/726.out |  49 +++++++++++++++
 tests/generic/727     |  83 +++++++++++++++++++++++++
 tests/generic/727.out |  17 +++++
 tests/xfs/122.out     |   3 +
 tests/xfs/537         |   2 +-
 tests/xfs/789         |  59 ++++++++++++++++++
 tests/xfs/789.out     |  12 ++++
 tests/xfs/790         |  62 +++++++++++++++++++
 tests/xfs/790.out     |  10 +++
 tests/xfs/791         |  59 ++++++++++++++++++
 tests/xfs/791.out     |   7 +++
 tests/xfs/792         |  61 ++++++++++++++++++
 tests/xfs/792.out     |   5 ++
 tests/xfs/793         |  48 +++++++++++++++
 tests/xfs/793.out     |   2 +
 tests/xfs/794         |  40 ++++++++++++
 tests/xfs/794.out     |   2 +
 tests/xfs/795         |  77 +++++++++++++++++++++++
 tests/xfs/795.out     |   3 +
 tests/xfs/796         |  37 +++++++++++
 tests/xfs/796.out     |   2 +
 tests/xfs/797         |  38 ++++++++++++
 tests/xfs/797.out     |   2 +
 tests/xfs/798         | 105 +++++++++++++++++++++++++++++++
 tests/xfs/798.out     |  32 ++++++++++
 73 files changed, 3198 insertions(+), 8 deletions(-)
--
Zorro Lang
zlang@kernel.org

