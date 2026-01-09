Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F3500970
	for <fstests@vger.kernel.org>; Fri,  9 Jan 2026 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002148; cv=none; b=X/U+cQo2LMsqpmGA4Vb2YE98cbp+f/+cQ8jeMxcauh7lf039vC4skbK+X0PID59CCP9VPQ32P/yMI1KiD5bIedwPJnZqQ/zPr3hIYphyFR5lght76UCY+P0nt2AI7cdDK9VAjz5zACs3I9JLi7wYLlG4ld+n+rA5nuxLTcVFE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002148; c=relaxed/simple;
	bh=YCCjnZr4Qqb+IA44tC3Cp0886KWLNFgVYTnXbNrtsIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KarMw7wbklHZOOkPTsWW3ZXdpkaK23Nul2Kn2Rby82AjBQgbO2SLm3DvkxvOyIDfnOu8hQxux1BH/HgppnrxQCDSWwiSr2VvfW4Od12OEl8WqgI4YAX45VKRVT3Km7GJM8R7GC0QfzoXy6Tw/zhchqXSBpv1U+e+XjvdRUI84FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=xzFlHQeR; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="xzFlHQeR"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64760131fc1so1694856d50.2
        for <fstests@vger.kernel.org>; Fri, 09 Jan 2026 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1768002145; x=1768606945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjR1+My9/h/V8rcnHHcdtvTUn2KiGs5+Ao9TPiIaVtY=;
        b=xzFlHQeRhTbBM+4JQJQ67o/2Qt1hShHHGTDiF/HnE+QSA6jheRpk4FDco8UbUhMNDE
         9/P/Wi6xzU7IgGnQ0SWMoJlvC2nXTe+QIkj5ZQFfulTrEQa1adM2Bmesvrh2EoOj/uL3
         xYFZ4EHCPld6l8n+u2XPc+vf0EENM4o6MKkzTPRKqNGQYe8L2HpktSWu1Ohb7TVW9uIz
         11Pr2KKmyQCMOV+BwTeQ7K7QdokbHlwGGpS6LrIE2zL+P0xziSO/FzXGosTVfUpkRIor
         hKkrY5bxOB4dKh9olCCugwcF1SJsmSL0dJ7hRjqzIBct9q1rU682vZgWQlPByqEyzriW
         BmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002145; x=1768606945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjR1+My9/h/V8rcnHHcdtvTUn2KiGs5+Ao9TPiIaVtY=;
        b=GPKpTDtySeIgH01cQTXev3z0j7cwy/E9izscnIxCOcYTol1JDu3oqLceuWKxY20Bgt
         Af8v4LHQNRKiySHd/DsmN3mQ79s6usVa5SeMKRB4gkm9juQ7MyljtdeoaxZzK4t+OSjJ
         ltcQxQ4HXQBkTTHBYwrTR9tfcBVM/6wsGDLYlx0QrHK5pOG5ZJ0SirAzEkVT6vehtAd5
         Vg1fbAyxdCOe0Boo5jLmsXneLIhcp0iNAoT3DJ8qqJxPyM0UDCJI8dSPzJu8NAR8mhFw
         I009r5+798qQR0XXO9KuIcqUGlMU5C0ysA9/E7itbnqGUce6hUUzzUpAjUG4KmA0N/fR
         o+mA==
X-Forwarded-Encrypted: i=1; AJvYcCWuxsAl5GpWl8ZD2WBHcB5S9pWl8IRQw/mS1EbQZ6pl2AcLJ5jVlEDb1NdyiKzqbclKRHzj+ot+@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFd4zIaUWza3r5MiQKp0kTmnpJGay4HvtbNszFFb/n5imTZEf
	QTHVmgQ5RRYVox3WJMpffq2FVdx9DJ8soUGxm1/VCROh5wWvLZdvHOitXHFMtruUE7Q=
