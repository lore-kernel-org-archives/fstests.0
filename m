Received: from mx1.redhat.com ([209.132.183.28]:36152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbdALE1W (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Jan 2017 23:27:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC73A13A5E
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2017 04:27:22 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] fstests: remove tmp files properly
Date: Thu, 12 Jan 2017 12:27:14 +0800
Message-Id: <20170112042714.24385-1-eguan@redhat.com>
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
- let common helper functions do their cleanups by themselves,
  no hidden usage of $tmp
- only remove/adjust necessary files, don't do large scale test updates

 common/rc         | 4 ++++
 tests/generic/100 | 2 +-
 tests/generic/260 | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 5e54fc2..1f3727f 100644
--- a/common/rc
+++ b/common/rc
@@ -566,6 +566,7 @@ _scratch_mkfs_ext4()
 	# output mkfs stdout and stderr
 	cat $tmp.mkfsstd
 	cat $tmp.mkfserr >&2
+	rm -f $tmp*
 
 	return $mkfs_status
 }
@@ -1244,6 +1245,7 @@ _do()
     (eval "echo '---' \"$_cmd\"") >>$seqres.full
     (eval "$_cmd") >$tmp._out 2>&1; ret=$?
     cat $tmp._out | _fix_malloc >>$seqres.full
+    rm -f $tmp._out
     if [ $# -eq 2 ]; then
 	if [ $ret -eq 0 ]; then
 	    echo "done"
@@ -3150,8 +3152,10 @@ run_fsx()
 	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
 	if [ ${PIPESTATUS[0]} -ne 0 ]; then
 		cat $tmp.fsx
+		rm -f $tmp.fsx
 		exit 1
 	fi
+	rm -f $tmp.fsx
 }
 
 # Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
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
2.9.3

