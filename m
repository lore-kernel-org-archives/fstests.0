Received: from cn.fujitsu.com ([59.151.112.132]:10646 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932427AbcE0JRr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 05:17:47 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
	by cn.fujitsu.com (Postfix) with ESMTP id 51BF9489F998
	for <fstests@vger.kernel.org>; Fri, 27 May 2016 17:17:35 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/122: update against xfsprogs 4.5
Date: Fri, 27 May 2016 16:32:15 +0800
Message-ID: <1464337935-29183-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) add necessary version check for xfs/122
2} filter out reflink, rmap and rmapx related outputs

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc         |  8 ++++++++
 tests/xfs/122     | 10 ++--------
 tests/xfs/122.out |  5 -----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/common/rc b/common/rc
index 51092a0..992a3af 100644
--- a/common/rc
+++ b/common/rc
@@ -1654,6 +1654,14 @@ _require_xfs_crc()
 	_scratch_unmount
 }
 
+_require_xfs_version()
+{
+	local version=`_scratch_mkfs_xfs -V | awk '{split($3,ver,"."); print ver[1]*100 + ver[2]*10 + ver[3]}'`
+	if [ $version -lt $1 ]; then
+		_notrun "this test requires higher xfsprogs"
+	fi
+}
+
 # this test requires the ext4 kernel support crc feature on scratch device
 #
 _require_scratch_ext4_crc()
diff --git a/tests/xfs/122 b/tests/xfs/122
index 845cdd2..945c979 100755
--- a/tests/xfs/122
+++ b/tests/xfs/122
@@ -224,20 +224,14 @@ echo 'return 0; }' >>$cprog
 # create and run program
 cc -o $oprog $cprog >> $seqres.full 2>&1 || \
   _notrun "Could not compile test program (see end of $seqres.full)"
-$oprog | _type_size_filter | _type_name_filter > $progout
+$oprog | _type_size_filter | _type_name_filter | egrep -v 'xfs_refcount.*|xfs_rmap.*' > $progout
 
 #
 # add addition sizes and xfs_sb_t fields that don't exist in the version
 # being tested.
 #
 
-# xfsprogs 2.9.8: sb_bad_features2 in pv 978822
-if [ $XFSPROGS_VERSION -lt 20908 ]; then
-	echo 'offsetof(xfs_sb_t, sb_bad_features2 ) = 204' >>$progout
-fi
-if [ $XFSPROGS_VERSION -lt 30000 ]; then
-	echo 'sizeof( xfs_dsb_t ) = 208' >>$progout;
-fi
+_require_xfs_version 450
 
 LC_COLLATE=POSIX sort $progout
 
diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index 451871e..8ba121e 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -75,11 +75,6 @@ sizeof(struct xfs_extent_data) = 24
 sizeof(struct xfs_extent_data_info) = 32
 sizeof(struct xfs_fs_eofblocks) = 128
 sizeof(struct xfs_icreate_log) = 28
-sizeof(struct xfs_refcount_key) = 4
-sizeof(struct xfs_refcount_rec) = 12
-sizeof(struct xfs_rmap_key) = 4
-sizeof(struct xfs_rmap_rec) = 24
-sizeof(struct xfs_rmapx_key) = 20
 sizeof(xfs_agf_t) = 224
 sizeof(xfs_agfl_t) = 36
 sizeof(xfs_agi_t) = 336
-- 
1.8.3.1



