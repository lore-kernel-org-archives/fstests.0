Received: from mail-pf0-f172.google.com ([209.85.192.172]:33488 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbcJLWDj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Oct 2016 18:03:39 -0400
Received: by mail-pf0-f172.google.com with SMTP id 128so24734089pfz.0
        for <fstests@vger.kernel.org>; Wed, 12 Oct 2016 15:03:39 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] generic/314: don't test SGID behavior after setfacl
Date: Wed, 12 Oct 2016 15:03:08 -0700
Message-Id: <1476309788-101401-2-git-send-email-ebiggers@google.com>
In-Reply-To: <1476309788-101401-1-git-send-email-ebiggers@google.com>
References: <1476309788-101401-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jack@suse.cz, agruenba@redhat.com, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Linux 4.9 (since commit 073931017b49: "posix_acl: Clear SGID bit when
setting file permissions") now may clear the SGID bit when setting a
POSIX ACL, to match chmod() behavior.  This was making generic/314 fail.
Since SGID bit clearing is already tested by generic/375, just remove
the problematic portion of generic/314.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/314     | 8 ++------
 tests/generic/314.out | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/tests/generic/314 b/tests/generic/314
index 65d3513..49b03e4 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -39,12 +39,10 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
-. ./common/attr
 
 # real QA test starts here
 _supported_fs generic
 _require_test
-_require_acls
 _require_user
 
 rm -rf $TEST_DIR/$seq-dir
@@ -56,12 +54,10 @@ chown $qa_user:12345 $TEST_DIR/$seq-dir
 # Make parent dir sgid
 chmod 2775 $TEST_DIR/$seq-dir
 
-# Make subdirs before & after acl set
+# Make subdir
 su $qa_user -c "umask 022; mkdir $TEST_DIR/$seq-dir/subdir"
-su $qa_user -c "setfacl -m u:$qa_user:rwx,d:u:$qa_user:rwx $TEST_DIR/$seq-dir"
-su $qa_user -c "mkdir $TEST_DIR/$seq-dir/subdir2"
 
-# Both subdirs should have inherited sgid
+# Subdir should have inherited sgid
 _ls_l $TEST_DIR/$seq-dir/ | grep -v total | _filter_test_dir | awk '{print $1,$NF}'
 
 status=0
diff --git a/tests/generic/314.out b/tests/generic/314.out
index b2db82b..bcd14f5 100644
--- a/tests/generic/314.out
+++ b/tests/generic/314.out
@@ -1,3 +1,2 @@
 QA output created by 314
 drwxr-sr-x subdir
-drwxrwsr-x+ subdir2
-- 
2.8.0.rc3.226.g39d4020

