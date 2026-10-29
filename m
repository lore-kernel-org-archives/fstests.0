Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276938;
	b=i5bPwKEHk6zsFcoKwyLM4b4qq4qEXp45lAaNoagKU5Uq33jt0mRT0HERn3J/uz2LRocB
	 OrSUBpbvtqTigWAcpR9La9dzSF3NYb4sqfz+V+kmZu+Dj6GQZ2MrME77R6BV7JTlVhrlo
	 J20UyZZvHYmh2gEP3BlnLguIrifmwhh5YLVCp9PUgOs6dEOpznZwP99CHIZKqvD31EpDx
	 WsfQHAgFPRYJBoGGoIC5SzRhnoa7QYeKR3YrcAiPVAFnUKbuqby0a1eDcyXJdrIx6Llos
	 v4DH7CS1tUl8o/2DOmdkuEhMmKwHHEyVfj7kKAUycJtQXbJApMS/sPq63v0XsIrDruw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hp3kP48xuTrTKK7wCJLZCredy5L8Nv2jBeLHqVbKxMU=;
	b=yTT/S9FuNun8R8Hk817SfDKs5n+BGkTKS+CqJODLKBBkdWiAZrY9Cv2c3wQ9aesTRt6a
	 s5ho0bk+ZQg9NyiuUyhco4v64RcKo7RCPR6DNpPp4hqIKQEnihZc8zB+GNEziJq1WYDrG
	 wCsh8mtt1iEDeE+EdtesTHVR6cX5q8WrBzZqOTrk81gBjBdrRvT5XSMsB2O+bScs6F646
	 FUUsxtyZu40hE+KiA1cwS9YNyqwv8b9TKXqS7t3Uq7JRwkIPp16To3zBr1pnf2wb++uSK
	 lT7dwW8V1WqaDMkjWRSclaQF8xhV9NPX8cUUJ2oW38Y4PIOwo+J0DCfWzp9JzLcDdUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPZD38Ya;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67145606A332
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67145606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPZD38Ya
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso14787245e9.2
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276937; x=1793881737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hp3kP48xuTrTKK7wCJLZCredy5L8Nv2jBeLHqVbKxMU=;
        b=dPZD38Ya+N1qL6Bx4BsBTFFGX6UOZ8SU3H0kgpPAk9eovl9tKFDNTYVgkGSCYjSKg1
         rFzfmId9gXd5pZ5sW8IO7BvG7ITPB331miwozTDi9yENS+RYheFC9KWe2cvFGDsvTtFD
         skmzQLr/uqoBLguDrhU9n76Mq8tfIEhXYjhycwGgsLXeroL3FT5JoZRGkTm4+Jlic+Og
         8euf3U0pSqo6hLnwXHwcldSjS7qDWQufh7SKJoNle1jX1aqzOl7U/kiBh0cWRP+oKfzF
         SRoF1oNvQQ3S4u38u+iVLIc7mRwDrKJSDYCidKUxEluBl8SkYixTak7+SP6bkfIwi2et
         nAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276937; x=1793881737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hp3kP48xuTrTKK7wCJLZCredy5L8Nv2jBeLHqVbKxMU=;
        b=TiA0LaIscjkuwabjg5x7Vqx4tHEytVO7eOwG2eSy1NSLhcWcMKfw6ydwtik8uMdzOw
         tfidoxhL9uqUCHoGyW3wZoqTnXh0MJnIPQOlAgG9GZSWxJTsfrhDMV2+hxfm+r02yO99
         Yt39Q3xy1onsQahE1H/e6jlKUTk+0ItrdZfQXYuFQNueRaCoMfEx+dTCnA6hXEY2Uvtr
         M2ifLAXqcLAsG1AEqJvJcbzprKGHFfcRnvUJk73XNVpCqKrtwtAbZOs9Jbhy7kQw24AK
         SHniql2CLAkbSsGCjn/qNftOwJVuxscrGSOMCHZFuSQDPyWZp1I996JNUEgGK2ldmi3A
         G+2A==
X-Gm-Message-State: AFq9FYJ5bvNJ3d7SrPqpxNTeBrQPu5CHWDirNLyGPScjoTsOU8YnMxrY
	IOLRL9amsll5tx3O1yhb6PfblXAzRVqwgOcO5fCICgD7X0NMPdFv9Hon5/l8Znvf
