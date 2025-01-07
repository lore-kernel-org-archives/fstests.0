Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04B78F5E
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265987; cv=none; b=UvtdPbAM9ViRynx4MKvTaRk7nPTTS5OwUlZQnq3oOjBSQcfq5mUZn+kBDKUdindy98eV5mtvJm7rUKIzwHyn6jMtSUyXdPWHIAj1/PqzkV3kpWlfmC4Ug1Q3WL/0WpYRVQLgqaVtI+uDk2GJWjEZSjMD40qPUi4GRQtMjMS3REQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265987; c=relaxed/simple;
	bh=wtV4tWvdHCc0BYgs7ryYGPM+vvAyED0pDJgZpb7sMaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gShajfMrdiNfe6HDHh2vgXMzZX7UEGPGta1a1nvg14/NNR0FhgP0teDN5ZEDGGm7QilyhyiT+Y2Tz8k0V19sw0MQ7SpANqa5K6xPudxXiDwDTgKYltXqSoHy+wh+AYArsgBBcL7W3m50Jqn2Q6AkA+2iZjbqj682dDdPvJvMT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hw/6sKTL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hw/6sKTL"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cdd57060acso12936675ab.0
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2025 08:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736265982; x=1736870782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMWy4lVwJHJ3LX8Yqx0H0hDkU0C1A4oW2X7MUAtdqMM=;
        b=Hw/6sKTLlo4JC9/D2wfIxA+BhVoUQYvwmn48tM8lRmH8gcagWQPhT3suY7Fk0izDqW
         WUhcOtAl4TdQKNeI6Olu4u4CX1jhDpIfSIde3poKSaCHyF2VDNKNFZQKpq8fEyUBcEJN
         IGCPCbQEDIp0wlTqWngfy8PDKtvhUCYoD5ONigR053fC9mzAN4aaDB+mu+VZVgOV/4ES
         5nYz5/Abz/6UT0giKz2uAs1VsuFhUymXgN7GHvbkYtp/K5hNngJe7kyyeBwCQQiJfemU
         Vymfkgv5wa4h6wTbkIZfafuqmNktGxK9dQk9GoZ6kyo4vAaScLIbvg2WEOx7GY+Bd9Up
         +vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736265982; x=1736870782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMWy4lVwJHJ3LX8Yqx0H0hDkU0C1A4oW2X7MUAtdqMM=;
        b=GCxHIgE+Ti2n3UorEEb3OpIBw62cpb4HMHE7zz0C7i9rVZrzb0zh8eySiC3ShnTOnj
         hl/bMzNm0TyqrbMT69tK+67hH7t3K3kTL6E1p6DfIxh6tP9QwtewcjeJstEHY8zZcZ47
         CGsO+O/g2dSu0WAbaDhQ9qwHRX1wB1M1rPa4f9h3G+e+0Fs6frsr/4bVfjpOwWuswnHQ
         emTqNMxpyYzBgCJRfKONbp0JyJVhe2QuUbJPEXQovQFRErbTv0+OVCRnR3y9367kG8zs
         YjLEwRZ3Ur20d35ClAoLs+aFyUpj242/DrTAuCPemGrXnM4LlTXQW2bEiwVHsdCijoLc
         Loog==
X-Forwarded-Encrypted: i=1; AJvYcCVFBCFoMZ0ptrBDx+Uj6Shs4ZfkKn5TPZc9CfW4vPo5KYzugI+Ievcf0Nco1zVK1/fF3mSabRSj@vger.kernel.org
X-Gm-Message-State: AOJu0YwxztO1BEf8233gTnC/hFsj8Fc0vttJNgooDVtPaYByc80ie2WK
	IsfvjCXX/gkf953o4yrY/cQH2VNoYpldc/Rqn/X+TqRXIO7HNnHgbAQyaG5jmEM=
X-Gm-Gg: ASbGncuHy3VgZR5eamVTAaA853lYKYQUyBQymYp7l94Jh1gdAa0zOE17xr9BzSxvrzG
	3qpR1Yv43Oo72xzm6k3d3m5Pqrgvv+KTJ/qg+Mkosb1TA/V70mmrofh7tbVVs8HLtAofjxTQBgr
	gw0wvrbo399nu6pwOt5YT7LKsjq4w91wekfvrMjGQEuVOn+lFzaWRSxqv15mXCmH6n1FwedS2SD
	qKUBBMJzut2mcpzuCW3mexcFYBiTJ5sfEpDxwdH0ZhugC3SwAgHs3JY5qhr
X-Google-Smtp-Source: AGHT+IF+HaeIiFVpeL/VbxKOkBi8d7+5Gppi0Wqx6gx5ir8wCeq05WbmVZbnDk1YVrh8ON0Rf5cWeg==
X-Received: by 2002:a05:6e02:3201:b0:3a7:c3aa:a82b with SMTP id e9e14a558f8ab-3c2d1aa2b75mr516367585ab.1.1736265982360;
        Tue, 07 Jan 2025 08:06:22 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c22455csm9529955173.160.2025.01.07.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:06:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] fsstress: add support for RWF_DONTCACHE
Date: Tue,  7 Jan 2025 09:05:14 -0700
Message-ID: <20250107160617.222775-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160617.222775-1-axboe@kernel.dk>
References: <20250107160617.222775-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using RWF_DONTCACHE tells the kernel that any page cache instantiated
by this operation should get pruned once the operation completes. If
data is in cache prior to the operation it will remain there.

Add ops for testing both the read and write side of this. If the kernel
being tested doesn't support RWF_DONTCACHE, then operations are performed
with regular read/write buffered IO.

See the kernel posting adding support:

