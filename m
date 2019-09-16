Received: from mail.cn.fujitsu.com ([183.91.158.132]:50342 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbfIPF1K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Sep 2019 01:27:10 -0400
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/465: fix a read bug when encounter EOF
Date: Mon, 16 Sep 2019 13:24:26 +0800
Message-ID: <1568611466-100970-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, suyj.fnst@cn.fujitsu.com
List-ID: <fstests@vger.kernel.org>

In nfs test, if the writer has not written enough data for reader reading,
then reader only get partial data and test fails.

We can continue reading until read enough data.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 src/aio-dio-regress/aio-dio-append-write-read-race.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
index 911f272..f28ef3c 100644
--- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
+++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
@@ -44,14 +44,27 @@ static void usage(const char *prog)
 static void *reader(void *arg)
 {
 	struct io_data *data = (struct io_data *)arg;
+	size_t blksize = data->blksize;
+	size_t offset = data->offset;
+	char   *buf = data->buf;
 
 	memset(data->buf, 'b', data->blksize);
 	reader_ready = 1;
 	do {
-		data->read_sz = pread(data->fd, data->buf, data->blksize,
-				      data->offset);
+		data->read_sz = pread(data->fd, buf, blksize,
+				      offset);
 		if (data->read_sz < 0)
 			perror("read file");
+
+		if (data->read_sz > 0) {
+			blksize -= data->read_sz;
+			offset  += data->read_sz;
+			buf	+= data->read_sz;
+			data->read_sz = 0;
+		}
+
+		if (blksize <= 0)
+			break;
 	} while (data->read_sz <= 0);
 
 	return NULL;
-- 
2.7.4
