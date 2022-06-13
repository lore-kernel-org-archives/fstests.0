Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184DFC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jun 2022 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbiFMSmQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbiFMSlx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Jun 2022 14:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE33E2760
        for <fstests@vger.kernel.org>; Mon, 13 Jun 2022 08:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84A82614D4
        for <fstests@vger.kernel.org>; Mon, 13 Jun 2022 15:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4E8C34114;
        Mon, 13 Jun 2022 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655133805;
        bh=EjEtTuzY1+1Z7no0JZdfeBwLEVuRm5ZR6E6849QRGOc=;
        h=From:To:Cc:Subject:Date:From;
        b=ovKw8i06jo20voVRN+8PpUGUAhPtDmb97D2WTYrRiHzPWkNE9+i3mFjd5AmtDicCn
         lJqkUkxVPJt1DQHTKi4ihBM8sqQigELSA12Jv7Jy5b+YQVgew0lMJIHjHq/GI6ipdd
         3eJ763oft+WRoEfaIm6zZRPjhgrlzJdkMGS/7707rbgaAuwucv1SU+4gIkXEt9OHTb
         QMiUKh6YADG5iYk0K6vsR4rFooAQ1JkHR0opKqmDQwjgqmIe2xFPldBIotSv5DtYAu
         UlLac0F/Vzav5aw08G5AWG/edKdk6jCXnZCaUE4m8cZ9d4omX1t74zqSCpNPz+/FgO
         Y5o7uMNaC/msw==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] generic/692: test group ownership change
Date:   Mon, 13 Jun 2022 17:23:14 +0200
Message-Id: <20220613152314.2235940-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2899; h=from:subject; bh=EjEtTuzY1+1Z7no0JZdfeBwLEVuRm5ZR6E6849QRGOc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQtDwva8X7a+UN3WxYdvWPw5kx9cHnBHdXPa5xNWKpV1QLF vycs7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI+kJGhtPBLxaoXn/aZFbiLd/VZb 7mumHEuTDt3GNRm5lWGCyeoc7wP+tC80qWalP9HXOu521pmx//Olv69idm1ou/Z21ba93hzwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When group ownership is changed a caller whose fsuid owns the inode can
change the group of the inode to any group they are a member of. When
searching through the caller's groups we failed to use the gid mapped
according to the idmapped mount otherwise we fail to change ownership.
Add a test for this.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 tests/generic/692     | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/692.out |  3 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/generic/692
 create mode 100644 tests/generic/692.out

diff --git a/tests/generic/692 b/tests/generic/692
new file mode 100755
index 00000000..825c836a
--- /dev/null
+++ b/tests/generic/692
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
+#
+# FS QA Test 692
+#
+# Test that users can changed group ownership of a file they own to a group
+# they are a member of.
+#
+# Regression test for commit:
+#
+# 263de29d8397 ("fs: account for group membership")
+#
+. ./common/preamble
+_begin_fstest auto quick perms attr idmapped mount
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $TEST_DIR/target-mnt
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+_require_chown
+_require_idmapped_mounts
+_require_user fsgqa
+_require_group fsgqa
+_require_group fsgqa2
+
+uqid=`id -u fsgqa`
+gqid=`id -g fsgqa`
+uqid2=`id -u fsgqa2`
+gqid2=`id -g fsgqa2`
+
+setup_tree()
+{
+	mkdir -p $TEST_DIR/source-mnt
+	chmod 0777 $TEST_DIR/source-mnt
+	touch $TEST_DIR/source-mnt/dir1
+	chown 65534:65534 $TEST_DIR/source-mnt
+	chown 65534:65535 $TEST_DIR/source-mnt/dir1
+
+	mkdir -p $TEST_DIR/target-mnt
+	chmod 0777 $TEST_DIR/target-mnt
+}
+
+setup_idmapped_mnt()
+{
+	$here/src/vfs/mount-idmapped \
+		--map-mount=u:65534:$uqid:1 \
+		--map-mount=g:65534:$gqid:1 \
+		--map-mount=u:65535:$uqid2:1 \
+		--map-mount=g:65535:$gqid2:1 \
+		$TEST_DIR/source-mnt $TEST_DIR/target-mnt
+}
+
+setup_tree
+setup_idmapped_mnt
+stat -c '%U:%G' "$TEST_DIR/target-mnt/dir1"
+_user_do "chgrp $gqid $TEST_DIR/target-mnt/dir1"
+stat -c '%U:%G' "$TEST_DIR/target-mnt/dir1"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/692.out b/tests/generic/692.out
new file mode 100644
index 00000000..c963f7f4
--- /dev/null
+++ b/tests/generic/692.out
@@ -0,0 +1,3 @@
+QA output created by 692
+fsgqa:fsgqa2
+fsgqa:fsgqa

base-commit: 568ac9fffeb6afec03e5d6c9936617232fd7fc6d
-- 
2.34.1

