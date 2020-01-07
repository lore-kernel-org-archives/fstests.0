Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571DEC33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 08:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2951C2080A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 08:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGIpQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:45:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49261 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbgAGIpQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 03:45:16 -0500
X-IronPort-AV: E=Sophos;i="5.69,405,1571673600"; 
   d="scan'208";a="81428046"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2020 16:45:14 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 387E849E933D;
        Tue,  7 Jan 2020 16:36:13 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 7 Jan 2020 16:45:10 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 7 Jan 2020 16:45:17 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <eguan@linux.alibaba.com>, <amir73il@gmail.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 2/2] generic: Add check for required keep_size/punch_hole/zero_range/collapse_range
Date:   Tue, 7 Jan 2020 16:40:53 +0800
Message-ID: <20200107084053.2889-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107084053.2889-1-yangx.jy@cn.fujitsu.com>
References: <20200107084053.2889-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 387E849E933D.AB728
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Tests need the exact operations to reproduce some issues by --replay-ops so skip tests
rather than one operation if a required operation/flag in tests is not supported.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/456 | 3 +++
 tests/generic/469 | 3 +++
 tests/generic/499 | 1 +
 tests/generic/511 | 1 +
 4 files changed, 8 insertions(+)

diff --git a/tests/generic/456 b/tests/generic/456
index 6124f0bb..434a0ffa 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -36,6 +36,9 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_dm_target flakey
+_require_xfs_io_command "falloc" "-k"
+_require_xfs_io_command "fzero"
+_require_xfs_io_command "fcollapse"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/469 b/tests/generic/469
index 47fdf0cf..e9411d47 100755
--- a/tests/generic/469
+++ b/tests/generic/469
@@ -40,6 +40,9 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_xfs_io_command "falloc" "-k"
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "fzero"
 
 run_fsx()
 {
diff --git a/tests/generic/499 b/tests/generic/499
index 773eab2e..b3363ac4 100755
--- a/tests/generic/499
+++ b/tests/generic/499
@@ -28,6 +28,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fcollapse"
 _require_xfs_io_command "fzero"
 
diff --git a/tests/generic/511 b/tests/generic/511
index 4d133f49..f8022905 100755
--- a/tests/generic/511
+++ b/tests/generic/511
@@ -28,6 +28,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fzero"
 
 rm -f $seqres.full
-- 
2.21.0



