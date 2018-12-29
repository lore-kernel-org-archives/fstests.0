Received: from szxga04-in.huawei.com ([45.249.212.190]:17069 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbeL2Cbg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Dec 2018 21:31:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3A4CA5BBA5C3
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 10:31:30 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH 5/5] fsx: check ENOSYS in test_copy_range()
Date: Sat, 29 Dec 2018 10:34:52 +0800
Message-ID: <20181229023452.28074-6-houtao1@huawei.com>
In-Reply-To: <20181229023452.28074-1-houtao1@huawei.com>
References: <20181229023452.28074-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

In configure script, we only check whether or not the build
of copy-range test program is successful, but that doesn't
mean the kernel has implemented the syscall, so checking
for this case.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 ltp/fsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 316f08eb..b84180f7 100644
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
-- 
2.16.2.dirty
