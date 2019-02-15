Received: from bombadil.infradead.org ([198.137.202.133]:45630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfBOMlq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Feb 2019 07:41:46 -0500
Received: from clnet-p01-149.ikbnet.co.at ([83.175.85.149] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gucoK-0002CZ-5H
        for fstests@vger.kernel.org; Fri, 15 Feb 2019 12:41:45 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] generic: detect preallocation support for fsx tests 075 and 112
Date: Fri, 15 Feb 2019 13:41:40 +0100
Message-Id: <20190215124140.6832-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Currently generic/075 and generic/112 have two extra fsx passes each that
exercise fsx with preallocation, which are only enabled for XFS.

These tests can also be run with other file systems, given that the XFS
prealloc ioctls are implemented in generic code since the addition of
the fallocate system call.  This also means a version of XFS that does
not support preallocation (e.g. because it always writes out of place)
can skip the prealloc tests while still completing the normal fsx tests
just fine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - use the resvsp command instead of falloc
 - just check for a non-empty output from xfs_io

 tests/generic/075 | 13 ++++++++-----
 tests/generic/112 | 17 ++++++++++-------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/tests/generic/075 b/tests/generic/075
index 2b957891..acaa3b4c 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -48,11 +48,9 @@ _do_test()
     echo "fsx.$_n : $_filter_param"
     echo "-----------------------------------------------"
 
-    if [ "$FSTYP" != "xfs" ]
-    then
-	if [ "$_n" = "1" -o "$_n" = "3" ]
-	then
-	    # HACK: only xfs handles preallocation (-x) so just skip this test
+    # Skip the prealloc runs if the file system does not support preallocation
+    if [ "$_n" = "1" -o "$_n" = "3" ]; then
+        if [ -n "$testio" ]; then
 	    return
 	fi
     fi
@@ -128,6 +126,11 @@ echo "brevity is wit..."
 
 _check_test_fs
 
+# check if preallocation is supported
+testfile=$TEST_DIR/$$.xfs_io
+testio=`$XFS_IO_PROG -F -f -c "resvsp 0 1" $testfile 2>&1`
+rm -f $testfile 2>&1 > /dev/null
+
 # Options:
 # -d: debug output for all operations
 # -l flen: the upper bound on file size (default 262144)
diff --git a/tests/generic/112 b/tests/generic/112
index 1879e7b5..2c0d53e3 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -48,13 +48,11 @@ _do_test()
     echo "fsx.$_n : $_filter_param"
     echo "-----------------------------------------------"
 
-    if [ "$FSTYP" != "xfs" ]
-    then
-        if [ "$_n" = "1" -o "$_n" = "3" ]
-        then
-            # HACK: only xfs handles preallocation (-x) so just skip this test
-            return
-        fi
+    # Skip the prealloc runs if the file system does not support preallocation
+    if [ "$_n" = "1" -o "$_n" = "3" ]; then
+        if [ -n "$testio" ]; then
+	    return
+	fi
     fi
 
     # This cd and use of -P gets full debug on $here (not TEST_DEV)
@@ -128,6 +126,11 @@ echo "brevity is wit..."
 
 _check_test_fs
 
+# check if preallocation is supported
+testfile=$TEST_DIR/$$.xfs_io
+testio=`$XFS_IO_PROG -F -f -c "falloc 0 1m" $testfile 2>&1`
+rm -f $testfile 2>&1 > /dev/null
+
 # Options:
 # -d: debug output for all operations
 # -l flen: the upper bound on file size (default 262144)
-- 
2.20.1
