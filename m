Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E727E1DC
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159091; cv=none; b=DaF/W9Qh3za5bGcfoCPQmtjzRUi9TjcMuJ12He48qywT/xO2g8/d50ilF8v1LYItQt365MPH7XykzmruYewyVG9x+YW6Ng2ASQievKWZ6es8lAp8UxfE2za5DQlWNwPyqAh8sAVlcaDmr9G4ggmseEBbuWGKq+u9Bk3QOFWUCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159091; c=relaxed/simple;
	bh=272A+WGOcSZyMrCrNDf56BW7+LlUnWFM/Lk8FkFiyCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2nyVYFYAp1G9oaBWfxida/SnSaZ3bhEfRsCqjpE/hq/maOAt11TnyXadhoV+QUjVlT2f/eAyKxdoFmWlAIVKjlTV+kEyWcnyzuU6cjEgE5/g1k+/l2Oj7U2FKi/ZrdqY1Qt3SRsqCiDqUALIauAhbq57j9ZgHFoLCSSYbuvMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F93ZgwxX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F93ZgwxX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RoInsf6Ojyti4nHDOsk9sZnL7O4HLTaBprRa/Lj4Ey0=; b=F93ZgwxXgDhsONB/6FLlSRom8O
	66D4Ktd4DgW/aXwAjfw+fIdbq8UwMO5CIsxANLhWoBEAMMRQN/D1VmgA46XnHFK5/KhywYv1xteTG
	y3xtY0jNimauvXUSsGIDOOmK1PQY3HM6U/1DGDG4vEL9G9Ktwsvs9BKEluJnm0wZvPNfmVvkwn6Y+
	3NUKlqcZ3Y1IGMfD2xDTOt7rL99RPMFhg4b6q18JaA7X4RP95GnvvU82reUCt7L2UW2QZELIKjqJk
	FeXddqP5Yp+yke5PlxQ/ImhyzmT4shL/4f6bNwiCofFAykvencWphyh+2PRtjLV9QeF+lVeE+46sb
	Ff1S1Thg==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vrc-00000008eY2-26FI;
	Mon, 31 Aug 2026 06:51:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 1/5] statx.h: update to latest kernel UAPI
Date: Mon, 31 Aug 2026 09:51:04 +0300
Message-ID: <20260831065120.2578146-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831065120.2578146-1-hch@lst.de>
References: <20260831065120.2578146-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Update the localy provided statx definition to the kernel UAPI as of
7.3-rc1.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 src/statx.h | 126 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 30 deletions(-)

diff --git a/src/statx.h b/src/statx.h
index bae1c86f6201..0a27bf030b1d 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -95,44 +95,97 @@ struct statx_timestamp {
  */
 struct statx {
 	/* 0x00 */
-	__u32	stx_mask;	/* What results were written [uncond] */
-	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
-	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* What results were written [uncond] */
+	__u32	stx_mask;
+
+	/* Preferred general I/O size [uncond] */
+	__u32	stx_blksize;
+
+	/* Flags conveying information about the file [uncond] */
+	__u64	stx_attributes;
+
 	/* 0x10 */
-	__u32	stx_nlink;	/* Number of hard links */
-	__u32	stx_uid;	/* User ID of owner */
-	__u32	stx_gid;	/* Group ID of owner */
-	__u16	stx_mode;	/* File mode */
+	/* Number of hard links */
+	__u32	stx_nlink;
+
+	/* User ID of owner */
+	__u32	stx_uid;
+
+	/* Group ID of owner */
+	__u32	stx_gid;
+
+	/* File mode */
+	__u16	stx_mode;
 	__u16	__spare0[1];
+
 	/* 0x20 */
-	__u64	stx_ino;	/* Inode number */
-	__u64	stx_size;	/* File size */
-	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
-	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* Inode number */
+	__u64	stx_ino;
+
+	/* File size */
+	__u64	stx_size;
+
+	/* Number of 512-byte blocks allocated */
+	__u64	stx_blocks;
+
+	/* Mask to show what's supported in stx_attributes */
+	__u64	stx_attributes_mask;
 
 	/* 0x40 */
-	struct statx_timestamp	stx_atime;	/* Last access time */
-	struct statx_timestamp	stx_btime;	/* File creation time */
-	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
-	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* Last access time */
+	struct statx_timestamp	stx_atime;
+
+	/* File creation time */
+	struct statx_timestamp	stx_btime;
+
+	/* Last attribute change time */
+	struct statx_timestamp	stx_ctime;
+
+	/* Last data modification time */
+	struct statx_timestamp	stx_mtime;
+
 	/* 0x80 */
-	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_major;
 	__u32	stx_rdev_minor;
-	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+
+	/* ID of device containing file [uncond] */
+	__u32	stx_dev_major;
 	__u32	stx_dev_minor;
+
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
-	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+
+	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_mem_align;
+
+	/* File offset alignment for direct I/O */
+	__u32	stx_dio_offset_align;
+
 	/* 0xa0 */
-	__u64	stx_subvol;	/* Subvolume identifier */
-	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
-	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
+	/* Subvolume identifier */
+	__u64	stx_subvol;
+
+	/* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_min;
+
+	/* Max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max;
+
 	/* 0xb0 */
-	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
-	__u32   __spare1[1];
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Max atomic write segment count */
+	__u32   stx_atomic_write_segments_max;
+
+	/* File offset alignment for direct I/O reads */
+	__u32	stx_dio_read_offset_align;
+
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
+
 	/* 0x100 */
 };
 
@@ -162,19 +215,32 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
+#ifndef __KERNEL__
 /*
- * Attributes to be found in stx_attributes
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
+/*
+ * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
  *
  * These give information about the features or the state of a file that might
  * be of use to ordinary userspace programs such as GUIs or ls rather than
  * specialised tools.
  *
- * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
+ * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
  * semantically.  Where possible, the numerical value is picked to correspond
- * also.
+ * also.  Note that the DAX attribute indicates that the file is in the CPU
+ * direct access state.  It does not correspond to the per-inode flag that
+ * some filesystems support.
+ *
  */
 #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
 #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
-- 
2.53.0

