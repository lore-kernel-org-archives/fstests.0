Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE146A60B
	for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142209; cv=none; b=NvSzGhh0ZZopNNgIRDidXHKMarxN9RKVWLvpLucE+pyzq1bPDTFsFzcWYrLw49ZAC3eVqDzbPoBoHwmlB8B2treNIH+8IBdrnGw7QvbmZ8WHyE29cd829PYsxNNqhhy1l0VL/v6doz22QvN82OMVYTssFdx7vUPZ7HxndehkDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142209; c=relaxed/simple;
	bh=oXNDbs+Nukr+czwyLTAEp3V4Zr3whFmdWm+z4GQwC8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UoZtt1dje6GCycrUjoucf5UlRCfr2lNpoGypkw/EVHSflAZ4aLEA8uqJvdWzAyn3f5gSwHbOAJSVOFdOzpQRa4zHlih+3x75HB2mgu4HbIzA9hTRaiy1nZ4SUvTAcOW5bNc1KchlZL08VWwCFnVSSNWMfygnK8N0mkVC3C9y4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2zUNJ/e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWuUdP47; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2zUNJ/e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWuUdP47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792142203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fZobDny03baFt+4u61Pe/BIFLetc9Sn9H3g8zBwmB28=;
	b=S2zUNJ/elbxFk0BAChP0lYgk2KPpbREfS0k/yE+Thqp+LHIkYbRZdxxAl9ff/1uVqku2pr
	YqfhXrJ2/omnuB++d4xNocKDU/rI7OGEHHF3H7/lCVEvLHGed6RE1pTNA5wtWWKemwJb1j
	ZF9XvBpiL+bmXJAfbOECJdw3FvddbXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-d_ATxG99MtWq7Uw6v0VsAQ-1; Fri, 16 Oct 2026 09:16:41 +0000
X-MC-Unique: d_ATxG99MtWq7Uw6v0VsAQ-1
X-Mimecast-MFC-AGG-ID: d_ATxG99MtWq7Uw6v0VsAQ_1792142200
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so1618255e9.1
        for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792142200; x=1792747000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZobDny03baFt+4u61Pe/BIFLetc9Sn9H3g8zBwmB28=;
        b=HWuUdP47wqgGOWW7W6Srblu6M0cXzNnwt3W/X0FnGF3ri8kYFh9nEg9ydaXODyD4VR
         Lyp3RFFxZ4btWyLMqbgE1++bwCGa6dXigRYqy29Y0T06TaVNFvRUDr3v/k8IFg/7Vl1j
         nPXuZv5piykw0OV0KZdPiPHbHEYTwoB1PvB9cGzdrTqZE91gXrtHMC1Js2HUIleOZd4a
         HIJbUXr0hQ0EL44uotk0954DGizDFHsePrTvepyYsn+pjooAC7bD/tFTdmHIm9EtM+0B
         kLX/d0JS6Jc/X9yehPoxTGcrNmVx99TAcOSUBcawQb2iy9BgyHCGPycT6FUCpAly7lP1
         JqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142200; x=1792747000;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fZobDny03baFt+4u61Pe/BIFLetc9Sn9H3g8zBwmB28=;
        b=SKNLt2o3INgVicrWDQAx9i5v+CXIxbhajortZjOopNxfSSJTShHtWy2h2MZX9in2Ec
         Xe8OXGEUgBL66DTh/HCIo2d7nIRwbTm0a7ZDIurbXfKcycZV8uvFuJNF1ia8oseohMZB
         QolD8dlsuYidUin351nKMyMbHqg3hSNLmCy+cm0Gfozu/NO0JrroaoiL/TyDZZLqu/C6
         pV04kCExnZS01H+hJWjo4c20lt2uR4PKG3ov+UzKrzudzJQIw6pamimfPQuMvpPFCMyI
         24TPpg4ZP51dxBAMsCgpJvBXXCVeIyybvnTc30r0ZCVq3NI4l9u4vh7n4ajY5ptWBO9y
         KQ1w==
X-Gm-Message-State: AFq9FYLO4hur3oGh4j37C6KdJDRMF4H6PF/BO6jOWzW8ejre6rQc+ZF3
	Q4mqPMcs/y0yIH3nkBHCOzOinm/1rKlxPLU0eeHxPBrPCa8uFDG1UrXJeL8SMcK6SKmf1YLpjS4
	JTOSyRBU5zu/lnbWQG9dTOzAJFkPwvqSXa1sQZV2HNDqu9olwA21BSJgSBcQ=
