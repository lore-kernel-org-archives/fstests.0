Received: from mail.cn.fujitsu.com ([183.91.158.132]:22588 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752801AbdKUHKr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Nov 2017 02:10:47 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 450EA487F164
        for <fstests@vger.kernel.org>; Tue, 21 Nov 2017 15:10:42 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/465: just check the actual read data under dio read/write
Date: Tue, 21 Nov 2017 15:10:40 +0800
Message-ID: <1511248240-15172-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

I got the following message when running generic/465 on RHEL7.4
---------------------------------------------------------------
QA output created by 465
non-aio dio test
encounter an error: block 43 offset 0, content 0
encounter an error: block 0 offset 4096, content 62
encounter an error: block 1 offset 0, content 0
encounter an error: block 17 offset 0, content 0
aio-dio test
encounter an error: block 9 offset 0, content 0
encounter an error: block 2 offset 0, content 0
encounter an error: block 0 offset 4096, content 62
encounter an error: block 12 offset 0, content 0
---------------------------------------------------------------

It is possible that dio read reads less than 1M data while dio write
is writing 1M data into file, because concurrent dio read/write to the
same file cannot guarantee atomicity and may split specified size.
Please see this URL for detailed explanation:
https://marc.info/?l=linux-fsdevel&m=151053542926457&w=2

We can just check the actual read data instead of the whole read buffer.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/aio-dio-regress/aio-dio-append-write-read-race.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
index 8f94d50..848755c 100644
--- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
+++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
@@ -46,6 +46,7 @@ struct io_data {
 };
 
 int reader_ready = 0;
+static volatile int act_rd_sz;
 
 static void usage(const char *prog)
 {
@@ -57,15 +58,15 @@ static void usage(const char *prog)
 static void *reader(void *arg)
 {
 	struct io_data *data = (struct io_data *)arg;
-	int ret;
 
+	act_rd_sz = 0;
 	memset(data->buf, 'b', data->blksize);
 	reader_ready = 1;
 	do {
-		ret = pread(data->fd, data->buf, data->blksize, data->offset);
-		if (ret < 0)
+		act_rd_sz = pread(data->fd, data->buf, data->blksize, data->offset);
+		if (act_rd_sz < 0)
 			perror("read file");
-	} while (ret <= 0);
+	} while (act_rd_sz <= 0);
 
 	return NULL;
 }
@@ -203,7 +204,7 @@ int main(int argc, char *argv[])
 			goto err;
 		}
 
-		for (j = 0; j < blksize; j++) {
+		for (j = 0; j < act_rd_sz; j++) {
 			if (rdata.buf[j] != 'a') {
 				fail("encounter an error: "
 					"block %d offset %d, content %x\n",
-- 
1.8.3.1



