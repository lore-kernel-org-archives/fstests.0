Return-Path: <SRS0=sm2X=AZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1152FC433E7
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F88217D8
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGNJre (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:47:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64663 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgGNJre (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jul 2020 05:47:34 -0400
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="96311040"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jul 2020 17:47:26 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 16DB14CE3F17;
        Tue, 14 Jul 2020 17:47:21 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Jul 2020 17:47:20 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 17:47:19 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v6 0/7] Make fstests support new behavior of DAX
Date:   Tue, 14 Jul 2020 17:40:02 +0800
Message-ID: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 16DB14CE3F17.AF136
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The new behavior of DAX on xfs/ext4 has been merged into main kernel
tree/ext4-dax branch so it is time for fstests to support new behavior
of DAX.

1) Refactor common functions and take use of them.
2) Move and update xfs/260.
3) Add two new tests to verify some features.

References:
https://lkml.org/lkml/2019/10/20/96
https://lkml.org/lkml/2020/5/28/949

Xiao Yang (7):
  common/rc: Introduce new helpers for DAX mount options and
    FS_XFLAG_DAX
  fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
  generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
    roughly
  generic/413, xfs/260: Improve format operation for PMD fault testing
  xfs/260: Move and update xfs/260
  generic: Verify if statx() can qurey S_DAX flag on regular file
    correctly
  generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in
    various combinations

 common/rc                      |  47 ++++++--
 tests/ext4/030                 |   2 +-
 tests/ext4/031                 |   4 +-
 tests/generic/223              |   1 -
 tests/generic/413              |  12 +-
 tests/generic/462              |   2 +-
 tests/{xfs/260 => generic/603} |  74 ++++++------
 tests/generic/603.out          |   2 +
 tests/generic/604              | 100 +++++++++++++++++
 tests/generic/604.out          |   2 +
 tests/generic/605              | 199 +++++++++++++++++++++++++++++++++
 tests/generic/605.out          |   2 +
 tests/generic/group            |   3 +
 tests/xfs/260.out              |   2 -
 tests/xfs/group                |   1 -
 15 files changed, 390 insertions(+), 63 deletions(-)
 rename tests/{xfs/260 => generic/603} (53%)
 create mode 100644 tests/generic/603.out
 create mode 100644 tests/generic/604
 create mode 100644 tests/generic/604.out
 create mode 100644 tests/generic/605
 create mode 100644 tests/generic/605.out
 delete mode 100644 tests/xfs/260.out

-- 
2.21.0



