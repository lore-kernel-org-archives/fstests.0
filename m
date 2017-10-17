Received: from szxga05-in.huawei.com ([45.249.212.191]:8496 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbdJQDPi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2017 23:15:38 -0400
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH] log-writes: fix possible infinite loop in zero_range()
Date: Tue, 17 Oct 2017 11:20:45 +0800
Message-ID: <1508210445-27135-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Found it when trying to remove the limitation of log->max_zero_size.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 src/log-writes/log-writes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
index fab447a..0939157 100644
--- a/src/log-writes/log-writes.c
+++ b/src/log-writes/log-writes.c
@@ -65,6 +65,9 @@ static int zero_range(struct log *log, u64 start, u64 len)
 
 	memset(buf, 0, bufsize);
 	while (len) {
+		if (len < bufsize)
+			bufsize = len;
+
 		ret = pwrite(log->replayfd, buf, bufsize, start);
 		if (ret != bufsize) {
 			fprintf(stderr, "Error zeroing file: %d\n", errno);
-- 
2.5.0