X-Gm-Gg: AY/fxX5CPD9heMKq/kx1My6YXEq0cpEYXBsGoFlDK4v7s0bYFM7Vc+VbvqOk8YAvZb1
	OVfjXjTAUS+QstS7IvkIVWZYmJi2gpmiWP2TaqoWNYXXCkTA7Gkx3c6KaOeKxLw4/67KVwkilxQ
	yTQBTGQfb6mWgXKLxPD0hUQjIX77HCMv6KTsJ8YGVjLt1sQN6Nd4iLzlhFX1PYq2SNmvZeRu+Nv
	xqxgsIdikn1Vf5pjdlZbF/DXZIWE/y96IIAR/jXU5AlcbLR/BDq0gb4tpbcJwAdTDV/rqxa4SJz
	/xb37O+Zoax67/tUKZlQB9/CIcKbRMgsrKXrR/fbkeN7f5HNHMK37umONv8COQFVeZpSTUq+Vkv
	HlkpMLcpSvx9GHAJcBuyHxFsqmHt9GpTa8IbEkU98nzR/pIWoifhFOkJccxkISGV75r/DAg3SQL
	1dEaldVBpIEXUCT6ngc6bxLiAMsIfMlYZYu3ffzXLGy64APYrBhAsogQRZtpJLTcZIB9j9B4CxX
	hwZ4P0/9UrIki3i++od
X-Google-Smtp-Source: AGHT+IFpPao4sTUm/S5dH5Th3GU8V2Q4iNtzbVaLMqVC2lqtnyaWlpHDW2r+F9YCBb1FqM/gpIgm2Q==
X-Received: by 2002:a05:690c:670a:b0:787:f2c3:7164 with SMTP id 00721157ae682-790b55e044cmr219709487b3.0.1768002144826;
        Fri, 09 Jan 2026 15:42:24 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9ccf:afa4:f4:d25a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d0c3f72sm19047317b3.21.2026.01.09.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 15:42:24 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix generic/037 xfstests failure
Date: Fri,  9 Jan 2026 15:42:13 -0800
Message-Id: <20260109234213.2805400-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/037 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/037 - output mismatch (see xfstests-dev/results//generic/037.out.bad)

The goal of generic/037 test-case is to "verify that replacing
a xattr's value is an atomic operation". The test "consists of
removing the old value and then inserting the new value in a btree.
This made readers (getxattr and listxattrs) not getting neither
the old nor the new value during a short time window".

The HFS+ has the issue of executing the xattr replace operation
because __hfsplus_setxattr() method [1] implemented it as not
atomic operation [2]:

	if (hfsplus_attr_exists(inode, name)) {
		if (flags & XATTR_CREATE) {
			pr_err("xattr exists yet\n");
			err = -EOPNOTSUPP;
			goto end_setxattr;
		}
		err = hfsplus_delete_attr(inode, name);
		if (err)
			goto end_setxattr;
		err = hfsplus_create_attr(inode, name, value, size);
		if (err)
			goto end_setxattr;
	}

The main issue of the logic that it implements delete and
create of xattr as independent atomic operations, but the replace
operation at whole is not atomic operation. This patch implements
a new hfsplus_replace_attr() method that makes the xattr replace
operation by atomic one. Also, it reworks hfsplus_create_attr() and
hfsplus_delete_attr() with the goal of reusing the common logic
in hfsplus_replace_attr() method.

sudo ./check generic/037
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #47 SMP PREEMPT_DYNAMIC Thu Jan  8 15:37:20 PST 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/037 37s ...  37s
Ran: generic/037
Passed all 1 tests

[1] https://elixir.bootlin.com/linux/v6.19-rc4/source/fs/hfsplus/xattr.c#L261
[2] https://elixir.bootlin.com/linux/v6.19-rc4/source/fs/hfsplus/xattr.c#L338

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/attributes.c | 181 +++++++++++++++++++++++++++++-----------
 fs/hfsplus/hfsplus_fs.h |   3 +
 fs/hfsplus/xattr.c      |   7 +-
 3 files changed, 136 insertions(+), 55 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index 74b0ca9c4f17..4b79cd606276 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -193,46 +193,26 @@ int hfsplus_attr_exists(struct inode *inode, const char *name)
 	return 0;
 }
 
