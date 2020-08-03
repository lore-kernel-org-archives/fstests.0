Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E7AC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BF0206D7
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHCIqZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:46:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbgHCIqZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 04:46:25 -0400
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; 
   d="scan'208";a="97500117"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Aug 2020 16:46:07 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 662294CE5444;
        Mon,  3 Aug 2020 16:46:03 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 3 Aug 2020 16:46:06 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 3 Aug 2020 16:46:06 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v8 0/7] Make fstests support new behavior of DAX
Date:   Mon, 3 Aug 2020 16:38:31 +0800
Message-ID: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 662294CE5444.A88D0
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
3) Add two new tests to verify some features.

References:
https://lkml.org/lkml/2019/10/20/96
https://lkml.org/lkml/2020/5/28/949

V7->V8:
1) Rebase against the latest xfstests.
2) Factor out _check_s_dax() and _check_xflag().

Xiao Yang (7):
  common/rc: Introduce helpers for new dax mount options and
    FS_XFLAG_DAX
  fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
  generic/223: Don't clear MKFS_OPTION before calling
    _scratch_mkfs_geom()
  generic/413, xfs/260: Improve format operation for PMD fault testing
  xfs/260: Move and update xfs/260
  generic: Verify if statx() can qurey S_DAX flag on regular file
    correctly
  generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in
    various combinations

 common/rc                      |  96 +++++++++++++++--
 tests/ext4/030                 |   2 +-
 tests/ext4/031                 |   4 +-
 tests/generic/223              |   1 -
 tests/generic/413              |  12 +--
 tests/generic/462              |   2 +-
 tests/{xfs/260 => generic/605} |  74 +++++++------
 tests/generic/605.out          |   2 +
 tests/generic/606              |  88 ++++++++++++++++
 tests/generic/606.out          |   2 +
 tests/generic/607              | 187 +++++++++++++++++++++++++++++++++
 tests/generic/607.out          |   2 +
 tests/generic/group            |   3 +
 tests/xfs/260.out              |   2 -
 tests/xfs/group                |   1 -
 15 files changed, 413 insertions(+), 65 deletions(-)
 rename tests/{xfs/260 => generic/605} (53%)
 create mode 100644 tests/generic/605.out
 create mode 100644 tests/generic/606
 create mode 100644 tests/generic/606.out
 create mode 100644 tests/generic/607
 create mode 100644 tests/generic/607.out
 delete mode 100644 tests/xfs/260.out

-- 
2.21.0



