Received: from mx1.redhat.com ([209.132.183.28]:37414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753405AbcJNKja (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Oct 2016 06:39:30 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E98856647
        for <fstests@vger.kernel.org>; Fri, 14 Oct 2016 10:28:38 +0000 (UTC)
Received: from bcodding.csb (vpn-60-9.rdu2.redhat.com [10.10.60.9])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9EAScXL026400
        for <fstests@vger.kernel.org>; Fri, 14 Oct 2016 06:28:38 -0400
From: Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] generic/285: discover allocation size for NFS
Date: Fri, 14 Oct 2016 06:28:37 -0400
Message-Id: <883bff7d2f3123aeb461df1072f9930c3d0f063b.1476440892.git.bcodding@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On NFS, try to discover the allocation size for the exported filesystem.
NFS st_blksize is optimized for the network, and will usually be much
larger than the allocation size of the exported filesystem, which may
trigger preallocation strategies in the exported filesystem causing the
seek tests here to fail.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 src/seek_sanity_test.c | 57 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 18262c2b0493..5455cdb0824e 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -39,21 +39,54 @@ static blksize_t alloc_size;
 int default_behavior = 0;
 char *base_file_path;
 
-static void get_file_system(int fd)
+/*
+ * NFS' st_blksize is typically set to maximize network
+ * efficiency, and will not be indicative of the allocation
+ * size of the exported filesystem.  Try to determine the size
+ * using SEEK_DATA.
+ */
+static void get_nfs_alloc_size(int fd)
 {
-	struct statfs buf;
-
-	if (!fstatfs(fd, &buf)) {
-		fprintf(stdout, "File system magic#: 0x%lx\n",
-				(unsigned long int)buf.f_type);
-	}
+       int shift;
+       off_t pos = 0, offset = 1;
+
+       /* walk up */
+       while (pos == 0 && offset < alloc_size) {
+              offset <<= 1;
+              ftruncate(fd, 0);
+              pwrite(fd, "a", 1, offset);
+              pos = lseek(fd, 0, SEEK_DATA);
+       }
+
+       /* bisect */
+       shift = offset >> 2;
+       while (shift && offset < alloc_size) {
+              ftruncate(fd, 0);
+              pwrite(fd, "a", 1, offset);
+              pos = lseek(fd, 0, SEEK_DATA);
+              offset += pos ? -shift : shift;
+              shift >>= 1;
+       }
+       if (!shift)
+	      offset += pos ? 0 : 1;
+       alloc_size = offset;
 }
 
-static int get_io_sizes(int fd)
+#define NFS_SUPER_MAGIC 0x6969
+
+static int get_fs_info(int fd)
 {
        struct stat buf;
+       struct statfs fsbuf;
        int ret;
 
+       ret = fstatfs(fd, &fsbuf);
+       if (ret)
+               fprintf(stderr, "  ERROR %d: Failed to get fs info\n",
+                     errno);
+       fprintf(stdout, "File system magic#: 0x%lx\n",
+                     (unsigned long int)fsbuf.f_type);
+
        ret = fstat(fd, &buf);
        if (ret)
                fprintf(stderr, "  ERROR %d: Failed to find io blocksize\n",
@@ -61,6 +94,10 @@ static int get_io_sizes(int fd)
 
        /* st_blksize is typically also the allocation size */
        alloc_size = buf.st_blksize;
+
+       if (fsbuf.f_type == NFS_SUPER_MAGIC)
+              get_nfs_alloc_size(fd);
+
        fprintf(stdout, "Allocation size: %ld\n", alloc_size);
 
        return ret;
@@ -709,9 +746,7 @@ static int test_basic_support(void)
 	if (fd == -1)
 		goto out;
 
-	get_file_system(fd);
-
-	ret = get_io_sizes(fd);
+	ret = get_fs_info(fd);
 	if (ret)
 		goto out;
 
-- 
2.5.5