-int hfsplus_create_attr(struct inode *inode,
-				const char *name,
-				const void *value, size_t size)
+static
+int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
+				const void *value, size_t size,
+				struct hfs_find_data *fd,
+				hfsplus_attr_entry *entry_ptr)
 {
 	struct super_block *sb = inode->i_sb;
-	struct hfs_find_data fd;
-	hfsplus_attr_entry *entry_ptr;
 	int entry_size;
 	int err;
 
 	hfs_dbg("name %s, ino %ld\n",
 		name ? name : NULL, inode->i_ino);
 
-	if (!HFSPLUS_SB(sb)->attr_tree) {
-		pr_err("attributes file doesn't exist\n");
-		return -EINVAL;
-	}
-
-	entry_ptr = hfsplus_alloc_attr_entry();
-	if (!entry_ptr)
-		return -ENOMEM;
-
-	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
-	if (err)
-		goto failed_init_create_attr;
-
-	/* Fail early and avoid ENOSPC during the btree operation */
-	err = hfs_bmap_reserve(fd.tree, fd.tree->depth + 1);
-	if (err)
-		goto failed_create_attr;
-
 	if (name) {
-		err = hfsplus_attr_build_key(sb, fd.search_key,
+		err = hfsplus_attr_build_key(sb, fd->search_key,
 						inode->i_ino, name);
 		if (err)
-			goto failed_create_attr;
-	} else {
-		err = -EINVAL;
-		goto failed_create_attr;
-	}
+			return err;
+	} else
+		return -EINVAL;
 
 	/* Mac OS X supports only inline data attributes. */
 	entry_size = hfsplus_attr_build_record(entry_ptr,
@@ -245,24 +225,62 @@ int hfsplus_create_attr(struct inode *inode,
 		else
 			err = -EINVAL;
 		hfs_dbg("unable to store value: err %d\n", err);
-		goto failed_create_attr;
+		return err;
 	}
 
-	err = hfs_brec_find(&fd, hfs_find_rec_by_key);
+	err = hfs_brec_find(fd, hfs_find_rec_by_key);
 	if (err != -ENOENT) {
 		if (!err)
 			err = -EEXIST;
-		goto failed_create_attr;
+		return err;
 	}
 
-	err = hfs_brec_insert(&fd, entry_ptr, entry_size);
+	err = hfs_brec_insert(fd, entry_ptr, entry_size);
 	if (err) {
 		hfs_dbg("unable to store value: err %d\n", err);
-		goto failed_create_attr;
+		return err;
 	}
 
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ATTR_DIRTY);
 
+	return 0;
+}
+
+int hfsplus_create_attr(struct inode *inode,
+			const char *name,
+			const void *value, size_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct hfs_find_data fd;
+	hfsplus_attr_entry *entry_ptr;
+	int err;
+
+	hfs_dbg("name %s, ino %ld\n",
+		name ? name : NULL, inode->i_ino);
+
+	if (!HFSPLUS_SB(sb)->attr_tree) {
+		pr_err("attributes file doesn't exist\n");
+		return -EINVAL;
+	}
+
+	entry_ptr = hfsplus_alloc_attr_entry();
+	if (!entry_ptr)
+		return -ENOMEM;
+
+	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
+	if (err)
+		goto failed_init_create_attr;
+
+	/* Fail early and avoid ENOSPC during the btree operation */
+	err = hfs_bmap_reserve(fd.tree, fd.tree->depth + 1);
+	if (err)
+		goto failed_create_attr;
+
+	err = hfsplus_create_attr_nolock(inode, name, value, size,
+					 &fd, entry_ptr);
+	if (err)
+		goto failed_create_attr;
+
 failed_create_attr:
 	hfs_find_exit(&fd);
 
@@ -312,6 +330,37 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 	return err;
 }
 
