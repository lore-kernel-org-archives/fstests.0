Received: from mx2.suse.de ([195.135.220.15]:38165 "EHLO mx2.suse.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751458AbeERICz
 (ORCPT <rfc822;fstests@vger.kernel.org>); Fri, 18 May 2018 04:02:55 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254]) by
 mx2.suse.de (Postfix) with ESMTP id D4244AEA1 for <fstests@vger.kernel.org>;
 Fri, 18 May 2018 08:02:53 +0000 (UTC)
MIME-Version: 1.0
Message-ID: <20180518080239.31492-1-jack@suse.cz>
Date: Fri, 18 May 2018 01:02:39 -0700 (PDT)
From: Jan Kara <jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
Subject: [PATCH] Handle missing [gs]etcap tools
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Add proper requires for getcap and setcap tools to tests that need them.
Also define standard variables GETCAP_PROG and SETCAP_PROG.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/config     |  2 ++
 tests/generic/093 | 10 ++++++----
 tests/generic/270 |  6 ++----
 tests/xfs/296     |  8 +++++---
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/common/config b/common/config
index cc3180694e26..4ea141809d4c 100644
--- a/common/config
+++ b/common/config
@@ -204,6 +204,8 @@ export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
 export THIN_CHECK_PROG="$(set_prog_path thin_check)"
 export PYTHON2_PROG="`set_prog_path python2`"
 export SQLITE3_PROG="`set_prog_path sqlite3`"
+export SETCAP_PROG="`set_prog_path setcap`"
+export GETCAP_PROG="`set_prog_path getcap`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/generic/093 b/tests/generic/093
index 197e6722f22c..e70273bca7f2 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -54,6 +54,8 @@ _require_test
 _require_attrs
 _require_user
 _require_test_program "writemod"
+_require_command "$SETCAP_PROG" "setcap"
+_require_command "$GETCAP_PROG" "getcap"
 
 rm -f $seqres.full
 
@@ -65,15 +67,15 @@ rm -f $file
 touch $file
 
 echo "**** Verifying that appending to file clears capabilities ****"
-setcap cap_chown+ep $file
-getcap $file | filefilter
+$SETCAP_PROG cap_chown+ep $file
+$GETCAP_PROG $file | filefilter
 echo data1 >> $file
 cat $file
-getcap $file | filefilter
+$GETCAP_PROG $file | filefilter
 echo
 
 echo "**** Verifying that appending to file doesn't clear other xattrs ****"
-setcap cap_chown+ep $file
+$SETCAP_PROG cap_chown+ep $file
 $SETFATTR_PROG -n trusted.name -v value $file
 echo data2 >> $file
 cat $file
diff --git a/tests/generic/270 b/tests/generic/270
index f5026ba0cd30..d597ab494286 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -51,10 +51,7 @@ _workout()
 	echo "fsstress $args" >> $seqres.full
 	# Grant chown capability 
 	cp $FSSTRESS_PROG  $tmp.fsstress.bin
-	if [ "`whereis setcap`" == "setcap:" ]; then
-            _notrun "setcap not installed."
-	fi
-	setcap cap_chown=epi  $tmp.fsstress.bin
+	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
 
 	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
 	pid=$!
@@ -80,6 +77,7 @@ _require_quota
 _require_user
 _require_scratch
 _require_command "$KILLALL_PROG" killall
+_require_command "$SETCAP_PROG" setcap
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
diff --git a/tests/xfs/296 b/tests/xfs/296
index 610c2ec426c6..8baf97abdd7e 100755
--- a/tests/xfs/296
+++ b/tests/xfs/296
@@ -47,6 +47,8 @@ _cleanup()
 _supported_fs xfs
 _supported_os Linux
 _require_scratch
+_require_command "$SETCAP_PROG" setcap
+_require_command "$GETCAP_PROG" getcap
 
 rm -f $seqres.full
 
@@ -57,12 +59,12 @@ echo test > $dump_dir/testfile
 # Set a generic xattr
 setfattr -n user.name -v value $dump_dir/testfile
 # Now set the cap (which is also an xattr)
-setcap cap_setgid,cap_setuid+ep $dump_dir/testfile
+$SETCAP_PROG cap_setgid,cap_setuid+ep $dump_dir/testfile
 # And make sure they are there on the source
 echo "Checking for xattr on source file"
 getfattr --absolute-names -m user.name $dump_dir/testfile | _dir_filter
 echo "Checking for capability on source file"
-getcap $dump_dir/testfile | _dir_filter
+$GETCAP_PROG $dump_dir/testfile | _dir_filter
 getfattr --absolute-names -m security.capability $dump_dir/testfile | _dir_filter
 
 _do_dump_file -f $tmp.df.0
@@ -75,7 +77,7 @@ _diff_compare
 echo "Checking for xattr on restored file"
 getfattr --absolute-names -m user.name $restore_dir/$dump_sdir/testfile | _dir_filter
 echo "Checking for capability on restored file"
-getcap $restore_dir/$dump_sdir/testfile | _dir_filter
+$GETCAP_PROG $restore_dir/$dump_sdir/testfile | _dir_filter
 getfattr --absolute-names -m security.capability $restore_dir/$dump_sdir/testfile | _dir_filter
 
 status=0
-- 
2.13.6

