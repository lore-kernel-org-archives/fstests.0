Received: from cn.fujitsu.com ([59.151.112.132]:55691 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752140AbdGXKoj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2017 06:44:39 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/rc: factor out _ext4_disable_extent_zeroout() helper
Date: Mon, 24 Jul 2017 18:44:31 +0800
Message-ID: <1500893071-15192-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170724100423.GD9167@eguan.usersys.redhat.com>
References: <20170724100423.GD9167@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) This pattern is repeated in several seek_data/hole tests
   (e.g. generic/285, generic/436, generic/445 generic/448)
   and generic/009.  A common _ext4_disable_extent_zeroout()
   helper could be added and applied by generic/009 and
   _require_seek_data_hole().

2) On some old kernels(e.g. v3.1-v3.6), when vfs recognizes
   SEEK_DATA/HOLE flag && ext4 has no extent zeroout tunable
   in sysfs, these cases may trigger "sysfs entry not found"
   issue.  We can add check if extent_max_zeroout_kb exists
   on ext4 filesystem.
   The extent_max_zeroout_kb is introduced by:
   '67a5da564f97 ("ext4: make the zero-out chunk size tunable")'

3) Declare several vars as local in _require_seek_data_hole().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc         | 29 ++++++++++++++++++++++-------
 tests/generic/009 |  3 +--
 tests/generic/285 |  6 ------
 tests/generic/436 |  6 ------
 tests/generic/445 |  6 ------
 tests/generic/448 |  6 ------
 6 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/common/rc b/common/rc
index bd989bb..49887cf 100644
--- a/common/rc
+++ b/common/rc
@@ -2304,16 +2304,31 @@ _require_fail_make_request()
  not found. Seems that CONFIG_FAIL_MAKE_REQUEST kernel config option not enabled"
 }
 
-#
+# Disable extent zeroing for ext4 on the given device
+_ext4_disable_extent_zeroout()
+{
+	local dev=${1:-$TEST_DEV}
+	local sdev=`_short_dev $dev`
+
+	[ -f /sys/fs/ext4/$sdev/extent_max_zeroout_kb ] && \
+		echo 0 >/sys/fs/ext4/$sdev/extent_max_zeroout_kb
+}
+
 # Check if the file system supports seek_data/hole
-#
 _require_seek_data_hole()
 {
-    testfile=$TEST_DIR/$$.seek
-    testseek=`$here/src/seek_sanity_test -t $testfile 2>&1`
-    rm -f $testfile &>/dev/null
-    echo $testseek | grep -q "Kernel does not support" && \
-        _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
+	local dev=${1:-$TEST_DEV}
+	local testfile=$TEST_DIR/$$.seek
+	local testseek=`$here/src/seek_sanity_test -t $testfile 2>&1`
+
+	rm -f $testfile &>/dev/null
+	echo $testseek | grep -q "Kernel does not support" && \
+		_notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
+	# Disable extent zeroing for ext4 as that change where holes are
+	# created
+	if [ "$FSTYP" = "ext4" ]; then
+		_ext4_disable_extent_zeroout $dev
+	fi
 }
 
 _require_runas()
diff --git a/tests/generic/009 b/tests/generic/009
index 5902afd..797def5 100755
--- a/tests/generic/009
+++ b/tests/generic/009
@@ -53,8 +53,7 @@ testfile=$TEST_DIR/009.$$
 
 # Disable extent zeroing for ext4 as that change where holes are created
 if [ "$FSTYP" = "ext4" ]; then
-	DEV=`_short_dev $TEST_DEV`
-	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
+	_ext4_disable_extent_zeroout
 fi
 
 # When PAGE_SIZE > 4096 xfs extent layout is different so it would not match
diff --git a/tests/generic/285 b/tests/generic/285
index 16e70b1..3f7d298 100755
--- a/tests/generic/285
+++ b/tests/generic/285
@@ -47,12 +47,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
 
 _require_test_program "seek_sanity_test"
 
-# Disable extent zeroing for ext4 as that change where holes are created
-if [ "$FSTYP" = "ext4" ]; then
-	DEV=`_short_dev $TEST_DEV`
-	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
-fi
-
 _cleanup()
 {
 	eval "rm -f $BASE_TEST_FILE.*"
diff --git a/tests/generic/436 b/tests/generic/436
index bcd6ddc..6cda008 100755
--- a/tests/generic/436
+++ b/tests/generic/436
@@ -44,12 +44,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
 
 _require_test_program "seek_sanity_test"
 
-# Disable extent zeroing for ext4 as that change where holes are created
-if [ "$FSTYP" = "ext4" ]; then
-	DEV=`_short_dev $TEST_DEV`
-	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
-fi
-
 _cleanup()
 {
 	rm -f $tmp.* $BASE_TEST_FILE.*
diff --git a/tests/generic/445 b/tests/generic/445
index 81dd916..323a0ca 100755
--- a/tests/generic/445
+++ b/tests/generic/445
@@ -44,12 +44,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
 
 _require_test_program "seek_sanity_test"
 
-# Disable extent zeroing for ext4 as that change where holes are created
-if [ "$FSTYP" = "ext4" ]; then
-	DEV=`_short_dev $TEST_DEV`
-	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
-fi
-
 _cleanup()
 {
 	rm -f $tmp.* $BASE_TEST_FILE.*
diff --git a/tests/generic/448 b/tests/generic/448
index 87b99d7..22656f6 100755
--- a/tests/generic/448
+++ b/tests/generic/448
@@ -48,12 +48,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
 
 _require_test_program "seek_sanity_test"
 
-# Disable extent zeroing for ext4 as that change where holes are created
-if [ "$FSTYP" = "ext4" ]; then
-	DEV=`_short_dev $TEST_DEV`
-	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
-fi
-
 $here/src/seek_sanity_test -s 18 -e 18 $BASE_TEST_FILE > $seqres.full 2>&1 ||
 	_fail "seek sanity check failed!"
 
-- 
1.8.3.1



