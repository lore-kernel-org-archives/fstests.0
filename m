Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED230568E
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386363; cv=none; b=ZQcvOjwljSTZB+O7vAd7hKSQn+GEtOtkFVrPAO/8Ence9kyR7o7EOoEVBd5Q9Tp6uQ4luKgVeWX3gAXTPDBKgX3rMHHiUGs+NJ4ukGC4N2NU5QbDl5LUihCVDIpzHI4vXKzuOYoJOakasnL4h+YF5r/ILdtmYl8+Iy1iabdlvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386363; c=relaxed/simple;
	bh=sCuainD9dTgCHQJRJPivVALSzsNDQkJPMHDusu/GgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3agXon1VTYF1zWGtzGO774uIzvog4XwKC31Y7/AvtE6UDEm0K8SCnz617UP6mqEFAWyXJlzZY5qiRdLkPRPEXINKg+tT0SR80cOsNts+Vmn0PVaFHpWqIzby6FyFT7Z3VCvPK24PR1/jfvebTDYD9td+/lzEa7gyLty2hbS+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAG5MyJu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAG5MyJu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LBzuFzsvEIO4kkA4FX9IMq0KwlW9ELak7VjIIbRxtxc=; b=PAG5MyJumP5DKSPWfgsTW/bi1+
	dODx5QuJZ7J4OQY114tIqrcf9V5EwjFq7Eohx7a1ayR50VY6+dkvSuT6A+m1jUermcqTleToyMF5E
	MadcFW3TgzvKHcgJHl+ywjenUx97KfAXqS1pWGa4unCzSHvOZAnwnUO64P6zg0zRS67/KPZhb26cm
	nVvTaghJ0qV4nWvoIbrXcA6TGBCK/cJAc1bkV/zQiC3N9u+cU4eTVkuOlzNRzUygMKbSl2Oxbs93C
	TDz0TAwZCm8HU50ZVC6eNVzlvu3nCUc9tzLEGmt+NF+LJvriPhuHVqI7lamNkW/Njzcrv8FdmUE64
	l76JZ/Pw==;
Received: from [195.12.231.4] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x658K-00000003Mzf-19ZT;
	Mon, 14 Sep 2026 11:46:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 2/5] min_dio_alignment: add a -r option to query read alignment
Date: Mon, 14 Sep 2026 13:45:44 +0200
Message-ID: <20260914114550.2451308-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914114550.2451308-1-hch@lst.de>
References: <20260914114550.2451308-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add an option to query the STATX_DIO_READ_ALIGN if provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 src/min_dio_alignment.c | 45 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
index 866fba1546c4..a557ce93a5d6 100644
--- a/src/min_dio_alignment.c
+++ b/src/min_dio_alignment.c
@@ -1,17 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2024 Christoph Hellwig
+ * Copyright (c) 2024,2026 Christoph Hellwig
  */
 #include <fcntl.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <getopt.h>
 #include <sys/mount.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include "statx.h"
 
-static int min_dio_alignment(const char *mntpnt, const char *devname)
+static int min_dio_alignment(const char *mntpnt, const char *devname, bool read)
 {
 	struct statx stx = { };
 	struct stat st;
@@ -27,9 +29,17 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 	 */
 	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
 	if (fd >= 0 &&
-	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
-	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
-		return stx.stx_dio_offset_align;
+	    xfstests_statx(fd, "", AT_EMPTY_PATH,
+			STATX_DIOALIGN | STATX_DIO_READ_ALIGN, &stx) == 0) {
+		if (read &&
+		    (stx.stx_mask & STATX_DIO_READ_ALIGN) &&
+		    stx.stx_dio_read_offset_align != 0)
+			return stx.stx_dio_read_offset_align;
+
+		if ((stx.stx_mask & STATX_DIOALIGN) &&
+		    stx.stx_dio_offset_align != 0)
+			return stx.stx_dio_offset_align;
+	}
 
 	/*
 	 * If we are on a block device and no explicit aligned is reported, use
@@ -42,9 +52,8 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 		if (dev_fd > 0 &&
 		    fstat(dev_fd, &st) == 0 &&
 		    S_ISBLK(st.st_mode) &&
-		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0) {
+		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0)
 			return logical_block_size;
-		}
 	}
 
 	/*
@@ -56,11 +65,25 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 
 int main(int argc, char **argv)
 {
-	if (argc != 3) {
-		fprintf(stderr, "usage: %s mountpoint devicename\n", argv[0]);
-		exit(1);
+	bool read = false;
+	int c;
+
+	while ((c = getopt(argc, argv, "r")) != -1) {
+		switch(c) {
+		case 'r':
+			read = 1;
+			break;
+		default:
+			goto usage;
+		}
 	}
 
-	printf("%d\n", min_dio_alignment(argv[1], argv[2]));
+	if (argc - optind != 2)
+		goto usage;
+
+	printf("%d\n", min_dio_alignment(argv[optind], argv[optind + 1], read));
 	exit(0);
+usage:
+	fprintf(stderr, "usage: %s [-r] mountpoint devicename\n", argv[0]);
+	exit(1);
 }
-- 
2.53.0

