Received: from mail.cn.fujitsu.com ([183.91.158.132]:50661 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750841AbeASFqy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Jan 2018 00:46:54 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v6 2/3] common: Add _require_no_xfs_bug_on_assert && Factor out filter_xfs_dmesg
Date: Fri, 19 Jan 2018 13:38:05 +0800
Message-ID: <1516340286-21331-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180118182915.GI5606@magnolia>
References: <20180118182915.GI5606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com, eguan@redhat.com
Cc: david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org, xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) Introduce _require_no_xfs_bug_on_assert helper to check if XFS is built
   with CONFIG_XFS_ASSERT_FATAL, and call _require_no_xfs_debug if bug_on_assert
   is not available.

2) Apply _require_no_xfs_bug_on_assert in xfs/098 and xfs/115.

3) Move filter_xfs_dmesg from xfs/098 to common/filter, and rename
   it as _filter_assert_dmesg.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 common/filter | 11 +++++++++++
 common/xfs    | 22 ++++++++++++++++++++++
 tests/xfs/098 | 18 ++++++------------
 tests/xfs/115 |  5 ++---
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/common/filter b/common/filter
index 8e1fdb4..53874a0 100644
--- a/common/filter
+++ b/common/filter
@@ -570,5 +570,16 @@ _filter_aiodio_dmesg()
 	    -e "s#$warn9#Intentional warnings in dio_complete#"
 }
 
+# We generate assert related WARNINGs on purpose and make sure test doesn't fail
+# because of these warnings. This is a helper for _check_dmesg() to filter out
+# them.
+_filter_assert_dmesg()
+{
+	local warn1="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
+	local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
+	sed -e "s#$warn1#Intentional warnings in asswarn#" \
+	    -e "s#$warn2#Intentional warnings in assfail#"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/common/xfs b/common/xfs
index ab58364..72ad64d 100644
--- a/common/xfs
+++ b/common/xfs
@@ -625,6 +625,28 @@ _require_no_xfs_debug()
 	fi
 }
 
+# Require that assertions will not crash the system.
+_require_no_xfs_bug_on_assert()
+{
+	# Assertions would always crash the system if XFS assert fatal was
+	# enabled (CONFIG_XFS_ASSERT_FATAL=y).  If a test is designed to
+	# trigger an assertion, skip the test on a CONFIG_XFS_ASSERT_FATAL
+	# built XFS by default.
+	# Note: CONFIG_XFS_ASSERT_FATAL can be disabled by setting bug_on_assert
+	# to zero if we want test to run.
+	if [ -f /sys/fs/xfs/debug/bug_on_assert ]; then
+		grep -q "1" /sys/fs/xfs/debug/bug_on_assert && \
+		   _notrun "CONFIG_XFS_ASSERT_FATAL is enabled, but setting bug_on_assert can disable it at runtime"
+	else
+	# Note: Prior to the creation of CONFIG_XFS_ASSERT_FATAL (and the
+	# sysfs knob bug_on_assert), assertions would always crash the system
+	# if XFS debug was enabled (CONFIG_XFS_DEBUG=y).  If a test is designed
+	# to trigger an assertion and the test designer does not want to hang
+	# fstests, skip the test.
+		_require_no_xfs_debug
+	fi
+}
+
 # Get a metadata field
 # The first arg is the field name
 # The rest of the arguments are xfs_db commands to find the metadata.
diff --git a/tests/xfs/098 b/tests/xfs/098
index 9bcd94b..24ce1d5 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -47,6 +47,8 @@ _cleanup()
 _supported_fs xfs
 _supported_os Linux
 
+# We corrupt XFS on purpose, and check if assert failures would crash system.
+_require_no_xfs_bug_on_assert
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
 _require_attrs
@@ -56,16 +58,6 @@ test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-n 8 -3"
 
 rm -f $seqres.full
 
-# If we corrupt log on a CONFIG_XFS_WARN build, there will be mount related
-# WARNINGs in dmesg as expected.  We don't want to simply _disable_dmesg_check
-# which could miss other potential bugs, so filter out the intentional WARNINGs,
-# make sure test doesn't fail because of this warning and fails on other WARNINGs.
-filter_xfs_dmesg()
-{
-	local warn="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
-	sed -e "s#$warn#Intentional warnings in asswarn#"
-}
-
 TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
@@ -107,8 +99,10 @@ _scratch_mount 2>/dev/null && _fail "mount should not succeed"
 echo "+ repair fs"
 _repair_scratch_fs >> $seqres.full 2>&1
 
-# mount may trigger related WARNINGs, so filter them.
-_check_dmesg filter_xfs_dmesg
+# We may trigger assert related WARNINGs if we corrupt log on a
+# CONFIG_XFS_WARN or CONFIG_XFS_DEBUG (CONFIG_XFS_ASSERT_FATAL is
+# disabled) build, so filter them.
+_check_dmesg _filter_assert_dmesg
 
 echo "+ mount image (2)"
 _scratch_mount
diff --git a/tests/xfs/115 b/tests/xfs/115
index 0e62628..f77d0dd 100755
--- a/tests/xfs/115
+++ b/tests/xfs/115
@@ -52,9 +52,8 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch_nocheck
-# we corrupt XFS on purpose, and debug built XFS would crash due to assert
-# failure, so skip if we're testing on a debug built XFS
-_require_no_xfs_debug
+# We corrupt XFS on purpose, and check if assert failures would crash system.
+_require_no_xfs_bug_on_assert
 _disable_dmesg_check
 
 # Make sure we disable finobt if the filesystem supports it, otherwise, just
-- 
1.8.3.1



