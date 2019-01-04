Received: from szxga06-in.huawei.com ([45.249.212.32]:44279 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbfADIQC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 03:16:02 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 390E7584DC47F
        for <fstests@vger.kernel.org>; Fri,  4 Jan 2019 16:15:59 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH v2 2/2] fsx: check ENOSYS in test_copy_range() & test_fallocate()
Date: Fri, 4 Jan 2019 16:19:27 +0800
Message-ID: <20190104081927.112622-3-houtao1@huawei.com>
In-Reply-To: <20190104081927.112622-1-houtao1@huawei.com>
References: <20190104081927.112622-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

In configure script, we only check whether or not the build
of test program succeeds, but that doesn't mean the kernel
has implemented the syscall, so checking for this case.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2:
	* also check ENOSYS for fallocate syscall
---
 ltp/fsx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 316f08eb..f4a1c7cf 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1583,7 +1583,7 @@ test_copy_range(void)
 	loff_t o1 = 0, o2 = 0;
 
 	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 0, 0) == -1 &&
-	    (errno == EOPNOTSUPP || errno == ENOTTY)) {
+	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
 		if (!quiet)
 			fprintf(stderr,
 				"main: filesystem does not support "
@@ -2423,7 +2423,8 @@ __test_fallocate(int mode, const char *mode_str)
 #ifdef HAVE_LINUX_FALLOC_H
 	int ret = 0;
 	if (!lite) {
-		if (fallocate(fd, mode, file_size, 1) && errno == EOPNOTSUPP) {
+		if (fallocate(fd, mode, file_size, 1) &&
+		    (errno == ENOSYS || errno == EOPNOTSUPP)) {
 			if(!quiet)
 				fprintf(stderr,
 					"main: filesystem does not support "
-- 
2.16.2.dirty
