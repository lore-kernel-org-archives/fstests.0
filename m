Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA0C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  6 May 2022 15:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbiEFPIs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 May 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352071AbiEFPIr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 May 2022 11:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFA96B09C
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651849503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NN88GW9sXNuu5jk7PMF3rd+RPSE7PSgFZpN3yKjIt7Q=;
        b=UKQTseVrKm5NfGtueRkF6ANnFgBBk+ZZSW/5OHSTz2LM954dVs0UGlaweO3rpSicRSNhIN
        +RAfK5zG7d2Th9c+oHhSumngxYrFIRuysxQ8sWBxdrMuGuParHBI+t34LzUn9nAOecS+h8
        8Oj+LA0pddI7RPp5e0lRwMw5ZzCdCJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-wLhwKOEtPOu3zxSce2TfXw-1; Fri, 06 May 2022 11:05:02 -0400
X-MC-Unique: wLhwKOEtPOu3zxSce2TfXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C2CE8FB77A;
        Fri,  6 May 2022 15:02:14 +0000 (UTC)
Received: from p50.redhat.com (unknown [10.74.16.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 573EDC15E71;
        Fri,  6 May 2022 15:02:12 +0000 (UTC)
From:   Rishabh Dave <ridave@redhat.com>
To:     fstests@vger.kernel.org
Cc:     jlayton@redhat.com, rishabhddave@gmail.com,
        Rishabh Dave <ridave@redhat.com>
Subject: [PATCHv2] cephfs: add ceph-fuse suport for ceph-fuse
Date:   Fri,  6 May 2022 20:31:42 +0530
Message-Id: <20220506150141.333929-1-ridave@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently tests in xfstests-dev can be executed against CephFS only by
mounting CephFS using kernel driver. Attempting to run tests against
CephFS using FUSE doesn't work because xfstests-dev would remount CephFS
using kernel. This patch adds the ability for xfstest-dev code to mount
CephFS using FUSE.

Fixes: https://tracker.ceph.com/issues/55354
Signed-off-by: Rishabh Dave <ridave@redhat.com>
---
 common/config |  2 ++
 common/rc     | 47 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/common/config b/common/config
index 1033b890..efcf12e9 100644
--- a/common/config
+++ b/common/config
@@ -556,6 +556,8 @@ _check_device()
 			_fatal "common/config: $name ($dev) is not a character device"
 		fi
 		;;
+	ceph-fuse)
+		;;
 	*)
 		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
 	esac
diff --git a/common/rc b/common/rc
index 553ae350..a8252c7f 100644
--- a/common/rc
+++ b/common/rc
@@ -500,10 +500,14 @@ _test_mount()
 {
     local mount_ret
 
-    if [ "$FSTYP" == "overlay" ]; then
+    if [ "$FSTYP" == "ceph-fuse" ]; then
+        $CEPH_FUSE_BIN_PATH $TEST_FS_MOUNT_OPTS $TEST_DIR 2> /dev/null
+        return $?
+    elif [ "$FSTYP" == "overlay" ]; then
         _overlay_test_mount $*
         return $?
     fi
+
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
     mount_ret=$?
@@ -1446,7 +1450,8 @@ _fs_type()
     # have to bother with this quirk.
     #
     _df_device $1 | $AWK_PROG '{ print $2 }' | \
-        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
+        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/' \
+            -e 's/fuse.ceph-fuse/ceph-fuse/'
 }
 
 # return the FS mount options of a mounted device
@@ -1595,6 +1600,24 @@ _supported_fs()
     _notrun "not suitable for this filesystem type: $FSTYP"
 }
 
+_check_if_dev_already_mounted()
+{
+	local dev=$1
+	local mnt=$2
+
+	# find $dev as the source, and print result in "$dev $mnt" format
+	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
+	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
+
+	# if it's mounted, make sure its on $mnt
+	if [ "$mount_rec" != "$dev $mnt" ]; then
+		echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
+		echo "Already mounted result:"
+		echo $mount_rec
+		return 2 # 2 = mounted on wrong mnt
+	fi
+}
+
 # check if a FS on a device is mounted
 # if so, verify that it is mounted on mount point
 # if fstype is given as argument, verify that it is also
@@ -1608,16 +1631,14 @@ _check_mounted_on()
 	local mnt=$4
 	local type=$5
 
-	# find $dev as the source, and print result in "$dev $mnt" format
-	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
-	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
+	# this check doesn't work on ceph-fuse
+	if [ "$dev" != "ceph-fuse" ]; then
+		_check_if_dev_already_mounted $dev $mnt
+		dev_already_mounted=$?
 
-	# if it's mounted, make sure its on $mnt
-	if [ "$mount_rec" != "$dev $mnt" ]; then
-		echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
-		echo "Already mounted result:"
-		echo $mount_rec
-		return 2 # 2 = mounted on wrong mnt
+		if [ $dev_already_mounted -ne 0 ]; then
+			return $dev_already_mounted
+		fi
 	fi
 
 	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
@@ -1870,6 +1891,8 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	ceph-fuse)
+		;;
 	cifs)
 		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
@@ -3204,7 +3227,7 @@ _check_test_fs()
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
-    ceph)
+    ceph|ceph-fuse)
 	# no way to check consistency for CephFS
 	;;
     glusterfs)
-- 
2.34.1

