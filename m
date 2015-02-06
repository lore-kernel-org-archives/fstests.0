Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52921 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbbBFGho (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:44 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/9 v5] tests/generic: relocate xfs's tests into tests/generic/
Date: Thu,  5 Feb 2015 22:37:08 -0800
Message-Id: <1423204633-66673-5-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch moves the generic testcases defined in xfs into tests/generic/.
  xfs/053 -> generic/042
  xfs/137 -> generic/043
  xfs/138 -> generic/044
  xfs/139 -> generic/045
  xfs/140 -> generic/046
  xfs/179 -> generic/047
  xfs/180 -> generic/048
  xfs/182 -> generic/049
  xfs/200 -> generic/050
  xfs/306 -> generic/051

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/{xfs/053 => generic/042}         |  4 ++--
 tests/{xfs/053.out => generic/042.out} |  2 +-
 tests/{xfs/137 => generic/043}         |  8 ++++----
 tests/generic/043.out                  |  1 +
 tests/{xfs/138 => generic/044}         |  8 ++++----
 tests/generic/044.out                  |  1 +
 tests/{xfs/139 => generic/045}         |  8 ++++----
 tests/generic/045.out                  |  1 +
 tests/{xfs/140 => generic/046}         |  8 ++++----
 tests/generic/046.out                  |  1 +
 tests/{xfs/179 => generic/047}         |  6 +++---
 tests/generic/047.out                  |  1 +
 tests/{xfs/180 => generic/048}         |  6 +++---
 tests/generic/048.out                  |  1 +
 tests/{xfs/182 => generic/049}         |  6 +++---
 tests/generic/049.out                  |  1 +
 tests/{xfs/200 => generic/050}         |  8 ++++----
 tests/{xfs/200.out => generic/050.out} |  2 +-
 tests/{xfs/306 => generic/051}         |  4 ++--
 tests/{xfs/306.out => generic/051.out} |  2 +-
 tests/generic/group                    | 10 ++++++++++
 tests/xfs/137.out                      |  1 -
 tests/xfs/138.out                      |  1 -
 tests/xfs/139.out                      |  1 -
 tests/xfs/140.out                      |  1 -
 tests/xfs/179.out                      |  1 -
 tests/xfs/180.out                      |  1 -
 tests/xfs/182.out                      |  1 -
 tests/xfs/group                        | 10 ----------
 29 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/tests/xfs/053 b/tests/generic/042
similarity index 98%
rename from tests/xfs/053
rename to tests/generic/042
index 6428d5c..6eecbdc 100755
--- a/tests/xfs/053
+++ b/tests/generic/042
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test No. 053
+# FS QA Test No. 042
 #
 # Test stale data exposure via writeback using various file allocation
 # modification commands. The presumption is that such commands result in partial
@@ -83,7 +83,7 @@ _crashtest()
 }
 
 # Modify as appropriate.
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_scratch_shutdown
diff --git a/tests/xfs/053.out b/tests/generic/042.out
similarity index 92%
rename from tests/xfs/053.out
rename to tests/generic/042.out
index c777fe2..c1130e1 100644
--- a/tests/xfs/053.out
+++ b/tests/generic/042.out
@@ -1,4 +1,4 @@
-QA output created by 053
+QA output created by 042
 falloc -k
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/xfs/137 b/tests/generic/043
similarity index 96%
rename from tests/xfs/137
rename to tests/generic/043
index e31a616..8222506 100755
--- a/tests/xfs/137
+++ b/tests/generic/043
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 137
+# FSQA Test No. 043
 #
 # Test for NULL files problem
 #
@@ -36,13 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -104,4 +104,4 @@ do
 done
 
 status=0
-exit 
+exit
diff --git a/tests/generic/043.out b/tests/generic/043.out
new file mode 100644
index 0000000..7851fbe
--- /dev/null
+++ b/tests/generic/043.out
@@ -0,0 +1 @@
+QA output created by 043
diff --git a/tests/xfs/138 b/tests/generic/044
similarity index 97%
rename from tests/xfs/138
rename to tests/generic/044
index b2cbb4e..ef56d0e 100755
--- a/tests/xfs/138
+++ b/tests/generic/044
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 138
+# FSQA Test No. 044
 #
 # Test for NULL files problem
 #
@@ -36,13 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -110,4 +110,4 @@ do
 done
 
 status=0
