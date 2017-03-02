Received: from imap.thunk.org ([74.207.234.97]:47990 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbdCCBIH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 2 Mar 2017 20:08:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [RFC PATCH] check: try to fix the test device if it gets corrupted
Date: Thu,  2 Mar 2017 18:20:50 -0500
Message-Id: <20170302232050.31125-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

If the test device gets corrupted all subsequent tests will fail.  To
prevent this from causing all subsequent tests to be useless, try
repair the file system on TEST_DEV if possible.  We don't need to do
this with the scratch device since that file system gets recreated
each time anyway.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

This is a quick hack that I needed while debubgging some research
code[1].  It turns out that when the grad student is up against a
paper deadline is an, this becomes amazing evolutionary process which
creates file system modifications which are optimized for running
postmark and file bench --- and falls over very easily otherwise.  So
when TEST_DEV is getting corrupted very frequently, it's nice to be
able to continue running other tests in the quick or auto group.

So please consider this a proof-concept-patch; would people consider
it worthwhile to have this in xfstests upstream?

 check     |  6 +++++-
 common/rc | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 5d7f75c4..62f8ff41 100755
--- a/check
+++ b/check
@@ -455,7 +455,11 @@ _summary()
 _check_filesystems()
 {
 	if [ -f ${RESULT_DIR}/require_test ]; then
-		_check_test_fs || err=true
+		if ! _check_test_fs ; then
+		    err=true
+		    echo "Trying to repair broken TEST_DEV file system"
+		    _repair_test_fs
+		fi
 		rm -f ${RESULT_DIR}/require_test*
 	fi
 	if [ -f ${RESULT_DIR}/require_scratch ]; then
diff --git a/common/rc b/common/rc
index 2be55e6f..60af86fc 100644
--- a/common/rc
+++ b/common/rc
@@ -1098,6 +1098,28 @@ _repair_scratch_fs()
     esac
 }
 
+_repair_test_fs()
+{
+    case $FSTYP in
+    ext2|ext3|ext4)
+        fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
+	if test $? -ge 4 ; then
+	    echo "_repair_test_fs: couldn't repair filesystem on $device (see $seqres.full)"
+
+	    echo "_repair_test_fs: couldn't repair filesystem on $device" >>$seqres.full
+	    echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+            cat $tmp.repair			>>$seqres.full
+	    echo "*** end fsck.$FSTYP output"	>>$seqres.full
+	    return 1
+	fi
+	return 0
+	;;
+    *)
+	return 1
+	;;
+    esac
+}
+
 _get_pids_by_name()
 {
     if [ $# -ne 1 ]
-- 
2.11.0.rc0.7.gbe5a750