X-Gm-Gg: AYBFou0EO2bqZMso3/tm+tPo3GsYuvUDghtfEf4ATzYALBS2vYLxkVQC9JF1U+IF4aE
	9HhMbC+mon7PeWVUUbVvQxU2zg+huiHhmwrksGaRT7ctnebBHg+/M4QHkM5gy/pSoRCjhoU9Ens
	Fk/66+hpe0ZHm+7FsJl4+rX9v06v3XzFsxDxNrbDWu4uxFvW8MhyBfUwU2wZJhwF5icJiwxcxtU
	xPPQXkev0kbABwPDRfeebM5fbC0QbPFSlhvxVlOXWcKNHuYmMb1JcZYV6+aFndIOryCObPd+uuv
	+g/SO7vrm2YxHvjLFS3r/SyzXQ/tZYV1lZDMfIwyAgUe9KL8HR6dohVR/418v9q+aWqR6LZNIQR
	+pJx7ZtSCl2K86UCMywvC5GbPa1mry9o46hzSGqkHO0Gyce4UL4w8S8u89ZdCPz1ljK2qvDnJSU
	XG/OGKZblhax8sJbwLhMeX1LzDl7VA0vMgoJxB+vn6n/QHOPQFxKrTDUUtEH7+V31G210fV77Ye
	1cgbfb0azhbTwH103KAz8nLfJYrQKIUFjelWLsIdvGxiwwjiOnqWPVTGXA1tD7sx5q+Q4OB+9IT
	GHBGhGHEn5FDpUVR5kTnNzyFqb/Xjo636s3BbYpk6JPi4990axBUymnoKPbxZw==
X-Received: by 2002:a05:600c:810c:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4a963d1b300mr111830615e9.2.1793276936718;
        Thu, 29 Oct 2026 05:28:56 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:56 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 4/8] ext4: add set_lufid utility
Date: Thu, 29 Oct 2026 12:28:35 +0000
Message-ID: <20261029122842.230704-5-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
References: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Blagodarenko <artem.blagodarenko@gmail.com>

EXT4 provides the EXT4_IOC_SET_LUFID ioctl, which allows setting
or replacing the LUFID dirdata field for an existing directory entry.

The set_lufid utility uses this ioctl and accepts a directory path,
directory entry name, and LUFID value as arguments.

This utility is used by subsequent dirdata-related tests.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 common/config   |   1 +
 src/Makefile    |   2 +-
 src/set_lufid.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 src/set_lufid.c

diff --git a/common/config b/common/config
index 69e5d833..e0cd9ccd 100644
--- a/common/config
+++ b/common/config
@@ -210,6 +210,7 @@ export LVM_PROG="$(type -P lvm)"
 export LSATTR_PROG="$(type -P lsattr)"
 export CHATTR_PROG="$(type -P chattr)"
 export DEBUGFS_PROG="$(type -P debugfs)"
+export SET_LUFID_PROG="$(type -P set_lufid || echo $here/src/set_lufid)"
 export UUIDGEN_PROG="$(type -P uuidgen)"
 export KEYCTL_PROG="$(type -P keyctl)"
 export XZ_PROG="$(type -P xz)"
diff --git a/src/Makefile b/src/Makefile
index eaf0621f..fd70f407 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -37,7 +37,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
 	rw_hint btrfs_ioctl refluxfs xfs-exchange-to-eof \
