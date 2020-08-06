Return-Path: <SRS0=LCFT=BQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4547C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB54120823
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHFCVr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:21:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64122 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbgHFCVr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2020 22:21:47 -0400
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; 
   d="scan'208";a="97677620"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2020 10:21:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 203E04CE34DE;
        Thu,  6 Aug 2020 10:21:14 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 6 Aug 2020 10:21:15 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 6 Aug 2020 10:21:14 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        <guaneryu@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v9 0/8] Make fstests support new behavior of DAX
Date:   Thu, 6 Aug 2020 10:13:34 +0800
Message-ID: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 203E04CE34DE.AB807
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The new behavior of DAX on xfs/ext4 has been merged into main kernel
so it is time for fstests to support new behavior of DAX.

1) Refactor common functions and take use of them.
2) Move and update xfs/260.
3) Add three new tests to verify some features.

References:
https://lkml.org/lkml/2019/10/20/96
https://lkml.org/lkml/2020/5/28/949

V7->V8:
1) Rebase against the latest xfstests.
2) Factor out _check_s_dax() and _check_xflag().

V8->V9:
1) Squash a new test(generic/608) into the patch set.
2) Add a new combination(without dax option) for all related tests(generic/605,
   generic/606, generic/608).
3) In generic/607, factor out _scratch_mkfs() and export MOUNT_OPTIONS=""
   for a combination(without dax option).

Xiao Yang (8):
  common/rc: Introduce helpers for new dax mount options and FS_XFLAG_DAX
  fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
  generic/223: Don't clear MKFS_OPTION before calling _scratch_mkfs_geom()
  generic/413, xfs/260: Improve format operation for PMD fault testing
  xfs/260: Move and update xfs/260
  generic: Verify if statx() can qurey S_DAX flag on regular file correctly
  generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations
  generic: Verify how to change the S_DAX flag on an existing file

 common/rc                      | 105 ++++++++++++++++--
 tests/ext4/030                 |   2 +-
 tests/ext4/031                 |   4 +-
 tests/generic/223              |   1 -
 tests/generic/413              |  12 +--
 tests/generic/462              |   2 +-
 tests/{xfs/260 => generic/605} |  79 +++++++-------
 tests/generic/605.out          |   2 +
 tests/generic/606              |  92 ++++++++++++++++
 tests/generic/606.out          |   2 +
 tests/generic/607              | 189 +++++++++++++++++++++++++++++++++
 tests/generic/607.out          |   2 +
 tests/generic/608              | 121 +++++++++++++++++++++
 tests/generic/608.out          |   2 +
 tests/generic/group            |   4 +
 tests/xfs/260.out              |   2 -
 tests/xfs/group                |   1 -
 17 files changed, 559 insertions(+), 63 deletions(-)
 rename tests/{xfs/260 => generic/605} (54%)
 create mode 100644 tests/generic/605.out
 create mode 100644 tests/generic/606
 create mode 100644 tests/generic/606.out
 create mode 100644 tests/generic/607
 create mode 100644 tests/generic/607.out
 create mode 100644 tests/generic/608
 create mode 100644 tests/generic/608.out
 delete mode 100644 tests/xfs/260.out

-- 
2.21.0