X-Gm-Gg: AYBFou33f3fgIhUW7D4R8N9dxA1RIKzZV+KQzXeuPEdh+m2P43paq2OYxbJabHbAZQE
	fT8qqGfBoRfCWMaFGKrB6wsonijcHswUXJZ5R3z3EDimnAFN3MF+6ubfBR9nq9/YaRI33/TowG1
	WmoevC2o2qdF76pYOJ40uc/AaOvx4eaJW9fXidPTu9lAhI739JBu5OKz2uTwvCu8wVEThHxyyRz
	j83hc7vJtopi+dNkC0KoK61QY7LAK7iBwS1HmqK6LZ8H1F2AF0fW3di/dyWT+y8jSemZ/WaoLAh
	BNSt/yj0bCPSWl8+1htiKtViyruBHVmM5KEM4mugEsUs8ijxNQRVz+98755YZ/xHF4NYaJznrXA
	73raM
X-Received: by 2002:a05:600c:1d11:b0:4a0:25db:4591 with SMTP id 5b1f17b1804b1-4a18e4a4c33mr460053065e9.23.1792142199624;
        Fri, 16 Oct 2026 02:16:39 -0700 (PDT)
X-Received: by 2002:a05:600c:1d11:b0:4a0:25db:4591 with SMTP id 5b1f17b1804b1-4a18e4a4c33mr460051825e9.23.1792142198347;
        Fri, 16 Oct 2026 02:16:38 -0700 (PDT)
Received: from localhost (mx0.herbolt.com. [5.59.97.199])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a1cc642573sm28602775e9.2.2026.10.16.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:16:37 -0700 (PDT)
From: Lukas Herbolt <lherbolt@redhat.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	hch@lst.de,
	linux-xfs@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/1] xfs: add test for ENOSR/ENOSPC on DIO into delalloc extents
Date: Fri, 16 Oct 2026 11:16:25 +0200
Message-ID: <20261016091628.295119-1-lherbolt@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  Test if a DIO extending write into a speculative delalloc region on a
  fragmented XFS filesystem does not trigger a dirty transaction cancel
  (-ENOSR) or return a spurious -ENOSPC.

  With allocsize=128MB, a buffered write creates a large delalloc extent.
  A subsequent DIO write at i_size lands in the speculative prealloc
  region. On a fragmented filesystem, xfs_bmapi_write converts the
  delalloc starting from offset 0 but the allocation is too short to
  reach the DIO offset, causing either -ENOSR (dirty transaction cancel
  and filesystem shutdown) or -ENOSPC (wrong error from xfs_bmapi_write).

  Assisted by LLM.

  Fixed by kernel commits:
    2a9b99d45be0 xfs: pass the actual offset and len to xfs_bmapi_allocate
    21255afdd729 xfs: do not allocate the entire delalloc extent
    6773da870ab8 xfs: fix error returns from xfs_bmapi_write

Co-developed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Lukas Herbolt <lherbolt@redhat.com>
---
 .gitignore                 |   2 +
 src/Makefile               |   3 +-
 src/buffer_direct_io.c     | 154 ++++++++++++++++++++++++++++++++
 src/fragment_fs.c          | 101 +++++++++++++++++++++
 src/mix_buffer_direct_io.c | 175 +++++++++++++++++++++++++++++++++++++
 tests/xfs/842              |  63 +++++++++++++
 tests/xfs/842.out          |   2 +
 7 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 src/buffer_direct_io.c
 create mode 100644 src/fragment_fs.c
 create mode 100644 src/mix_buffer_direct_io.c
 create mode 100755 tests/xfs/842
 create mode 100644 tests/xfs/842.out

diff --git a/.gitignore b/.gitignore
index d52ba4ad3085..eafc36c7d8ab 100644
--- a/.gitignore
+++ b/.gitignore
@@ -217,6 +217,8 @@ tags
 /src/t_btrfs_received_uuid_ioctl
 /src/btrfs_ioctl
 /src/dio-read-into-mmap
+/src/buffer_direct_io
+/src/fragment_fs
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/src/Makefile b/src/Makefile
index 0ff607ae1593..c8964a59a539 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
 	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
