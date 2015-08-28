Received: from nebula-exfe-01.nebula.fi ([83.145.198.163]:43985 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751965AbbH1KZm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 28 Aug 2015 06:25:42 -0400
Message-ID: <1440757500.29614.26.camel@ari-macbook>
Subject: [PATCH 1/2 v2] Add checks for hard links support.
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 28 Aug 2015 13:25:00 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

There are filesystems that do not support hard links that we want to run
xfstests on. Add a function for checking for support and use it wherever
hard links are used.

v2: Move all checks for hard link support to this patch.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 common/rc         |   12 ++++++++++++
 tests/generic/002 |    1 +
 tests/generic/039 |    1 +
 tests/generic/040 |    1 +
 tests/generic/041 |    1 +
 tests/generic/056 |    1 +
 tests/generic/057 |    1 +
 tests/generic/065 |    1 +
 tests/generic/066 |    1 +
 tests/generic/084 |    1 +
 tests/generic/090 |    1 +
 tests/generic/104 |    1 +
 tests/generic/106 |    1 +
 tests/generic/236 |    1 +
 tests/generic/294 |    1 +
 15 files changed, 26 insertions(+)

diff --git a/common/rc b/common/rc
index 780b7ed..d3aeddf 100644
--- a/common/rc
+++ b/common/rc
@@ -2714,6 +2714,18 @@ _require_test_symlinks()
 	rm -f $target $link
 }
 
+_require_test_hardlinks()
+{
+	target=`mktemp -p $TEST_DIR`
+	link=`mktemp -p $TEST_DIR -u`
+	ln `basename $target` $link
+	if [ "$?" -ne 0 ]; then
+		rm -f $target
+		_notrun "Require hardlinks support"
+	fi
+	rm -f $target $link
+}
+
 _require_test_fcntl_advisory_locks()
 {
 	[ "$FSTYP" != "cifs" ] && return 0
diff --git a/tests/generic/002 b/tests/generic/002
index f63b208..0b96709 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -43,6 +43,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _supported_os IRIX Linux
+_require_test_hardlinks
 _require_test
 
 echo "Silence is goodness ..."
diff --git a/tests/generic/039 b/tests/generic/039
index 4bbfc50..367a6d0 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -55,6 +55,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/040 b/tests/generic/040
index c841fbc..1b8287f 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -60,6 +60,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/041 b/tests/generic/041
index f38b662..588d5ff 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -64,6 +64,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/056 b/tests/generic/056
index 8bb1522..e111bec 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -53,6 +53,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/057 b/tests/generic/057
index 3b9f89e..d3b1aa2 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -53,6 +53,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/065 b/tests/generic/065
index 739a4d5..5403c53 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -54,6 +54,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/066 b/tests/generic/066
index cb36506..51aa22a 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -58,6 +58,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_attrs
diff --git a/tests/generic/084 b/tests/generic/084
index 3fec6c2..86c38db 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -46,6 +46,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
+_require_test_hardlinks
 _require_scratch
 
 link_unlink_storm()
diff --git a/tests/generic/090 b/tests/generic/090
index a1f2b89..c3eeb1a 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -52,6 +52,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/104 b/tests/generic/104
index eeb7363..9fed5f2 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -48,6 +48,7 @@ _cleanup()
 _need_to_be_root
 _supported_fs generic
 _supported_os Linux
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/106 b/tests/generic/106
index 0afee41..59efe7c 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -47,6 +47,7 @@ _cleanup()
 _need_to_be_root
 _supported_fs generic
 _supported_os Linux
+_require_test_hardlinks
 _require_scratch
 _require_dm_flakey
 _require_metadata_journaling $SCRATCH_DEV
diff --git a/tests/generic/236 b/tests/generic/236
index 12ea0bc..df0250f 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 # only Linux supports fallocate
 _supported_os Linux
+_require_test_hardlinks
 _require_test
 
 rm -f $TEST_DIR/ouch*
diff --git a/tests/generic/294 b/tests/generic/294
index 3fa6ba2..944b6a1 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -46,6 +46,7 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs generic
 _supported_os Linux
+_require_test_hardlinks
 _require_scratch
 
 rm -f $seqres.full
-- 
1.7.10.4



