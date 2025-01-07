Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407411CAF
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265988; cv=none; b=enPrPOS8qJFLNxPx0jjJQF80sEIvlnE7t7oXh5ohDWa28UTKUpr3x5c3TvhyW6gPQh9VKnPpCPPIL9EmR+Ww6YdQBnqURpeGyAjN89rGiMGdY7Be93QmO5h2w0kaWMD6fzYHvSh9LvtN2CTRPo21nr6N+mrJGu7+Xz0z023Voi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265988; c=relaxed/simple;
	bh=Ln/PhFpbf5GjSd84Py9k23dBz/p0fgtoulwsbcaHtFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIWLxx7SQEyoiGA/ruIBb+K2ItofgzlZl+i0mQChZcRMVfTu+Ii1bgPJt1rgSU/VwssTs9qjhEKzpUJUi9wb9wDNVAN+4mQpxqg+lK2v74wBShb9SjkELXX1lMV+gciMH3ivk+XIC5j+6b58sAdO9DOBy1MzwJWlAwGyRiti1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BypVQLju; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BypVQLju"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so606977339f.0
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2025 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736265984; x=1736870784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XGT260sEidNoQlUv2QG3xH2gCfLfyJH70rVR3JcN6U=;
        b=BypVQLjuN6XgtSQuW2PkQ1YygmaEFul9CANTW/g6M7f2tn88083D2mKpwbNMlwZpgX
         Tph9LMet9ypSQJhNZI350OloJVUEvy4Vx+LKv9aQgtFMLY9W3swU790AxZmJ+xDuNKgv
         haasZ3kBaVmhT8fMGeZhdn2OY4uZQKq8GRrrMS5xZXE8qH1fRrx5C0vaWky9wiIzXGET
         QZWSB/khenaYOWeA61bl8RqEnhiJF8odtFM4Vgr8WWFtNHQuZs65+UmdV74ugTrT/YLY
         JLO0Xf3GWhTPOGh2OK1vRWoOTFt9SDXOY1YSYet1VPM9MHh8aI4Z6LihC8PIndRzWrtZ
         +QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736265984; x=1736870784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XGT260sEidNoQlUv2QG3xH2gCfLfyJH70rVR3JcN6U=;
        b=nFfXOB3hAtc6ZDmJswjdOz20GyTBEbDjqFpTJ/uexrYZP/LqFu1IofsG9hcODjtGgS
         Fiqn69NApxaAYR43+wBzwio43x0gaFcB83pZmnuVawAbFD0eIBwTd0/J9UXSg0O+/1iS
         0XwM1panAmMWcVnrDRsmSn+iKGkO/qKPWDA9MVdd0oiOUv7KJUQB36EVcSomAksYLdx7
         DZpSWy1MK0ur+8qIiK7f/+99xhzPlV4fJJC1G48M6Ml34ovfv0ytIfCd2jmtHo6G2RlG
         pyxeqHtSM4gKK9LuuDElm5RvcNZJvO4ede5gWAtSbflyHMa07pMLn1dWotiXZdW+ksLv
         zlGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxy7edcFDSWTDhwi4dR4jTLoPQmltye6BPfMELTOUdvuYN5x01lZcRay9gZBZcEteTzqIdek88@vger.kernel.org
X-Gm-Message-State: AOJu0YypK2nKY6dUYhnMYRk2JsyxA5X7mw69Sm64JgB0p0ATyDagoA3/
	p5tlb3cz7V2mJpu5RjalXmQNBcusBx+GvfW+XTOJBD0Xb015MgaitLTfQyAJnrVrUGDgr/Dq4Zg
	5
X-Gm-Gg: ASbGncsdjFdz7QOw+xU5gUQQa+dX/nPx9rKYOCludhnMqz63WV9tKQSXeZcKQY5p5aM
	QIy5sCj770RLVn0pB4ihcoVQEt3FK2VQ6YYU7PKR7spXcvSuz6W3c+GYO+ZUqlPOiEs5b0ehWRM
	XDkj4KleMCGVoJk+yxUdAmDZGwnmyyfnlBJFpnZk47yX/o1DorwDioAhgsiRzx+2pvSPpvf49X4
	vmPCvMmHieyRxzKq/i3mdNqXB9NFFwyQP8TWNYNaTi35LpG78WfCVpSRlrx
X-Google-Smtp-Source: AGHT+IGfzTnIaDi1dIDGCTDby/aq/7jRiAVHpE0thrDxNT6hGXqIWRxD0pwZMKh4Cdv/5a7g43GegQ==
X-Received: by 2002:a05:6602:e41:b0:835:39a8:e201 with SMTP id ca18e2360f4ac-84cd2c9f339mr255859339f.0.1736265983645;
        Tue, 07 Jan 2025 08:06:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c22455csm9529955173.160.2025.01.07.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:06:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] fsx: add support for RWF_DONTCACHE
Date: Tue,  7 Jan 2025 09:05:15 -0700
Message-ID: <20250107160617.222775-3-axboe@kernel.dk>
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

