Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8153BED4F
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159095; cv=none; b=OhSXIelpyHqcFEgnRN0cI0jRkzl6xEqx/grOd3B4fY375ORAlFK9cNadflqPJ+jcjCJOMYtSo1A2ndUGbx5OuqHVFykHSDreE80/QvLldtIzbi1pWalDzQzuB0+bLIGjt56sKh33LYDUx6SnwudHl38Ov02EzKrMqoG99bLv3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159095; c=relaxed/simple;
	bh=wncC8HDi5MqnfufZRW2xNT95FnQHfboFZ7OZ+C9Wef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAJ7lUToOkDIRg9y0j8xlFAIiJb5zmScUekLlTFOutrVtTZzJuqMEbNuQ3WRKvunQjl+IwP4mZrluU9e+ZSnp0zROa9B91CWeaxe4gS1E9x4wDj9SUTbG58EW9lCY7FiOoK2Huxp5YELulva/rEBqzJ5urVsfJEJUDJx7i4L7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z/VBG2zi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z/VBG2zi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=w/Yg8M/+T0IDOlKqAm4qjuj5riHshsVQUSScEhTfrJY=; b=z/VBG2ziKou7V7UGHd4iUoO0I8
	fu3lR6PJyW76/p6BteOP0tUrV4KsK2LXkzRCr+6J4mfcQ6HJvRqujwmSuKzYSJF2rDwj6+RqryI2m
	hAM9mUTH8kWIranwMqgVyjwWxuwXwXbdkmFw22/ixlzU6VeDSmI6CFxOdJNtTeVFyI9vm3nA8RiJ9
	nDi7VTRmpkD7tCxOMwctaFgMW0oiTqWy/rjjPD4I1Fka/qgqEew7aaBIOzJbmpVZ0K+hLvOsdUHTj
	wS1diF5CVaTbxnUIR+gqSxVQS1u76qmZMPeQh1skayr2ZjsOIfHzn7hF2/VCQ+f80yJeR1p1Iuna9
	PfF3CfDw==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vrg-00000008eYQ-2OEl;
	Mon, 31 Aug 2026 06:51:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 2/5] min_dio_alignment: add a -r option to query read alignment
Date: Mon, 31 Aug 2026 09:51:05 +0300
Message-ID: <20260831065120.2578146-3-hch@lst.de>
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

Add an option to query the STATX_DIO_READ_ALIGN if provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 src/min_dio_alignment.c | 44 ++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
index 866fba1546c4..143cee684ab4 100644
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
@@ -27,9 +29,16 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 	 */
 	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
 	if (fd >= 0 &&
-	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
-	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
-		return stx.stx_dio_offset_align;
+	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0) {
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
@@ -42,9 +51,8 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 		if (dev_fd > 0 &&
 		    fstat(dev_fd, &st) == 0 &&
 		    S_ISBLK(st.st_mode) &&
-		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0) {
+		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0)
 			return logical_block_size;
-		}
 	}
 
 	/*
@@ -56,11 +64,25 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
 
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

