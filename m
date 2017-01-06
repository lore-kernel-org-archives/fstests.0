Received: from mx1.redhat.com ([209.132.183.28]:44534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936283AbdAFDqy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Jan 2017 22:46:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F34F7C057FA6
        for <fstests@vger.kernel.org>; Fri,  6 Jan 2017 03:45:52 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] fstests: cleanup tmp files in tests
Date: Fri,  6 Jan 2017 11:45:07 +0800
Message-Id: <20170106034507.5915-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

$tmp.* files should be removed in _cleanup() even if the test is not
using any $tmp.* file explicitly, because common helper functions
may take use of them too.

So cleanup tmp files properly in tests, and add a _cleanup()
function and trap it on exit if the test doesn't do so, to make all
tests consistent on the way they do cleanup.

Also remove other tmp files used by the tests and the harness so
that we leave no new tmp files in /tmp dir after a full test run.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc         |  1 +
 tests/btrfs/011   |  2 +-
 tests/btrfs/014   |  8 ++++++++
 tests/btrfs/025   |  3 ++-
 tests/btrfs/030   |  3 ++-
 tests/btrfs/034   |  3 ++-
 tests/btrfs/037   |  4 ++--
 tests/btrfs/038   |  3 ++-
 tests/btrfs/039   |  3 ++-
 tests/btrfs/040   |  3 ++-
 tests/btrfs/041   |  2 +-
 tests/btrfs/043   |  3 ++-
 tests/btrfs/044   |  3 ++-
 tests/btrfs/045   |  3 ++-
 tests/btrfs/046   |  4 ++--
 tests/btrfs/048   |  4 ++--
 tests/btrfs/049   |  2 +-
 tests/btrfs/050   |  4 ++--
 tests/btrfs/051   |  4 ++--
 tests/btrfs/052   |  2 +-
 tests/btrfs/053   |  4 ++--
 tests/btrfs/054   |  4 ++--
 tests/btrfs/055   |  2 +-
 tests/btrfs/056   |  2 +-
 tests/btrfs/058   |  2 +-
 tests/btrfs/059   |  2 +-
 tests/btrfs/076   |  2 +-
 tests/btrfs/077   |  6 +++---
 tests/btrfs/078   |  4 ++--
 tests/ext4/003    |  4 +++-
 tests/ext4/305    |  6 ++++--
 tests/ext4/306    |  4 +++-
 tests/generic/004 |  5 +++--
 tests/generic/005 |  7 ++++---
 tests/generic/008 |  9 ++++++++-
 tests/generic/013 | 19 ++++++++++---------
 tests/generic/015 |  1 +
 tests/generic/034 |  2 ++
 tests/generic/038 |  2 +-
 tests/generic/039 |  1 +
 tests/generic/040 |  1 +
 tests/generic/041 |  1 +
 tests/generic/043 |  8 +++++++-
 tests/generic/044 |  7 ++++++-
 tests/generic/045 |  7 ++++++-
 tests/generic/046 |  7 ++++++-
 tests/generic/047 |  7 ++++++-
 tests/generic/048 |  7 ++++++-
 tests/generic/049 |  7 ++++++-
 tests/generic/050 |  1 +
 tests/generic/068 |  8 +++-----
 tests/generic/079 |  9 +++++----
 tests/generic/087 |  3 ++-
 tests/generic/093 |  3 ++-
 tests/generic/100 |  2 +-
 tests/generic/102 |  7 ++++++-
 tests/generic/105 |  3 ++-
 tests/generic/113 |  5 +++--
 tests/generic/114 |  5 +++--
 tests/generic/123 |  7 ++++---
 tests/generic/124 |  3 ++-
 tests/generic/125 |  7 ++++++-
 tests/generic/126 |  3 ++-
 tests/generic/127 |  3 ++-
 tests/generic/128 |  7 ++++++-
 tests/generic/129 |  7 ++++++-
 tests/generic/130 |  7 ++++++-
 tests/generic/131 |  5 +++--
 tests/generic/132 |  7 ++++++-
 tests/generic/133 |  7 ++++++-
 tests/generic/135 |  7 ++++++-
 tests/generic/141 |  7 ++++++-
 tests/generic/192 |  1 +
 tests/generic/193 |  8 +++++++-
 tests/generic/215 |  1 +
 tests/generic/221 |  6 ++++++
 tests/generic/236 |  2 ++
 tests/generic/239 |  5 +++--
 tests/generic/245 |  1 +
 tests/generic/246 |  1 +
 tests/generic/251 |  1 +
 tests/generic/257 |  1 +
 tests/generic/260 |  9 +++++++--
 tests/generic/275 |  1 +
 tests/generic/277 |  4 +++-
 tests/generic/285 |  2 ++
 tests/generic/286 |  2 ++
 tests/generic/288 |  8 +++++++-
 tests/generic/307 |  2 ++
 tests/generic/308 |  2 ++
 tests/generic/309 |  8 +++++---
 tests/generic/310 |  2 ++
 tests/generic/311 |  2 ++
 tests/generic/313 |  6 ++++--
 tests/generic/317 |  5 +++--
 tests/generic/318 |  5 +++--
 tests/generic/321 |  2 ++
 tests/generic/322 |  2 ++
 tests/generic/325 |  2 ++
 tests/shared/298  |  1 +
 tests/xfs/009     |  5 +++--
 tests/xfs/142     |  7 ++++++-
 tests/xfs/143     |  7 ++++++-
 tests/xfs/144     |  7 ++++++-
 tests/xfs/145     |  7 ++++++-
 tests/xfs/146     |  7 ++++++-
 tests/xfs/147     |  7 ++++++-
 tests/xfs/150     |  7 ++++++-
 tests/xfs/151     |  7 ++++++-
 tests/xfs/152     |  7 ++++++-
 tests/xfs/153     |  7 ++++++-
 tests/xfs/154     |  7 ++++++-
 tests/xfs/155     |  7 ++++++-
 tests/xfs/156     |  7 ++++++-
 tests/xfs/157     |  7 ++++++-
 tests/xfs/158     |  7 ++++++-
 tests/xfs/159     |  7 ++++++-
 tests/xfs/160     |  7 ++++++-
 tests/xfs/161     |  7 ++++++-
 tests/xfs/162     |  7 ++++++-
 tests/xfs/163     |  7 ++++++-
 tests/xfs/166     |  7 ++++++-
 tests/xfs/167     |  1 +
 tests/xfs/168     |  7 ++++++-
 tests/xfs/175     |  2 +-
 tests/xfs/176     |  2 +-
 tests/xfs/185     |  7 ++++++-
 tests/xfs/190     |  7 +++++++
 tests/xfs/195     |  1 +
 tests/xfs/197     |  1 +
 tests/xfs/199     |  1 +
 tests/xfs/201     |  1 +
 tests/xfs/202     |  6 ++++++
 tests/xfs/203     |  1 +
 tests/xfs/205     |  6 ++++++
 tests/xfs/206     |  9 +++++----
 tests/xfs/220     |  1 +
 tests/xfs/229     |  3 ++-
 tests/xfs/250     |  1 +
 tests/xfs/259     |  4 +++-
 tests/xfs/261     |  4 ++--
 tests/xfs/290     |  7 ++++++-
 142 files changed, 493 insertions(+), 150 deletions(-)

