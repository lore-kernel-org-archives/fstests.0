Received: from mgw-01.mpynet.fi ([82.197.21.90]:52626 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfBZOtM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Feb 2019 09:49:12 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id x1QEUDfl040728
        for <fstests@vger.kernel.org>; Tue, 26 Feb 2019 16:31:05 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 2qvkkf9p9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Tue, 26 Feb 2019 16:31:05 +0200
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH] fsstress: show correct offsets and length for copy_file_range
Date: Tue, 26 Feb 2019 14:29:02 +0000
Message-ID: <1551191342-14428-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Copy original offsets and length and use them for logging as in
splice_f. Fix grammar mistakes in the comment about them.

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 ltp/fsstress.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 2223fd7..41a0155 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2356,8 +2356,11 @@ copyrange_f(
 	loff_t			lr;
 	loff_t			off1;
 	loff_t			off2;
+	loff_t			offset1;
+	loff_t			offset2;
 	loff_t			max_off2;
 	size_t			len;
+	size_t			length;
 	int			tries = 0;
 	int			v1;
 	int			v2;
@@ -2446,6 +2449,14 @@ copyrange_f(
 		off2 %= maxfsize;
 	} while (stat1.st_ino == stat2.st_ino && llabs(off2 - off1) < len);
 
+	/*
+	 * Since len, off1 and off2 will be changed later, preserve their
+	 * original values.
+	 */
+	length = len;
+	offset1 = off1;
+	offset2 = off2;
+
 	while (len > 0) {
 		ret = syscall(__NR_copy_file_range, fd1, &off1, fd2, &off2,
 			      len, 0);
@@ -2461,8 +2472,10 @@ copyrange_f(
 	if (v1 || v2) {
 		printf("%d/%d: copyrange %s%s [%lld,%lld] -> %s%s [%lld,%lld]",
 			procid, opno,
-			fpath1.path, inoinfo1, (long long)off1, (long long)len,
-			fpath2.path, inoinfo2, (long long)off2, (long long)len);
+			fpath1.path, inoinfo1,
+			(long long)offset1, (long long)length,
+			fpath2.path, inoinfo2,
+			(long long)offset2, (long long)length);
 
 		if (ret < 0)
 			printf(" error %d", e);
@@ -2869,8 +2882,8 @@ splice_f(int opno, long r)
 	off2 = (off64_t)(lr % MIN(stat2.st_size + (1024ULL * stat2.st_blksize), MAXFSIZE));
 
 	/*
-	 * Due to len, off1 and off2 will be changed later, so record the
-	 * original number at here
+	 * Since len, off1 and off2 will be changed later, preserve their
+	 * original values.
 	 */
 	length = len;
 	offset1 = off1;
-- 
2.1.4
