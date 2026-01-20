Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652033D6C2
	for <fstests@vger.kernel.org>; Tue, 20 Jan 2026 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882810; cv=none; b=MVoPUz3T0fBadmvFKg2kWbkKxAL4RfO+F2JFstWo+buXXXP2twsIoDxux9fxXNAEMe5Rp8+28t4WuTkriFknzf72mN2rdr4UIVE79p1AJOxILSLitCVdzq5+dUz5xs3Yt+vv1VfCfdAOEnMaJ3hxp9GKlfewRZiXiCNAyCGyhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882810; c=relaxed/simple;
	bh=DlXgw2xybDKncbIwL7HxVkjEVsLQnZIQdS531aY8JUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AArykweHnhqn9Y+r8wbTg3HzXgfFI1Tzm8Hf3ds4XqrobB5VZVva9Xso08rKi2pmJJ9WQ8I5LFWv2Hebnazo3kGfM17lF32U74REZiyotKU8d3Ya74Rg4Vmla9c3AOnWrU3dZheD+fn9wO/U4Nu68tHibq1TxmwEJU/tT4r4zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=obEGGJ+l; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="obEGGJ+l"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64455a2a096so4023143d50.3
        for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 20:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1768882805; x=1769487605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jRfA1Hde7rJpNzHrIbFX351VYVHvA+SREvN9uZgC2c=;
        b=obEGGJ+lp16vG5AYD5reJEw2qWtuqkumV0grroFIedzfi61lu5bU5CWIZJJigJ4znB
         OR3Ucxg1W5Bgn8qnCJaUeMZUk7a9PuFNLrzxDNKAz/L6OKW/cH5H22LupVg/6sZHAqXK
         631baate2UfB6njT8hwPhLExhQgqrx1+JlhrgW+P2G6iKXbPuJWEpKOTuhmuQK4X9QFY
         fFFRgdvfMTBAPCep1sHdLPrSs9ptEQv/s6+FGIfy6Pzv38pRh5YNAw/5EFDqEolU2CBl
         FIYjaW4mf3+JXIlXL1rNMo4wSu6Cr3sX/F7oaLIPdZt6sBrx02s4oiVFSb5i+wVfax1M
         RgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768882805; x=1769487605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jRfA1Hde7rJpNzHrIbFX351VYVHvA+SREvN9uZgC2c=;
        b=YlwzvsmcPt3KFRuek8KC64ame0Zrwm9u7JY9th6Ap9mqQ8jug89sOyPgZ5t1OgFczz
         ZSiNhnly8Bzd0Zpy/fyB1YmJs4wxlZKQepsOYunzSZf2DkOSdvUFtGYZijQUHJQkk/B3
         bGVRz0RY8y9cOOLWMp2RF/3wRvP3v2zdEis8cHmRLI30avO+KiEwkrq5JysPqm6Kje4V
         zy+XGA/o22SVdNyI88WyVG2YKB93edfnmdCr/AYCM9eNrky9qchoRkW3+xtVreSyITsH
         bapYHq1vEWl4gaUJUvQkDHH7xT5Twkv5yhLI0qBlWLUbuhNLXXEaL0LuaQUanMa4PAg5
         CQgA==
X-Forwarded-Encrypted: i=1; AJvYcCX30TmV2gzfJRE6C65K8jLLygsPbw0eEwuoJdfSRgkkoovzcpZJaBXc5SI3aY8YOqpwBHvNyeBZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjn7kwoNi7Qp429cDRj83UseLECRWmsCv2b0+gvKJtuKwsDdrX
	5k0Zdsw9f8L0yzsz8cpgG4ipqJouTa9AdYttPVlDD2YDlfLUuyCzdsly53kJh1H+BEA=
X-Gm-Gg: AZuq6aIx8WiEmk95MCDDZobhlFFpzvmjC8HMEP+ZQDPayLpFQ+RAtVdtCf5NiUAaYZ2
	Kp6dA/EOKk1mu0ibEZD3pApIuxEO/3fxqaLm2FTFHOVYbs+rVoCRy8Ri7fQzHBtH2njfCW4e/iU
	ZM7t3JpQKEkXYD97IoRKhE9++AvJzKVL4k16HogjjLPyd05soI5BvznGrH+n3i9V/dsJEkWDMjc
	bL2KhqHiO0D5GeuWQJzmMKSBSWr1UunTdyd2J587LPgtfPrk/UCFIUdObeGvON7dLjVHQ46gFkY
	34+wckFu0R2cIIRQozv1Hhfim8uqF1iAMrGm9QurBK6L9z9PNTzArh4NOV9keZmzU05yqY9hxuh
	DX4gseVd2tXac0wYle5YjbZoDZk+VszbnPM0rXelCLAFUpmHm/dGUa9rrbLa33oXIORkI7lUQgc
	1jqTCCNAxr7/paEGhPWlJRJNtksp6QdfQGcU0KepVjAr1TC8rOANVbUOwewHRWb+0KLVmfDsjCs
	1dQasFS6Hf9ONFQdDxKywg=