diff --git a/common/rc b/common/rc
index 159e73a..e761735 100644
--- a/common/rc
+++ b/common/rc
@@ -566,6 +566,7 @@ _scratch_mkfs_ext4()
 	# output mkfs stdout and stderr
 	cat $tmp.mkfsstd
 	cat $tmp.mkfserr >&2
+	rm -f $tmp*
 
 	return $mkfs_status
 }
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 6bc5ba2..ee3d1e9 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -50,7 +50,7 @@ _cleanup()
 		kill -TERM $noise_pid
 	fi
 	wait
-	rm -f $tmp.tmp
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/btrfs/014 b/tests/btrfs/014
index 142423f..b099f0d 100755
--- a/tests/btrfs/014
+++ b/tests/btrfs/014
@@ -29,6 +29,14 @@ here="`pwd`"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+trap "_cleanup ; exit \$status" 0 1 2 3 15
+
 _create_snapshot()
 {
 	for i in $(seq 20)
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index 81ae943..4d1fe39 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -36,7 +36,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index a8e08f6..76ca4c4 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -42,7 +42,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index 179c827..9b8f621 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -33,7 +33,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/037 b/tests/btrfs/037
index 5c0ea66..24b4060 100755
--- a/tests/btrfs/037
+++ b/tests/btrfs/037
@@ -33,14 +33,14 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
-tmp=`mktemp -d`
+tmp=/tmp/$$
 
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index d75ed48..70373d0 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -38,7 +38,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index ac7144f..58a066d 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -41,7 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index c97ed50..2396dee 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -41,7 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/041 b/tests/btrfs/041
index 8bb74cd..4bd60cd 100755
--- a/tests/btrfs/041
+++ b/tests/btrfs/041
@@ -40,7 +40,7 @@ restore_dir=$TEST_DIR/btrfs-test-$seq
 
 _cleanup()
 {
-	rm -fr $tmp
+	rm -f $tmp.*
 	rm -fr $restore_dir
 }
 
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 1ba5acd..9b79b71 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -37,7 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 9d6d212..dbe6693 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -42,7 +42,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index bdafbab..f3184f2 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -58,7 +58,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 6bf5000..5964b36 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -32,7 +32,7 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
-tmp=`mktemp -d`
+tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -41,7 +41,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
 _cleanup()
 {
 	rm -fr $send_files_dir
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index e03b3c5..9a23969 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -34,8 +34,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $send_files_dir
-    rm -fr $tmp
+	rm -fr $send_files_dir
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index 4ec5dd8..f92f0cb 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	_cleanup_flakey
-	rm -rf $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index 9a1f5e4..a2a5432 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -40,8 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $send_files_dir
-    rm -fr $tmp
+	rm -fr $send_files_dir
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index 9ffbde3..b029449 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -37,8 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $send_files_dir
-    rm -fr $tmp
+	rm -fr $send_files_dir
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index 599d261..ef070d0 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -33,7 +33,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 06dcaff..69a7e54 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -38,8 +38,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $send_files_dir
-    rm -fr $tmp
+	rm -fr $send_files_dir
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/054 b/tests/btrfs/054
index 606fb40..adce001 100755
--- a/tests/btrfs/054
+++ b/tests/btrfs/054
@@ -46,8 +46,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $send_files_dir
-    rm -fr $tmp
+	rm -fr $send_files_dir
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/055 b/tests/btrfs/055
index 29afdba..dee80c3 100755
--- a/tests/btrfs/055
+++ b/tests/btrfs/055
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index ef515a1..0607213 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	_cleanup_flakey
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/058 b/tests/btrfs/058
index ecfe857..c2072aa 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -42,7 +42,7 @@ _cleanup()
 	if [ ! -z $XFS_IO_PID ]; then
 		kill $XFS_IO_PID > /dev/null 2>&1
 	fi
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 2d1ec23..16aa50b 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 1c86d81..735ab87 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	cd /
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index e56fe5b..4fa7114 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -39,14 +39,14 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
-tmp=`mktemp -d`
+tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -fr $send_files_dir
-    rm -fr $tmp
+	rm -fr $send_files_dir
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/btrfs/078 b/tests/btrfs/078
index 2c1dfa3..95261fe 100755
--- a/tests/btrfs/078
+++ b/tests/btrfs/078
@@ -34,13 +34,13 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
-tmp=`mktemp -d`
+tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/ext4/003 b/tests/ext4/003
index 53875a9..11767ae 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -20,13 +20,15 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    _scratch_unmount
+	_scratch_unmount
+	rm $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/ext4/305 b/tests/ext4/305
index 09db2e1..58444d8 100755
--- a/tests/ext4/305
+++ b/tests/ext4/305
@@ -24,6 +24,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 PIDS=""
@@ -32,8 +33,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    kill $PIDS >/dev/null 2>&1
+	cd /
+	kill $PIDS >/dev/null 2>&1
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/ext4/306 b/tests/ext4/306
index fa3b782..fe6bc51 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -24,6 +24,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 PIDS=""
@@ -32,7 +33,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    _scratch_unmount
+	_scratch_unmount
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/004 b/tests/generic/004
index d0926f1..bc9e18d 100755
--- a/tests/generic/004
+++ b/tests/generic/004
@@ -32,8 +32,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f ${testfile}
+	cd /
+	rm -f ${testfile}
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/005 b/tests/generic/005
index 70f6073..026ff90 100755
--- a/tests/generic/005
+++ b/tests/generic/005
@@ -43,9 +43,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd $TEST_DIR
-    rm -f symlink_{0,1,2,3,4}{0,1,2,3,4,5,6,7,8,9} symlink_self empty_file
-    cd /
+	cd $TEST_DIR
+	rm -f symlink_{0,1,2,3,4}{0,1,2,3,4,5,6,7,8,9} symlink_self empty_file
+	cd /
+	rm -f $tmp.*
 }
 
 _touch()
diff --git a/tests/generic/008 b/tests/generic/008
index 9b70b28..528527d 100755
--- a/tests/generic/008
+++ b/tests/generic/008
@@ -31,7 +31,14 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/013 b/tests/generic/013
index e31fe35..939fb2a 100755
--- a/tests/generic/013
+++ b/tests/generic/013
@@ -33,15 +33,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    # we might get here with a RO FS
-    _test_cycle_mount
-    # now remove fsstress directory.
-    # N.B. rm(1) on IRIX can find problems when building up a long pathname
-    # such that what it has is greater the 1024 chars and will
-    # stop and complain - so get rid of complaint
-    # Ref. pv#935754
-    rm -rf $TEST_DIR/fsstress.$$.* 2>&1 | grep -v 'Path too long'
+	cd /
+	# we might get here with a RO FS
+	_test_cycle_mount
+	# now remove fsstress directory.
+	# N.B. rm(1) on IRIX can find problems when building up a long pathname
+	# such that what it has is greater the 1024 chars and will
+	# stop and complain - so get rid of complaint
+	# Ref. pv#935754
+	rm -rf $TEST_DIR/fsstress.$$.* 2>&1 | grep -v 'Path too long'
+	rm -f $tmp.*
 }
 
 _filesize()
