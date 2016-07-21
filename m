Received: from userp1040.oracle.com ([156.151.31.81]:29979 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcGUXsI (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:48:08 -0400
Subject: [PATCH 16/17] xfs/122: add the realtime rmapbt inode and btree
 fields
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:48:00 -0700
Message-ID: <146914488084.11762.2546324713817812928.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Add the on-disk structures added by the realtime rmapbt.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/122.out |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index c4ed725..b20011e 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -44,6 +44,7 @@ offsetof(xfs_sb_t, sb_rextents) = 24
 offsetof(xfs_sb_t, sb_rextsize) = 80
 offsetof(xfs_sb_t, sb_rextslog) = 125
 offsetof(xfs_sb_t, sb_rootino) = 56
+offsetof(xfs_sb_t, sb_rrmapino) = 264
 offsetof(xfs_sb_t, sb_rsumino) = 72
 offsetof(xfs_sb_t, sb_sectlog) = 121
 offsetof(xfs_sb_t, sb_sectsize) = 102
@@ -86,6 +87,9 @@ sizeof(struct xfs_refcount_key) = 4
 sizeof(struct xfs_refcount_rec) = 12
 sizeof(struct xfs_rmap_key) = 20
 sizeof(struct xfs_rmap_rec) = 24
+sizeof(struct xfs_rtrmap_key) = 24
+sizeof(struct xfs_rtrmap_rec) = 32
+sizeof(struct xfs_rtrmap_root) = 4
 sizeof(struct xfs_rud_log_format) = 48
 sizeof(struct xfs_rui_log_format) = 48
 sizeof(xfs_agf_t) = 224
@@ -130,7 +134,7 @@ sizeof(xfs_dir2_sf_off_t) = 2
 sizeof(xfs_disk_dquot_t) = 104
 sizeof(xfs_dq_logformat_t) = 24
 sizeof(xfs_dqblk_t) = 136
-sizeof(xfs_dsb_t) = 264
+sizeof(xfs_dsb_t) = 272
 sizeof(xfs_efd_log_format_32_t) = 28
 sizeof(xfs_efd_log_format_64_t) = 32
 sizeof(xfs_efi_log_format_32_t) = 28

