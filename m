Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FADC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8C20739
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lvvqKd53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFQJrx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:47:53 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58166 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFQJrw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SGQde
        N3AYmxeTF1G/+42M6VDu6xaH83iGO4TT0hC198=; b=lvvqKd53YJxABg+JqT1Aq
        CIxycNhio858apHonQfHe+MkLxYz5PBqsptZHyA4VTuAax5a/cV2OmssnsdvSDGe
        I58zfzIO7m2y23NGm6IkgDOkhMtxgtoL6pDjkDmR6Xaw5roykuSPSUqiY+/5yjSS
        Yuv0GsHO+5teMKionsmcwY=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S8;
        Wed, 17 Jun 2020 17:32:11 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 6/6] xfs/260: Move xfs/260 to generic
Date:   Wed, 17 Jun 2020 17:32:04 +0800
Message-Id: <20200617093204.20838-7-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr17KFW5Kr1rJryrZw4UXFb_yoW8trWUpa
        yv9ryrKF4xA3W7AF48GFnFgFykCan7urW29rn7X342vF1kXw17tryIgr17Jr15WrW8ur4S
        v3ZYyFyF9r48Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnuc_UUUUU=
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0hxGXlUMW8jYLQAAsp
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Both ext4 and xfs support per-inode DAX flag now so move it to generic.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/{xfs/260 => generic/602} | 4 ++--
 tests/generic/602.out          | 2 ++
 tests/generic/group            | 1 +
 tests/xfs/260.out              | 2 --
 tests/xfs/group                | 1 -
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename tests/{xfs/260 => generic/602} (98%)
 create mode 100644 tests/generic/602.out
 delete mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/generic/602
similarity index 98%
rename from tests/xfs/260
rename to tests/generic/602
index 7afc20f1..9137c5b9 100755
--- a/tests/xfs/260
+++ b/tests/generic/602
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 260
+# FS QA Test 602
 #
 # Test per-inode DAX flag by mmap direct/buffered IO.
 #
@@ -28,7 +28,7 @@ _cleanup()
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 _require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
diff --git a/tests/generic/602.out b/tests/generic/602.out
new file mode 100644
index 00000000..61976e5e
--- /dev/null
+++ b/tests/generic/602.out
@@ -0,0 +1,2 @@
+QA output created by 602
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index c6ce029c..4bda3772 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -604,3 +604,4 @@
 599 auto quick remount shutdown
 600 auto quick quota
 601 auto quick quota
+602 auto attr quick dax
diff --git a/tests/xfs/260.out b/tests/xfs/260.out
deleted file mode 100644
index 18ca517c..00000000
--- a/tests/xfs/260.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 260
-Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index daf54add..71c30898 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -257,7 +257,6 @@
 257 auto quick clone
 258 auto quick clone
 259 auto quick
-260 auto attr quick dax
 261 auto quick quota
 262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 263 auto quick quota
-- 
2.21.0