-exit 
+exit
diff --git a/tests/generic/044.out b/tests/generic/044.out
new file mode 100644
index 0000000..ef9885b
--- /dev/null
+++ b/tests/generic/044.out
@@ -0,0 +1 @@
+QA output created by 044
diff --git a/tests/xfs/139 b/tests/generic/045
similarity index 97%
rename from tests/xfs/139
rename to tests/generic/045
index 5e8b7c5..8f90370 100755
--- a/tests/xfs/139
+++ b/tests/generic/045
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 139
+# FSQA Test No. 045
 #
 # Test for NULL files problem
 #
@@ -36,13 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -110,4 +110,4 @@ do
 done
 
 status=0
-exit 
+exit
diff --git a/tests/generic/045.out b/tests/generic/045.out
new file mode 100644
index 0000000..5b0d489
--- /dev/null
+++ b/tests/generic/045.out
@@ -0,0 +1 @@
+QA output created by 045
diff --git a/tests/xfs/140 b/tests/generic/046
similarity index 96%
rename from tests/xfs/140
rename to tests/generic/046
index 105ef0d..893538e 100755
--- a/tests/xfs/140
+++ b/tests/generic/046
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 140
+# FSQA Test No. 046
 #
 # Test for NULL files problem
 #
@@ -36,13 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -107,4 +107,4 @@ do
 done
 
 status=0
-exit 
+exit
diff --git a/tests/generic/046.out b/tests/generic/046.out
new file mode 100644
index 0000000..a14e592
--- /dev/null
+++ b/tests/generic/046.out
@@ -0,0 +1 @@
+QA output created by 046
diff --git a/tests/xfs/179 b/tests/generic/047
similarity index 97%
rename from tests/xfs/179
rename to tests/generic/047
index 5dec31f..4767456 100755
--- a/tests/xfs/179
+++ b/tests/generic/047
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 179
+# FSQA Test No. 047
 #
 # Test for NULL files problem
 # test inode size is on disk after fsync
@@ -37,13 +37,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _check_files()
diff --git a/tests/generic/047.out b/tests/generic/047.out
new file mode 100644
index 0000000..58e2353
--- /dev/null
+++ b/tests/generic/047.out
@@ -0,0 +1 @@
+QA output created by 047
diff --git a/tests/xfs/180 b/tests/generic/048
similarity index 97%
rename from tests/xfs/180
rename to tests/generic/048
index 853f6f2..4c1edc2 100755
--- a/tests/xfs/180
+++ b/tests/generic/048
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 180
+# FSQA Test No. 048
 #
 # Test for NULL files problem
 # test inode size is on disk after sync
@@ -37,13 +37,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # Do we have enough space on disk?  10G
diff --git a/tests/generic/048.out b/tests/generic/048.out
new file mode 100644
index 0000000..7554630
--- /dev/null
+++ b/tests/generic/048.out
@@ -0,0 +1 @@
+QA output created by 048
diff --git a/tests/xfs/182 b/tests/generic/049
similarity index 97%
rename from tests/xfs/182
rename to tests/generic/049
index 4b08989..1d2ddc5 100755
--- a/tests/xfs/182
+++ b/tests/generic/049
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FSQA Test No. 182
+# FSQA Test No. 049
 #
 # Test for NULL files problem
 # test inode size is on disk after sync - expose log replay bug
@@ -37,13 +37,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
 _require_fiemap
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _check_files()
diff --git a/tests/generic/049.out b/tests/generic/049.out
new file mode 100644
index 0000000..cb0061b
--- /dev/null
+++ b/tests/generic/049.out
@@ -0,0 +1 @@
+QA output created by 049
diff --git a/tests/xfs/200 b/tests/generic/050
similarity index 96%
rename from tests/xfs/200
rename to tests/generic/050
index bd6d0fd..a32e049 100755
--- a/tests/xfs/200
+++ b/tests/generic/050
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test No. 200
+# FS QA Test No. 050
 #
 # Check out various mount/remount/unmount scenarious on a read-only blockdev.
 #
@@ -41,14 +41,14 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 
 _require_scratch_nocheck
 _require_scratch_shutdown
 _require_norecovery
 
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 
 #
 # Mark the device read-only
@@ -119,7 +119,7 @@ blockdev --setrw $SCRATCH_DEV
 # the underlying device is not write protected.
 #
 echo "mounting filesystem that needs recovery with -o ro:"
-_scratch_mount -o ro 2>&1 | _filter_scratch 
+_scratch_mount -o ro 2>&1 | _filter_scratch
 
 # success, all done
 echo "*** done"