-	xfs-exchange-to-dirty-eof xfs-swapext-reflink
+	xfs-exchange-to-dirty-eof xfs-swapext-reflink set_lufid
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/set_lufid.c b/src/set_lufid.c
new file mode 100644
index 00000000..42fc5a6d
--- /dev/null
+++ b/src/set_lufid.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * set_lufid.c --- Set LUFID on a directory entry using IOCTL
+ *
+ * Copyright (C) 2026 The Lustre Collective. All Rights Reserved.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <libgen.h>
+#include <stdint.h>
+#include <linux/fs.h>
+
+/* Structure for EXT4_IOC_SET_LUFID - should match kernel definition */
+struct ext4_dirdata_fid {
+	__u8 edf_data_len;
+	char edf_data[255];
+} __attribute__((packed));
+
+struct ext4_set_lufid {
+        __u8 esl_name_len;
+        char esl_name[255 + 1];
+        union {
+                char esl_data[1 + 255];
+                struct ext4_dirdata_fid esl_edf;
+        };
+} __attribute__((packed));
+
+#ifndef EXT4_IOC_SET_LUFID
+#define EXT4_IOC_SET_LUFID	_IOW('f', 47, struct ext4_set_lufid)
+#endif
+
+static void usage(const char *prog)
+{
+	fprintf(stderr, "Usage: %s DIRECTORY FILENAME [LUFID]\n", prog);
+	fprintf(stderr, "  DIRECTORY: path to the directory containing the FILENAME\n");
+	fprintf(stderr, "  FILENAME:  name of the file to set LUFID on\n");
+	fprintf(stderr, "  LUFID: data to attach (generated if not passed)\n");
+	exit(1);
+}
+
+static void dump_lufid_payload(const char *data, int len)
+{
+	int i;
+
+	printf("LUFID payload length: %d bytes\n", len);
+	printf("LUFID payload hex:");
+	for (i = 0; i < len; i++)
+		printf(" %02x", (unsigned char)data[i]);
+	printf("\n");
+}
+
+static int build_default_lufid(int dir_fd, const char *dir_path, const char *filename,
+			       uint32_t fid[4])
+{
+	int file_fd;
+	unsigned long ver = 0;
+	struct stat st;
+
+	/* Build an IGIF-style default payload from inode + version. */
+	file_fd = openat(dir_fd, filename, O_RDONLY | O_CLOEXEC);
+	if (file_fd < 0) {
+		fprintf(stderr, "Error opening %s/%s: %s\n",
+			dir_path, filename, strerror(errno));
+		return -1;
+	}
+
+	if (fstat(file_fd, &st) < 0) {
+		fprintf(stderr, "Error stating %s/%s: %s\n",
+			dir_path, filename, strerror(errno));
+		close(file_fd);
+		return -1;
+	}
+
+	fid[0] = (uint32_t)(st.st_ino >> 32);
+	fid[1] = (uint32_t)st.st_ino;
+
+	if (ioctl(file_fd, FS_IOC_GETVERSION, &ver) < 0) {
+		fprintf(stderr, "Error calling EXT4_IOC_GETVERSION for %s/%s: %s\n",
+			dir_path, filename, strerror(errno));
+		close(file_fd);
+		return -1;
+	}
+
+	fid[2] = (uint32_t)ver;
+	fid[3] = (uint32_t)(ver >> 32);
+
+	close(file_fd);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *dir_path;
+	const char *filename;
+	const char *lufid_data;
+	DIR *dirp;
+	int fd;
+	int name_len, data_len;
+	struct ext4_set_lufid lufid_args;
+	struct stat st;
+	uint32_t fid[4];
+	int rc;
+
+	if (argc < 2) {
+		usage(argv[0]);
+	}
+
+	dir_path = argv[1];
+	filename = argv[2];
+	name_len = strlen(filename);
+
+	if (name_len == 0 || name_len > 255) {
+		fprintf(stderr, "Error: Invalid filename length: %d (must be 1-256 with NUL)\n",
+			name_len);
+		return 1;
+	}
+
+	/* Check if directory exists and is a directory */
+	if (stat(dir_path, &st) < 0) {
+		fprintf(stderr, "Error accessing %s: %s\n", dir_path, strerror(errno));
+		return 1;
+	}
+
+	if (!S_ISDIR(st.st_mode)) {
+		fprintf(stderr, "Error: %s is not a directory\n", dir_path);
+		return 1;
+	}
+
+	/* Open the directory */
+	dirp = opendir(dir_path);
+	if (!dirp) {
+		fprintf(stderr, "Error opening directory %s: %s\n", dir_path, strerror(errno));
+		return 1;
+	}
+
+	fd = dirfd(dirp);
+	if (fd < 0) {
+		fprintf(stderr, "Error getting directory fd: %s\n", strerror(errno));
+		closedir(dirp);
+		return 1;
+	}
+
+	if (argc > 3) {
+		lufid_data = argv[3];
+		data_len = strlen(lufid_data);
+	} else {
+		rc = build_default_lufid(fd, dir_path, filename, fid);
+		if (rc) {
+			fprintf(stderr, "Error getting lufid for %s/%s\n",
+				dir_path, filename);
+			closedir(dirp);
+			return 1;
+		}
+		lufid_data = (char *)fid;
+		data_len = sizeof(fid);
+	}
+
+	if (data_len == 0 || data_len > 255) {
+		fprintf(stderr, "Error: Invalid LUFID data length: %d (must be 1-255)\n",
+			data_len);
+		closedir(dirp);
+		return 1;
+	}
+
+	/* Prepare LUFID data */
+	memset(&lufid_args, 0, sizeof(lufid_args));
+	lufid_args.esl_name_len = name_len;
+	lufid_args.esl_edf.edf_data_len = data_len;
+	/* Ensure filename is properly NUL-terminated at the correct position */
+	strncpy(lufid_args.esl_name, filename, name_len);
+	lufid_args.esl_name[name_len] = '\0';
+	memcpy(lufid_args.esl_edf.edf_data, lufid_data, data_len);
+
+	/* Call the ioctl */
+	if (ioctl(fd, EXT4_IOC_SET_LUFID, &lufid_args)) {
+		fprintf(stderr, "Error calling EXT4_IOC_SET_LUFID for %s/%s: %s\n",
+			dir_path, filename, strerror(errno));
+		closedir(dirp);
+		return 1;
+	}
+
+	closedir(dirp);
+	printf("Successfully set LUFID  on %s in directory %s\n", filename, dir_path);
+	dump_lufid_payload(lufid_args.esl_edf.edf_data, data_len);
+
+	return 0;
+}
-- 
2.52.0

