Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D0C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 00:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356539AbiD0Azb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356541AbiD0Azb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Apr 2022 20:55:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882EE13DC5
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 17:52:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23R0qFnh016528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 20:52:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 29B4D15C3EA1; Tue, 26 Apr 2022 20:52:15 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/054,ext4/055: don't run when using DAX
Date:   Tue, 26 Apr 2022 20:52:09 -0400
Message-Id: <20220427005209.4188220-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The ext4/054 and ext4/055 tests create a scratch file system with a 1k
block size.  This is not compatible with mounting with the DAX option,
which requires a block size equal to the page size (which is 4k on
x86).

Also, the ext4/054 test doesn't use the test device, so remove the
_require_test declaration.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/054 | 2 +-
 tests/ext4/055 | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/054 b/tests/ext4/054
index 9a11719f..6c722f32 100755
--- a/tests/ext4/054
+++ b/tests/ext4/054
@@ -19,8 +19,8 @@ _begin_fstest auto quick dangerous_fuzzers
 
 # real QA test starts here
 _supported_fs ext4
-_require_test
 _require_scratch_nocheck
+_exclude_scratch_mount_option dax
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "pwrite"
 _require_xfs_io_command "fsync"
diff --git a/tests/ext4/055 b/tests/ext4/055
index 8f466f1b..1ae42b89 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -17,8 +17,9 @@
 _begin_fstest auto quota
 
 # real QA test starts here
-_require_scratch_nocheck
 _supported_fs ext4
+_require_scratch_nocheck
+_exclude_scratch_mount_option dax
 _require_user fsgqa
 _require_user fsgqa2
 _require_command "$DEBUGFS_PROG" debugfs
-- 
2.31.0

