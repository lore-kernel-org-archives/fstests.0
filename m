Received: from mx1.redhat.com ([209.132.183.28]:58012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfB1Egh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Feb 2019 23:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30BEDB06D6
        for <fstests@vger.kernel.org>; Thu, 28 Feb 2019 04:36:37 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-138.pek2.redhat.com [10.72.12.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39DDD5D707
        for <fstests@vger.kernel.org>; Thu, 28 Feb 2019 04:36:35 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] fsstress: avoid infinite zero byte reading
Date: Thu, 28 Feb 2019 12:36:33 +0800
Message-Id: <20190228043633.15727-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

copyrange_f and splice_f functions use a while loop to read a file,
it's fine if there's only one fsstress process(and its children),
but if some third part testing processes remove the file in the
middle phase of copyrange_f running, copyrange_f maybe always return
0, and the while loop can't be end. As below:

root     47184  xxxxxx S+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
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
 ltp/fsstress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 25e0c3e2..7bc0a58a 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2449,7 +2449,7 @@ copyrange_f(
 	while (len > 0) {
 		ret = syscall(__NR_copy_file_range, fd1, &off1, fd2, &off2,
 			      len, 0);
-		if (ret < 0) {
+		if (ret <= 0) {
 			if (errno != EAGAIN || tries++ >= 300)
 				break;
 		} else if (ret > len)
@@ -2890,7 +2890,7 @@ splice_f(int opno, long r)
 	while (len > 0) {
 		/* move to pipe buffer */
 		ret1 = splice(fd1, &off1, filedes[1], NULL, len, 0);
-		if (ret1 < 0) {
+		if (ret1 <= 0) {
 			break;
 		}
 		bytes = ret1;
@@ -2898,12 +2898,12 @@ splice_f(int opno, long r)
 		/* move from pipe buffer to dst file */
 		while (bytes > 0) {
 			ret2 = splice(filedes[0], NULL, fd2, &off2, bytes, 0);
-			if (ret2 < 0) {
+			if (ret2 <= 0) {
 				break;
 			}
 			bytes -= ret2;
 		}
-		if (ret2 < 0)
+		if (ret2 <= 0)
 			break;
 
 		len -= ret1;
-- 
2.17.2
