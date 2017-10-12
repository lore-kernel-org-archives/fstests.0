Received: from mail-wm0-f66.google.com ([74.125.82.66]:56238 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdJLOyX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Oct 2017 10:54:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id u138so14197910wmu.4
        for <fstests@vger.kernel.org>; Thu, 12 Oct 2017 07:54:22 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 2/3] common: turn _filter_xfs_dmesg() into _filter_aiodio_dmesg()
Date: Thu, 12 Oct 2017 16:54:03 +0200
Message-Id: <1507820044-2161-3-git-send-email-idryomov@gmail.com>
In-Reply-To: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
References: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

With upstream commit 332391a9935d ("fs: Fix page cache inconsistency
when mixing buffered and AIO DIO"), ext4 (and probably other non-iomap
based filesystems) need a _check_dmesg() whitelist entry for a new WARN
in dio_complete() -- generic/095 and 247 trigger a dio_complete() splat
pretty reliably for me.

Add dio_complete() entry to _filter_xfs_dmesg(), rename it and use it
unconditionally in generic/095, 224, 247 and 446.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 common/filter     | 8 +++++---
 tests/generic/095 | 7 ++-----
 tests/generic/224 | 9 +++------
 tests/generic/247 | 9 +++------
 tests/generic/446 | 9 +++------
 5 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/common/filter b/common/filter
index 441ee1a6e490..0cb458b0051f 100644
--- a/common/filter
+++ b/common/filter
@@ -448,10 +448,10 @@ _filter_filefrag()
 	      $flags, "\n"'
 }
 
-# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
+# We generate WARNINGs on purpose when applications mix buffered/mmap IO with
 # direct IO on the same file. This is a helper for _check_dmesg() to filter out
 # such warnings.
-_filter_xfs_dmesg()
+_filter_aiodio_dmesg()
 {
 	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
 	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
@@ -461,6 +461,7 @@ _filter_xfs_dmesg()
 	local warn6="WARNING:.*fs/xfs/xfs_aops\.c:.*__xfs_get_blocks.*"
 	local warn7="WARNING:.*fs/iomap\.c:.*iomap_dio_actor.*"
 	local warn8="WARNING:.*fs/iomap\.c:.*iomap_dio_complete.*"
+	local warn9="WARNING:.*fs/direct-io\.c:.*dio_complete.*"
 	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
 	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
 	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
@@ -468,7 +469,8 @@ _filter_xfs_dmesg()
 	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#" \
 	    -e "s#$warn6#Intentional warnings in __xfs_get_blocks#" \
 	    -e "s#$warn7#Intentional warnings in iomap_dio_actor#" \
-	    -e "s#$warn8#Intentional warnings in iomap_dio_complete#"
+	    -e "s#$warn8#Intentional warnings in iomap_dio_complete#" \
+	    -e "s#$warn9#Intentional warnings in dio_complete#"
 }
 
 # make sure this script returns success
diff --git a/tests/generic/095 b/tests/generic/095
index 050215d41700..fd4f13fd0a1b 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -126,10 +126,7 @@ $FIO_PROG $fio_config >>$seqres.full 2>&1
 # umount before checking dmesg in case umount triggers any WARNING or Oops
 _scratch_unmount
 
-if [ "$FSTYP" == "xfs" ]; then
-	_check_dmesg _filter_xfs_dmesg
-else
-	_check_dmesg
-fi
+_check_dmesg _filter_aiodio_dmesg
+
 status=$?
 exit
diff --git a/tests/generic/224 b/tests/generic/224
index 29b1c05d06df..6b3a81536aa8 100755
--- a/tests/generic/224
+++ b/tests/generic/224
@@ -83,13 +83,10 @@ done
 wait
 echo "*** Silence is golden ***"
 
-# unmount and check dmesg, filtering out expected XFS warnings about mixed
+# unmount and check dmesg, filtering out expected warnings about mixed
 # direct and buffered I/O
 _scratch_unmount
-if [ "$FSTYP" == "xfs" ]; then
-	_check_dmesg _filter_xfs_dmesg
-else
-	_check_dmesg
-fi
+_check_dmesg _filter_aiodio_dmesg
+
 status=$?
 exit
diff --git a/tests/generic/247 b/tests/generic/247
index aac7078045ee..0614100cd7a8 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -80,13 +80,10 @@ wait
 
 echo "Silence is golden."
 
-# unmount and check dmesg, filtering out expected XFS warnings about mixed
+# unmount and check dmesg, filtering out expected warnings about mixed
 # mmap/dio
 _test_unmount
-if [ "$FSTYP" == "xfs" ]; then
-	_check_dmesg _filter_xfs_dmesg
-else
-	_check_dmesg
-fi
+_check_dmesg _filter_aiodio_dmesg
+
 status=$?
 exit
diff --git a/tests/generic/446 b/tests/generic/446
index 6a1b69aa2edc..01228322911e 100755
--- a/tests/generic/446
+++ b/tests/generic/446
@@ -79,13 +79,10 @@ wait $dread_pid > /dev/null 2>&1
 
 echo "Silence is golden"
 
-# check dmesg, filtering out expected XFS warnings about mixed mmap/dio
+# check dmesg, filtering out expected warnings about mixed mmap/dio
 # and umount first in case umount triggers warnings
 _scratch_unmount
-if [ "$FSTYP" == "xfs" ]; then
-	_check_dmesg _filter_xfs_dmesg
-else
-	_check_dmesg
-fi
+_check_dmesg _filter_aiodio_dmesg
+
 status=$?
 exit
-- 
2.4.3