diff --git a/tests/generic/015 b/tests/generic/015
index 66c33c2..d53aa30 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -37,6 +37,7 @@ status=1	# success is the default!
 _cleanup()
 {
 	_scratch_unmount
+	rm -f $tmp.*
 }
 
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/034 b/tests/generic/034
index 6727b98..cd3a829 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -31,6 +31,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -39,6 +40,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/038 b/tests/generic/038
index 025e1b0..b8f5643 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -57,7 +57,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-	rm -fr $tmp
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/039 b/tests/generic/039
index 7d62393..292aa20 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -43,6 +43,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/040 b/tests/generic/040
index 2aeccdd..c603caa 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -48,6 +48,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/041 b/tests/generic/041
index 283c305..70549e8 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -52,6 +52,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/043 b/tests/generic/043
index b76a5aa..10aba87 100755
--- a/tests/generic/043
+++ b/tests/generic/043
@@ -29,7 +29,13 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/044 b/tests/generic/044
index 0331baa..ab2d3b9 100755
--- a/tests/generic/044
+++ b/tests/generic/044
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/045 b/tests/generic/045
index 874c955..9799db1 100755
--- a/tests/generic/045
+++ b/tests/generic/045
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/046 b/tests/generic/046
index 5a894b8..16c824b 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/047 b/tests/generic/047
index 631dc1e..1db981c 100755
--- a/tests/generic/047
+++ b/tests/generic/047
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/048 b/tests/generic/048
index 51d7efd..aee2e85 100755
--- a/tests/generic/048
+++ b/tests/generic/048
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/049 b/tests/generic/049
index 1299242..31dc413 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/050 b/tests/generic/050
index 5fa28a7..a230c80 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -33,6 +33,7 @@ _cleanup()
 {
 	cd /
 	blockdev --setrw $SCRATCH_DEV
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/068 b/tests/generic/068
index f9f5f5a..5d1c6c8 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -35,13 +35,11 @@ ITERATIONS=10
 
 _cleanup()
 {
-    cd /
-
-    trap 0 1 2 3 15
-    exit $status
+	cd /
+	rm -f $tmp.*
 }
 
-trap "_cleanup" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/079 b/tests/generic/079
index 5cceeba..3bb895d 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -34,10 +34,11 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    echo "*** cleaning up"
-    $timmutable -r $SCRATCH_MNT/$seq
-    _scratch_unmount
+	cd /
+	echo "*** cleaning up"
+	$timmutable -r $SCRATCH_MNT/$seq
+	_scratch_unmount
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/087 b/tests/generic/087
index 9653230..f6af6e4 100755
--- a/tests/generic/087
+++ b/tests/generic/087
@@ -44,7 +44,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
+	cd /
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/093 b/tests/generic/093
index 824e9b2..800efe4 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -40,7 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    [ -n "$TEST_DIR" ] && rm -f $file
+	[ -n "$TEST_DIR" ] && rm -f $file
+	rm -f $tmp.*
 }
 
 _testfilter()
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
diff --git a/tests/generic/102 b/tests/generic/102
index 3cdc2ba..b896e26 100755
--- a/tests/generic/102
+++ b/tests/generic/102
@@ -34,7 +34,12 @@ echo "QA output created by $seq"
 
 tmp=/tmp/$$
 status=1
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/105 b/tests/generic/105
index 9b7beb4..9da204b 100755
--- a/tests/generic/105
+++ b/tests/generic/105
@@ -36,7 +36,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
+	cd /
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/113 b/tests/generic/113
index 54d6191..fe2b7f9 100755
--- a/tests/generic/113
+++ b/tests/generic/113
@@ -33,8 +33,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f $TEST_DIR/aio-stress.$$.*
+	cd /
+	rm -f $TEST_DIR/aio-stress.$$.*
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/114 b/tests/generic/114
index 8082a0d..9c7cf61 100755
--- a/tests/generic/114
+++ b/tests/generic/114
@@ -32,8 +32,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f $TEST_DIR/tst-aio-dio-eof-race
+	cd /
+	rm -f $TEST_DIR/tst-aio-dio-eof-race
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/123 b/tests/generic/123
index 453ede4..2a27b9d 100755
--- a/tests/generic/123
+++ b/tests/generic/123
@@ -35,9 +35,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd $TEST_DIR
-    rm -rf $my_test_subdir
-    cd /
+	cd $TEST_DIR
+	rm -rf $my_test_subdir
+	cd /
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/124 b/tests/generic/124
index b78c189..6e8be66 100755
--- a/tests/generic/124
+++ b/tests/generic/124
@@ -37,7 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
+	cd /
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/125 b/tests/generic/125
index 67eb63f..a628f08 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/126 b/tests/generic/126
index bb3a566..6d839b9 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -33,7 +33,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
+	cd /
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/127 b/tests/generic/127
index 94d15b2..c7acf8d 100755
--- a/tests/generic/127
+++ b/tests/generic/127
@@ -37,7 +37,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -f $tmp.output
+	rm -f $tmp.output
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/128 b/tests/generic/128
index 39fc807..9470cc4 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/129 b/tests/generic/129
index 9a10d76..0ed3619 100755
--- a/tests/generic/129
+++ b/tests/generic/129
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/130 b/tests/generic/130
index 1e96630..709d950 100755
--- a/tests/generic/130
+++ b/tests/generic/130
@@ -38,7 +38,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/131 b/tests/generic/131
index d64ba55..d1d6d44 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -33,8 +33,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    kill $locktest_pid2 > /dev/null 2>&1
-    kill $locktest_pid1 > /dev/null 2>&1
+	kill $locktest_pid2 > /dev/null 2>&1
+	kill $locktest_pid1 > /dev/null 2>&1
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/132 b/tests/generic/132
index aa52c7d..be2cbe1 100755
--- a/tests/generic/132
+++ b/tests/generic/132
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/133 b/tests/generic/133
index f1a221e..cd7bf09 100755
--- a/tests/generic/133
+++ b/tests/generic/133
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/135 b/tests/generic/135
index 14b8132..fab9269 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/141 b/tests/generic/141
index fa08484..5d715b3 100755
--- a/tests/generic/141
+++ b/tests/generic/141
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/192 b/tests/generic/192
index d3ed0ec..c62cfaf 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -36,6 +36,7 @@ trap "exit \$status" 0 1 2 3 15
 _access_time()
 {
 	stat -c %X $1
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/193 b/tests/generic/193
index 6d0754f..3566c1d 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -28,7 +28,13 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "_cleanup_files; exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	_cleanup_files
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 tag="added by qa $seq"
 
 #
diff --git a/tests/generic/215 b/tests/generic/215
index 80df55d..dc98069 100755
--- a/tests/generic/215
+++ b/tests/generic/215
@@ -31,6 +31,7 @@ _cleanup()
 {
 	cd /
 	rm -f $testfile
+	rm -f $tmp.*
 }
 
 here=`pwd`
diff --git a/tests/generic/221 b/tests/generic/221
index aa42f65..a0f575a 100755
--- a/tests/generic/221
+++ b/tests/generic/221
@@ -32,6 +32,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/236 b/tests/generic/236
index 12ea0bc..ed61660 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -25,11 +25,13 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 _cleanup()
 {
 	rm -f $TEST_DIR/ouch*
+	rm -f $tmp.*
 }
 
 here=`pwd`
diff --git a/tests/generic/239 b/tests/generic/239
index 4f764c2..3e7b889 100755
--- a/tests/generic/239
+++ b/tests/generic/239
@@ -33,8 +33,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f $TEST_DIR/tst-aio-dio-sparse-unwritten
+	cd /
+	rm -f $TEST_DIR/tst-aio-dio-sparse-unwritten
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/245 b/tests/generic/245
index 4034d04..1592ec5 100755
--- a/tests/generic/245
+++ b/tests/generic/245
@@ -46,6 +46,7 @@ dir=$TEST_DIR/test-mv
 _cleanup()
 {
 	rm -rf $dir
+	rm -f $tmp.*
 }
 
 # According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
diff --git a/tests/generic/246 b/tests/generic/246
index 4184cfc..25ae556 100755
--- a/tests/generic/246
+++ b/tests/generic/246
@@ -48,6 +48,7 @@ _cleanup()
 {
 	rm -rf $file
 	rm -rf $file.NEW
+	rm -f $tmp.*
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/251 b/tests/generic/251
index 848ee74..aaeffe4 100755
--- a/tests/generic/251
+++ b/tests/generic/251
@@ -50,6 +50,7 @@ _require_batched_discard $SCRATCH_MNT
 _cleanup()
 {
 	rm -rf $tmp
+	rm -f $tmp.*
 }
 
 _destroy()
diff --git a/tests/generic/257 b/tests/generic/257
index 64f2100..85cd525 100755
--- a/tests/generic/257
+++ b/tests/generic/257
@@ -32,6 +32,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	rm -rf $TEST_DIR/ttt
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/260 b/tests/generic/260
index 312e6d2..3448b3b 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -26,9 +26,14 @@ seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
 here=`pwd`
-tmp=`mktemp -d`
+tmp=/tmp/$$
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
 status=0
-trap "exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
 chpid=0
 mypid=$$
 
diff --git a/tests/generic/275 b/tests/generic/275
index 955c4ac..7bdb0f1 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -37,6 +37,7 @@ _cleanup()
 {
 	cd /
 	_scratch_unmount
+	rm -f $tmp.*
 }
 
 . ./common/rc
diff --git a/tests/generic/277 b/tests/generic/277
index 4dfc431..14b6527 100755
--- a/tests/generic/277
+++ b/tests/generic/277
@@ -24,13 +24,15 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f $SCRATCH_MNT/tmp*
+	rm -f $SCRATCH_MNT/tmp*
+	rm -f $tmp.*
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/generic/285 b/tests/generic/285
index 16e70b1..050443e 100755
--- a/tests/generic/285
+++ b/tests/generic/285
@@ -27,6 +27,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -56,6 +57,7 @@ fi
 _cleanup()
 {
 	eval "rm -f $BASE_TEST_FILE.*"
+	rm -f $tmp.*
 }
 
 $here/src/seek_sanity_test $BASE_TEST_FILE > $seqres.full 2>&1 ||
diff --git a/tests/generic/286 b/tests/generic/286
index f88f079..e2dab19 100755
--- a/tests/generic/286
+++ b/tests/generic/286
@@ -24,6 +24,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -49,6 +50,7 @@ _require_test_program "seek_copy_test"
 _cleanup()
 {
 	rm -f $src $dest
+	rm -f $tmp.*
 }
 
 # seek_copy_test_01: tests file with holes and written data extents.
diff --git a/tests/generic/288 b/tests/generic/288
index aed6238..85a9b8b 100755
--- a/tests/generic/288
+++ b/tests/generic/288
@@ -23,10 +23,16 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
 echo "QA output created by $seq"
 
 status=0
-trap "exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/generic/307 b/tests/generic/307
index f5d0680..595cc74 100755
--- a/tests/generic/307
+++ b/tests/generic/307
@@ -30,6 +30,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 status=1	# failure is the default!
@@ -39,6 +40,7 @@ _cleanup()
 {
 	cd /
 	rm -f $testfile
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/308 b/tests/generic/308
index e639da1..a3ed5a5 100755
--- a/tests/generic/308
+++ b/tests/generic/308
@@ -24,6 +24,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 status=1	# failure is the default!
@@ -33,6 +34,7 @@ _cleanup()
 {
 	cd /
 	rm -f $testfile
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/309 b/tests/generic/309
index c6b89db..35d5d84 100755
--- a/tests/generic/309
+++ b/tests/generic/309
@@ -27,6 +27,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 status=0	# success is the default!
@@ -34,9 +35,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -rf $TEST_DIR/testdir_$seq
-    rm -f $TEST_DIR/testfile.$seq
+	cd /
+	rm -rf $TEST_DIR/testdir_$seq
+	rm -f $TEST_DIR/testfile.$seq
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/310 b/tests/generic/310
index 895481c..ca38a0a 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -40,6 +40,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 status=1	# failure is the default!
@@ -47,6 +48,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	rm -rf $TEST_DIR/tmp
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/311 b/tests/generic/311
index d510204..d757bf0 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -34,6 +34,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -42,6 +43,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/313 b/tests/generic/313
index a906926..1f133e1 100755
--- a/tests/generic/313
+++ b/tests/generic/313
@@ -26,6 +26,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -34,8 +35,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f $testfile
+	cd /
+	rm -f $testfile
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/generic/317 b/tests/generic/317
index 7e40b1f..f3f5c41 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -36,8 +36,9 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    cd /
-    _scratch_unmount >/dev/null 2>&1
+	cd /
+	_scratch_unmount >/dev/null 2>&1
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/318 b/tests/generic/318
index e284317..adb1cbb 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -37,8 +37,9 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    cd /
-    _scratch_unmount >/dev/null 2>&1
+	cd /
+	_scratch_unmount >/dev/null 2>&1
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/321 b/tests/generic/321
index 8798503..3d81640 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -23,6 +23,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -31,6 +32,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/322 b/tests/generic/322
index 475a31c..f8d9743 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -23,6 +23,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -31,6 +32,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/325 b/tests/generic/325
index a0b641a..75b8908 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -33,6 +33,7 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 here=`pwd`
@@ -41,6 +42,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_flakey
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/shared/298 b/tests/shared/298
index 2ed7eab..6c73a71 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -47,6 +47,7 @@ _cleanup()
 		rm -rf $tmp
 		rm $img_file
 	fi
+	rm -f $tmp.*
 }
 
 get_holes()
diff --git a/tests/xfs/009 b/tests/xfs/009
index abef2e0..e1afc47 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -36,8 +36,9 @@ bsize=4096
 
 _cleanup()
 {
-    echo "*** unmount"
-    _scratch_unmount
+	echo "*** unmount"
+	_scratch_unmount
+	rm -f $tmp.*
 }
 
 _block_filter()
diff --git a/tests/xfs/142 b/tests/xfs/142
index a1efcc2..a3db707 100755
--- a/tests/xfs/142
+++ b/tests/xfs/142
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/143 b/tests/xfs/143
index c389a2b..0d4d6e8 100755
--- a/tests/xfs/143
+++ b/tests/xfs/143
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/144 b/tests/xfs/144
index 41041c4..aa0a81e 100755
--- a/tests/xfs/144
+++ b/tests/xfs/144
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/145 b/tests/xfs/145
index 44b3e4e..e4cefd3 100755
--- a/tests/xfs/145
+++ b/tests/xfs/145
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/146 b/tests/xfs/146
index f6cd3f3..276353a 100755
--- a/tests/xfs/146
+++ b/tests/xfs/146
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _report_filter () {
     $PERL_PROG -ne "s/Report: \"0x[0-f]+\" was written and \"0x[0-f]+\" was read at/Report: \"HEX\" was written and \"HEX\" was read at/g ;
diff --git a/tests/xfs/147 b/tests/xfs/147
index 73ff7f9..2307dfd 100755
--- a/tests/xfs/147
+++ b/tests/xfs/147
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/150 b/tests/xfs/150
index f9e690a..1e13fa9 100755
--- a/tests/xfs/150
+++ b/tests/xfs/150
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _filter_fs_handle()
 {
diff --git a/tests/xfs/151 b/tests/xfs/151
index bba7094..1a7a238 100755
--- a/tests/xfs/151
+++ b/tests/xfs/151
@@ -31,7 +31,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _dm_create_session()
 {
diff --git a/tests/xfs/152 b/tests/xfs/152
index 72bdabf..9e0ba79 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _filter_handles()
 {
diff --git a/tests/xfs/153 b/tests/xfs/153
index cac7722..95c5b58 100755
--- a/tests/xfs/153
+++ b/tests/xfs/153
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/154 b/tests/xfs/154
index 810a6ac..ad825d1 100755
--- a/tests/xfs/154
+++ b/tests/xfs/154
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/155 b/tests/xfs/155
index 1a1631e..ac7c2b3 100755
--- a/tests/xfs/155
+++ b/tests/xfs/155
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/156 b/tests/xfs/156
index d6e22b6..495cffc 100755
--- a/tests/xfs/156
+++ b/tests/xfs/156
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/157 b/tests/xfs/157
index bf65590..05cca9c 100755
--- a/tests/xfs/157
+++ b/tests/xfs/157
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/158 b/tests/xfs/158
index 596f4c2..0a2ccd7 100755
--- a/tests/xfs/158
+++ b/tests/xfs/158
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/159 b/tests/xfs/159
index fc5193f..133f382 100755
--- a/tests/xfs/159
+++ b/tests/xfs/159
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/160 b/tests/xfs/160
index 9a2e2d0..bc8e1ad 100755
--- a/tests/xfs/160
+++ b/tests/xfs/160
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/161 b/tests/xfs/161
index 11e53de..475470a 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -30,7 +30,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _filter_get_allocinfo()
 {
diff --git a/tests/xfs/162 b/tests/xfs/162
index 4edb68f..ec2c677 100755
--- a/tests/xfs/162
+++ b/tests/xfs/162
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/163 b/tests/xfs/163
index e283545..8d6849b 100755
--- a/tests/xfs/163
+++ b/tests/xfs/163
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _filter_paths()
 {
diff --git a/tests/xfs/166 b/tests/xfs/166
index 2a96f8a..b6e0dc7 100755
--- a/tests/xfs/166
+++ b/tests/xfs/166
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 rm -f $seqres.full
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/167 b/tests/xfs/167
index a9f0e61..041943d 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -36,6 +36,7 @@ _cleanup()
 {
 	$KILLALL_PROG -r -q -TERM fsstress 2> /dev/null
 	wait	# ensures all fsstress processes died
+	rm -f $tmp.*
 }
 
 workout()
diff --git a/tests/xfs/168 b/tests/xfs/168
index 6fc4540..7f07c4b 100755
--- a/tests/xfs/168
+++ b/tests/xfs/168
@@ -29,9 +29,14 @@ echo "QA output created by $seq"
 
 here=`pwd`
 tmp=/tmp/$$
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
 rm -f $seqres.full
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _filter_dmapi_print_event() {
     $PERL_PROG -ne '
diff --git a/tests/xfs/175 b/tests/xfs/175
index ad18e42..6bc4b9a 100755
--- a/tests/xfs/175
+++ b/tests/xfs/175
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-	rm -f $tmp/*
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/176 b/tests/xfs/176
index 035d3b4..995c6fe 100755
--- a/tests/xfs/176
+++ b/tests/xfs/176
@@ -34,7 +34,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-	rm -f $tmp/*
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/185 b/tests/xfs/185
index 17334de..96bc425 100755
--- a/tests/xfs/185
+++ b/tests/xfs/185
@@ -29,7 +29,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1    # failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/190 b/tests/xfs/190
index d688216..d68b6ab 100755
--- a/tests/xfs/190
+++ b/tests/xfs/190
@@ -41,6 +41,13 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=0    # success is the default!
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
 rm -f $seqres.full
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/195 b/tests/xfs/195
index 3948ca4..2716bff 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -35,6 +35,7 @@ _cleanup()
 {
 	rm -rf $TEST_DIR/d
 	rm -f $TEST_DIR/dumpfile
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/197 b/tests/xfs/197
index 7706e03..aebf167 100755
--- a/tests/xfs/197
+++ b/tests/xfs/197
@@ -38,6 +38,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	rm -rf $TEST_DIR/ttt
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/199 b/tests/xfs/199
index ee26439..c9c0de3 100755
--- a/tests/xfs/199
+++ b/tests/xfs/199
@@ -36,6 +36,7 @@ _cleanup()
 {
 	cd /
 	_scratch_unmount >/dev/null 2>&1
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/201 b/tests/xfs/201
index 45dc42f..b947e50 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -35,6 +35,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_scratch_unmount
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/202 b/tests/xfs/202
index b9827a7..4533dfa 100755
--- a/tests/xfs/202
+++ b/tests/xfs/202
@@ -28,6 +28,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/203 b/tests/xfs/203
index 2ac5290..62a5bac 100755
--- a/tests/xfs/203
+++ b/tests/xfs/203
@@ -59,6 +59,7 @@ _filter_bmap()
 _cleanup()
 {
 	rm -f $SCRATCH_MNT/r??
+	rm -f $tmp.*
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/xfs/205 b/tests/xfs/205
index debdc2a..ec59130 100755
--- a/tests/xfs/205
+++ b/tests/xfs/205
@@ -28,6 +28,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tests/xfs/206 b/tests/xfs/206
index d549a4c..9e0a4d9 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -38,10 +38,11 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    umount $tmpdir
-    rmdir $tmpdir
-    rm -f $tmp
-    rm -f $tmpfile
+	umount $tmpdir
+	rmdir $tmpdir
+	rm -f $tmp
+	rm -f $tmpfile
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/220 b/tests/xfs/220
index 69b539c..bf7a433 100755
--- a/tests/xfs/220
+++ b/tests/xfs/220
@@ -36,6 +36,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	cd /
+	rm -f $tmp.*
 	_scratch_unmount >/dev/null 2>&1
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/xfs/229 b/tests/xfs/229
index 0a42bcf..ee2931b 100755
--- a/tests/xfs/229
+++ b/tests/xfs/229
@@ -38,7 +38,8 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -rf ${TDIR}
+	rm -rf ${TDIR}
+	rm -f $tmp.*
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/xfs/250 b/tests/xfs/250
index f807c5a..f2fbef7 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -36,6 +36,7 @@ _cleanup()
 	umount $LOOP_MNT 2>/dev/null
 	rm -f $LOOP_DEV
 	rmdir $LOOP_MNT
+	rm -f $tmp.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/259 b/tests/xfs/259
index 17f3c6d..a931a10 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -24,13 +24,15 @@
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
+tmp=/tmp/$$
 echo "QA output created by $seq"
 
 status=1	# failure is the default!
 
 _cleanup()
 {
-    rm -f "$testfile"
+	rm -f "$testfile"
+	rm -f $tmp.*
 }
 
 trap "_cleanup ; exit \$status" 0 1 2 3 15
diff --git a/tests/xfs/261 b/tests/xfs/261
index e3c2591..1054f7d 100755
--- a/tests/xfs/261
+++ b/tests/xfs/261
@@ -41,8 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f ${tmp}.*
+	cd /
+	rm -f ${tmp}.*
 }
 
 # get standard environment, filters and checks
diff --git a/tests/xfs/290 b/tests/xfs/290
index adc398f..3bc54e4 100755
--- a/tests/xfs/290
+++ b/tests/xfs/290
@@ -33,7 +33,12 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
-- 
2.9.3

