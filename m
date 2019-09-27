Return-Path: <SRS0=31Kr=XW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B9FC4360C
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5D8206B7
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfI0B4b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:56:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47687 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726145AbfI0B4b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:56:31 -0400
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="76089014"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Sep 2019 09:56:30 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 8BCD14CE14F7;
        Fri, 27 Sep 2019 09:56:29 +0800 (CST)
Received: from localhost.localdomain (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 27 Sep 2019 09:56:32 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH v2] fsx: add more check for copy_file_range
Date:   Fri, 27 Sep 2019 09:53:54 +0800
Message-ID: <1569549234-13096-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 8BCD14CE14F7.A1522
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org
Message-ID: <20190927015354.AVx1fDTytjssYlmnD-nAAjv44R_nEuSc080WVj7DDNk@z>

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



