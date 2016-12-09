Received: from mail-wm0-f67.google.com ([74.125.82.67]:35178 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbcLIIvH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2016 03:51:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so2526385wme.2
        for <fstests@vger.kernel.org>; Fri, 09 Dec 2016 00:51:07 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] common: fix excluding test groups
Date: Fri,  9 Dec 2016 10:50:46 +0200
Message-Id: <1481273446-32502-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The -x flag is used to exclude tests that belong to
certain groups from the test args list.

When the test args list is expressed as a match pattern,
-x fails to exclude the tests that match the pattern
and belong to excluded groups.

For example:
$ ./check -n xfs/??? | wc -l
341
$ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
341

After the fix:
$ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
315

This bug seems to date back to this git repo epoc.

The fix also sorts out filtering of test that are not found
in group files for the patten match input.

For example:
$ ./check xfs/001*
...
xfs/001	 2s
xfs/001.out	 [failed, exit status 127] - no qualified output

After the fix:
$ ./check -n xfs/001*
xfs/001.out - unknown test, ignored
...
xfs/001 2s

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

v2:
- Expand test match pattern when processing arglist

v1:
- Expand test match pattern before excluding groups

diff --git a/check b/check
index 8f2a1bb..1d08718 100755
--- a/check
+++ b/check
@@ -281,18 +281,24 @@ if $have_test_arg; then
 			status=1
 			exit $status
 			;;
-		*)	test_dir=`dirname $1`
-			test_dir=${test_dir#$SRC_DIR/*}
-			test_name=`basename $1`
-			group_file=$SRC_DIR/$test_dir/group
-
-			if egrep "^$test_name" $group_file >/dev/null ; then
-				# in group file ... OK
-				echo $SRC_DIR/$test_dir/$test_name >>$tmp.arglist
-			else
-				# oops
-				echo "$1 - unknown test, ignored"
-			fi
+		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
+			list=$(cd $SRC_DIR; echo $1)
+			for t in $list; do
+				test_dir=`dirname $t`
+				test_dir=${test_dir#$SRC_DIR/*}
+				test_name=`basename $t`
+				group_file=$SRC_DIR/$test_dir/group
+
+				if egrep "^$test_name" $group_file >/dev/null
+				then
+					# in group file ... OK
+					echo $SRC_DIR/$test_dir/$test_name \
+						>>$tmp.arglist
+				else
+					# oops
+					echo "$t - unknown test, ignored"
+				fi
+			done
 			;;
 		esac
 
-- 
2.7.4

