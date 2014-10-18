Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:16131 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaJRQGk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 18 Oct 2014 12:06:40 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 1/2] xfstests: update 'new' script v2
Date: Sat, 18 Oct 2014 20:06:32 +0400
Message-Id: <1413648393-17845-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

- Update script to support new test cheme tests/$fs_type/$TEST_IDX
- Try to use first unused ID


placed in root dir.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 new |   85 ++++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/new b/new
index f3e6fa1..88cb7c7 100755
--- a/new
+++ b/new
@@ -32,10 +32,22 @@ _cleanup()
     :
 }
 
-if [ ! -f group ]
+SRC_GROUPS=`find tests -not -path tests -type d -printf "%f "`
+usage()
+{
+    echo "Usage $0 test_dir"
+    echo "Available dirs are: $SRC_GROUPS"
+    exit
+}
+
+[ $# -eq 0 ] && usage
+tdir=tests/$1
+shift
+
+if [ ! -f $tdir/group ]
 then
-    echo "Creating the group index ..."
-    cat <<'End-of-File' >group
+    echo "Creating the $tdir/group index ..."
+    cat <<'End-of-File' >$tdir/group
 # QA groups control
 #
 # define groups and default group owners
@@ -51,10 +63,10 @@ other		some-user-login
 End-of-File
 fi
 
-if [ ! -w group ]
+if [ ! -w $tdir/group ]
 then
-    chmod u+w group
-    echo "Warning: making the index file \"group\" writeable"
+    chmod u+w $tdir/group
+    echo "Warning: making the index file \"$tdir/group\" writeable"
 fi
 
 if make
@@ -64,13 +76,33 @@ else
     echo "Warning: make failed -- some tests may be missing"
 fi
 
-last=`grep '^[0-9][0-9]* ' group | sort | tail -1 | sed -e 's/[ 	].*//'`
-# get rid of leading 0s as can be interpreted as octal
-last=`echo $last | sed 's/^0*//'`
-id=`$AWK_PROG </dev/null 'BEGIN{printf "%03d\n",'$last'+1}'`
+i=0
+line=0
+eof=1
+[ -f "$tdir/group" ] || usage
+
+for found in `cat $tdir/group | gawk '{ print $1 }'`
+do
+    line=$((line+1))
+    if [ -z "$found" ] || [ "$found" == "#" ];then
+	continue
+    fi
+    i=$((i+1))
+    id=`printf "%03d" $i`
+    if [ "$id" != "$found" ];then
+	eof=0
+	break
+    fi
+done
+if [ $eof -eq 1 ]; then
+   line=$((line+1))
+   i=$((i+1))
+   id=`printf "%03d" $i`
+fi
+
 echo "Next test is $id"
 
-if [ -f $id ]
+if [ -f $tdir/$id ]
 then
     echo "Error: test $id already exists!"
     _cleanup
@@ -81,7 +113,7 @@ echo -n "Creating skeletal script for you to edit ..."
 
 year=`date +%Y`
 
-cat <<End-of-File >$id
+cat <<End-of-File >$tdir/$id
 #! /bin/bash
 # FS QA Test No. $id
 #
@@ -146,11 +178,12 @@ End-of-File
 sleep 2		# latency to read messages to this point
 echo ""
 
-chmod 755 $id
-${EDITOR-vi} $id
+chmod 755 $tdir/$id
+${EDITOR-vi} $tdir/$id
 
 if [ $# -eq 0 ]
 then
+
     while true
     do
 	echo -n "Add to group(s) [other] (? for list): "
@@ -158,12 +191,15 @@ then
 	[ -z "$ans" ] && ans=other
 	if [ "X$ans" = "X?" ]
 	then
-	    $AWK_PROG <group '
-BEGIN		{ text = "# ???" }
-/^[a-z]/	{ printf "%-16.16s %s\n",$1,text; text = "# ???"; next }
-NF < 2		{ next }
-		{ text = $0 }' \
-	    | sort
+	    for d in $SRC_GROUPS; do
+		l=$(sed -n < tests/$d/group \
+		    -e 's/#.*//' \
+		    -e 's/$/ /' \
+		    -e 's;\(^[0-9][0-9][0-9]\)\(.*$\);\2;p')
+		grpl="$grpl $l"
+	    done
+	    lst=`for word in $grpl; do echo $word; done | sort| uniq `
+	    echo $lst
 	else
 	    break
 	fi
@@ -173,18 +209,21 @@ else
     #
     for g in $*
     do
-	if grep "^$g[ 	]" group >/dev/null
+	if grep "^$g[ 	]" $tdir/group >/dev/null
 	then
 	    :
 	else
-	    echo "Warning: group \"$g\" not defined in ./group"
+	    echo "Warning: group \"$g\" not defined in $tdir/group"
 	fi
     done
     ans="$*"
 fi
 
 echo -n "Adding $id to group index ..."
-echo "$id $ans" >>group
+head -n $(($line-1)) $tdir/group > /tmp/$$.group
+echo "$id $ans" >> /tmp/$$.group
+tail -n +$((line)) $tdir/group >> /tmp/$$.group
+mv /tmp/$$.group $tdir/group
 echo " done."
 
 exit 0
-- 
1.7.1

