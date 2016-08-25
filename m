Received: from userp1040.oracle.com ([156.151.31.81]:32417 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbcHYXar (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 19:30:47 -0400
Subject: [PATCH 02/13] xfs/122: decrease the log update done item sizes
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 25 Aug 2016 16:28:32 -0700
Message-ID: <147216771202.32641.9018236822745566504.stgit@birch.djwong.org>
In-Reply-To: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
References: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Redundant fields were removed from the rmap/refcount/bmap update done
log items, so fix the size tests.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/122.out |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index b20011e..06d1432 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -61,10 +61,10 @@ sizeof(struct xfs_attr3_leaf_hdr) = 80
 sizeof(struct xfs_attr3_leafblock) = 88
 sizeof(struct xfs_attr3_rmt_hdr) = 56
 sizeof(struct xfs_btree_block) = 72
-sizeof(struct xfs_bud_log_format) = 48
+sizeof(struct xfs_bud_log_format) = 16
 sizeof(struct xfs_bui_log_format) = 48
 sizeof(struct xfs_clone_args) = 32
-sizeof(struct xfs_cud_log_format) = 32
+sizeof(struct xfs_cud_log_format) = 16
 sizeof(struct xfs_cui_log_format) = 32
 sizeof(struct xfs_da3_blkinfo) = 56
 sizeof(struct xfs_da3_intnode) = 64
@@ -90,7 +90,7 @@ sizeof(struct xfs_rmap_rec) = 24
 sizeof(struct xfs_rtrmap_key) = 24
 sizeof(struct xfs_rtrmap_rec) = 32
 sizeof(struct xfs_rtrmap_root) = 4
-sizeof(struct xfs_rud_log_format) = 48
+sizeof(struct xfs_rud_log_format) = 16
 sizeof(struct xfs_rui_log_format) = 48
 sizeof(xfs_agf_t) = 224
 sizeof(xfs_agfl_t) = 36

