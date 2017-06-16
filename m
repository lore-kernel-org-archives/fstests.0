Received: from mx1.redhat.com ([209.132.183.28]:43458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbdFPQLf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Jun 2017 12:11:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93F7FC04B943
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 16:11:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8E682E2E
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 16:11:33 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 3/4] fsstress: do memset randomly before write operations
Date: Sat, 17 Jun 2017 00:11:05 +0800
Message-Id: <1497629466-22647-3-git-send-email-zlang@redhat.com>
In-Reply-To: <1497629466-22647-1-git-send-email-zlang@redhat.com>
References: <1497629466-22647-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Recently we found a bug by trigger a page fault when io-vector of
writev is in processing. If do memset between malloc() and write
operations, memset will init the pages. So do memset randomly
maybe help to cover above situation.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 ltp/fsstress.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 4ff90d5..e1b73e4 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -1924,7 +1924,8 @@ do_aio_rw(int opno, long r, int flags)
 		off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 		off -= (off % align);
 		off %= maxfsize;
-		memset(buf, nameseq & 0xff, len);
+		/* randomly memset maybe trigger page fault at write time */
+		if (random() / 2) memset(buf, nameseq & 0xff, len);
 		io_prep_pwrite(&iocb, fd, buf, len, off);
 	} else {
 		off = (off64_t)(lr % stb.st_size);
@@ -2455,7 +2456,8 @@ dwrite_f(int opno, long r)
 	buf = memalign(diob.d_mem, len);
 	off %= maxfsize;
 	lseek64(fd, off, SEEK_SET);
-	memset(buf, nameseq & 0xff, len);
+	/* randomly memset maybe trigger page fault at write time */
+	if (random() / 2) memset(buf, nameseq & 0xff, len);
 	e = write(fd, buf, len) < 0 ? errno : 0;
 	free(buf);
 	if (v)
@@ -3672,7 +3674,8 @@ write_f(int opno, long r)
 	lseek64(fd, off, SEEK_SET);
 	len = (random() % FILELEN_MAX) + 1;
 	buf = malloc(len);
-	memset(buf, nameseq & 0xff, len);
+	/* randomly memset maybe trigger page fault at write time */
+	if (random() / 2) memset(buf, nameseq & 0xff, len);
 	e = write(fd, buf, len) < 0 ? errno : 0;
 	free(buf);
 	if (v)
@@ -3733,7 +3736,8 @@ writev_f(int opno, long r)
 	lseek64(fd, off, SEEK_SET);
 	len = (random() % FILELEN_MAX) + 1;
 	buf = malloc(len);
-	memset(buf, nameseq & 0xff, len);
+	/* randomly memset maybe trigger page fault at write time */
+	if (random() / 2) memset(buf, nameseq & 0xff, len);
 
 	iovcnt = (random() % MIN(len, IOV_MAX)) + 1;
 	iov = malloc(sizeof(struct iovec) * iovcnt);
-- 
2.7.4

