Received: from mail.cn.fujitsu.com ([183.91.158.132]:20251 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbfAJDPK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Jan 2019 22:15:10 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 280EB4BAC833
        for <fstests@vger.kernel.org>; Thu, 10 Jan 2019 11:15:04 +0800 (CST)
From: Cui Yue <cuiyue-fnst@cn.fujitsu.com>
Subject: [PATCH] generic/423: statx mask of the reference file is different from the original file
Date: Wed, 9 Jan 2019 22:14:59 -0500
Message-ID: <1547090099-8394-1-git-send-email-cuiyue-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Cui Yue <cuiyue-fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

When running xfstests generic/423 to test system call statx() on hard link files of NFS, it fails.
error message:
[!] attr 'stx_mask' differs from ref file, 7ff != e0

The values of parameter "mask" between the original file and the reference file are different.
One is STATX_ALL;
The other is STATX_ATIME | STATX_BTIME | STATX_CTIME | STATX_MTIME.

Modify the function get_reference() to pass the "mask" in,
and change STATX_ATIME | STATX_BTIME | STATX_CTIME | STATX_MTIME to "mask".
---
 src/stat_test.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/stat_test.c b/src/stat_test.c
index 94c20d6..95cfdc4 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -290,7 +290,7 @@ static void set_origin_timestamp(const char *arg)
 /*
  * Get reference stats from a file.
  */
-static void get_reference(const char *file)
+static void get_reference(const char *file, unsigned int mask)
 {
 	int ret;
 
@@ -298,9 +298,7 @@ static void get_reference(const char *file)
 		bad_arg("ref= requires a filename\n");
 
 	memset(&ref, 0xfb, sizeof(ref));
-	ret = xfstests_statx(AT_FDCWD, file, AT_SYMLINK_NOFOLLOW,
-			     STATX_ATIME | STATX_BTIME | STATX_CTIME | STATX_MTIME,
-			     &ref);
+	ret = xfstests_statx(AT_FDCWD, file, AT_SYMLINK_NOFOLLOW, mask, &ref);
 	switch (ret) {
 	case 0:
 		ref_set = true;
@@ -751,7 +749,7 @@ int main(int argc, char **argv)
 
 		if (strncmp("ref=", arg, 4) == 0) {
 			/* ref=<file> - set reference stats from file */
-			get_reference(arg + 4);
+			get_reference(arg + 4, mask);
 			continue;
 		}
 
-- 
1.8.3.1
