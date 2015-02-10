Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52305 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbbBJVwU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 10 Feb 2015 16:52:20 -0500
Date: Tue, 10 Feb 2015 13:52:16 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/9 v6] common/rc: add _require_fiemap and counting
 extents and holes
Message-ID: <20150210215216.GA83208@jaegeuk-mac02.mot.com>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
 <1423204633-66673-3-git-send-email-jaegeuk@kernel.org>
 <20150210054748.GL4251@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150210054748.GL4251@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Change log from v5:
 o split _count_extents and _count_holes

-- >8 --

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
 common/rc     | 18 ++++++++++++++++++
 tests/xfs/137 |  9 +++++----
 tests/xfs/138 |  9 +++++----
 tests/xfs/139 |  9 +++++----
 tests/xfs/140 |  5 +++--
 tests/xfs/179 |  5 +++--
 tests/xfs/180 |  5 +++--
 tests/xfs/182 |  5 +++--
 8 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/common/rc b/common/rc
index 234638b..a0b92eb 100644
--- a/common/rc
+++ b/common/rc
@@ -2332,6 +2332,24 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+# Does fiemap support?
+_require_fiemap()
+{
+	_require_xfs_io_command "fiemap"
+}
+
+_count_extents()
+{
+	res=`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
+	echo $res | grep -v hole | wc -l | $AWK_PROG '{print $1}'
+}
+
+_count_holes()
+{
+	res=`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
+	echo $res | grep hole | wc -l | $AWK_PROG '{print $1}'
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
diff --git a/tests/xfs/137 b/tests/xfs/137
index 662a267..eb9a5fa 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -85,11 +86,11 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			num_extents=`_count_extents $file`
+			num_holes=`_count_holes $file`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
-			then
+			elif [ $num_holes -ne 0 ]; then
 				echo corrupt file $file - contains holes
 			else
 				rm -f $file
diff --git a/tests/xfs/138 b/tests/xfs/138
index 3fb182c..809a8ee 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -91,11 +92,11 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			num_extents=`_count_extents $file`
+			num_holes=`_count_holes $file`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
-			then
+			elif [ $num_holes -ne 0 ]; then
 				echo corrupt file $file - contains holes
 			else
 				rm -f $file
diff --git a/tests/xfs/139 b/tests/xfs/139
index 6986c17..de91a29 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -91,11 +92,11 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			num_extents=`_count_extents $file`
+			num_holes=`_count_holes $file`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
-			then
+			elif [ $num_holes -ne 0 ]; then
 				echo corrupt file $file - contains holes
 			else
 				rm -f $file
diff --git a/tests/xfs/140 b/tests/xfs/140
index b82e43b..4882abd 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -41,6 +41,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -91,8 +92,8 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
-			then
+			num_extents=`_count_extents $file`
+			if [ $num_extents -eq 0 ]; then
 				echo corrupt file $file - non-zero size but no extents
 			else
 				rm -f $file
diff --git a/tests/xfs/179 b/tests/xfs/179
index 87fac8a..2f3673e 100755
--- a/tests/xfs/179
+++ b/tests/xfs/179
@@ -42,6 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -59,8 +60,8 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
-				then
+				num_extents=`_count_extents $file`
+				if [ $num_extents -eq 0 ]; then
 					echo corrupt file $file - non-zero size but no extents
 				else
 					rm -f $file
diff --git a/tests/xfs/180 b/tests/xfs/180
index b3b0fe4..40a186a 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -42,6 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -62,8 +63,8 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 10485760 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
-				then
+				num_extents=`_count_extents $file`
+				if [ $num_extents -eq 0 ]; then
 					echo corrupt file $file - non-zero size but no extents
 				else
 					rm -f $file
diff --git a/tests/xfs/182 b/tests/xfs/182
index dac15d4..028e121 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -42,6 +42,7 @@ _supported_os Linux IRIX
 
 _require_scratch
 _require_scratch_shutdown
+_require_fiemap
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
@@ -59,8 +60,8 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
-				then
+				num_extents=`_count_extents $file`
+				if [ $num_extents -eq 0 ]; then
 					echo corrupt file $file - non-zero size but no extents
 				else
 					rm -f $file
-- 
2.1.1


