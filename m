Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbEOEaV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 May 2015 00:30:21 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id B5FE7AB12C
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 04:30:20 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3] fstests: be compatible with older mkfs.xfs which has no v5 support
Date: Fri, 15 May 2015 12:29:53 +0800
Message-Id: <1431664193-18596-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1431258643-13620-1-git-send-email-eguan@redhat.com>
References: <1431258643-13620-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

With the change to CRCs by default, some tests are updated to call mkfs
with "-m crc=0" option directly, and this breaks testings on older
distros where mkfs.xfs doesn't have crc support.

Introduce a new variable to tell if mkfs.xfs supports v5 xfs and do
tweaks in _scratch_mkfs_xfs_opts() based on it.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This depends on Dave's commit "filter: inode size output of mkfs.xfs can change"

v3:
- move mkfs.xfs check to common/config

v2:
- use _scratch_mkfs_xfs_supported not _scratch_mkfs
- use if/else not [ ] && ... in xfs/073

 common/config | 11 +++++++++++
 common/rc     |  5 +++++
 tests/xfs/073 |  7 ++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 3732287..8e21c28 100644
--- a/common/config
+++ b/common/config
@@ -239,6 +239,17 @@ if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
 	export SELINUX_MOUNT_OPTIONS
 fi
 
+# check if mkfs.xfs supports v5 xfs
+XFS_MKFS_HAS_NO_META_SUPPORT=""
+touch /tmp/crc_check.img
+$MKFS_XFS_PROG -N -d file,name=/tmp/crc_check.img,size=32m -m crc=0 \
+	>/dev/null 2>&1;
+if [ $? -ne 0 ]; then
+	XFS_MKFS_HAS_NO_META_SUPPORT=true
+fi
+rm -f /tmp/crc_check.img
+export XFS_MKFS_HAS_NO_META_SUPPORT
+
 _mount_opts()
 {
 	case $FSTYP in
diff --git a/common/rc b/common/rc
index 242dedb..d55dda8 100644
--- a/common/rc
+++ b/common/rc
@@ -308,6 +308,11 @@ _scratch_mkfs_xfs_opts()
 {
 	mkfs_opts=$*
 
+	# remove crc related mkfs options if mkfs.xfs doesn't support v5 xfs
+	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
+		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+crc=.//"`
+	fi
+
 	_scratch_options mkfs
 
 	$MKFS_XFS_PROG $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
diff --git a/tests/xfs/073 b/tests/xfs/073
index 45a3fdf..32faffd 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -156,7 +156,12 @@ _verify_copy $imgs.image $SCRATCH_DEV $SCRATCH_MNT
 
 echo 
 echo === copying scratch device to single target, large ro device
-${MKFS_XFS_PROG} -m crc=0 -dfile,name=$imgs.source,size=100g | _filter_mkfs 2>/dev/null
+mkfs_crc_opts="-m crc=0"
+if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
+	mkfs_crc_opts=""
+fi
+${MKFS_XFS_PROG} $mkfs_crc_opts -dfile,name=$imgs.source,size=100g \
+	| _filter_mkfs 2>/dev/null
 rmdir $imgs.source_dir 2>/dev/null
 mkdir $imgs.source_dir
 
-- 
1.8.3.1

