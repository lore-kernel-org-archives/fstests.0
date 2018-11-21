Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729727AbeKVDCB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Nov 2018 22:02:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALGONaL109659
        for <fstests@vger.kernel.org>; Wed, 21 Nov 2018 11:26:53 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nwae29ch5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Wed, 21 Nov 2018 11:26:53 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Wed, 21 Nov 2018 16:26:52 -0000
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH] src/t_stripealign.c: Use block size reported by fstatfs()
Date: Wed, 21 Nov 2018 21:56:46 +0530
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181121162646.18117-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

On ppc64le, block size reported by fstat(2) is 64k (the page size)
i.e. the "preferred I/O size". However src/t_stripealign.c requires the
actual block size of the filesystem. Hence this commit now makes use of
the block size reported by fstatfs(2) syscall.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 src/t_stripealign.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/t_stripealign.c b/src/t_stripealign.c
index c61e7632..5cdadaae 100644
--- a/src/t_stripealign.c
+++ b/src/t_stripealign.c
@@ -7,7 +7,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <sys/vfs.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <sys/ioctl.h>
@@ -31,7 +31,7 @@
 
 int main(int argc, char ** argv)
 {
-	struct stat		sb;
+	struct statfs		sb;
 	struct fiemap		*fie;
 	struct fiemap_extent	*fe;
 	int			fd;
@@ -54,7 +54,7 @@ int main(int argc, char ** argv)
                 return 1;
         }
 
-	ret = fstat(fd, &sb);
+	ret = fstatfs(fd, &sb);
 	if (ret) {
 		perror(filename);
 		close(fd);
@@ -101,7 +101,7 @@ int main(int argc, char ** argv)
 		return 1;
 	}
 
-	block = fie->fm_extents[0].fe_physical / sb.st_blksize;
+	block = fie->fm_extents[0].fe_physical / sb.f_bsize;
 check:
 	if (block % sunit) {
 		printf("%s: Start block %llu not multiple of sunit %u\n",
-- 
2.19.1