Add ops for testing both the read and write side of this. At startup,
kernel support for this feature is probed. If support isn't available,
uncached/dontcache IO is performed as regular buffered IO. If -Z is
used to turn on O_DIRECT, then uncached/dontcache IO isn't performed.
Defaults to on if available, and adds a -T parameter to turn it off.

See the kernel posting adding support:

https://lore.kernel.org/linux-fsdevel/20241220154831.1086649-1-axboe@kernel.dk/

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 ltp/fsx.c | 114 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 76 insertions(+), 38 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354328a..9efd2f5c86d1 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -43,6 +43,10 @@
 # define MAP_FILE 0
 #endif
 
+#ifndef RWF_DONTCACHE
+#define RWF_DONTCACHE	0x80
+#endif
+
 #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
 
 /* Operation flags (bitmask) */
@@ -101,7 +105,9 @@ int			logcount = 0;	/* total ops */
 enum {
 	/* common operations */
 	OP_READ = 0,
+	OP_READ_DONTCACHE,
 	OP_WRITE,
+	OP_WRITE_DONTCACHE,
 	OP_MAPREAD,
 	OP_MAPWRITE,
 	OP_MAX_LITE,
@@ -190,15 +196,16 @@ int	o_direct;			/* -Z */
 int	aio = 0;
 int	uring = 0;
 int	mark_nr = 0;
+int	dontcache_io = 1;
 
 int page_size;
 int page_mask;
 int mmap_mask;
-int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
+int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags);
 #define READ 0
 #define WRITE 1
-#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
-#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
+#define fsxread(a,b,c,d,f)	fsx_rw(READ, a,b,c,d,f)
+#define fsxwrite(a,b,c,d,f)	fsx_rw(WRITE, a,b,c,d,f)
 
 struct timespec deadline;
 
@@ -266,7 +273,9 @@ prterr(const char *prefix)
 
 static const char *op_names[] = {
 	[OP_READ] = "read",
+	[OP_READ_DONTCACHE] = "read_dontcache",
 	[OP_WRITE] = "write",
+	[OP_WRITE_DONTCACHE] = "write_dontcache",
 	[OP_MAPREAD] = "mapread",
 	[OP_MAPWRITE] = "mapwrite",
 	[OP_TRUNCATE] = "truncate",
@@ -393,12 +402,14 @@ logdump(void)
 				prt("\t******WWWW");
 			break;
 		case OP_READ:
+		case OP_READ_DONTCACHE:
 			prt("READ     0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
 			    lp->args[1]);
 			if (overlap)
 				prt("\t***RRRR***");
 			break;
+		case OP_WRITE_DONTCACHE:
 		case OP_WRITE:
 			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
@@ -784,9 +795,8 @@ doflush(unsigned offset, unsigned size)
 }
 
 void
-doread(unsigned offset, unsigned size)
+doread(unsigned offset, unsigned size, int flags)
 {
-	off_t ret;
 	unsigned iret;
 
 	offset -= offset % readbdy;
@@ -818,12 +828,7 @@ doread(unsigned offset, unsigned size)
 			(monitorend == -1 || offset <= monitorend))))))
 		prt("%lld read\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
 		    offset, offset + size - 1, size);
-	ret = lseek(fd, (off_t)offset, SEEK_SET);
-	if (ret == (off_t)-1) {
-		prterr("doread: lseek");
-		report_failure(140);
-	}
-	iret = fsxread(fd, temp_buf, size, offset);
+	iret = fsxread(fd, temp_buf, size, offset, flags);
 	if (iret != size) {
 		if (iret == -1)
 			prterr("doread: read");
@@ -870,7 +875,6 @@ check_contents(void)
 	unsigned map_offset;
 	unsigned map_size;
 	char *p;
-	off_t ret;
 	unsigned iret;
 
 	if (!check_buf) {
@@ -885,13 +889,7 @@ check_contents(void)
 	if (size == 0)
 		return;
 
-	ret = lseek(fd, (off_t)offset, SEEK_SET);
-	if (ret == (off_t)-1) {
-		prterr("doread: lseek");
-		report_failure(140);
-	}
-
-	iret = fsxread(fd, check_buf, size, offset);
+	iret = fsxread(fd, check_buf, size, offset, 0);
 	if (iret != size) {
 		if (iret == -1)
 			prterr("check_contents: read");
@@ -1064,9 +1062,8 @@ update_file_size(unsigned offset, unsigned size)
 }
 
 void
-dowrite(unsigned offset, unsigned size)
+dowrite(unsigned offset, unsigned size, int flags)
 {
-	off_t ret;
 	unsigned iret;
 
 	offset -= offset % writebdy;
@@ -1099,14 +1096,9 @@ dowrite(unsigned offset, unsigned size)
 		       (monitorstart == -1 ||
 			(offset + size > monitorstart &&
 			(monitorend == -1 || offset <= monitorend))))))