X-Received: by 2002:a05:690c:c50c:b0:78f:984b:4bef with SMTP id 00721157ae682-7940a470576mr11400417b3.68.1768882805114;
        Mon, 19 Jan 2026 20:20:05 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:ead3:ebfb:3b92:a0e5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c686db17sm47946407b3.38.2026.01.19.20.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 20:20:04 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix generic/062 xfstests failure
Date: Mon, 19 Jan 2026 20:19:38 -0800
Message-Id: <20260120041937.3450928-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/062 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/062 - output mismatch (see xfstests-dev/results//generic/062.out.bad)

The generic/062 test tries to set and get xattrs for various types
of objects (regular file, folder, block device, character
device, pipe, etc) with the goal to check that xattr operations
works correctly for all possible types of file system objects.
But current HFS+ implementation somehow hasn't support of
xattr operatioons for the case of block device, character
device, and pipe objects. Also, it has not completely correct
set of operations for the case symlinks.

This patch implements proper declaration of xattrs operations
hfsplus_special_inode_operations and hfsplus_symlink_inode_operations.
Also, it slightly corrects the logic of hfsplus_listxattr()
method.

sudo ./check generic/062
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #59 SMP PREEMPT_DYNAMIC Mon Jan 19 16:26:21 PST 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/062 20s ...  20s
Ran: generic/062
Passed all 1 tests

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/93

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c | 23 +++++++++++++++++++++--
 fs/hfsplus/xattr.c | 29 ++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 6153e5cc6eb6..533c43cc3768 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -396,6 +396,19 @@ static const struct inode_operations hfsplus_file_inode_operations = {
 	.fileattr_set	= hfsplus_fileattr_set,
 };
 
+const struct inode_operations hfsplus_symlink_inode_operations = {
+	.get_link	= page_get_link,
+	.setattr	= hfsplus_setattr,
+	.getattr	= hfsplus_getattr,
+	.listxattr	= hfsplus_listxattr,
+};
+
+const struct inode_operations hfsplus_special_inode_operations = {
+	.setattr	= hfsplus_setattr,
+	.getattr	= hfsplus_getattr,
+	.listxattr	= hfsplus_listxattr,
+};
+
 static const struct file_operations hfsplus_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -455,12 +468,17 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		hip->clump_blocks = sbi->data_clump_blocks;
 	} else if (S_ISLNK(inode->i_mode)) {
 		sbi->file_count++;
-		inode->i_op = &page_symlink_inode_operations;
+		inode->i_op = &hfsplus_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &hfsplus_aops;
 		hip->clump_blocks = 1;
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		sbi->file_count++;
+		inode->i_op = &hfsplus_special_inode_operations;
 	} else
 		sbi->file_count++;
+
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 	hfsplus_mark_mdb_dirty(sb);
@@ -591,10 +609,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			inode->i_fop = &hfsplus_file_operations;
 			inode->i_mapping->a_ops = &hfsplus_aops;
 		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = &page_symlink_inode_operations;
+			inode->i_op = &hfsplus_symlink_inode_operations;
 			inode_nohighmem(inode);
 			inode->i_mapping->a_ops = &hfsplus_aops;
 		} else {
+			inode->i_op = &hfsplus_special_inode_operations;
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index c3dcbe30f16a..9904944cbd54 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -258,6 +258,15 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	return err;
 }
 
+static inline
+bool is_xattr_operation_supported(struct inode *inode)
+{
+	if (HFSPLUS_IS_RSRC(inode))
+		return false;
+
+	return true;
+}
+
 int __hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags)
 {
@@ -268,9 +277,11 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	u16 folder_finderinfo_len = sizeof(DInfo) + sizeof(DXInfo);
 	u16 file_finderinfo_len = sizeof(FInfo) + sizeof(FXInfo);
 
-	if ((!S_ISREG(inode->i_mode) &&
-			!S_ISDIR(inode->i_mode)) ||
-				HFSPLUS_IS_RSRC(inode))
+	hfs_dbg("ino %lu, name %s, value %p, size %zu\n",
+		inode->i_ino, name ? name : NULL,
+		value, size);
+
+	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
 
 	if (value == NULL)
@@ -390,6 +401,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 end_setxattr:
 	hfs_find_exit(&cat_fd);
+	hfs_dbg("finished: res %d\n", err);
 	return err;
 }
 
@@ -514,9 +526,7 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 	u16 record_length = 0;
 	ssize_t res;
 
-	if ((!S_ISREG(inode->i_mode) &&
-			!S_ISDIR(inode->i_mode)) ||
-				HFSPLUS_IS_RSRC(inode))
+	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
 
 	if (!strcmp_xattr_finder_info(name))
@@ -709,9 +719,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 
-	if ((!S_ISREG(inode->i_mode) &&
-			!S_ISDIR(inode->i_mode)) ||
-				HFSPLUS_IS_RSRC(inode))
+	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
 
 	res = hfsplus_listxattr_finder_info(dentry, buffer, size);
@@ -737,8 +745,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
 		if (err == -ENOENT) {
-			if (res == 0)
-				res = -ENODATA;
+			res = 0;
 			goto end_listxattr;
 		} else {
 			res = err;
-- 
2.43.0

