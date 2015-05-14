Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbbENGr7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 May 2015 02:47:59 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4E6lx28017845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 14 May 2015 02:47:59 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] fstests: be compatible with older mkfs.xfs which has no v5 support
Date: Thu, 14 May 2015 14:42:57 +0800
Message-Id: <1431585777-29894-1-git-send-email-eguan@redhat.com>
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

v2:
- use _scratch_mkfs_xfs_supported not _scratch_mkfs
- use if/else not [ ] && ... in xfs/073

 check         | 10 +++++++++-
 common/rc     |  5 +++++
 tests/xfs/073 |  7 ++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 4fa96ed..9eecb44 100755
--- a/check
+++ b/check
@@ -505,9 +505,17 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	if [ ! -z "$SCRATCH_DEV" ]; then
 	  umount $SCRATCH_DEV 2>/dev/null
+
+	  # check if mkfs.xfs supports v5 xfs
+	  if [ "$FSTYP" == "xfs" ]; then
+		export XFS_MKFS_HAS_NO_META_SUPPORT=""
+		if ! _scratch_mkfs_xfs_supported -m crc=1 >/dev/null 2>&1; then
+			export XFS_MKFS_HAS_NO_META_SUPPORT=true
+		fi
+	  fi
+
 	  # call the overridden mkfs - make sure the FS is built
 	  # the same as we'll create it later.
-
 	  if ! _scratch_mkfs $flag >$tmp.err 2>&1
 	  then
 	      echo "our local _scratch_mkfs routine ..."
diff --git a/common/rc b/common/rc
index 242dedb..6af7f14 100644
--- a/common/rc
+++ b/common/rc
@@ -308,6 +308,11 @@ _scratch_mkfs_xfs_opts()
 {
 	mkfs_opts=$*
 
+	# remove crc related mkfs options if mkfs.xfs doesn't support v5 support
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

