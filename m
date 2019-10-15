Return-Path: <SRS0=6y5p=YI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02ECC10F14
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 08:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6192064B
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 08:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfJOIoC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:44:02 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:32900 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOIoC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Oct 2019 04:44:02 -0400
X-Greylist: delayed 673 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 04:44:00 EDT
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym02.jp.fujitsu.com with smtp
         id 56ad_202a_8db402eb_8b7a_4d39_98d7_47b333069961;
        Tue, 15 Oct 2019 17:32:41 +0900
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4716DAC00F8
        for <fstests@vger.kernel.org>; Tue, 15 Oct 2019 17:32:41 +0900 (JST)
Received: from qi-tx200s7.8.8.8.8 (unknown [10.19.3.106])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 2315AF1;
        Tue, 15 Oct 2019 17:32:41 +0900 (JST)
From:   QI Fuli <qi.fuli@fujitsu.com>
To:     fstests@vger.kernel.org, virtio-fs@redhat.com
Cc:     QI Fuli <qi.fuli@fujitsu.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>
Subject: [PATCH] fstests: Add virtio-fs shared file system support
Date:   Tue, 15 Oct 2019 17:32:28 +0900
Message-Id: <20191015083228.13475-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch adds support for virtio-fs shared file system that lets
virtual machines access a directory tree on the host.

To run xfstests on it, first, start virtiofsd daemon in host:
 ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu0 -o source=$DIR0 -o cache=always
 ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu1 -o source=$DIR1 -o cache=always

second, launch QEMU with:
 -chardev socket,id=char0,path=/tmp/vhostqemu0
 -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs0
 -chardev socket,id=char1,path=/tmp/vhostqemu1
 -device vhost-user-fs-pci,queue-size=1024,chardev=char1,tag=myfs1
 -m 8G
 -object memory-backend-file,id=mem,size=8G,mem-path=/dev/shm,share=on
 -numa node,memdev=mem

then, inside the VM run xfstests with:
 export TEST_DEV=myfs0
 export TEST_DIR=$TESTDIR
 export SCRATCH_DEV=myfs1
 export SCRATCH_MNT=$SCRATCHMNT
 export MOUNT_OPTIONS=""
 export TEST_FS_MOUNT_OPTS=""

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>
Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 check         |  2 ++
 common/config |  4 ++--
 common/rc     | 18 +++++++++++++++---
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/check b/check
index c7f1dc5e..2e148e57 100755
--- a/check
+++ b/check
@@ -56,6 +56,7 @@ check options
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
+    -virtiofs		test virtiofs
     -overlay		test overlay
     -pvfs2		test PVFS2
     -tmpfs		test TMPFS
@@ -268,6 +269,7 @@ while [ $# -gt 0 ]; do
 	-glusterfs)	FSTYP=glusterfs ;;
 	-cifs)		FSTYP=cifs ;;
 	-9p)		FSTYP=9p ;;
+	-virtiofs)	FSTYP=virtiofs ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
 	-pvfs2)		FSTYP=pvfs2 ;;
 	-tmpfs)		FSTYP=tmpfs ;;
diff --git a/common/config b/common/config
index a0d58bde..2cb0202a 100644
--- a/common/config
+++ b/common/config
@@ -480,8 +480,8 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|tmpfs)
-		# 9p mount tags are just plain strings, so anything is allowed
+	9p|tmpfs|virtiofs)
+		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
 	overlay)
diff --git a/common/rc b/common/rc
index cfaabf10..3d5c8b23 100644
--- a/common/rc
+++ b/common/rc
@@ -603,6 +603,9 @@ _test_mkfs()
     9p)
 	# do nothing for 9p
 	;;
+    virtiofs)
+	# do nothing for virtiofs
+	;;
     ceph)
 	# do nothing for ceph
 	;;
@@ -640,6 +643,9 @@ _mkfs_dev()
     9p)
 	# do nothing for 9p
 	;;
+    virtiofs)
+	# do nothing for virtiofs
+	;;
     overlay)
 	# do nothing for overlay
 	;;
@@ -704,7 +710,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1467,7 +1473,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	9p)
+	9p|virtiofs)
 		if [ -z "$SCRATCH_DEV" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
 		fi
@@ -1591,7 +1597,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	9p)
+	9p|virtiofs)
 		if [ -z "$TEST_DEV" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
 		fi
@@ -2686,6 +2692,9 @@ _check_test_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    virtiofs)
+	# no way to check consistency for virtiofs
+	;;
     ceph)
 	# no way to check consistency for CephFS
 	;;
@@ -2744,6 +2753,9 @@ _check_scratch_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    virtiofs)
+	# no way to check consistency for virtiofs
+	;;
     ceph)
 	# no way to check consistency for CephFS
 	;;
-- 
2.20.1

