Received: from mx1.redhat.com ([209.132.183.28]:38746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbdHCEdN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Aug 2017 00:33:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC34F4E4D2
        for <fstests@vger.kernel.org>; Thu,  3 Aug 2017 04:33:12 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] fstests: remove tmp files properly
Date: Thu,  3 Aug 2017 12:33:04 +0800
Message-Id: <20170803043304.17274-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests and common helpers don't properly clean up tmp files and
leave them behind in /tmp dir, and these tmp files are accumulating
over time.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- fix tmp_dir usage in _mkfs_dev as well

 common/rc         | 25 +++++++++++++++----------
 common/xfs        |  4 ++--
 tests/generic/100 |  2 +-
 tests/generic/260 |  2 +-
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/common/rc b/common/rc
index c7529796ad55..9c5f54aa6dc9 100644
--- a/common/rc
+++ b/common/rc
@@ -560,7 +560,7 @@ _scratch_do_mkfs()
 	shift 2
 	local extra_mkfs_options=$*
 	local mkfs_status
-	local tmp=`mktemp`
+	local tmp=`mktemp -u`
 
 	# save mkfs output in case conflict means we need to run again.
 	# only the output for the mkfs that applies should be shown
@@ -588,7 +588,7 @@ _scratch_do_mkfs()
 	cat $tmp.mkfsstd
 	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
 
-	rm -f $tmp*
+	rm -f $tmp.mkfserr $tmp.mkfsstd
 	return $mkfs_status
 }
 
@@ -669,7 +669,7 @@ _scratch_mkfs_ext4()
 {
 	local mkfs_cmd="$MKFS_EXT4_PROG -F"
 	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
-	local tmp=`mktemp`
+	local tmp=`mktemp -u`
 	local mkfs_status
 
 	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
@@ -694,6 +694,7 @@ _scratch_mkfs_ext4()
 	# output mkfs stdout and stderr
 	cat $tmp.mkfsstd
 	cat $tmp.mkfserr >&2
+	rm -f $tmp.mkfserr $tmp.mkfsstd
 
 	return $mkfs_status
 }
@@ -736,6 +737,7 @@ _test_mkfs()
 
 _mkfs_dev()
 {
+    local tmp=`mktemp -u`
     case $FSTYP in
     nfs*)
 	# do nothing for nfs
@@ -747,30 +749,30 @@ _mkfs_dev()
 	# do nothing for pvfs2
 	;;
     udf)
-        $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+        $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* \
-		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+		2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
 
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
-		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+		2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
     esac
 
     if [ $? -ne 0 ]; then
 	# output stored mkfs output
-	cat $tmp_dir.mkfserr >&2
-	cat $tmp_dir.mkfsstd
+	cat $tmp.mkfserr >&2
+	cat $tmp.mkfsstd
 	status=1
 	exit 1
     fi
-    rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
+    rm -f $tmp.mkfserr $tmp.mkfsstd
 }
 
 # remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
@@ -1431,6 +1433,7 @@ _do()
     (eval "echo '---' \"$_cmd\"") >>$seqres.full
     (eval "$_cmd") >$tmp._out 2>&1; ret=$?
     cat $tmp._out | _fix_malloc >>$seqres.full
+    rm -f $tmp._out
     if [ $# -eq 2 ]; then
 	if [ $ret -eq 0 ]; then
 	    echo "done"
@@ -3565,8 +3568,10 @@ run_fsx()
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
index a1ee384786bb..729a6ccf292b 100644
--- a/common/xfs
+++ b/common/xfs
@@ -82,7 +82,7 @@ _scratch_mkfs_xfs()
 	local mkfs_cmd="`_scratch_mkfs_xfs_opts`"
 	local mkfs_filter="sed -e '/less than device physical sector/d' \
 			       -e '/switching to logical sector/d'"
-	local tmp=`mktemp`
+	local tmp=`mktemp -u`
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
index 8aff7b445ce6..0e928cecc86a 100755
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
index 312e6d206fb3..4c152929424a 100755
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
2.13.3