-		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
-		    offset, offset + size - 1, size);
-	ret = lseek(fd, (off_t)offset, SEEK_SET);
-	if (ret == (off_t)-1) {
-		prterr("dowrite: lseek");
-		report_failure(150);
-	}
-	iret = fsxwrite(fd, good_buf + offset, size, offset);
+		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
+		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
+	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
 	if (iret != size) {
 		if (iret == -1)
 			prterr("dowrite: write");
@@ -1954,6 +1946,26 @@ do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
 }
 #endif
 
+int
+test_dontcache_io(void)
+{
+	char buf[4096];
+	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+	int ret, e;
+
+	ret = preadv2(fd, &iov, 1, 0, RWF_DONTCACHE);
+	e = ret < 0 ? errno : 0;
+	if (e == EOPNOTSUPP) {
+		if (!quiet)
+			fprintf(stderr,
+				"main: filesystem does not support "
+				"dontcache IO, disabling!\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 void
 writefileimage()
 {
@@ -2337,12 +2349,28 @@ have_op:
 	switch (op) {
 	case OP_READ:
 		TRIM_OFF_LEN(offset, size, file_size);
-		doread(offset, size);
+		doread(offset, size, 0);
+		break;
+
+	case OP_READ_DONTCACHE:
+		TRIM_OFF_LEN(offset, size, file_size);
+		if (dontcache_io)
+			doread(offset, size, RWF_DONTCACHE);
+		else
+			doread(offset, size, 0);
 		break;
 
 	case OP_WRITE:
 		TRIM_OFF_LEN(offset, size, maxfilelen);
-		dowrite(offset, size);
+		dowrite(offset, size, 0);
+		break;
+
+	case OP_WRITE_DONTCACHE:
+		TRIM_OFF_LEN(offset, size, maxfilelen);
+		if (dontcache_io)
+			dowrite(offset, size, RWF_DONTCACHE);
+		else
+			dowrite(offset, size, 0);
 		break;
 
 	case OP_MAPREAD:
@@ -2538,6 +2566,7 @@ usage(void)
 "	-0: Do not use exchange range calls\n"
 #endif
 "	-K: Do not use keep size\n\
+	-T: Do not use dontcache IO\n\
 	-L: fsxLite - no file creations & no file size changes\n\
 	-N numops: total # operations to do (default infinity)\n\
 	-O: use oplen (see -o flag) for every op (default random)\n\
@@ -2546,7 +2575,7 @@ usage(void)
 	-S seed: for random # generator (default 1) 0 gets timestamp\n\
 	-W: mapped write operations DISabled\n\
 	-X: Read file and compare to good buffer after every operation\n\
-	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
+	-Z: O_DIRECT (use -R, -W, -r and -w too, excludes dontcache IO)\n\
 	--replay-ops=opsfile: replay ops from recorded .fsxops file\n\
 	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
 	--duration=seconds: ignore any -N setting and run for this many seconds\n\
@@ -2702,7 +2731,7 @@ uring_setup()
 }
 
 int
-uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
 {
 	struct io_uring_sqe     *sqe;
 	struct io_uring_cqe     *cqe;
@@ -2733,6 +2762,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 		} else {
 			io_uring_prep_writev(sqe, fd, &iovec, 1, o);
 		}
+		sqe->rw_flags = flags;
 
 		ret = io_uring_submit_and_wait(&ring, 1);
 		if (ret != 1) {
@@ -2781,7 +2811,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 }
 #else
 int
-uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
 {
 	fprintf(stderr, "io_rw: need IO_URING support!\n");
 	exit(111);
@@ -2789,19 +2819,21 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 #endif
 
 int
-fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
 {
 	int ret;
 
 	if (aio) {
 		ret = aio_rw(rw, fd, buf, len, offset);
 	} else if (uring) {
-		ret = uring_rw(rw, fd, buf, len, offset);
+		ret = uring_rw(rw, fd, buf, len, offset, flags);
 	} else {
+		struct iovec iov = { .iov_base = buf, .iov_len = len };
+
 		if (rw == READ)
-			ret = read(fd, buf, len);
+			ret = preadv2(fd, &iov, 1, offset, flags);
 		else
-			ret = write(fd, buf, len);
+			ret = pwritev2(fd, &iov, 1, offset, flags);
 	}
 	return ret;
 }
@@ -3065,6 +3097,9 @@ main(int argc, char **argv)
 			if (seed < 0)
 				usage();
 			break;
+		case 'T':
+			dontcache_io = 0;
+			break;
 		case 'W':
 		        mapped_writes = 0;
 			if (!quiet)
@@ -3076,6 +3111,7 @@ main(int argc, char **argv)
 		case 'Z':
 			o_direct = O_DIRECT;
 			o_flags |= O_DIRECT;
+			dontcache_io = 0;
 			break;
 		case 254:  /* --duration */
 			if (!optarg) {
@@ -3293,6 +3329,8 @@ main(int argc, char **argv)
 		copy_range_calls = test_copy_range();
 	if (exchange_range_calls)
 		exchange_range_calls = test_exchange_range();
+	if (dontcache_io)
+		dontcache_io = test_dontcache_io();
 
 	while (keep_running())
 		if (!test())
-- 
2.47.1

