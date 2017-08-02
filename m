Received: from mx1.redhat.com ([209.132.183.28]:35974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbdHBOkC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Aug 2017 10:40:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2229E4E4C8
        for <fstests@vger.kernel.org>; Wed,  2 Aug 2017 14:40:02 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] common/config: unset TEST_FS_MOUNT_OPTS across config sections
Date: Wed,  2 Aug 2017 22:39:14 +0800
Message-Id: <20170802143915.19585-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

TEST_FS_MOUNT_OPTS doesn't get reset before parsing next config
section, this will cause unexpected TEST_FS_MOUNT_OPTS in test,
because it can be assigned some fs-specific mount options in
_test_mount_opts, which might not be supported by the filesystem in
next config section. And MOUNT_OPTIONS is reset, I don't see why
TEST_FS_MOUNT_OPTS shouldn't be.

Also update README.config-sections to reflect this change and fix
typos (replace MOUNT_OPTIONS with TEST_FS_MOUNT_OPTS).

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 README.config-sections | 10 +++++-----
 common/config          |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/README.config-sections b/README.config-sections
index 8c319ba97778..4f1a4dc6df7a 100644
--- a/README.config-sections
+++ b/README.config-sections
@@ -40,8 +40,8 @@ Different mount options
 -----------------------
 
 Specifying different mount options in difference config sections is allowed.
-When MOUNT_OPTIONS differs in the following section TEST_DEV will be remounted
-with new MOUNT_OPTIONS automatically before running the test.
+When TEST_FS_MOUNT_OPTS differs in the following section TEST_DEV will be
+remounted with new TEST_FS_MOUNT_OPTS automatically before running the test.
 
 
 Multiple file systems
@@ -51,9 +51,9 @@ Having different file systems in different config sections is allowed. When
 FSTYP differs in the following section the FSTYP file system will be created
 automatically before running the test.
 
-Note that if MOUNT_OPTIONS, MKFS_OPTIONS, or FSCK_OPTIONS are not directly
-specified in the section it will be reset to the default for a given file
-system.
+Note that if TEST_FS_MOUNT_OPTS, MOUNT_OPTIONS, MKFS_OPTIONS, or FSCK_OPTIONS
+are not directly specified in the section it will be reset to the default for a
+given file system.
 
 You can also force the file system recreation by specifying RECREATE_TEST_DEV.
 
diff --git a/common/config b/common/config
index 80598d063f6e..d08d14b35c56 100644
--- a/common/config
+++ b/common/config
@@ -602,6 +602,7 @@ get_next_config() {
 	local OLD_USE_EXTERNAL=$USE_EXTERNAL
 
 	unset MOUNT_OPTIONS
+	unset TEST_FS_MOUNT_OPTS
 	unset MKFS_OPTIONS
 	unset FSCK_OPTIONS
 	unset USE_EXTERNAL
-- 
2.13.3

