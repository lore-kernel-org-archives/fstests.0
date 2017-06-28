Received: from mx1.redhat.com ([209.132.183.28]:41012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbdF1OOo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Jun 2017 10:14:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 287FF110E
        for <fstests@vger.kernel.org>; Wed, 28 Jun 2017 14:14:44 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-20.bos.redhat.com [10.18.41.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A68A891F1
        for <fstests@vger.kernel.org>; Wed, 28 Jun 2017 14:14:44 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] generic/247: filter out expected XFS warnings for mixed mmap/direct I/O
Date: Wed, 28 Jun 2017 10:14:42 -0400
Message-Id: <20170628141442.10950-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/247 reproduces some of the same, expected warnings from XFS
as generic/095. These warnings occur due to mixed buffered/mapped
I/O racing with direct I/O to the same file.

generic/095 contains a custom dmesg filter to prevent test failure
in the event of such warnings. Lift the helper from generic/095 to
common/xfs and reuse it in generic/247 to implement the same
behavior.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 common/xfs        | 18 ++++++++++++++++++
 tests/generic/095 | 20 +++-----------------
 tests/generic/247 | 11 +++++++++--
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/common/xfs b/common/xfs
index 0f0825b..0266f50 100644
--- a/common/xfs
+++ b/common/xfs
@@ -584,3 +584,21 @@ _require_xfs_mkfs_ciname()
 	_scratch_mkfs_xfs_supported -n version=ci >/dev/null 2>&1 \
 		|| _notrun "need case-insensitive naming support in mkfs.xfs"
 }
+
+# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
+# direct IO on the same file. This is a helper for _check_dmesg() to filter out
+# such warnings.
+filter_xfs_dmesg()
+{
+	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
+	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
+	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
+	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
+	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
+	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
+	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
+	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
+	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
+	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#"
+}
+
diff --git a/tests/generic/095 b/tests/generic/095
index d837564..9580aaf 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -117,28 +117,14 @@ _scratch_mount
 echo "Silence is golden"
 $FIO_PROG $fio_config >>$seqres.full 2>&1
 
+# umount before checking dmesg in case umount triggers any WARNING or Oops
+_scratch_unmount
+
 # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
 # direct IO on the same file. On the other hand, this fio job has been proven
 # to be potent, we don't want to simply _disable_dmesg_check which could miss
 # other potential bugs. So filter out the intentional WARNINGs, make sure test
 # doesn't fail because of this warning and fails on other WARNINGs.
-filter_xfs_dmesg()
-{
-	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
-	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
-	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
-	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
-	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
-	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
-	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
-	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
-	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
-	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#"
-}
-
-# umount before checking dmesg in case umount triggers any WARNING or Oops
-_scratch_unmount
-
 if [ "$FSTYP" == "xfs" ]; then
 	_check_dmesg filter_xfs_dmesg
 else
diff --git a/tests/generic/247 b/tests/generic/247
index 832ade1..f46ab30 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -80,6 +80,13 @@ wait
 
 echo "Silence is golden."
 
-# success, all done
-status=0
+# unmount and check dmesg, filtering out expected XFS warnings about mixed
+# mmap/dio
+_scratch_unmount
+if [ "$FSTYP" == "xfs" ]; then
+	_check_dmesg filter_xfs_dmesg
+else
+	_check_dmesg
+fi
+status=$?
 exit
-- 
2.9.4

