Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733313AD11
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185766; cv=none; b=Xiy4ZrE+itlY9rzijrhggQZ96p00WuhZqYj/zVwcciInjLszyyfbaT4YD9fWofZkV4JRUhGw/y7j/vChWJfD6/n+vI4aw+ifvJyjR8i0GOXsq3xcWAcUixUAFplOQfXKB1gtIaSQDiI0KPPoOp5SQmOyvQdd6niAvF90f6A4z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185766; c=relaxed/simple;
	bh=tvqES3UOwZ9RKao+t3rmRllqr7DqDrZubWtdq9sgZHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTfFOpLQfQ7op95sdW3KMP9EJ95/ubGmgn8VOUTc9TJD9en1SdVAaNAU4JfvEycob1jIiv+Wz3wkMQdFVkMWgG6ns05DUjGszVCeit4fdjgxPn8FZNtFmJYqOHJhKWDnbB1rGR4I/DDV9jvDPavl5X7WyRC+tz+7VXYmQK47iqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RKBllJIE; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RKBllJIE"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e55a981dso583504439f.3
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736185764; x=1736790564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UsatFm0Ukbq7RUqKO9Rc0W/a/IUpPePTOsrGCkqtTg=;
        b=RKBllJIExiD7fU6qa2ZLRPXDZQcd1SU0Q61s/C2gVGDo+aBSLAHQZi5GUix39onn7W
         WAj5zLo+ue2SqZvH6VyvNFCOs5VjLc8GGRhHTeYx/J1SlzGvCXLN5dZBkP5Fup0h+xqS
         evNjyL007N2wYMM1SuGeote0/l8TGxKc8HRPC58ehk636TnGTxl5hbgBE+dLVCYuRx3R
         vaUtOw6ZaGQccHpyjCSGGjg1vkjMizORpX49FAc1aoUp4zCuWyxR0qXEy4ulEqqggbd9
         eHN7vQBOj+MKuaT4uGWgA/vQoUN/N0Kur2bra3M/adnkShK4hVTb66NjTPoh2nWr2Ln9
         8QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185764; x=1736790564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UsatFm0Ukbq7RUqKO9Rc0W/a/IUpPePTOsrGCkqtTg=;
        b=R5NtuN2KrJZZlc9xtemlMb93zM0gC2A7c3KrsjFBlv4DogGBXNm0F7szcbFSBq2ouR
         8qZwuO8MwvNmKK7Nl3bOyTFhitPGRmpk++cTol87Lw1dBpXkrvx4P8f1GN6mt1FSyKbb
         zv8Uqpm3zYvMk3uv1tOkOT0Q3C6gC8vboLPtXhjtdGcediyOJgtFbeonCvfEEIOCFelr
         1VSFSfFPwBN/j+nNHYPbor6H2leapxs5sM6s29vLyEyKjm4un3XQkGm45Ho2Mc/Z2/H/
         ceCviYR11ffsovTl6CbHIo8bSWnEf7ez4YMjSl3dL0Z3O+NxZEG/L6gPayzZ3SH5cqri
         eA4A==
X-Forwarded-Encrypted: i=1; AJvYcCWFlgPqfImSWBxyKQv/x05oMTcDF2C3b/kyR29gw1RmWPnR+oGEvyENiRM9wPlTmr4z+C6LmVv8@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAa1G6Z36t8Tk1boXMKZKJs1n74zMZswU844WsP4gAG5gtbaV
	w8YTLwpYNugCANxDhRPZiM9qIVq84rFH9T6zCtzUFvWsv+ofToXEq5IlY24ooKcC2V59nRah6bD
	o
X-Gm-Gg: ASbGncvZ0Gwp1i+wZq2+yGyZsAfymyZN+spQbmIHtTuy5JWjVxhojaIc9wdRF9kGjks
	mmdsa4dANRtr6KEsZilJ/K/oVLImhi4wqegvoXq4VZ8sPydsoL9sG9+r+lDw2/2BqOXtVUjwj/x
	htnYbZhrfkq+kPE04Fbu5G+YMGuq+bKJT2L1kA8avVDSsfRaRgwwTno9ZNRrhQqRSkI0XLkkmXH
	+26EUJuA1xa16kendBjD1aTTDi9B2yJro7T5LfxXaNmTEnu7GLkGOHt5f9k
