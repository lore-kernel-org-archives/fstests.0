Return-Path: <SRS0=QKYl=AL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CECC433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 14:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47F02073E
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgF3OHc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:07:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60118 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727796AbgF3OHc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 10:07:32 -0400
X-IronPort-AV: E=Sophos;i="5.75,297,1589212800"; 
   d="scan'208";a="95563330"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jun 2020 22:06:50 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 344EC4CE4BD7;
        Tue, 30 Jun 2020 21:56:16 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 30 Jun 2020 22:06:44 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:06:38 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 0/6] Make fstests support new behavior of DAX
Date:   Tue, 30 Jun 2020 21:59:45 +0800
Message-ID: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 344EC4CE4BD7.AB913
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The new behavior of DAX on xfs/ext4 has been merged into main kernel
tree/ext4-dax branch so it is time for fstests to support new behavior
of DAX.

References:
https://lkml.org/lkml/2019/10/20/96
https://lkml.org/lkml/2020/5/28/949

Xiao Yang (6):
  common/rc: Introduce new helpers for DAX mount options and
    FS_XFLAG_DAX
  fstests: Use _require_scratch_dax_mountopt() and
    _require_scratch_dax_iflag()
  common/rc: Remove unused _require_scratch_dax()
  generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
    roughly
  generic/413, xfs/260: Improve format operation for PMD fault testing
  xfs/260: Move and update xfs/260

 common/rc                      | 60 ++++++++++++++++++++++++----
 tests/ext4/030                 |  2 +-
 tests/ext4/031                 |  4 +-
 tests/generic/223              |  1 -
 tests/generic/413              | 12 ++----
 tests/generic/462              |  2 +-
 tests/{xfs/260 => generic/603} | 71 +++++++++++++++++-----------------
 tests/generic/603.out          |  2 +
 tests/generic/group            |  1 +
 tests/xfs/260.out              |  2 -
 tests/xfs/group                |  1 -
 11 files changed, 97 insertions(+), 61 deletions(-)
 rename tests/{xfs/260 => generic/603} (54%)
 create mode 100644 tests/generic/603.out
 delete mode 100644 tests/xfs/260.out

-- 
2.21.0



