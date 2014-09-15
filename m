Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:14385 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbaIOJTR (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Sep 2014 05:19:17 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] Add UBIFS support
Date: Mon, 15 Sep 2014 11:11:20 +0200
Message-Id: <1410772280-9771-1-git-send-email-richard@nod.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

UBIFS needs some extra care, the device node is of type character and
it has no fsck tool.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 README        |  1 +
 check         |  2 ++
 common/config |  4 ++--
 common/rc     | 18 ++++++++++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 8a362bd..96adc44 100644
--- a/README
+++ b/README
@@ -100,6 +100,7 @@ Running tests:
       Running all the udf tests: ./check -udf -g udf
     - for running nfs tests: ./check -nfs [test(s)]
     - for running cifs/smb3 tests: ./check -cifs [test(s)]
+    - for running ubifs tests: ./check -ubifs [test(s)]
     - To randomize test order: ./check -r [test(s)]
 
     
diff --git a/check b/check
index 42a1ac2..57ec612 100755
--- a/check
+++ b/check
@@ -70,6 +70,7 @@ check options
     -nfs                test NFS
     -cifs               test CIFS
     -tmpfs              test TMPFS
+    -ubifs              test UBIFS
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -208,6 +209,7 @@ while [ $# -gt 0 ]; do
 	-nfs)	FSTYP=nfs ;;
 	-cifs)	FSTYP=cifs ;;
 	-tmpfs)	FSTYP=tmpfs ;;
+	-ubifs)	FSTYP=ubifs ;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST $group"
diff --git a/common/config b/common/config
index fc21b37..af082ea 100644
--- a/common/config
+++ b/common/config
@@ -430,7 +430,7 @@ get_next_config() {
 		exit 1
 	fi
 
-	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
+	echo $TEST_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
 	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
 		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
 		exit 1
@@ -453,7 +453,7 @@ get_next_config() {
 		export SCRATCH_DEV_NOT_SET=true
 	fi
 
-	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
+	echo $SCRATCH_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
 	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
 		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
 		exit 1
diff --git a/common/rc b/common/rc
index b8f711a..064b987 100644
--- a/common/rc
+++ b/common/rc
@@ -1034,6 +1034,12 @@ _require_scratch_nocheck()
 		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
 		fi
 		;;
+	ubifs)
+		if [ -z "$SCRATCH_DEV" -o ! -c "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
+		then
+		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
+		fi
+		;;
 	*)
 		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
 		 then
@@ -1100,6 +1106,12 @@ _require_test()
 		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
 		fi
 		;;
+	ubifs)
+		if [ -z "$TEST_DEV" -o ! -c "$TEST_DEV" -o ! -d "$TEST_DIR" ];
+		then
+		    _notrun "this test requires a valid \$TEST_DIR and a valid $TEST_DEV"
+		fi
+		;;
 	*)
 		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
 		 then
@@ -1897,6 +1909,9 @@ _check_test_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    ubifs)
+	# ubifs has no fsck :-(
+	;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -1935,6 +1950,9 @@ _check_scratch_fs()
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
+    ubifs)
+	# ubifs has no fsck :-(
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
-- 
1.8.4.5