diff --git a/tests/xfs/200.out b/tests/generic/050.out
similarity index 97%
rename from tests/xfs/200.out
rename to tests/generic/050.out
index 40f9163..f8dbb7a 100644
--- a/tests/xfs/200.out
+++ b/tests/generic/050.out
@@ -1,4 +1,4 @@
-QA output created by 200
+QA output created by 050
 setting device read-only
 mounting read-only block device:
 mount: SCRATCH_DEV is write-protected, mounting read-only
diff --git a/tests/xfs/306 b/tests/generic/051
similarity index 98%
rename from tests/xfs/306
rename to tests/generic/051
index 5af5ace..614939f 100755
--- a/tests/xfs/306
+++ b/tests/generic/051
@@ -1,5 +1,5 @@
 #!/bin/bash
-# FS QA Test No. xfs/306
+# FS QA Test No. 051
 #
 # Basic log recovery stress test - do lots of stuff, shut down in the middle of
 # it and check that recovery runs to completion and everything can be
@@ -45,7 +45,7 @@ _cleanup()
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 
 _require_scratch
diff --git a/tests/xfs/306.out b/tests/generic/051.out
similarity index 60%
rename from tests/xfs/306.out
rename to tests/generic/051.out
index 9fd18a4..daf2e6a 100644
--- a/tests/xfs/306.out
+++ b/tests/generic/051.out
@@ -1,2 +1,2 @@
-QA output created by 306
+QA output created by 051
 No output is good. Failures are loud.
diff --git a/tests/generic/group b/tests/generic/group
index fb67b57..d38240e 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -44,6 +44,16 @@
 039 metadata auto quick
 040 metadata auto quick
 041 metadata auto quick
+042 auto quick rw
+043 metadata log auto
+044 metadata log auto
+045 metadata log auto
+046 metadata log auto
+047 metadata rw auto
+048 metadata rw auto
+049 metadata rw auto
+050 mount auto quick
+051 auto stress log metadata repair
 053 acl repair auto quick
 062 attr udf auto quick
 068 other auto freeze dangerous stress
diff --git a/tests/xfs/137.out b/tests/xfs/137.out
deleted file mode 100644
index 0fd8b81..0000000
--- a/tests/xfs/137.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 137
diff --git a/tests/xfs/138.out b/tests/xfs/138.out
deleted file mode 100644
index f3eb411..0000000
--- a/tests/xfs/138.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 138
diff --git a/tests/xfs/139.out b/tests/xfs/139.out
deleted file mode 100644
index be0ebc2..0000000
--- a/tests/xfs/139.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 139
diff --git a/tests/xfs/140.out b/tests/xfs/140.out
deleted file mode 100644
index e6506b8..0000000
--- a/tests/xfs/140.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 140
diff --git a/tests/xfs/179.out b/tests/xfs/179.out
deleted file mode 100644
index e5b0ba9..0000000
--- a/tests/xfs/179.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 179
diff --git a/tests/xfs/180.out b/tests/xfs/180.out
deleted file mode 100644
index 9035544..0000000
--- a/tests/xfs/180.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 180
diff --git a/tests/xfs/182.out b/tests/xfs/182.out
deleted file mode 100644
index 5e665c8..0000000
--- a/tests/xfs/182.out
+++ /dev/null
@@ -1 +0,0 @@
-QA output created by 182
diff --git a/tests/xfs/group b/tests/xfs/group
index 496630d..4099793 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -50,7 +50,6 @@
 050 quota auto quick
 051 auto log metadata
 052 quota db auto quick
-053 auto quick rw
 054 quota auto quick
 055 dump ioctl remote tape
 056 dump ioctl auto quick
@@ -99,10 +98,6 @@
 122 other auto quick
 134 quota auto quick
 136 attr2
-137 metadata log auto
-138 metadata log auto
-139 metadata log auto
-140 metadata log auto
 142 dmapi
 143 dmapi
 144 dmapi
@@ -139,10 +134,7 @@
 176 dmapi
 177 dmapi
 178 mkfs other auto
-179 metadata rw auto
-180 metadata rw auto
 181 log auto quick
-182 metadata rw auto
 183 rw other auto quick
 185 dmapi
 186 attr auto quick
@@ -156,7 +148,6 @@
 196 quota auto quick
 197 dir auto quick
 199 mount auto quick
-200 mount auto quick
 201 metadata auto quick
 202 repair auto quick
 203 ioctl auto
@@ -201,4 +192,3 @@
 303 auto quick quota
 304 auto quick quota
 305 auto quota
-306 auto stress log metadata repair
-- 
2.1.1

