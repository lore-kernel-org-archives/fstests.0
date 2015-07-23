Received: from mx1.redhat.com ([209.132.183.28]:47360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbbGWQp6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jul 2015 12:45:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id CDCF49022B
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2015 16:45:58 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH] xfstests: add a flag for direct printing of test output
Date: Thu, 23 Jul 2015 18:45:55 +0200
Message-Id: <1437669955-18454-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add -d debug dump flag to ./check to directly print a test output
to stdout, instead of just saving it into a file and showing a diff
snippet.

Useful e.g. when writing a new test.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 check | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/check b/check
index a300130..a4ee224 100755
--- a/check
+++ b/check
@@ -37,6 +37,8 @@ randomize=false
 export here=`pwd`
 xfile=""
 
+DUMP_OUTPUT=false
+
 # start the initialisation work now
 iam=check
 
@@ -74,6 +76,7 @@ check options
     -n			show me, do not run tests
     -T			output timestamps
     -r			randomize test order
+    -d			dump test output to stdout
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
 
@@ -237,6 +240,7 @@ while [ $# -gt 0 ]; do
         -r)	randomize=true ;;
 
 	-T)	timestamp=true ;;
+	-d)	DUMP_OUTPUT=true ;;
 
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
@@ -598,8 +602,14 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			# _check_dmesg depends on this log in dmesg
 			touch ${RESULT_DIR}/check_dmesg
 		fi
-		./$seq >$tmp.rawout 2>&1
-		sts=$?
+		if [ "$DUMP_OUTPUT" = true ]; then
+			./$seq 2>&1 | tee $tmp.rawout
+			# Because $? would get tee's return code
+			sts=${PIPESTATUS[0]}
+		else
+			./$seq >$tmp.rawout 2>&1
+			sts=$?
+		fi
 		$timestamp && _timestamp
 		stop=`_wallclock`
 
-- 
2.4.3

