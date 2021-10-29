Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399BC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 07:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC07E60F93
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 07:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhJ2HCb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:02:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45817 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232024AbhJ2HCa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Oct 2021 03:02:30 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ANG6UbKtUylqtr92VPI+531ZO3ufnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yDFKWDqCPv7bYDf2fd0gb96y8UxTusKHmtQ1Glc/r3pgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUba?=
 =?us-ascii?q?eangqLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JLOkByZLySEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENaq2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKKb6vaOnGNLp6MBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="116579747"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Oct 2021 15:00:01 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 925C94D0F910
        for <fstests@vger.kernel.org>; Fri, 29 Oct 2021 14:59:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 29 Oct 2021 14:59:58 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 29 Oct 2021 14:59:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 2/3] generic: fix description or typo in head comment
Date:   Fri, 29 Oct 2021 14:59:42 +0800
Message-ID: <20211029065943.3556529-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
References: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 925C94D0F910.A0C05
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1. update description according to the current testcase
2. "an the end -> at the end"

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/155 | 3 +--
 tests/generic/269 | 2 +-
 tests/generic/270 | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/generic/155 b/tests/generic/155
index 2fe7894a..13292fbb 100755
--- a/tests/generic/155
+++ b/tests/generic/155
@@ -13,8 +13,7 @@
 #   - CoW all the rest of the blocks of the copies
 #   - Compare fs block usage to (2), (1), and (0)
 #
-# The main difference from 834 is that we use zero range, directio, and
-# mmap to mix things up a bit.
+# The main difference from No. 154 is that we use zero range to execute CoW.
 #
 . ./common/preamble
 _begin_fstest auto quick clone zero
diff --git a/tests/generic/269 b/tests/generic/269
index d78b7463..60a07b44 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -4,7 +4,7 @@
 #
 # FSQA Test No. 269
 #
-# Run fsstress and ENSPC hitters in parallel, check fs consistency an the end
+# Run fsstress and ENSPC hitters in parallel, check fs consistency at the end
 #
 . ./common/preamble
 _begin_fstest auto rw prealloc ioctl enospc stress
diff --git a/tests/generic/270 b/tests/generic/270
index 1fb5795a..35141e05 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -5,7 +5,7 @@
 # FSQA Test No. 270
 #
 # Run fsstress and ENSPC hitters in parallel, check quota and 
-# fs consistency an the end
+# fs consistency at the end
 #
 . ./common/preamble
 _begin_fstest auto quota rw prealloc ioctl enospc stress
-- 
2.33.0



