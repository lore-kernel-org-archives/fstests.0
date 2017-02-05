Received: from imap.thunk.org ([74.207.234.97]:33748 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbdBEGxq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 01:53:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] common/log: add ext4 support for log state probing
Date: Sun,  5 Feb 2017 01:53:35 -0500
Message-Id: <20170205065336.14994-2-tytso@mit.edu>
In-Reply-To: <20170205065336.14994-1-tytso@mit.edu>
References: <20170205065336.14994-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This enables generic/052, generic/054, and generic/055 for ext4.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/log | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/common/log b/common/log
index 82899c67..d1c19ff5 100644
--- a/common/log
+++ b/common/log
@@ -228,6 +228,14 @@ _scratch_f2fs_logstate()
     echo $?
 }
 
+_scratch_ext4_logstate()
+{
+    $DUMPE2FS_PROG -h $SCRATCH_DEV 2> /dev/null | tee -a $seqres.full | \
+	grep "^Filesystem features" | grep -q needs_recovery
+    test $? -ne 0
+    echo $?
+}
+
 _scratch_dump_log()
 {
 	case "$FSTYP" in
@@ -237,6 +245,9 @@ _scratch_dump_log()
 	f2fs)
 		$DUMP_F2FS_PROG $SCRATCH_DEV
 		;;
+	ext4)
+		$DUMPE2FS_PROG -h $SCRATCH_DEV
+		;;
 	*)
 		;;
 	esac
@@ -251,6 +262,9 @@ _test_dump_log()
 	f2fs)
 		$DUMP_F2FS_PROG $TEST_DEV
 		;;
+	ext4)
+		$DUMPE2FS_PROG -h $TEST_DEV
+		;;
 	*)
 		;;
 	esac
@@ -265,6 +279,9 @@ _print_logstate()
     f2fs)
         dirty=$(_scratch_f2fs_logstate)
         ;;
+    ext4)
+        dirty=$(_scratch_ext4_logstate)
+        ;;
     *)
         ;;
     esac
@@ -532,6 +549,11 @@ _require_logstate()
             _notrun "This test requires dump.f2fs utility."
         fi
         ;;
+    ext4)
+	if [ -z "$DUMPE2FS_PROG" ]; then
+		_notrun "This test requires dumpe2fs utility."
+	fi
+	;;
     *)
         _notrun "$FSTYP does not support log state probing."
         ;;
@@ -570,6 +592,22 @@ _f2fs_log_config()
     echo "  test10    active_logs=6,background_gc=on,discard,inline_data,inline_dentry"
 }
 
+_ext4_log_config()
+{
+    echo "# mkfs-opt             mount-opt"
+    echo "# ------------------------------"
+    echo "  /dev/null     data=writeback"
+    echo "  /dev/null     data=ordered"
+    echo "  /dev/null     data=journal"
+    echo "  /dev/null     data=ordered,data_err=abort"
+    echo "  /dev/null     data=writeback,nojournal_checksum"
+    echo "  /dev/null     data=ordered,nojournal_checksum"
+    echo "  /dev/null     data=journal,nojournal_checksum"
+    echo "  /dev/null     data=ordered,data_err=abort,nojournal_checksum"
+    echo "  /dev/null     data=writeback,journal_checksum"
+    echo "  /dev/null     data=ordered,journal_checksum"
+}
+
 _get_log_configs()
 {
     case "$FSTYP" in
@@ -579,6 +617,9 @@ _get_log_configs()
     f2fs)
         _f2fs_log_config
         ;;
+    ext4)
+        _ext4_log_config
+        ;;
     *)
         _notrun "$FSTYP does not support log configs."
         ;;
-- 
2.11.0.rc0.7.gbe5a750

