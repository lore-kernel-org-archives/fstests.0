Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4AC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D79A600D4
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJ3IhZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Oct 2021 04:37:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2922 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229546AbhJ3IhY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Oct 2021 04:37:24 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AHBHo0a7xKORKBH0npJyizgxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1zUCyWEZWmCFOPeCNGvyfo91O4Sx/RhV68fTzYJhGgQ5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+KmWba?=
 =?us-ascii?q?fUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCbh65POlROun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rp0m8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASWsFL65wx4a4Jlzv7wPXwCzXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiX+rbHJoB17726MtN9/YhEdcLy7VJVoBEmskKKdgrNhWotKPjOW21?=
 =?us-ascii?q?dARbsKheCJrgEIWReOktK1vp0AT0ERMrLN5CBB/KTHCReDYqsd6ejC4Ka1nv3f?=
 =?us-ascii?q?0nsoaQlrbptr5wB/Bh3zKDwMeCB2QYo+CIGH5tdK4x6peXEsZMy9AXUfG8fZod?=
 =?us-ascii?q?mjruOdXTc2Qw4g9BKVjS6lrJrzEx2j1B8YVD9VhZcOmFK16zDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,194,1631548800"; 
   d="scan'208";a="116627526"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2021 16:34:54 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 0CFBD4D0F90E
        for <fstests@vger.kernel.org>; Sat, 30 Oct 2021 16:34:51 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 30 Oct 2021 16:34:46 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 30 Oct 2021 16:34:43 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 2/3] generic: fix description or typo in head comment
Date:   Sat, 30 Oct 2021 16:34:32 +0800
Message-ID: <20211030083433.3616711-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
References: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0CFBD4D0F90E.A6230
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1. update description according to the current testcase
2. "ENSPC" -> "ENOSPC" ,"an the end -> at the end"

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/155 | 3 +--
 tests/generic/269 | 2 +-
 tests/generic/270 | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/generic/155 b/tests/generic/155
index 2fe7894a..1ee04c67 100755
--- a/tests/generic/155
+++ b/tests/generic/155
@@ -13,8 +13,7 @@
 #   - CoW all the rest of the blocks of the copies
 #   - Compare fs block usage to (2), (1), and (0)
 #
-# The main difference from 834 is that we use zero range, directio, and
-# mmap to mix things up a bit.
+# The main difference from generic/154 is that we use zero range to execute CoW.
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