X-Google-Smtp-Source: AGHT+IHobrRuVrdvHTZtu083DaaP8tt1dNj3khhYo3ndKBMhO9kzJ0LVApBitOeqcWPaCw23eZFuMQ==
X-Received: by 2002:a05:6602:3c6:b0:847:51e2:eac with SMTP id ca18e2360f4ac-8499e625be2mr4766623239f.7.1736185763665;
        Mon, 06 Jan 2025 09:49:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f355sm9210867173.9.2025.01.06.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:49:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] fsstress: add support for RWF_DONTCACHE
Date: Mon,  6 Jan 2025 10:48:46 -0700
Message-ID: <20250106174919.103199-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106174919.103199-1-axboe@kernel.dk>
References: <20250106174919.103199-1-axboe@kernel.dk>
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
 ltp/fsstress.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 3d248ee25791..df9f6ffb86fc 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -82,6 +82,12 @@ static int renameat2(int dfd1, const char *path1,
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
 #endif
 
+#ifndef RWF_DONTCACHE
+#define RWF_DONTCACHE		0x80
+#endif
+
+static int have_rwf_dontcache = 1;
+
 #define FILELEN_MAX		(32*4096)
 
 typedef enum {
@@ -117,6 +123,7 @@ typedef enum {
 	OP_COLLAPSE,
 	OP_INSERT,
 	OP_READ,
+	OP_READ_DONTCACHE,
 	OP_READLINK,
 	OP_READV,
 	OP_REMOVEFATTR,
@@ -143,6 +150,7 @@ typedef enum {
 	OP_URING_READ,
 	OP_URING_WRITE,
 	OP_WRITE,
+	OP_WRITE_DONTCACHE,
 	OP_WRITEV,
 	OP_EXCHANGE_RANGE,
 	OP_LAST
@@ -248,6 +256,7 @@ void	zero_f(opnum_t, long);
 void	collapse_f(opnum_t, long);
 void	insert_f(opnum_t, long);
 void	unshare_f(opnum_t, long);
+void	read_dontcache_f(opnum_t, long);
 void	read_f(opnum_t, long);
 void	readlink_f(opnum_t, long);
 void	readv_f(opnum_t, long);
@@ -273,6 +282,7 @@ void	unlink_f(opnum_t, long);
 void	unresvsp_f(opnum_t, long);
 void	uring_read_f(opnum_t, long);
 void	uring_write_f(opnum_t, long);
+void	write_dontcache_f(opnum_t, long);
 void	write_f(opnum_t, long);
 void	writev_f(opnum_t, long);
 void	exchangerange_f(opnum_t, long);
@@ -315,6 +325,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_COLLAPSE]	   = {"collapse",      collapse_f,	1, 1 },
 	[OP_INSERT]	   = {"insert",	       insert_f,	1, 1 },
 	[OP_READ]	   = {"read",	       read_f,		1, 0 },
+	[OP_READ_DONTCACHE] = {"read_dontcache", read_dontcache_f,	1, 0 },
 	[OP_READLINK]	   = {"readlink",      readlink_f,	1, 0 },
 	[OP_READV]	   = {"readv",	       readv_f,		1, 0 },
 	/* remove (delete) extended attribute */
@@ -346,6 +357,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	1, 1 },
 	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
 	[OP_WRITEV]	   = {"writev",	       writev_f,	4, 1 },
+	[OP_WRITE_DONTCACHE]= {"write_dontcache", write_dontcache_f,4, 1 },
 	[OP_EXCHANGE_RANGE]= {"exchangerange", exchangerange_f,	2, 1 },
 }, *ops_end;
 
@@ -4635,6 +4647,71 @@ readv_f(opnum_t opno, long r)
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
+	if (have_rwf_dontcache && e == EOPNOTSUPP)
+		e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
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
@@ -5509,6 +5586,65 @@ writev_f(opnum_t opno, long r)
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
+	if (have_rwf_dontcache && e == EOPNOTSUPP)
+		e = pwritev2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
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

