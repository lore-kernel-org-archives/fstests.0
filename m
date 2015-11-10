Received: from mailout3.samsung.com ([203.254.224.33]:54192 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbKJJwn (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 10 Nov 2015 04:52:43 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NXL01FH6FFSNH50@mailout3.samsung.com> for
 fstests@vger.kernel.org; Tue, 10 Nov 2015 18:52:40 +0900 (KST)
From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] generic/285: fix the wrong result printed in full log
Date: Tue, 10 Nov 2015 17:52:03 +0800
Message-id: <01b701d11b9d$89404100$9bc0c300$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: 'Dave Chinner' <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This issue was found by testing f2fs module with generic/285, and the
related bug has already been fixed since commit 2e023174a88d ("f2fs:
avoid data offset overflow when lseeking huge file"), but forgot to fix
it in xfstest suit.

The wrong result printed is printed in log below:
10. Test a huge file for offset overflow
10.01 SEEK_HOLE expected 65536 or 0, got 65536.                   succ
10.02 SEEK_HOLE expected 65536 or 0, got 65536.                   succ
10.03 SEEK_DATA expected 0 or 0, got 0.                           succ
10.04 SEEK_DATA expected 1 or 1, got 1.                           succ
10.05 SEEK_HOLE expected 0 or 0, got 0.                           FAIL
10.06 SEEK_DATA expected -65536 or -65536, got -65536.            succ
10.07 SEEK_DATA expected -65535 or -65535, got -65535.            succ
10.08 SEEK_DATA expected -65536 or -65536, got -65536.            FAIL

The result printed in the log shows that when some test cases failed, the
data we expected and got are the same that is not correct obviously.

The reason is that we cast the result from type off_t(64-bit) to type
long(32-bit) when doing huge file offset seeking tests in 32-bit machine.

This patch fixes the wrong printing issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 src/seek_sanity_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 7cf45c0..18262c2 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -187,10 +187,10 @@ static int do_lseek(int testnum, int subtest, int fd, off_t filsz, int origin,
 		ret = !(errno == ENXIO);
 	} else {
 
-		x = fprintf(stdout, "%02d.%02d %s expected %ld or %ld, got %ld. ",
+		x = fprintf(stdout, "%02d.%02d %s expected %lld or %lld, got %lld. ",
 			    testnum, subtest,
 			    (origin == SEEK_HOLE) ? "SEEK_HOLE" : "SEEK_DATA",
-			    (long)exp, (long)exp2, (long)pos);
+			    (long long)exp, (long long)exp2, (long long)pos);
 		ret = !(pos == exp || pos == exp2);
 	}
 
-- 
2.4.2


