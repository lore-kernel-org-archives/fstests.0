Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E795DC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Feb 2022 03:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiB1Dmb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Feb 2022 22:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiB1Dmb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Feb 2022 22:42:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D0C5A5A5
        for <fstests@vger.kernel.org>; Sun, 27 Feb 2022 19:41:53 -0800 (PST)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K6R374Pd5zBrKD;
        Mon, 28 Feb 2022 11:40:03 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 11:41:50 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 11:41:50 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <chao@kernel.org>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <sunke32@huawei.com>
Subject: [PATCH] generic/066: attr1 is still there after log replay on f2fs
Date:   Mon, 28 Feb 2022 11:57:19 +0800
Message-ID: <20220228035719.4102745-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test fail on f2fs:
     xattr names and values after second fsync log replay:
     # file: SCRATCH_MNT/foobar
    +user.attr1="val1"
     user.attr3="val3"

attr1 is still there after log replay.
I guess it is f2fs's special feature to improve the performance.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---

Is it a BUG on f2fs?
 .gitignore                                 |  1 +
 tests/generic/066                          |  3 +++
 tests/generic/066.cfg                      |  1 +
 tests/generic/{066.out => 066.out.default} |  0
 tests/generic/066.out.f2fs                 | 11 +++++++++++
 5 files changed, 16 insertions(+)
 create mode 100644 tests/generic/066.cfg
 rename tests/generic/{066.out => 066.out.default} (100%)
 create mode 100644 tests/generic/066.out.f2fs

diff --git a/.gitignore b/.gitignore
index 65b93307..135742f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -194,6 +194,7 @@ tags
 /src/perf/*.pyc
 
 # Symlinked files
+/tests/generic/066.out
 /tests/generic/035.out
 /tests/generic/050.out
 /tests/xfs/033.out
diff --git a/tests/generic/066 b/tests/generic/066
index 105a7acd..524dc82d 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -17,6 +17,7 @@
 #
 #  Btrfs: remove deleted xattrs on fsync log replay
 #
+seqfull=$0
 . ./common/preamble
 _begin_fstest auto quick attr metadata log
 
@@ -32,6 +33,8 @@ _cleanup()
 . ./common/dmflakey
 . ./common/attr
 
+# Select appropriate golden output based on fstype
+_link_out_file
 # real QA test starts here
 _supported_fs generic
 _require_scratch
diff --git a/tests/generic/066.cfg b/tests/generic/066.cfg
new file mode 100644
index 00000000..c25641be
--- /dev/null
+++ b/tests/generic/066.cfg
@@ -0,0 +1 @@
+f2fs: f2fs
diff --git a/tests/generic/066.out b/tests/generic/066.out.default
similarity index 100%
rename from tests/generic/066.out
rename to tests/generic/066.out.default
diff --git a/tests/generic/066.out.f2fs b/tests/generic/066.out.f2fs
new file mode 100644
index 00000000..8fc58693
--- /dev/null
+++ b/tests/generic/066.out.f2fs
@@ -0,0 +1,11 @@
+QA output created by 066
+xattr names and values after first fsync log replay:
+# file: SCRATCH_MNT/foobar
+user.attr1="val1"
+user.attr3="val3"
+
+xattr names and values after second fsync log replay:
+# file: SCRATCH_MNT/foobar
+user.attr1="val1"
+user.attr3="val3"
+
-- 
2.13.6

