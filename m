Received: from mx1.redhat.com ([209.132.183.28]:52316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751592AbcICAEC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Sep 2016 20:04:02 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5037D43A37
        for <fstests@vger.kernel.org>; Sat,  3 Sep 2016 00:04:02 +0000 (UTC)
Received: from [IPv6:::1] (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u83041V3030170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <fstests@vger.kernel.org>; Fri, 2 Sep 2016 20:04:01 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] seek_sanity_test: use fs block size not preferred IO size
Message-ID: <1e34c608-b013-edc4-aec0-a50f6bf32a4e@redhat.com>
Date: Fri, 2 Sep 2016 19:04:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

seek_sanity_test uses a 16x multiple of st_blksize for the basis
of its io sizes; for filesystems that use generic_fillattr,
that's the same as fs block size.  But on xfs, we take
"blocksize for file system I/O" a bit more generously, and
use xfs_preferred_iosize, which may be page size, stripe width,
or otherwise.

If we get a value of any more than 4k, the 16x multiplier puts
us past 64k, which is the threshold for xfs speculative
preallocation kicking in, and this starts messing with the
file layout that the test expects.

So: Switch the test to use statvfs, and get the true fs
block size.  This will still break for block sizes > 4k,
but for now at least it makes the test work on xfs with
page sizes > 4k using the default mkfs or smaller.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Another option would be to mount xfs with options to
defeat speculative prealloc, or to decrease the 16x
multiplier, but the intent of the test seems to be a 16x
multiple of fs block size, so let's at least start there.

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 18262c2..4042e9b 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -20,7 +20,7 @@
 #define _XOPEN_SOURCE 500
 #define _FILE_OFFSET_BITS 64
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <sys/statvfs.h>
 #include <sys/vfs.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,16 +51,16 @@ static void get_file_system(int fd)
 
 static int get_io_sizes(int fd)
 {
-       struct stat buf;
+       struct statvfs buf;
        int ret;
 
-       ret = fstat(fd, &buf);
+       ret = fstatvfs(fd, &buf);
        if (ret)
                fprintf(stderr, "  ERROR %d: Failed to find io blocksize\n",
                        errno);
 
-       /* st_blksize is typically also the allocation size */
-       alloc_size = buf.st_blksize;
+       /* block size is typically also the allocation size */
+       alloc_size = buf.f_bsize;
        fprintf(stdout, "Allocation size: %ld\n", alloc_size);
 
        return ret;
