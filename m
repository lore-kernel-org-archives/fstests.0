Received: from mx1.redhat.com ([209.132.183.28]:50414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdF0Edk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Jun 2017 00:33:40 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] fstests: remove tmp files properly
Date: Tue, 27 Jun 2017 12:33:25 +0800
Message-Id: <20170627043325.15527-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ddiss@suse.de, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests and common helpers don't properly clean up tmp files and
leave them behind in /tmp dir, and these tmp files are accumulating
over time.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc         | 10 +++++++---
 common/xfs        |  4 ++--
 tests/generic/100 |  2 +-
 tests/generic/260 |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 2972f89..1fbe9d0 100644
--- a/common/rc
+++ b/common/rc
@@ -567,7 +567,7 @@ _scratch_do_mkfs()
 	shift 2
 	local extra_mkfs_options=$*
 	local mkfs_status
-	local tmp=`mktemp`
+	local tmp=/tmp/$$._mkfs
 
 	# save mkfs output in case conflict means we need to run again.
 	# only the output for the mkfs that applies should be shown
@@ -595,7 +595,7 @@ _scratch_do_mkfs()
 	cat $tmp.mkfsstd
 	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
 
-	rm -f $tmp*
+	rm -f $tmp.mkfserr $tmp.mkfsstd
 	return $mkfs_status
 }
 
@@ -676,7 +676,7 @@ _scratch_mkfs_ext4()
 {
 	local mkfs_cmd="$MKFS_EXT4_PROG -F"
 	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
-	local tmp=`mktemp`
+	local tmp=/tmp/$$._mkfs
 	local mkfs_status
 
 	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
@@ -701,6 +701,7 @@ _scratch_mkfs_ext4()
 	# output mkfs stdout and stderr
 	cat $tmp.mkfsstd
 	cat $tmp.mkfserr >&2
+	rm -f $tmp.mkfserr $tmp.mkfsstd
 
 	return $mkfs_status
 }
@@ -1429,6 +1430,7 @@ _do()
     (eval "echo '---' \"$_cmd\"") >>$seqres.full
     (eval "$_cmd") >$tmp._out 2>&1; ret=$?
     cat $tmp._out | _fix_malloc >>$seqres.full
+    rm -f $tmp._out
     if [ $# -eq 2 ]; then
 	if [ $ret -eq 0 ]; then
 	    echo "done"
@@ -3542,8 +3544,10 @@ run_fsx()
 	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
 	if [ ${PIPESTATUS[0]} -ne 0 ]; then
 		cat $tmp.fsx
+		rm -f $tmp.fsx
 		exit 1
 	fi
+	rm -f $tmp.fsx
 }
 
 # Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
diff --git a/common/xfs b/common/xfs
index 0f0825b..42f3f57 100644
--- a/common/xfs
+++ b/common/xfs
@@ -82,7 +82,7 @@ _scratch_mkfs_xfs()
 	local mkfs_cmd="`_scratch_mkfs_xfs_opts`"
 	local mkfs_filter="sed -e '/less than device physical sector/d' \
 			       -e '/switching to logical sector/d'"
-	local tmp=`mktemp`
+	local tmp=/tmp/$$._mkfs
 	local mkfs_status
 
 	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
@@ -104,7 +104,7 @@ _scratch_mkfs_xfs()
 	# output mkfs stdout and stderr
 	cat $tmp.mkfsstd
 	cat $tmp.mkfserr >&2
-	rm -f $tmp*
+	rm -f $tmp.mkfserr $tmp.mkfsstd
 
 	return $mkfs_status
 }
diff --git a/tests/generic/100 b/tests/generic/100
index e5e819d..161982f 100755
--- a/tests/generic/100
+++ b/tests/generic/100
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-     rm -f $tmp.* $testfile
+     rm -f $tmp.* $TEMP_DIR/$TAR_FILE
 }
  
 # real QA test starts here
diff --git a/tests/generic/260 b/tests/generic/260
index 312e6d2..4c15292 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -26,7 +26,7 @@ seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
 here=`pwd`
-tmp=`mktemp -d`
+tmp=/tmp/$$
 status=0
 trap "exit \$status" 0 1 2 3 15
 chpid=0
-- 
2.9.4