https://lore.kernel.org/linux-fsdevel/20241220154831.1086649-1-axboe@kernel.dk/

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 ltp/fsstress.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 3d248ee25791..c5554d651b67 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -82,6 +82,16 @@ static int renameat2(int dfd1, const char *path1,
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
 #endif
 
+#ifndef RWF_DONTCACHE
+#define RWF_DONTCACHE		0x80
+#endif
+
+/*
+ * Default to RWF_DONTCACHE being available, turn it off if -EOPNOTSUPP
+ * is seen during issue.
+ */
+static int have_rwf_dontcache = 1;
+
 #define FILELEN_MAX		(32*4096)
 
 typedef enum {
@@ -117,6 +127,7 @@ typedef enum {
 	OP_COLLAPSE,
 	OP_INSERT,
 	OP_READ,
+	OP_READ_DONTCACHE,
 	OP_READLINK,
 	OP_READV,
 	OP_REMOVEFATTR,
@@ -143,6 +154,7 @@ typedef enum {
 	OP_URING_READ,
 	OP_URING_WRITE,
 	OP_WRITE,
+	OP_WRITE_DONTCACHE,
 	OP_WRITEV,
 	OP_EXCHANGE_RANGE,
 	OP_LAST
@@ -248,6 +260,7 @@ void	zero_f(opnum_t, long);
 void	collapse_f(opnum_t, long);
 void	insert_f(opnum_t, long);
 void	unshare_f(opnum_t, long);
+void	read_dontcache_f(opnum_t, long);
 void	read_f(opnum_t, long);
 void	readlink_f(opnum_t, long);
 void	readv_f(opnum_t, long);
@@ -273,6 +286,7 @@ void	unlink_f(opnum_t, long);
 void	unresvsp_f(opnum_t, long);
 void	uring_read_f(opnum_t, long);
 void	uring_write_f(opnum_t, long);
+void	write_dontcache_f(opnum_t, long);
 void	write_f(opnum_t, long);
 void	writev_f(opnum_t, long);
 void	exchangerange_f(opnum_t, long);
@@ -315,6 +329,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_COLLAPSE]	   = {"collapse",      collapse_f,	1, 1 },
 	[OP_INSERT]	   = {"insert",	       insert_f,	1, 1 },
 	[OP_READ]	   = {"read",	       read_f,		1, 0 },
+	[OP_READ_DONTCACHE] = {"read_dontcache", read_dontcache_f,	1, 0 },
 	[OP_READLINK]	   = {"readlink",      readlink_f,	1, 0 },
 	[OP_READV]	   = {"readv",	       readv_f,		1, 0 },
 	/* remove (delete) extended attribute */
@@ -346,6 +361,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	1, 1 },
 	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
 	[OP_WRITEV]	   = {"writev",	       writev_f,	4, 1 },
+	[OP_WRITE_DONTCACHE]= {"write_dontcache", write_dontcache_f,4, 1 },
 	[OP_EXCHANGE_RANGE]= {"exchangerange", exchangerange_f,	2, 1 },
 }, *ops_end;
 
@@ -4635,6 +4651,73 @@ readv_f(opnum_t opno, long r)
 	close(fd);
 }
 
+void
+read_dontcache_f(opnum_t opno, long r)
+{
+	int		e;
+	pathname_t	f;
+	int		fd;
+	int64_t		lr;
+	off64_t		off;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+	struct iovec	iov;
+	int flags;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%lld: read - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_RDONLY);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%lld: read - open %s failed %d\n",
+				procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%lld: read - fstat64 %s failed %d\n",
+				procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	if (stb.st_size == 0) {
+		if (v)
+			printf("%d/%lld: read - %s%s zero size\n", procid, opno,
+			       f.path, st);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	lr = ((int64_t)random() << 32) + random();
+	off = (off64_t)(lr % stb.st_size);
+	iov.iov_len = (random() % FILELEN_MAX) + 1;
+	iov.iov_base = malloc(iov.iov_len);
+	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
+	e = preadv2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
+	if (have_rwf_dontcache && e == EOPNOTSUPP) {
+		have_rwf_dontcache = 0;
+		e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
+	}
+	free(iov.iov_base);
+	if (v)
+		printf("%d/%lld: read dontcache %s%s [%lld,%d] %d\n",
+		       procid, opno, f.path, st, (long long)off,
+		       (int)iov.iov_len, e);
+	free_pathname(&f);
+	close(fd);
+}
+
 void
 removefattr_f(opnum_t opno, long r)
 {
@@ -5509,6 +5592,67 @@ writev_f(opnum_t opno, long r)
 	close(fd);
 }
 
+void
+write_dontcache_f(opnum_t opno, long r)
+{
+	int		e;
+	pathname_t	f;
+	int		fd;
+	int64_t		lr;
+	off64_t		off;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+	struct iovec	iov;
+	int flags;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGm, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%lld: write - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_WRONLY);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%lld: write - open %s failed %d\n",
+				procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%lld: write - fstat64 %s failed %d\n",
+				procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	lr = ((int64_t)random() << 32) + random();
+	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	off %= maxfsize;
+	iov.iov_len = (random() % FILELEN_MAX) + 1;
+	iov.iov_base = malloc(iov.iov_len);
+	memset(iov.iov_base, nameseq & 0xff, iov.iov_len);
+	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
+	e = pwritev2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
+	if (have_rwf_dontcache && e == EOPNOTSUPP) {
+		have_rwf_dontcache = 0;
+		e = pwritev2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
+	}
+	free(iov.iov_base);
+	if (v)
+		printf("%d/%lld: write dontcache %s%s [%lld,%d] %d\n",
+		       procid, opno, f.path, st, (long long)off,
+		       (int)iov.iov_len, e);
+	free_pathname(&f);
+	close(fd);
+}
+
 char *
 xattr_flag_to_string(int flag)
 {
-- 
2.47.1

