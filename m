Received: from mx2.suse.de ([195.135.220.15]:46356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730522AbfAUQdq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:46 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBC09AFA3
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:44 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 7/7] check: move test exclusion handling to _prepare_test_list
Date: Mon, 21 Jan 2019 11:33:16 -0500
Message-Id: <20190121163316.20616-7-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
References: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

In order to simplify combining excluded tests specified on the command
line vs specified via config files, it makes sense to push the handling
into _prepare_test_list.  This means we start with a fresh $tmp.xlist
and rebuild it each time _prepare_test_list is called.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 check | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/check b/check
index 77a06b00..17073c4e 100755
--- a/check
+++ b/check
@@ -230,7 +230,28 @@ _prepare_test_list()
 		done
 	fi
 
-	# Specified groups to exclude
+	:> $tmp.xlist
+
+	# Per-fstype/generic/shared file of tests to exclude (-X)
+	for xfile in $XGROUP_FILES; do
+		for d in $SRC_GROUPS $FSTYP; do
+			[ -f $SRC_DIR/$d/$xfile ] || continue
+			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
+				echo "$d/$f command line" >> $tmp.xlist
+			done
+		done
+	done
+
+	# External file of tests to exclude (-E)
+	for xfile in $EXCLUDE_FILES; do
+		if [ -f $xfile ]; then
+			sed -e "s/#.*$//" \
+			    -e "s;$; file $xfile;" "$xfile" \
+			    >> $tmp.xlist
+	        fi
+	done
+
+	# Specified groups to exclude (-x)
 	for xgroup in $XGROUP_LIST; do
 		list=$(get_group_list $xgroup)
 		if [ -z "$list" ]; then
@@ -273,13 +294,8 @@ while [ $# -gt 0 ]; do
 		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
 		;;
 
-	-X)	subdir_xfile=$2; shift ;
-		;;
-	-E)	xfile=$2; shift ;
-		if [ -f $xfile ]; then
-			sed "s/#.*$//" "$xfile" >> $tmp.xlist
-	        fi
-		;;
+	-X)	XGROUP_FILES="$XGROUP_FILES $2" ; shift ;;
+	-E)	EXCLUDE_FILES="$EXCLUDE_FILES $2" ; shift ;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
@@ -320,15 +336,6 @@ if ! . ./common/rc; then
 	exit 1
 fi
 
-if [ -n "$subdir_xfile" ]; then
-	for d in $SRC_GROUPS $FSTYP; do
-		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
-		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
-			echo $d/$f >> $tmp.xlist
-		done
-	done
-fi
-
 # Process tests from command line now.
 if $have_test_arg; then
 	while [ $# -gt 0 ]; do
-- 
2.16.4
