Received: from aserp1040.oracle.com ([141.146.126.69]:47951 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755753AbcHYXas (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 19:30:48 -0400
Subject: [PATCH 13/13] xfs/122: check the ag reservation counter ioctl
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 25 Aug 2016 16:29:43 -0700
Message-ID: <147216778333.32641.6694229942234239492.stgit@birch.djwong.org>
In-Reply-To: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
References: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/122.out |    1 +
 1 file changed, 1 insertion(+)


diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index cd909e6..ae84283 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -81,6 +81,7 @@ sizeof(struct xfs_dsymlink_hdr) = 56
 sizeof(struct xfs_extent_data) = 24
 sizeof(struct xfs_extent_data_info) = 32
 sizeof(struct xfs_fs_eofblocks) = 128
+sizeof(struct xfs_fsop_ag_resblks) = 32
 sizeof(struct xfs_icreate_log) = 28
 sizeof(struct xfs_log_dinode) = 176
 sizeof(struct xfs_map_extent) = 32

