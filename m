Received: from imap.thunk.org ([74.207.234.97]:47996 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932479AbdEVBFf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 21 May 2017 21:05:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] Drop _require_fssum
Date: Sun, 21 May 2017 21:05:28 -0400
Message-Id: <20170522010528.23463-2-tytso@mit.edu>
In-Reply-To: <20170522010528.23463-1-tytso@mit.edu>
References: <20170522010528.23463-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Now that fssum is built unconditionally, we no longer need
_require_fssum.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc       | 6 ------
 tests/btrfs/007 | 1 -
 tests/btrfs/016 | 1 -
 tests/btrfs/030 | 1 -
 tests/btrfs/038 | 1 -
 tests/btrfs/039 | 1 -
 tests/btrfs/040 | 1 -
 tests/btrfs/043 | 1 -
 tests/btrfs/044 | 1 -
 tests/btrfs/045 | 1 -
 tests/btrfs/046 | 1 -
 tests/btrfs/050 | 1 -
 tests/btrfs/051 | 1 -
 tests/btrfs/053 | 1 -
 tests/btrfs/077 | 1 -
 tests/btrfs/083 | 1 -
 tests/btrfs/084 | 1 -
 tests/btrfs/087 | 1 -
 tests/btrfs/092 | 1 -
 tests/btrfs/127 | 1 -
 tests/btrfs/128 | 1 -
 tests/btrfs/129 | 1 -
 tests/btrfs/133 | 1 -
 tests/btrfs/134 | 1 -
 tests/btrfs/135 | 1 -
 25 files changed, 30 deletions(-)

diff --git a/common/rc b/common/rc
index 65886886..796f60e7 100644
--- a/common/rc
+++ b/common/rc
@@ -3164,12 +3164,6 @@ _require_ugid_map()
 	fi
 }
 
-_require_fssum()
-{
-	FSSUM_PROG=$here/src/fssum
-	[ -x $FSSUM_PROG ] || _notrun "fssum not built"
-}
-
 _require_cloner()
 {
 	CLONER_PROG=$here/src/cloner
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 57f9a79f..d74108e1 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -50,7 +50,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 _require_seek_data_hole
 
 rm -f $seqres.full
diff --git a/tests/btrfs/016 b/tests/btrfs/016
index de4f1a84..dbd59409 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -51,7 +51,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 _scratch_mkfs > /dev/null 2>&1
 
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index 6b67de08..3ea7b89d 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -53,7 +53,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index e46b7eb1..f5099e7a 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -49,7 +49,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index 25380dc1..e8239a86 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -52,7 +52,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index 13584b1e..ffce51af 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -52,7 +52,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 7bf83036..33c3e098 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -48,7 +48,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 8668d767..62223c53 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -53,7 +53,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index 9fad27d5..027d9184 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -69,7 +69,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 284fa955..de7a7df4 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -53,7 +53,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 rm -f $seqres.full
 rm -fr $send_files_dir
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index 62e2cfc4..10daa7a4 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -53,7 +53,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index 0a874120..679a4963 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -50,7 +50,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 1f9bffd2..239f6c92 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -52,7 +52,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 _require_attrs
 
 # max(16384, PAGE_SIZE) is the default leaf/node size on btrfs-progs v3.12+.
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index 8d6541aa..b2e6c2f8 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -57,7 +57,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/083 b/tests/btrfs/083
index 80c8cc39..775b12bc 100755
--- a/tests/btrfs/083
+++ b/tests/btrfs/083
@@ -51,7 +51,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/084 b/tests/btrfs/084
index 0dc94068..93f893be 100755
--- a/tests/btrfs/084
+++ b/tests/btrfs/084
@@ -50,7 +50,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/087 b/tests/btrfs/087
index 15b050db..dfa9c36b 100755
--- a/tests/btrfs/087
+++ b/tests/btrfs/087
@@ -56,7 +56,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/092 b/tests/btrfs/092
index 5f9c5d60..100cb63e 100755
--- a/tests/btrfs/092
+++ b/tests/btrfs/092
@@ -55,7 +55,6 @@ _cleanup()
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/127 b/tests/btrfs/127
index d1e873ac..e4b27d7c 100755
--- a/tests/btrfs/127
+++ b/tests/btrfs/127
@@ -48,7 +48,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/128 b/tests/btrfs/128
index b5563a7a..5470e0ed 100755
--- a/tests/btrfs/128
+++ b/tests/btrfs/128
@@ -47,7 +47,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/129 b/tests/btrfs/129
index e1fb7b50..e8b6317b 100755
--- a/tests/btrfs/129
+++ b/tests/btrfs/129
@@ -48,7 +48,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/133 b/tests/btrfs/133
index 34b6c131..858d90cb 100755
--- a/tests/btrfs/133
+++ b/tests/btrfs/133
@@ -48,7 +48,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/134 b/tests/btrfs/134
index f6520088..e41a71fd 100755
--- a/tests/btrfs/134
+++ b/tests/btrfs/134
@@ -48,7 +48,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/135 b/tests/btrfs/135
index 2199d6ae..99aefd35 100755
--- a/tests/btrfs/135
+++ b/tests/btrfs/135
@@ -49,7 +49,6 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_fssum
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
-- 
2.11.0.rc0.7.gbe5a750

