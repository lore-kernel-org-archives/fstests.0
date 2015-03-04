Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932878AbbCDQSR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 4 Mar 2015 11:18:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t24GIHgm012400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 4 Mar 2015 11:18:17 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH] Tests can use any name now, not 3 digits only.
Date: Wed,  4 Mar 2015 16:55:17 +0100
Message-Id: <1425484517-7938-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Tests can use any name now, not 3 digits only.
(e.g. a test can be named "tests/generic/some-name")

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 README | 2 +-
 check  | 6 +++---
 new    | 7 +++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 0c9449a..2376674 100644
--- a/README
+++ b/README
@@ -205,7 +205,7 @@ Test script environment:
 
 Verified output:
 
-    Each test script has a numerical name, e.g. 007, and an associated
+    Each test script has a name, e.g. 007, and an associated
     verified output, e.g. 007.out.
 
     It is important that the verified output is deterministic, and
diff --git a/check b/check
index 0830e0c..d7814a8 100755
--- a/check
+++ b/check
@@ -58,7 +58,7 @@ then
     exit 1
 fi
 
-SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
+SUPPORTED_TESTS="\S\+"
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
 
@@ -96,7 +96,7 @@ get_group_list()
 		l=$(sed -n < $SRC_DIR/$d/group \
 			-e 's/#.*//' \
 			-e 's/$/ /' \
-			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
+			-e "s;^\($SUPPORTED_TESTS\).* $grp .*;$SRC_DIR/$d/\1;p")
 		grpl="$grpl $l"
 	done
 	echo $grpl
@@ -111,6 +111,7 @@ get_all_tests()
 	for d in $SRC_GROUPS $FSTYP; do
 		ls $SRC_DIR/$d/* | \
 			grep -v "\..*" | \
+			grep "^$SRC_DIR/$d/$SUPPORTED_TESTS"| \
 			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
 	done
 }
@@ -178,7 +179,6 @@ _prepare_test_list()
 		# no test numbers, do everything
 		get_all_tests
 	fi
-
 	# Specified groups to exclude
 	for xgroup in $XGROUP_LIST; do
 		list=$(get_group_list $xgroup)
diff --git a/new b/new
index 86f9075..f755da3 100755
--- a/new
+++ b/new
@@ -84,8 +84,11 @@ eof=1
 for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
 do
     line=$((line+1))
-    if [ -z "$found" ] || [ "$found" == "#" ];then
-	continue
+    if [ -z "$found" ] || [ "$found" == "#" ] ;then
+        continue
+    elif ! echo "$found"|grep "[0-9][0-9][0-9]";then
+        # this one is for tests not named by a number
+        continue
     fi
     i=$((i+1))
     id=`printf "%03d" $i`
-- 
2.1.0

