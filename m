Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbbCTPD2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 11:03:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KF3Sd0018931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 11:03:28 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH] fstests: tests can use any name now, not 3 digits only.
Date: Fri, 20 Mar 2015 16:03:25 +0100
Message-Id: <1426863805-959-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <20150320111320.GW4810@dhcp-13-216.nay.redhat.com>
References: <20150320111320.GW4810@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Tests can use any name now, not 3 digits only.
(e.g. a test can be named "tests/generic/some-name")

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 README |  2 +-
 check  | 11 ++++++-----
 new    | 27 +++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 8 deletions(-)

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
index 0830e0c..394fae4 100755
--- a/check
+++ b/check
@@ -58,7 +58,7 @@ then
     exit 1
 fi
 
-SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
+SUPPORTED_TESTS="\S\+"
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
 
@@ -96,21 +96,22 @@ get_group_list()
 		l=$(sed -n < $SRC_DIR/$d/group \
 			-e 's/#.*//' \
 			-e 's/$/ /' \
-			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
+			-e "s;^\($SUPPORTED_TESTS\).* $grp .*;$SRC_DIR/$d/\1;p")
 		grpl="$grpl $l"
 	done
 	echo $grpl
 }
 
-# find all tests, excluding files that are test metadata such as group files.
-# This assumes that tests are defined purely by alphanumeric filenames with no
-# ".xyz" extensions in the name.
+# Find all tests, excluding files that are test metadata such as group files.
+# It matches test names against $SUPPORTED_TESTS defined at the top of this 
+# file.
 get_all_tests()
 {
 	touch $tmp.list
 	for d in $SRC_GROUPS $FSTYP; do
 		ls $SRC_DIR/$d/* | \
 			grep -v "\..*" | \
+			grep "^$SRC_DIR/$d/$SUPPORTED_TESTS"| \
 			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
 	done
 }
diff --git a/new b/new
index d1f8939..60b898a 100755
--- a/new
+++ b/new
@@ -84,8 +84,11 @@ eof=1
 for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
 do
     line=$((line+1))
-    if [ -z "$found" ] || [ "$found" == "#" ];then
-	continue
+    if [ -z "$found" ] || [ "$found" == "#" ]; then
+        continue
+    elif ! echo "$found" | grep "^[0-9][0-9][0-9]$" > /dev/null; then
+        # this one is for tests not named by a number
+        continue
     fi
     i=$((i+1))
     id=`printf "%03d" $i`
@@ -102,6 +105,26 @@ fi
 
 echo "Next test is $id"
 
+read -p "Do you want to use ANOTHER name? y,[n]: " -r
+if [[ "$REPLY" =~ ^[Yy]$ ]]; then
+    id=""
+    while [ "$id" = "" ]; do
+        read -p "Enter the new name: "
+        if [ "$REPLY" = "" ]; then
+            echo "Can't use empty name. For canceling, use ctrl+c."
+        elif [ -e "$tdir/$REPLY" ]; then
+            echo "File '$REPLY' already exists, use another one."
+            echo #
+        elif echo "$REPLY" | grep "^\\S\+$" > /dev/null; then
+            id="$REPLY"
+        else
+            echo "Filename must not contain whitespaces!"
+            echo
+        fi
+    done
+fi
+echo "Using '$id'."
+
 if [ -f $tdir/$id ]
 then
     echo "Error: test $id already exists!"
-- 
2.1.0

