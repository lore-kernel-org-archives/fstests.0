Received: from mx1.redhat.com ([209.132.183.28]:52190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfA2IJZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1E31C7A07
        for <fstests@vger.kernel.org>; Tue, 29 Jan 2019 08:09:25 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C196F5C893
        for <fstests@vger.kernel.org>; Tue, 29 Jan 2019 08:09:24 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] fsstress: avoid infinite zero byte reading
Date: Tue, 29 Jan 2019 16:09:16 +0800
Message-Id: <20190129080916.11529-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

copyrange_f and splice_f functions use a while loop to read a file,
it's fine if there's only one fsstress process(and its children),
but if some third part testing processes remove the file in the
middle phase of copyrange_f running, copyrange_f maybe always return
0, and the while loop can't be end. As below:

root     47184  xxxxxx S+ ./fsstress -R -d /mnt/scratch -n 10000 -p 20 -v
root     47187  xxxxxx R+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
root     47199  xxxxxx R+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
root     47314  xxxxxx S+ grep --color=auto fsstress
...
...
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
...
...
lr-x------. 1 root root 64 Jan 28 11:34 /proc/47187/fd/3 -> '/mnt/scratch/p2/f2 (deleted)'

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 ltp/fsstress.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index c04feb78..68e40ee6 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2363,8 +2363,9 @@ copyrange_f(
 	int			v2;
 	int			fd1;
 	int			fd2;
-	size_t			ret;
+	size_t			ret = 0;
 	int			e;
+	int			limit;
 
 	/* Load paths */
 	init_pathname(&fpath1);
@@ -2446,6 +2447,7 @@ copyrange_f(
 		off2 %= maxfsize;
 	} while (stat1.st_ino == stat2.st_ino && llabs(off2 - off1) < len);
 
+	limit = 300;
 	while (len > 0) {
 		ret = syscall(__NR_copy_file_range, fd1, &off1, fd2, &off2,
 			      len, 0);
@@ -2456,6 +2458,15 @@ copyrange_f(
 			break;
 		else if (ret > 0)
 			len -= ret;
+		else {
+			/*
+			 * if copy_file_range always get 0 byte, break from the
+			 * infinite loop running
+			 */
+			limit--;
+			if (limit <= 0)
+				break;
+		}
 	}
 	e = ret < 0 ? errno : 0;
 	if (v1 || v2) {
@@ -2790,6 +2801,7 @@ splice_f(int opno, long r)
 	size_t			bytes;
 	int			e;
 	int			filedes[2];
+	int			limit;
 
 	/* Load paths */
 	init_pathname(&fpath1);
@@ -2886,6 +2898,7 @@ splice_f(int opno, long r)
 
 	bytes = 0;
 	total = 0;
+	limit = 300;
 	while (len > 0) {
 		/* move to pipe buffer */
 		ret1 = splice(fd1, &off1, filedes[1], NULL, len, 0);
@@ -2907,6 +2920,11 @@ splice_f(int opno, long r)
 
 		len -= ret1;
 		total += ret1;
+		if (ret1 == 0) {
+			limit--;
+			if (limit <= 0)
+				break;
+		}
 	}
 
 	if (ret1 < 0 || ret2 < 0)
-- 
2.17.2
