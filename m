Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56472 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259AbbBCXHm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:42 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/8 v4] tests/xfs: convert 10 xfs's tests to be generic ones
Date: Tue,  3 Feb 2015 15:07:16 -0800
Message-Id: <1423004840-45315-5-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch changes ten xfs's testcases to be generic ones, pointed out by Dave.
 xfs/053         (data exposure)
 xfs/137         (data vs filesize)
 xfs/138         (data vs filesize vs truncate)
 xfs/139         (data vs filesize vs partial truncate)
 xfs/140         (data vs filesize vs extending truncate)
 xfs/179         (data vs filesize w/ fsync)
 xfs/180         (data vs filesize w/ sync)
 xfs/182         (data vs filesize w/ recovery)
 xfs/200         (recovery vs ro-block device)
 xfs/306         (fsstress vs recovery)

All these tests need _require_scratch_shutdown, and some of them need
_require_bmap utils.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/xfs/053 |  3 ++-
 tests/xfs/137 | 10 ++++++----
 tests/xfs/138 | 10 ++++++----
 tests/xfs/139 | 10 ++++++----
 tests/xfs/140 |  8 +++++---
 tests/xfs/179 |  8 +++++---
 tests/xfs/180 |  8 +++++---
 tests/xfs/182 |  8 +++++---
 tests/xfs/200 |  6 ++++--
 tests/xfs/306 |  3 ++-
 10 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/tests/xfs/053 b/tests/xfs/053
index 9749345..a3ebc62 100755
--- a/tests/xfs/053
+++ b/tests/xfs/053
@@ -83,9 +83,10 @@ _crashtest()
 }
 
 # Modify as appropriate.
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_scratch_shutdown
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "fzero"
diff --git a/tests/xfs/137 b/tests/xfs/137
index 79b3b89..6ec1bcb 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -36,11 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -84,10 +86,10 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
 			then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
+			elif $BMAP_PROG $file | grep 'hole' > /dev/null
 			then
 				echo corrupt file $file - contains holes
 			else
diff --git a/tests/xfs/138 b/tests/xfs/138
index 1b11cf6..9f12639 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -36,11 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -90,10 +92,10 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
 			then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
+			elif $BMAP_PROG $file | grep 'hole' > /dev/null
 			then
 				echo corrupt file $file - contains holes
 			else
diff --git a/tests/xfs/139 b/tests/xfs/139
index e5296f7..4baa1bc 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -36,11 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -90,10 +92,10 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
 			then
 				echo corrupt file $file - non-zero size but no extents
-			elif xfs_bmap $file | grep 'hole' > /dev/null
+			elif $BMAP_PROG $file | grep 'hole' > /dev/null
 			then
 				echo corrupt file $file - contains holes
 			else
diff --git a/tests/xfs/140 b/tests/xfs/140
index cccf262..aff835a 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -36,11 +36,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # create files
@@ -90,7 +92,7 @@ do
 		if [ -s $file ]
 		then
 			# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-			if xfs_bmap $file | grep 'no extents' > /dev/null
+			if $BMAP_PROG $file | grep 'no extents' > /dev/null
 			then
 				echo corrupt file $file - non-zero size but no extents
 			else
diff --git a/tests/xfs/179 b/tests/xfs/179
index ce50d99..e71afae 100755
--- a/tests/xfs/179
+++ b/tests/xfs/179
@@ -37,11 +37,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _check_files()
@@ -58,7 +60,7 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
+				if $BMAP_PROG $file | grep 'no extents' > /dev/null
 				then
 					echo corrupt file $file - non-zero size but no extents
 				else
diff --git a/tests/xfs/180 b/tests/xfs/180
index a0fb69a..9e9bf8d 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -37,11 +37,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 # Do we have enough space on disk?  10G
@@ -61,7 +63,7 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 10485760 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
+				if $BMAP_PROG $file | grep 'no extents' > /dev/null
 				then
 					echo corrupt file $file - non-zero size but no extents
 				else
diff --git a/tests/xfs/182 b/tests/xfs/182
index b75e4fc..68d872c 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -37,11 +37,13 @@ trap "exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+_require_scratch_shutdown
+_require_bmap
+_scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _check_files()
@@ -58,7 +60,7 @@ _check_files()
 			if [ `ls -l $file | tr -s ' ' | cut -d ' ' -f 5` -eq 32768 ]
 			then
 				# if file has non-zero size but no extents then it's contents will be NULLs, bad.
-				if xfs_bmap $file | grep 'no extents' > /dev/null
+				if $BMAP_PROG $file | grep 'no extents' > /dev/null
 				then
 					echo corrupt file $file - non-zero size but no extents
 				else
diff --git a/tests/xfs/200 b/tests/xfs/200
index f0c4337..f29feb9 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -41,12 +41,14 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 
 _require_scratch_nocheck
+_require_scratch_shutdown
+_require_norecovery
 
-_scratch_mkfs_xfs >/dev/null 2>&1
+_scratch_mkfs >/dev/null 2>&1
 
 #
 # Mark the device read-only
diff --git a/tests/xfs/306 b/tests/xfs/306
index 3053fd9..71f352e 100755
--- a/tests/xfs/306
+++ b/tests/xfs/306
@@ -45,10 +45,11 @@ _cleanup()
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
 
 _require_scratch
+_require_scratch_shutdown
 
 rm -f $seqres.full
 
-- 
2.1.1

