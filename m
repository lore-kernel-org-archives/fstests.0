Received: from mail-wm0-f67.google.com ([74.125.82.67]:56233 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdJLOyW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Oct 2017 10:54:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id u138so14197659wmu.4
        for <fstests@vger.kernel.org>; Thu, 12 Oct 2017 07:54:21 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 1/3] common: move _filter_xfs_dmesg() to common/filter
Date: Thu, 12 Oct 2017 16:54:02 +0200
Message-Id: <1507820044-2161-2-git-send-email-idryomov@gmail.com>
In-Reply-To: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
References: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 common/filter | 23 +++++++++++++++++++++++
 common/xfs    | 22 ----------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/common/filter b/common/filter
index 39ea140cb60f..441ee1a6e490 100644
--- a/common/filter
+++ b/common/filter
@@ -448,5 +448,28 @@ _filter_filefrag()
 	      $flags, "\n"'
 }
 
+# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
+# direct IO on the same file. This is a helper for _check_dmesg() to filter out
+# such warnings.
+_filter_xfs_dmesg()
+{
+	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
+	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
+	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
+	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
+	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
+	local warn6="WARNING:.*fs/xfs/xfs_aops\.c:.*__xfs_get_blocks.*"
+	local warn7="WARNING:.*fs/iomap\.c:.*iomap_dio_actor.*"
+	local warn8="WARNING:.*fs/iomap\.c:.*iomap_dio_complete.*"
+	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
+	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
+	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
+	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
+	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#" \
+	    -e "s#$warn6#Intentional warnings in __xfs_get_blocks#" \
+	    -e "s#$warn7#Intentional warnings in iomap_dio_actor#" \
+	    -e "s#$warn8#Intentional warnings in iomap_dio_complete#"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/common/xfs b/common/xfs
index 93eb50394984..d4fef941d321 100644
--- a/common/xfs
+++ b/common/xfs
@@ -599,25 +599,3 @@ _require_no_xfs_debug()
 		_notrun "Require XFS built without CONFIG_XFS_DEBUG"
 	fi
 }
-# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
-# direct IO on the same file. This is a helper for _check_dmesg() to filter out
-# such warnings.
-_filter_xfs_dmesg()
-{
-	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
-	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
-	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
-	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
-	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
-	local warn6="WARNING:.*fs/xfs/xfs_aops\.c:.*__xfs_get_blocks.*"
-	local warn7="WARNING:.*fs/iomap\.c:.*iomap_dio_actor.*"
-	local warn8="WARNING:.*fs/iomap\.c:.*iomap_dio_complete.*"
-	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
-	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
-	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
-	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
-	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#" \
-	    -e "s#$warn6#Intentional warnings in __xfs_get_blocks#" \
-	    -e "s#$warn7#Intentional warnings in iomap_dio_actor#" \
-	    -e "s#$warn8#Intentional warnings in iomap_dio_complete#"
-}
-- 
2.4.3

