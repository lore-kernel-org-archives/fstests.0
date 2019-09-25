Received: from mail.cn.fujitsu.com ([183.91.158.132]:37792 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390825AbfIYHTq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 03:19:46 -0400
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH] fsx: add more check for copy_file_range
Date: Wed, 25 Sep 2019 15:16:55 +0800
Message-ID: <1569395815-4657-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, suyj.fnst@cn.fujitsu.com
List-ID: <fstests@vger.kernel.org>

On some linux distros(RHEL7, centos 7) copy_file_range uses
general implementation (splice interface). splice interace
uses pipe_to_file. pipe_to_file only work for different page.
The userspace cant's be  aware of such error because copy_file_range
returns ok too.
So for such case when copy_file_range return we read back data
then check it.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 ltp/fsx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4..0439430 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1602,6 +1602,7 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
 	size_t olen;
 	ssize_t nr;
 	int tries = 0;
+	int ret = 0;
 
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
@@ -1665,6 +1666,37 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
 		memset(good_buf + file_size, '\0', dest - file_size);
 	if (dest + length > file_size)
 		file_size = dest + length;
+	/*
+	 * Although copy_file_range returns ok 
+	 * for some linux distros that use general implementation 
+	 * (splice interface) such as RHEL 7, centos 7 that use 
+	 * pipe_to_file will cause test fail.
+	 *
+	 * Here we add a little more check here for copy_file_range
+	 * We read copied data then check it. If check fail here 
+	 * then report it.
+	 */
+	ret = lseek(fd, (off_t)dest, SEEK_SET);
+	if (ret == (off_t)-1) {
+		prterr("doread: lseek");
+		report_failure(140);
+	}
+	ret = fsxread(fd, temp_buf, length, dest);
+	if (ret != length) {
+		if (ret == -1)
+				prterr("doread: read");
+		else
+				prt("short read: 0x%x bytes instead of 0x%x\n",
+					ret, length);
+		report_failure(141);
+	}
+	if (memcmp(good_buf+dest, temp_buf, length) != 0) {
+		prt("copy range: 0x%x to 0x%x at 0x%x\n", offset,
+				offset + length, dest);
+		prterr("do_copy_range:");
+		report_failure(161);
+
+	}
 }
 
 #else
-- 
2.7.4
