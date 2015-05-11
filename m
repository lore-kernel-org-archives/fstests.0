Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59123 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbbEKIY3 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 May 2015 04:24:29 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 418818F303
	for <fstests@vger.kernel.org>; Mon, 11 May 2015 08:24:29 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] check: set failure status before exit
Date: Mon, 11 May 2015 16:22:13 +0800
Message-Id: <1431332533-7557-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

check has trapped 'exit 1' and exit with $status, but check always
returns 0 on error because status never gets updated. This causes
problems while running some tests in a loop until it fails, e.g.

	while ./check generic/081; do : ; done

Just set status to 1 before exit, as what we do in the tests.

Also remove an unused $flag while we're at it.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 check | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/check b/check
index 4fa96ed..a300130 100755
--- a/check
+++ b/check
@@ -451,7 +451,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
 		echo "failed to create results directory $RESULT_BASE"
-		exit 1;
+		status=1
+		exit
 	fi
 
 	if $OPTIONS_HAVE_SECTIONS; then
@@ -466,12 +467,14 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			echo "our local _test_mkfs routine ..."
 			cat $tmp.err
 			echo "check: failed to mkfs \$TEST_DEV using specified options"
-			exit 1
+			status=1
+			exit
 		fi
 		out=`_mount_or_remount_rw "$MOUNT_OPTIONS" $TEST_DEV $TEST_DIR`
 		if [ $? -ne 1 ]; then
 			echo $out
-			exit 1
+			status=1
+			exit
 		fi
 		_prepare_test_list
 	elif [ "$OLD_MOUNT_OPTIONS" != "$MOUNT_OPTIONS" ]; then
@@ -479,7 +482,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		out=`_mount_or_remount_rw "$MOUNT_OPTIONS" $TEST_DEV $TEST_DIR`
 		if [ $? -ne 1 ]; then
 			echo $out
-			exit 1
+			status=1
+			exit
 		fi
 	fi
 
@@ -508,12 +512,13 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	  # call the overridden mkfs - make sure the FS is built
 	  # the same as we'll create it later.
 
-	  if ! _scratch_mkfs $flag >$tmp.err 2>&1
+	  if ! _scratch_mkfs >$tmp.err 2>&1
 	  then
 	      echo "our local _scratch_mkfs routine ..."
 	      cat $tmp.err
 	      echo "check: failed to mkfs \$SCRATCH_DEV using specified options"
-	      exit 1
+	      status=1
+	      exit
 	  fi
 
 	  # call the overridden mount - make sure the FS mounts with
@@ -523,7 +528,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	      echo "our local mount routine ..."
 	      cat $tmp.err
 	      echo "check: failed to mount \$SCRATCH_DEV using specified options"
-	      exit 1
+	      status=1
+	      exit
 	  fi
 	fi
 
-- 
2.1.0

