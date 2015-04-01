Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185AbbDANRQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 1 Apr 2015 09:17:16 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH v10] fstests: Tests can use any name now, not 3 digits only.
Date: Wed,  1 Apr 2015 15:17:13 +0200
Message-Id: <1427894233-10338-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <20150401043542.GD8465@dastard>
References: <20150401043542.GD8465@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

Tests can use any name now, not 3 digits only.
(e.g. a test can be named "tests/generic/001-some-name")

Names are limited to alphanumeric characters and dash and are always prefixed
with an unique id for easier identification of a specific test.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---

 ./new:
 - input validation is moved before file check
 - no longer printing regex to user
 - removed name comparison, as we have unique IDs.
 - better string cutting

 edited README, changed regex for valid test names


 README    |  8 +++++++-
 check     |  9 ++++-----
 common/rc | 10 ++++++++++
 new       | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/README b/README
index 0c9449a..f8a878c 100644
--- a/README
+++ b/README
@@ -202,10 +202,16 @@ Test script environment:
 	- When calling getfacl in a test, pass the "-n" argument so
 	  that numeric rather than symbolic identifiers are used in
 	  the output.
+	- When creating a new test, it is possible to enter a custom name
+	  for the file. Filenames are in form NNN-custom-name, where NNN
+	  is automatically added by the ./new script as an unique ID,
+	  and "custom-name" is the optional string entered into a prompt
+	  in the ./new script. It can contain only alphanumeric characters
+	  and dash. Note the "NNN-" part is added automatically.
 
 Verified output:
 
-    Each test script has a numerical name, e.g. 007, and an associated
+    Each test script has a name, e.g. 007, and an associated
     verified output, e.g. 007.out.
 
     It is important that the verified output is deterministic, and
diff --git a/check b/check
index 0830e0c..4fa96ed 100755
--- a/check
+++ b/check
@@ -58,7 +58,6 @@ then
     exit 1
 fi
 
-SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
 
@@ -96,21 +95,21 @@ get_group_list()
 		l=$(sed -n < $SRC_DIR/$d/group \
 			-e 's/#.*//' \
 			-e 's/$/ /' \
-			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
+			-e "s;^\($VALID_TEST_NAME\).* $grp .*;$SRC_DIR/$d/\1;p")
 		grpl="$grpl $l"
 	done
 	echo $grpl
 }
 
-# find all tests, excluding files that are test metadata such as group files.
-# This assumes that tests are defined purely by alphanumeric filenames with no
-# ".xyz" extensions in the name.
+# Find all tests, excluding files that are test metadata such as group files.
+# It matches test names against $VALID_TEST_NAME defined in common/rc
 get_all_tests()
 {
 	touch $tmp.list
 	for d in $SRC_GROUPS $FSTYP; do
 		ls $SRC_DIR/$d/* | \
 			grep -v "\..*" | \
+			grep "^$SRC_DIR/$d/$VALID_TEST_NAME"| \
 			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
 	done
 }
diff --git a/common/rc b/common/rc
index 857308a..869b56b 100644
--- a/common/rc
+++ b/common/rc
@@ -22,6 +22,16 @@
 
 BC=$(which bc 2> /dev/null) || BC=
 
+# Valid test names start with 3 digits "NNN":
+#  "[0-9]\{3\}"
+# followed by an optional "-":
+#  "-\?"
+# followed by an optional combination of alphanumeric and "-" chars:
+#  "[[:alnum:]-]*"
+# e.g. 999-the-mark-of-fstests
+#
+VALID_TEST_NAME="[0-9]\{3\}-\?[[:alnum:]-]*"
+
 _require_math()
 {
 	if [ -z "$BC" ]; then
diff --git a/new b/new
index d1f8939..c734bdc 100755
--- a/new
+++ b/new
@@ -81,11 +81,14 @@ line=0
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
+    elif ! echo "$found" | grep -q "^$VALID_TEST_NAME$"; then
+        # this one is for tests not named by a number
+        continue
     fi
     i=$((i+1))
     id=`printf "%03d" $i`
@@ -100,7 +103,48 @@ if [ $eof -eq 1 ]; then
    id=`printf "%03d" $i`
 fi
 
-echo "Next test is $id"
+echo "Next test id is $id"
+
+read -p "Append a name to the ID? Test name will be $id-\$name. y,[n]: " -r
+if [[ $REPLY = [Yy] ]]; then
+	# get the new name from user
+	name=""
+	while [ "$name" = "" ]; do
+		read -p "Enter the name: "
+		if [ "$REPLY" = "" ]; then
+			echo "For canceling, use ctrl+c."
+		elif echo "$id-$REPLY" | grep -q "^$VALID_TEST_NAME$"; then
+			if [ -e "$tdir/$id-$REPLY" ]; then
+				echo "File '$id-$REPLY' already exists, use another one."
+				echo
+			else
+				name="$REPLY"
+			fi
+		else
+			echo "A name can contain only alphanumeric symbols and dash!"
+			echo
+		fi
+	done
+
+	# now find where to insert this name
+	eof=1
+	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
+		found_id=$(echo "$found" | cut -d "-" -f 1 - )
+		line=$((line+1))
+		if [ -z "$found" ] || [ "$found" == "#" ]; then
+			continue
+		elif [ $found_id -gt $id ]; then
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
@@ -115,7 +159,7 @@ year=`date +%Y`
 
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
-# FS QA Test No. $id
+# FS QA Test $id
 #
 # what am I here for?
 #
-- 
2.1.0

