Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbbCZNfj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Mar 2015 09:35:39 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH] fstests: Tests can use any name now, not 3 digits only.
Date: Thu, 26 Mar 2015 14:35:33 +0100
Message-Id: <1427376933-7588-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

Tests can use any name now, not 3 digits only.
(e.g. a test can be named "tests/generic/001-some-name")

Names are limited to alphanumeric characters and dash and are always prefixed
with an unique id for easier identification of a specific patch.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 README |  2 +-
 check  | 11 ++++++-----
 new    | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 60 insertions(+), 12 deletions(-)

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
index 0830e0c..2730284 100755
--- a/check
+++ b/check
@@ -58,7 +58,7 @@ then
     exit 1
 fi
 
-SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
+SUPPORTED_TESTS="[a-zA-Z0-9-]\+"
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
index d1f8939..ccfb424 100755
--- a/new
+++ b/new
@@ -25,6 +25,9 @@
 iam=new
 . ./common/rc
 
+SUPPORTED_TESTS="^[a-zA-Z0-9-]\+$"
+
+
 trap "rm -f /tmp/$$.; exit" 0 1 2 3 15
 
 _cleanup()
@@ -81,11 +84,14 @@ line=0
 eof=1
 [ -f "$tdir/group" ] || usage
 
-for found in `cat $tdir/group | $AWK_PROG '{ print $1 }'`
+for found in `cat $tdir/group | tr - ' ' | $AWK_PROG '{ print $1 }'`
 do
     line=$((line+1))
-    if [ -z "$found" ] || [ "$found" == "#" ];then
-	continue
+    if [ -z "$found" ] || [ "$found" == "#" ]; then
+        continue
+    elif ! echo "$found" | grep -q "^[0-9][0-9][0-9]$"; then
+        # this one is for tests not named by a number
+        continue
     fi
     i=$((i+1))
     id=`printf "%03d" $i`
@@ -99,8 +105,49 @@ if [ $eof -eq 1 ]; then
    i=$((i+1))
    id=`printf "%03d" $i`
 fi
-
-echo "Next test is $id"
+auto_id=$id
+
+echo "Next test id is $id"
+
+read -p "Do you want to give a name to the test? y,[n]: " -r
+if [[ "$REPLY" =~ ^[Yy]$ ]]; then
+	# get the new name from user
+	name=""
+	while [ "$name" = "" ]; do
+		read -p "Enter the new name: "
+		if [ "$REPLY" = "" ]; then
+			echo "For canceling, use ctrl+c."
+		elif [ -e "$tdir/$REPLY" ]; then
+			echo "File '$REPLY' already exists, use another one."
+			echo #
+		elif echo "$REPLY" | grep -q "$SUPPORTED_TESTS"; then
+			name="$REPLY"
+		else
+			echo "Filename must contain only alphanumeric symbols and dash!"
+			echo "(Used regex: $SUPPORTED_TESTS)"
+			echo
+		fi
+	done
+
+	# now find where to insert this name
+	eof=1
+	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
+		foundId=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
+		line=$((line+1))
+		if [ -z "$found" ] || [ "$found" == "#" ]; then
+			continue
+		elif [[ "$found" > "$name" ]] || [ "$foundId" -gt "$id" ]; then
+			eof=0
+			break
+		fi
+	done
+	if [ $eof -eq 0 ]; then
+		# If place wasn't found, let $line be the end of the file
+		line=$((line-1))
+	fi
+	id="$id-$name"
+fi
+echo "Creating test file '$id'"
 
 if [ -f $tdir/$id ]
 then
@@ -115,7 +162,7 @@ year=`date +%Y`
 
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
-# FS QA Test No. $id
+# FS QA Test $id
 #
 # what am I here for?
 #
-- 
2.1.0

