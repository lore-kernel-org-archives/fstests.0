Received: from mail.cn.fujitsu.com ([183.91.158.132]:47687 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726145AbfI0B4b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:56:31 -0400
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH v2] fsx: add more check for copy_file_range
Date: Fri, 27 Sep 2019 09:53:54 +0800
Message-ID: <1569549234-13096-1-git-send-email-suyj.fnst@cn.fujitsu.com>
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

Also add check for do_clone_range following Eryu's advice.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
v2:
- Use check_buffers instead memcmp code
- Add check for do_clone_range
- Fix return unique error number for the check code
---
 ltp/fsx.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4..714bebc 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1378,6 +1378,7 @@ test_clone_range(void)
 void
 do_clone_range(unsigned offset, unsigned length, unsigned dest)
 {
+	int ret = 0;
 	struct file_clone_range	fcr = {
 		.src_fd = fd,
 		.src_offset = offset,
@@ -1429,6 +1430,23 @@ do_clone_range(unsigned offset, unsigned length, unsigned dest)
 		memset(good_buf + file_size, '\0', dest - file_size);
 	if (dest + length > file_size)
 		file_size = dest + length;
+
+	ret = lseek(fd, (off_t)dest, SEEK_SET);
+	if (ret == (off_t)-1) {
+		prterr("do_clone_range: lseek");
+		report_failure(162);
+	}
+	ret = fsxread(fd, temp_buf, length, dest);
+	if (ret != length) {
+		if (ret == -1)
+			prterr("do_clone_range: read");
+		else
+			prt("short read: 0x%x bytes instead of 0x%x\n",
+				ret, length);
+		report_failure(163);
+	}
+	check_buffers(temp_buf, dest, length);
+
 }
 
 #else
@@ -1602,6 +1620,7 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
 	size_t olen;
 	ssize_t nr;
 	int tries = 0;
+	int ret = 0;
 
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
@@ -1665,6 +1684,22 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
 		memset(good_buf + file_size, '\0', dest - file_size);
 	if (dest + length > file_size)
 		file_size = dest + length;
+
+	ret = lseek(fd, (off_t)dest, SEEK_SET);
+	if (ret == (off_t)-1) {
+		prterr("do_copy_range: lseek");
+		report_failure(162);
+	}
+	ret = fsxread(fd, temp_buf, length, dest);
+	if (ret != length) {
+		if (ret == -1)
+			prterr("do_copy_range: read");
+		else
+			prt("short read: 0x%x bytes instead of 0x%x\n",
+				ret, length);
+		report_failure(163);
+	}
+	check_buffers(temp_buf, dest, length);
 }
 
 #else
-- 
2.7.4
