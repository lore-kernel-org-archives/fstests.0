Received: from mx2.suse.de ([195.135.220.15]:39262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728844AbeLSPmA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Dec 2018 10:42:00 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F20B1ADD4
        for <fstests@vger.kernel.org>; Wed, 19 Dec 2018 15:41:58 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] check: fix -X exclude_file behaviour
Date: Wed, 19 Dec 2018 16:41:55 +0100
Message-Id: <20181219154155.10140-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

It is currently processed before FSTYP has been properly set, leading to
xfs, btrfs, etc. specific exclude_files being ignored.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 check | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/check b/check
index 59f94c1c..5f8210d7 100755
--- a/check
+++ b/check
@@ -22,6 +22,7 @@ have_test_arg=false
 randomize=false
 export here=`pwd`
 xfile=""
+subdir_xfile=""
 brief_test_summary=false
 do_report=false
 DUMP_OUTPUT=false
@@ -272,13 +273,7 @@ while [ $# -gt 0 ]; do
 		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
 		;;
 
-	-X)	xfile=$2; shift ;
-		for d in $SRC_GROUPS $FSTYP; do
-			[ -f $SRC_DIR/$d/$xfile ] || continue
-			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
-				echo $d/$f >> $tmp.xlist
-			done
-		done
+	-X)	subdir_xfile=$2; shift ;
 		;;
 	-E)	xfile=$2; shift ;
 		if [ -f $xfile ]; then
@@ -325,6 +320,15 @@ if ! . ./common/rc; then
 	exit 1
 fi
 
+if [ -n "$subdir_xfile" ]; then
+	for d in $SRC_GROUPS $FSTYP; do
+		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
+		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
+			echo $d/$f >> $tmp.xlist
+		done
+	done
+fi
+
 # Process tests from command line now.
 if $have_test_arg; then
 	while [ $# -gt 0 ]; do
-- 
2.13.7
