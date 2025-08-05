Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931810942
	for <fstests@vger.kernel.org>; Tue,  5 Aug 2025 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358361; cv=none; b=DFGZWapD+NuLRAw6+dVpiI5P2/6D18Ut03jq/VQ3Cb1c09oM9cSELwbKhSirm20h+zqWWCpF3/EGUBMzScFVFiu1h6XTr6fEM374xhDmK+UYKz/KRh9wGsQMqfAz5qDLjgTZ19yeXVmzkVXWhnPFOZERvN1LAQ8nOAvWddAIfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358361; c=relaxed/simple;
	bh=F9YqYh9yXg6ePlGxqwwCGcP0XvMR5h6mf2Mosq49hXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B4qI9QwRkEn26Xoc381dCXWZYTjUcBkKn2tMKosexp66113A/KYnOBq7GeTr1sTrNRdcxQNB2Q9Nuw4nny24aINkoLu0CAmAg0ZnyhgfJuKTbRW4okTxN1zer+3DXJzHnL06hdYB/CERw2OlEYf9VVg+0yJoSN0gPCKjuJbt9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeEj4JBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeEj4JBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDEFC4CEE7;
	Tue,  5 Aug 2025 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754358360;
	bh=F9YqYh9yXg6ePlGxqwwCGcP0XvMR5h6mf2Mosq49hXI=;
	h=From:To:Cc:Subject:Date:From;
	b=oeEj4JBP03B06EtS7cOaBdZYtLnOLUXpxquzteDUfo5woP1FV6u8NtZODtzFvIPM3
	 eEOURs4Bj2DpW3K5LDmWdcD+k0gHNSO/06TwFQpcD5HoAkqhwO0CeFNjU4b8IYPbgc
	 /+097L5BZbSwhFc00nBUzboXHvInZMaNEz9Ak6DJup1R/NFimEcB/r5ht7WmoSwQR6
	 kqXi4h9u+LHUN4ARw8RanFgsn0Eqwn0R/VagPxCTMtuVJtcJnQv4ej4yPX6co//yhE
	 gdTg5KLS7kclMJ2E2LGLupRKlcz9aPLSD2XW7E7U3E8u4iRDsOMXTI7Lhkg2avgstw
	 0y8SzL3hUFslA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fsx: check pwritev2(,RWF_DONTCACHE)in test_dontcache_io as well
Date: Tue,  5 Aug 2025 09:45:37 +0800
Message-ID: <20250805014538.2935061-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filesystem like XFS or ext4 has supported dontcache in both read&write
side, so we can know whether filesystem can support dontcache by only
checking w/ preadv2(,RWF_DONTCACHE).

However, filesystem can decide only support in read side or write side,
not sure, all filesystems will support this feature in both read&write
side later.

Let's add a check condition for write path as well.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 ltp/fsx.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 163b9453..5ad178fa 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -198,7 +198,8 @@ int	o_direct;			/* -Z */
 int	aio = 0;
 int	uring = 0;
 int	mark_nr = 0;
-int	dontcache_io = 1;
+int	read_dontcache_io = 1;
+int	write_dontcache_io = 1;
 int	hugepages = 0;                  /* -h flag */
 
 /* Stores info needed to periodically collapse hugepages */
@@ -1959,7 +1960,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size, int unshare)
 #endif
 
 int
-test_dontcache_io(void)
+test_read_dontcache_io(void)
 {
 	char buf[4096];
 	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
@@ -1971,7 +1972,27 @@ test_dontcache_io(void)
 		if (!quiet)
 			fprintf(stderr,
 				"main: filesystem does not support "
-				"dontcache IO, disabling!\n");
+				"read dontcache IO, disabling!\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+int
+test_write_dontcache_io(void)
+{
+	char buf[4096];
+	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+	int ret, e;
+
+	ret = pwritev2(fd, &iov, 1, 0, RWF_DONTCACHE);
+	e = ret < 0 ? errno : 0;
+	if (e == EOPNOTSUPP) {
+		if (!quiet)
+			fprintf(stderr,
+				"main: filesystem does not support "
+				"write dontcache IO, disabling!\n");
 		return 0;
 	}
 
@@ -2366,7 +2387,7 @@ have_op:
 
 	case OP_READ_DONTCACHE:
 		TRIM_OFF_LEN(offset, size, file_size);
-		if (dontcache_io)
+		if (read_dontcache_io)
 			doread(offset, size, RWF_DONTCACHE);
 		else
 			doread(offset, size, 0);
@@ -2379,7 +2400,7 @@ have_op:
 
 	case OP_WRITE_DONTCACHE:
 		TRIM_OFF_LEN(offset, size, maxfilelen);
-		if (dontcache_io)
+		if (write_dontcache_io)
 			dowrite(offset, size, RWF_DONTCACHE);
 		else
 			dowrite(offset, size, 0);
@@ -3250,7 +3271,8 @@ main(int argc, char **argv)
 				usage();
 			break;
 		case 'T':
-			dontcache_io = 0;
+			read_dontcache_io = 0;
+			write_dontcache_io = 0;
 			break;
 		case 'W':
 		        mapped_writes = 0;
@@ -3263,7 +3285,8 @@ main(int argc, char **argv)
 		case 'Z':
 			o_direct = O_DIRECT;
 			o_flags |= O_DIRECT;
-			dontcache_io = 0;
+			read_dontcache_io = 0;
+			write_dontcache_io = 0;
 			break;
 		case 254:  /* --duration */
 			if (!optarg) {
@@ -3473,8 +3496,10 @@ main(int argc, char **argv)
 		copy_range_calls = test_copy_range();
 	if (exchange_range_calls)
 		exchange_range_calls = test_exchange_range();
-	if (dontcache_io)
-		dontcache_io = test_dontcache_io();
+	if (read_dontcache_io)
+		read_dontcache_io = test_read_dontcache_io();
+	if (write_dontcache_io)
+		write_dontcache_io = test_write_dontcache_io();
 
 	while (keep_running())
 		if (!test())
-- 
2.49.0