+static
+int hfsplus_delete_attr_nolock(struct inode *inode, const char *name,
+				struct hfs_find_data *fd)
+{
+	struct super_block *sb = inode->i_sb;
+	int err;
+
+	hfs_dbg("name %s, ino %ld\n",
+		name ? name : NULL, inode->i_ino);
+
+	if (name) {
+		err = hfsplus_attr_build_key(sb, fd->search_key,
+						inode->i_ino, name);
+		if (err)
+			return err;
+	} else {
+		pr_err("invalid extended attribute name\n");
+		return -EINVAL;
+	}
+
+	err = hfs_brec_find(fd, hfs_find_rec_by_key);
+	if (err)
+		return err;
+
+	err = __hfsplus_delete_attr(inode, inode->i_ino, fd);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int hfsplus_delete_attr(struct inode *inode, const char *name)
 {
 	int err = 0;
@@ -335,22 +384,7 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
 	if (err)
 		goto out;
 
-	if (name) {
-		err = hfsplus_attr_build_key(sb, fd.search_key,
-						inode->i_ino, name);
-		if (err)
-			goto out;
-	} else {
-		pr_err("invalid extended attribute name\n");
-		err = -EINVAL;
-		goto out;
-	}
-
-	err = hfs_brec_find(&fd, hfs_find_rec_by_key);
-	if (err)
-		goto out;
-
-	err = __hfsplus_delete_attr(inode, inode->i_ino, &fd);
+	err = hfsplus_delete_attr_nolock(inode, name, &fd);
 	if (err)
 		goto out;
 
@@ -392,3 +426,50 @@ int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid)
 	hfs_find_exit(&fd);
 	return err;
 }
+
+int hfsplus_replace_attr(struct inode *inode,
+			 const char *name,
+			 const void *value, size_t size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct hfs_find_data fd;
+	hfsplus_attr_entry *entry_ptr;
+	int err = 0;
+
+	hfs_dbg("name %s, ino %ld\n",
+		name ? name : NULL, inode->i_ino);
+
+	if (!HFSPLUS_SB(sb)->attr_tree) {
+		pr_err("attributes file doesn't exist\n");
+		return -EINVAL;
+	}
+
+	entry_ptr = hfsplus_alloc_attr_entry();
+	if (!entry_ptr)
+		return -ENOMEM;
+
+	err = hfs_find_init(HFSPLUS_SB(sb)->attr_tree, &fd);
+	if (err)
+		goto failed_init_replace_attr;
+
+	/* Fail early and avoid ENOSPC during the btree operation */
+	err = hfs_bmap_reserve(fd.tree, fd.tree->depth + 1);
+	if (err)
+		goto failed_replace_attr;
+
+	err = hfsplus_delete_attr_nolock(inode, name, &fd);
+	if (err)
+		goto failed_replace_attr;
+
+	err = hfsplus_create_attr_nolock(inode, name, value, size,
+					 &fd, entry_ptr);
+	if (err)
+		goto failed_replace_attr;
+
+failed_replace_attr:
+	hfs_find_exit(&fd);
+
+failed_init_replace_attr:
+	hfsplus_destroy_attr_entry(entry_ptr);
+	return err;
+}
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 45fe3a12ecba..5f891b73a646 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -344,6 +344,9 @@ int hfsplus_create_attr(struct inode *inode, const char *name,
 			const void *value, size_t size);
 int hfsplus_delete_attr(struct inode *inode, const char *name);
 int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid);
+int hfsplus_replace_attr(struct inode *inode,
+			 const char *name,
+			 const void *value, size_t size);
 
 /* bitmap.c */
 int hfsplus_block_allocate(struct super_block *sb, u32 size, u32 offset,
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 504518a41212..c3dcbe30f16a 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -341,12 +341,9 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 			err = -EOPNOTSUPP;
 			goto end_setxattr;
 		}
-		err = hfsplus_delete_attr(inode, name);
-		if (err)
-			goto end_setxattr;
-		err = hfsplus_create_attr(inode, name, value, size);
+		err = hfsplus_replace_attr(inode, name, value, size);
 		if (err) {
-			hfs_dbg("unable to store value: err %d\n", err);
+			hfs_dbg("unable to replace xattr: err %d\n", err);
 			goto end_setxattr;
 		}
 	} else {
-- 
2.43.0

