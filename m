Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BCC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 07:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4467610A0
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 07:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhJ2IBn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:01:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30985 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232221AbhJ2IBm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Oct 2021 04:01:42 -0400
IronPort-Data: =?us-ascii?q?A9a23=3APxm5Oap8G6/tpq9m/qpU2+1GtGFeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmAYWG3XafbfZ2bwc4gkO47j80JU65ODnIJkSQdprC0zQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYHApHmeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXNkh2cLyC1qxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196HDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AwCiHTK/F3KA1d/we1btuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="116582431"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Oct 2021 15:59:14 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id BDBA34D0F912
        for <fstests@vger.kernel.org>; Fri, 29 Oct 2021 15:59:13 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 29 Oct 2021 15:59:14 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 29 Oct 2021 15:59:12 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v1.1 2/3] generic: fix description or typo in head comment
Date:   Fri, 29 Oct 2021 15:59:10 +0800
Message-ID: <20211029075910.3563132-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029065943.3556529-3-ruansy.fnst@fujitsu.com>
References: <20211029065943.3556529-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BDBA34D0F912.A1E27
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

==
The word "ENSPC" is a typo too. So update this patch.
==

1. update description according to the current testcase
2. "ENSPC" -> "ENOSPC" ,"an the end -> at the end"

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/155 | 3 +--
 tests/generic/269 | 2 +-
 tests/generic/270 | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

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
index d78b7463..838e696d 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -4,7 +4,7 @@
 #
 # FSQA Test No. 269
 #
-# Run fsstress and ENSPC hitters in parallel, check fs consistency an the end
+# Run fsstress and ENOSPC hitters in parallel, check fs consistency at the end
 #
 . ./common/preamble
 _begin_fstest auto rw prealloc ioctl enospc stress
diff --git a/tests/generic/270 b/tests/generic/270
index 1fb5795a..8a6a2822 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -4,8 +4,8 @@
 #
 # FSQA Test No. 270
 #
-# Run fsstress and ENSPC hitters in parallel, check quota and 
-# fs consistency an the end
+# Run fsstress and ENOSPC hitters in parallel, check quota and
+# fs consistency at the end
 #
 . ./common/preamble
 _begin_fstest auto quota rw prealloc ioctl enospc stress
-- 
2.33.0



