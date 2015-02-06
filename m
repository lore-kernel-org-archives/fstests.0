Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52869 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbbBFGhj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:39 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/9 v5] common/rc: add _require_fiemap and _extent_hole_counts
Date: Thu,  5 Feb 2015 22:37:06 -0800
Message-Id: <1423204633-66673-3-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This is to detect whether fiemap tool supports or not.

For the follwoing tests, this patch adds general script to get extent and
hole counts.

 xfs/137         (data vs filesize)
 xfs/138         (data vs filesize vs truncate)
 xfs/139         (data vs filesize vs partial truncate)
 xfs/140         (data vs filesize vs extending truncate)
 xfs/179         (data vs filesize w/ fsync)
 xfs/180         (data vs filesize w/ sync)
 xfs/182         (data vs filesize w/ recovery)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc     | 13 +++++++++++++
 tests/xfs/137 | 10 ++++++----
 tests/xfs/138 | 10 ++++++----
 tests/xfs/139 | 10 ++++++----
 tests/xfs/140 |  6 ++++--
 tests/xfs/179 |  6 ++++--
 tests/xfs/180 |  6 ++++--
 tests/xfs/182 |  6 ++++--
 8 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/common/rc b/common/rc
index 234638b..078d3ca 100644
--- a/common/rc
+++ b/common/rc
@@ -2332,6 +2332,19 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+# Does fiemap support?
+_require_fiemap()
+{
+	_require_xfs_io_command "fiemap"
+}
+
+_extent_hole_counts()
+{
+	res=`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
+	echo $res | grep -v hole | wc -l | $AWK_PROG '{print $1}'
+	echo $res | grep hole | wc -l | $AWK_PROG '{print $1}'
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
diff --git a/tests/xfs/137 b/tests/xfs/137
index 662a267..e31a616 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -85,11 +86,12 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			counts=`_extent_hole_counts`
+			num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+			num_holes=`echo $counts | $AWK_PROG '{print $2}'`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
-			then
+			elif [ $num_holes -ne 0 ]; then
 				echo corrupt file $file - contains holes
 			else
 				rm -f $file
diff --git a/tests/xfs/138 b/tests/xfs/138
index 3fb182c..b2cbb4e 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -91,11 +92,12 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			counts=`_extent_hole_counts`
+			num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+			num_holes=`echo $counts | $AWK_PROG '{print $2}'`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
-			then
+			elif [ $num_holes -ne 0 ]; then
 				echo corrupt file $file - contains holes
 			else
 				rm -f $file
diff --git a/tests/xfs/139 b/tests/xfs/139
index 6986c17..5e8b7c5 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -91,11 +92,12 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			counts=`_extent_hole_counts`
+			num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+			num_holes=`echo $counts | $AWK_PROG '{print $2}'`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
-			then
+			elif [ $num_holes -ne 0 ]; then
 				echo corrupt file $file - contains holes
 			else
 				rm -f $file
diff --git a/tests/xfs/140 b/tests/xfs/140
index b82e43b..105ef0d 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -91,8 +92,9 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			counts=`_extent_hole_counts`
+			num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
 			else
 				rm -f $file
diff --git a/tests/xfs/179 b/tests/xfs/179
index 87fac8a..5dec31f 100755
--- a/tests/xfs/179
+++ b/tests/xfs/179
@@ -42,6 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -59,8 +60,9 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
-				then
+				counts=`_extent_hole_counts`
+				num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+				if [ $num_extents -eq 0 ]; then
 					echo corrupt file $file - non-zero size but no extents
 				else
 					rm -f $file
diff --git a/tests/xfs/180 b/tests/xfs/180
index b3b0fe4..853f6f2 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -42,6 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -62,8 +63,9 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 10485760 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
-				then
+				counts=`_extent_hole_counts`
+				num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+				if [ $num_extents -eq 0 ]; then
 					echo corrupt file $file - non-zero size but no extents
 				else
 					rm -f $file
diff --git a/tests/xfs/182 b/tests/xfs/182
index dac15d4..4b08989 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -42,6 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -59,8 +60,9 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
-				then
+				counts=`_extent_hole_counts`
+				num_extents=`echo $counts | $AWK_PROG '{print $1}'`
+				if [ $num_extents -eq 0 ]; then
 					echo corrupt file $file - non-zero size but no extents
 				else
 					rm -f $file
-- 
2.1.1