-	dio-writeback-race unlink-fsync truncate dio-read-into-mmap
+	dio-writeback-race unlink-fsync truncate dio-read-into-mmap \
+	mix_buffer_direct_io fragment_fs
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/buffer_direct_io.c b/src/buffer_direct_io.c
new file mode 100644
index 000000000000..01b19994a2e2
--- /dev/null
+++ b/src/buffer_direct_io.c
@@ -0,0 +1,154 @@
+/*
+ * Mixer of buffered and direct IO originally written to test for XFS -ENOSPC 
+ * and -ENOSR dirty transaction cancel on fragmented filesystem.
+ *
+ * XFS notes:
+ * Buffered write size.  With allocsize=128MB, the buffered write creates
+ * a delalloc extent of [0, BUF_WRITE_SIZE + 128MB).  The DIO at i_size
+ * is at file offset BUF_WRITE_SIZE.  xfs_bmapi_allocate (RHEL 8) starts
+ * the delalloc conversion from offset 0; the allocation must span
+ * BUF_WRITE_SIZE/blocksize blocks in one contiguous extent to reach the
+ * DIO offset.  On a fragmented FS that's impossible — but the FS may
+ * still have large free extents in metadata-sparse regions (20-40 MB is
+ * common).  64 MB puts the DIO offset safely beyond those.
+
+
+ *
+ * Usage:
+ *   ./mix_buffer_direct_io $SCRATCH_MNT
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+
+#define BUF_WRITE_SIZE	(64 * 1024 * 1024)	/* 64 MB */
+
+/* DIO write size — must be block-aligned */
+#define DIO_SIZE	4096
+
+static int attempt_trigger(const char *dir, int attempt)
+{
+	char filepath[4096];
+	char *wbuf;
+	void *dbuf;
+	int bfd, dfd, ret;
+
+	snprintf(filepath, sizeof(filepath), "%s/target_%d", dir, attempt);
+
+	wbuf = calloc(1, BUF_WRITE_SIZE);
+	if (!wbuf) {
+		perror("calloc");
+		return -1;
+	}
+
+	if (posix_memalign(&dbuf, DIO_SIZE, DIO_SIZE)) {
+		perror("posix_memalign");
+		free(wbuf);
+		return -1;
+	}
+	memset(dbuf, 0xbb, DIO_SIZE);
+
+	/*
+	 * Open both fds up front. Keep the buffered fd open across the
+	 * DIO write so close() can't trigger writeback that converts the
+	 * delalloc before we hit it with DIO.
+	 */
+	bfd = open(filepath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (bfd < 0) {
+		if (errno == EIO || errno == EROFS) {
+			fprintf(stderr, "Filesystem shut down!\n");
+			free(wbuf); free(dbuf);
+			return 1;
+		}
+		perror("open for buffered write");
+		free(wbuf); free(dbuf);
+		return -1;
+	}
+
+	dfd = open(filepath, O_WRONLY | O_DIRECT);
+	if (dfd < 0) {
+		if (errno == EIO || errno == EROFS) {
+			fprintf(stderr, "Filesystem shut down!\n");
+			close(bfd);
+			free(wbuf); free(dbuf);
+			return 1;
+		}
+		perror("open for DIO");
+		close(bfd);
+		unlink(filepath);
+		free(wbuf); free(dbuf);
+		return -1;
+	}
+
+	/*
+	 * Step 1: One buffered write.
+	 * On XFS with  allocsize=128MB, this creates a delalloc extent of
+	 * [0, BUF_WRITE_SIZE + 128MB) but only [0, BUF_WRITE_SIZE) has pages. 
+	 * The rest is speculative prealloc.
+	 */
+	ret = pwrite(bfd, wbuf, BUF_WRITE_SIZE, 0);
+	if (ret < 0) {
+		if (errno == ENOSPC) {
+			fprintf(stderr, "attempt %d: ENOSPC on buffered write\n",
+				attempt);
+			close(dfd);
+			close(bfd);
+			unlink(filepath);
+			free(wbuf); free(dbuf);
+			return 0;
+		}
+		perror("buffered pwrite");
+		close(dfd);
+		close(bfd);
+		free(wbuf); free(dbuf);
+		return -1;
+	}
+
+	/*
+	 * Step 2: DIO extending write at i_size.
+	 *
+	 * Offset BUF_WRITE_SIZE is within the speculative delalloc but has no 
+	 * pages, so the DIO flush is a no-op. xfs_bmapi_write finds the 
+	 * delalloc starting at offset 0 and tries to convert from there. On 
+	 * our fragmented FS the allocation is 1 block at file offset 0,
+	 * nowhere near the DIO offset at block 256. Returns -ENOSPC or -ENOSR.
+	 */
+	ret = pwrite(dfd, dbuf, DIO_SIZE, BUF_WRITE_SIZE);
+	if (ret < 0) {
+		fprintf(stderr, "DIO pwrite failed: %s\n", strerror(errno));
+		close(dfd);
+		close(bfd);
+		free(wbuf); free(dbuf);
+		return errno;
+	}
+	close(dfd);
+	close(bfd);
+	unlink(filepath);
+	free(wbuf);
+	free(dbuf);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int i, ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "  %s <directory>\n", argv[0]);
+		return 1;
+	}
+
+	for (i = 0; i < 1000; i++) {
+		ret = attempt_trigger(argv[1], i);
+		if (ret != 0)
+			return ret;
+	}
+	return 0;
+}
diff --git a/src/fragment_fs.c b/src/fragment_fs.c
new file mode 100644
index 000000000000..cee4edef73ff
--- /dev/null
+++ b/src/fragment_fs.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Eric Sandeen, Lukas Herbolt
+ */
+
+/*
+ * Fragment filesystem by creating fixed-size files and then deleting
+ * every n-th one.
+ *
+ * Usage:
+ *	fragment_fs <directory> <prefix> <file size> <delete every n-th file>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/statvfs.h>
+
+static int fragment_fs(const char *dir, const char *prefix,
+		       off_t size, int delete_nth)
+{
+	char path[4096];
+	int i, fd;
+	int created = 0;
+
+	fprintf(stderr, "Fragmenting filesystem (filling to ENOSPC)...\n");
+
+	for (i = 0; ; i++) {
+		snprintf(path, sizeof(path), "%s/%s_%06d", dir, prefix, i);
+		fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (fd < 0) {
+			if (errno == ENOSPC)
+				break;
+			perror("open frag file");
+			return -1;
+		}
+		if (fallocate(fd, 0, 0, size) < 0) {
+			close(fd);
+			unlink(path);
+			if (errno == ENOSPC)
+				break;
+			perror("fallocate frag file");
+			return -1;
+		}
+		close(fd);
+		created++;
+	}
+	fprintf(stderr, "Created %d files\n", created);
+
+	fprintf(stderr, "Deleting every %d-th file...\n", delete_nth);
+	for (i = 0; i < created; i += delete_nth) {
+		snprintf(path, sizeof(path), "%s/%s_%06d", dir, prefix, i);
+		unlink(path);
+	}
+	sync();
+
+	{
+		struct statvfs st;
+		if (statvfs(dir, &st) == 0) {
+			unsigned long free_mb = (st.f_bfree * st.f_bsize)
+						/ (1024 * 1024);
+			fprintf(stderr,
+				"%d files remain, ~%lu MB free\n",
+				created - created / delete_nth, free_mb);
+		}
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	off_t file_size;
+	int delete_nth;
+
+	if (argc != 5) {
+		fprintf(stderr,
+			"Usage: %s <directory> <prefix> <file_size> <delete_every_nth>\n",
+			argv[0]);
+		return 1;
+	}
+
+	file_size = strtoll(argv[3], NULL, 0);
+	if (file_size <= 0) {
+		fprintf(stderr, "Invalid file size: %s\n", argv[3]);
+		return 1;
+	}
+
+	delete_nth = atoi(argv[4]);
+	if (delete_nth < 2) {
+		fprintf(stderr, "delete_every_nth must be >= 2\n");
+		return 1;
+	}
+
+	if (fragment_fs(argv[1], argv[2], file_size, delete_nth) < 0)
+		return 1;
+
+	return 0;
+}
diff --git a/src/mix_buffer_direct_io.c b/src/mix_buffer_direct_io.c
new file mode 100644
index 000000000000..0af227a7c9f0
--- /dev/null
+++ b/src/mix_buffer_direct_io.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Eric Sandeen, Lukas Herbolt
+ */
+
+/*
+ * Mix buffered and direct IO originally written to test for XFS -ENOSPC 
+ * and -ENOSR dirty transaction cancel on fragmented filesystem.
+ *
+ * XFS notes:
+ * Buffered write size. With allocsize=128MB, the buffered write creates
+ * a delalloc extent of [0, buf_write_size + 128MB).  The DIO at i_size
+ * is at file offset buf_write_size.  xfs_bmapi_allocate (RHEL 8) starts
+ * the delalloc conversion from offset 0; the allocation must span
+ * buf_write_size/blocksize blocks in one contiguous extent to reach the
+ * DIO offset.  On a fragmented FS that's impossible — but the FS may
+ * still have large free extents in metadata-sparse regions (20-40 MB is
+ * common).  64 MB puts the DIO offset safely beyond those.
+ *
+ * Usage:
+ *   ./mix_buffer_direct_io <dir> [buf_write_size] [dio_size]
+ *
+ *   buf_write_size  Buffered write size in bytes (default 67108864 / 64 MB)
+ *   dio_size        DIO write size in bytes (default 4096), must be
+ *                   block-aligned
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+
+static int attempt_trigger(const char *dir, int attempt,
+			   off_t buf_write_size, size_t dio_size)
+{
+	char filepath[4096];
+	char *wbuf;
+	void *dbuf;
+	int bfd, dfd, ret;
+
+	snprintf(filepath, sizeof(filepath), "%s/target_%d", dir, attempt);
+
+	wbuf = calloc(1, buf_write_size);
+	if (!wbuf) {
+		perror("calloc");
+		return -1;
+	}
+
+	if (posix_memalign(&dbuf, dio_size, dio_size)) {
+		perror("posix_memalign");
+		free(wbuf);
+		return -1;
+	}
+	memset(dbuf, 0xbb, dio_size);
+
+	/*
+	 * Open both fds up front. Keep the buffered fd open across the
+	 * DIO write so close() can't trigger writeback that converts the
+	 * delalloc before we hit it with DIO.
+	 */
+	bfd = open(filepath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (bfd < 0) {
+		if (errno == EIO || errno == EROFS) {
+			fprintf(stderr, "Filesystem shut down!\n");
+			free(wbuf); free(dbuf);
+			return 1;
+		}
+		perror("open for buffered write");
+		free(wbuf); free(dbuf);
+		return -1;
+	}
+
+	dfd = open(filepath, O_WRONLY | O_DIRECT);
+	if (dfd < 0) {
+		if (errno == EIO || errno == EROFS) {
+			fprintf(stderr, "Filesystem shut down!\n");
+			close(bfd);
+			free(wbuf); free(dbuf);
+			return 1;
+		}
+		perror("open for DIO");
+		close(bfd);
+		unlink(filepath);
+		free(wbuf); free(dbuf);
+		return -1;
+	}
+
+	/*
+	 * Step 1: One buffered write.
+	 * On XFS with  allocsize=128MB, this creates a delalloc extent of
+	 * [0, buf_write_size + 128MB) but only [0, buf_write_size) has pages. 
+	 * The rest is speculative prealloc.
+	 */
+	ret = pwrite(bfd, wbuf, buf_write_size, 0);
+	if (ret < 0) {
+		if (errno == ENOSPC) {
+			fprintf(stderr, "attempt %d: ENOSPC on buffered write\n",
+				attempt);
+			close(dfd);
+			close(bfd);
+			unlink(filepath);
+			free(wbuf); free(dbuf);
+			return 0;
+		}
+		perror("buffered pwrite");
+		close(dfd);
+		close(bfd);
+		free(wbuf); free(dbuf);
+		return -1;
+	}
+
+	/*
+	 * Step 2: DIO extending write at i_size.
+	 *
+	 * Offset buf_write_size is within the speculative delalloc but has no 
+	 * pages, so the DIO flush is a no-op. xfs_bmapi_write finds the 
+	 * delalloc starting at offset 0 and tries to convert from there. On 
+	 * our fragmented FS the allocation is 1 block at file offset 0,
+	 * nowhere near the DIO offset at block 256. Returns -ENOSPC or -ENOSR.
+	 */
+	ret = pwrite(dfd, dbuf, dio_size, buf_write_size);
+	if (ret < 0) {
+		fprintf(stderr, "DIO pwrite failed: %s\n", strerror(errno));
+		close(dfd);
+		close(bfd);
+		free(wbuf); free(dbuf);
+		return errno;
+	}
+	close(dfd);
+	close(bfd);
+	unlink(filepath);
+	free(wbuf);
+	free(dbuf);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	off_t buf_write_size = 64 * 1024 * 1024;
+	size_t dio_size = 4096;
+	int i, ret;
+
+	if (argc < 2 || argc > 4) {
+		fprintf(stderr,
+			"Usage: %s <dir> [buf_write_size] [dio_size]\n",
+			argv[0]);
+		return 1;
+	}
+
+	if (argc >= 3) {
+		buf_write_size = strtoll(argv[2], NULL, 0);
+		if (buf_write_size <= 0) {
+			fprintf(stderr, "Invalid buf_write_size: %s\n",
+				argv[2]);
+			return 1;
+		}
+	}
+	if (argc >= 4) {
+		dio_size = strtoul(argv[3], NULL, 0);
+		if (dio_size == 0 || dio_size % 512) {
+			fprintf(stderr, "Invalid dio_size: %s\n", argv[3]);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < 1000; i++) {
+		ret = attempt_trigger(argv[1], i,
+				      buf_write_size, dio_size);
+		if (ret != 0)
+			return ret;
+	}
+	return 0;
+}
diff --git a/tests/xfs/842 b/tests/xfs/842
new file mode 100755
index 000000000000..b2b2f7c493e7
--- /dev/null
+++ b/tests/xfs/842
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Lukas Herbolt.  All Rights Reserved.
+#
+# FS QA Test 842
+#
+# Regression test for XFS -ENOSR dirty transaction cancel during DIO
+# write into a speculative delalloc region on a fragmented filesystem.
+# With allocsize=128MB, a buffered write creates a large delalloc extent.
+# A subsequent DIO extending write at i_size triggers xfs_bmapi_write to
+# convert the delalloc from offset 0; on a fragmented FS the allocation
+# is too short to reach the DIO offset, returning -ENOSR and cancelling
+# a dirty transaction, which shuts down the filesystem.
+#
+. ./common/preamble
+_begin_fstest auto enospc
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+_require_test
+_require_scratch
+_require_test_program "fragment_fs"
+_require_test_program "buffer_direct_io"
+
+_scratch_mkfs_sized $((1<<30)) > "$seqres.full" 2>&1
+_scratch_mount -o allocsize=131072k >> "$seqres.full" 2>&1
+
+src/fragment_fs $SCRATCH_MNT frag 4096 2 >> "$seqres.full" 2>&1
+src/buffer_direct_io $SCRATCH_MNT >> "$seqres.full" 2>&1
+RET=$?
+
+_dmesg_since_test_start | grep -q "detected at xfs_trans_cancel"
+DMESG_CHECK=$?
+
+if [ $RET -eq 5 -a $DMESG_CHECK -eq 0 ]; then
+	_fixed_by_kernel_commit 2a9b99d45be0 \
+		"xfs: pass the actual offset and len to xfs_bmapi_allocate"
+	_fixed_by_kernel_commit 21255afdd729 \
+		"xfs: do not allocate the entire delalloc extent"
+	_fail "ENOSR dirty transaction cancel detected (ret=$RET)"
+
+elif [ $RET -eq 28 ]; then
+	_fixed_by_kernel_commit 2a9b99d45be0 \
+		"xfs: pass the actual offset and len to xfs_bmapi_allocate"
+	_fixed_by_kernel_commit 21255afdd729 \
+		"xfs: do not allocate the entire delalloc extent"
+	_fixed_by_kernel_commit 6773da870ab8 \
+		"xfs: fix error returns from xfs_bmapi_write"
+	_fail "ENOSPC returned from xfs_bmapi_write (ret=$RET)"
+
+elif [ $RET -eq 0 ]; then
+	echo "Silence is golden"
+else
+	_fail "Unknown error: src/buffer_direct_io error code $RET"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/842.out b/tests/xfs/842.out
new file mode 100644
index 000000000000..643d05289a33
--- /dev/null
+++ b/tests/xfs/842.out
@@ -0,0 +1,2 @@
+QA output created by 842
+Silence is golden
-- 
2.56.0

