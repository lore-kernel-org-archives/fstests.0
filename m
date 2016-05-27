Received: from cn.fujitsu.com ([59.151.112.132]:53092 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932338AbcE0IDe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 04:03:34 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/122: filter out reflink and rmap related outputs
Date: Fri, 27 May 2016 15:17:24 +0800
Message-ID: <1464333444-25575-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160527072828.GD9418@birch.djwong.org>
References: <20160527072828.GD9418@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

I make sure xfs/122 passed when run against xfsprogs 4.5

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/122     | 2 +-
 tests/xfs/122.out | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/xfs/122 b/tests/xfs/122
index 845cdd2..cb3e0e7 100755
--- a/tests/xfs/122
+++ b/tests/xfs/122
@@ -224,7 +224,7 @@ echo 'return 0; }' >>$cprog
 # create and run program
 cc -o $oprog $cprog >> $seqres.full 2>&1 || \
   _notrun "Could not compile test program (see end of $seqres.full)"
-$oprog | _type_size_filter | _type_name_filter > $progout
+$oprog | _type_size_filter | _type_name_filter | egrep -v 'xfs_refcount.*|xfs_rmap.*' > $progout
 
 #
 # add addition sizes and xfs_sb_t fields that don't exist in the version
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



