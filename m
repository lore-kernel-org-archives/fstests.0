Received: from mail.cn.fujitsu.com ([183.91.158.132]:33264 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726542AbeHHHyb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Aug 2018 03:54:31 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 51B274B6ADFF
        for <fstests@vger.kernel.org>; Wed,  8 Aug 2018 13:36:28 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] src/aiocp.c: Fix buffer alignment
Date: Thu, 9 Aug 2018 12:57:07 +0800
Message-ID: <1533790627-7733-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

In generic/252, aiocp with DIRECT will fail and return EINVAL on
4096 sector size block device, because the default 512 alignment
defined in aiocp is not aligned with 4096.

Please see the following error:
----------------------------------------------------------
read missing bytes expect 8388608 got -22
----------------------------------------------------------

aiocp with DIRECT should set a proper alignment if -a option is not
specified.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/aio-dio-regress/aiocp.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/aio-dio-regress/aiocp.c b/src/aio-dio-regress/aiocp.c
index 7e71cc5..57e9d35 100644
--- a/src/aio-dio-regress/aiocp.c
+++ b/src/aio-dio-regress/aiocp.c
@@ -40,6 +40,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/select.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
 
 #include <libaio.h>
 
@@ -69,6 +71,28 @@ int alignment = 512;		/* buffer alignment */
 
 struct timeval delay;		/* delay between i/o */
 
+static int get_sector_size(void)
+{
+	int fd, ret;
+	int sector_size;
+	char *name;
+
+	name = getenv("TEST_DEV");
+	if (!name)
+		return alignment;
+
+	fd = open(name, O_RDONLY);
+	if (fd < 0)
+		return alignment;
+
+	ret = ioctl(fd, BLKSSZGET, &sector_size);
+	close(fd);
+	if (ret < 0)
+		return alignment;
+
+	return sector_size;
+}
+
 int init_iocb(int n, int iosize)
 {
 	void *buf;
@@ -259,6 +283,7 @@ int main(int argc, char *const *argv)
 	int c;
 	extern char *optarg;
 	extern int optind, opterr, optopt;
+	int aligned = 0;
 
 	while ((c = getopt(argc, argv, "a:b:df:n:s:wzD:")) != -1) {
 		char *endp;
@@ -268,6 +293,7 @@ int main(int argc, char *const *argv)
 			alignment = strtol(optarg, &endp, 0);
 			alignment = (long)scale_by_kmg((long long)alignment,
 							*endp);
+			aligned = 1;
 			break;
 		case 'f':	/* use these open flags */
 			if (strcmp(optarg, "LARGEFILE") == 0 ||
@@ -334,6 +360,10 @@ int main(int argc, char *const *argv)
     srcname = "junkdata";
     dstname = "ff2";
 #endif
+
+	if (!aligned && (source_open_flag & O_DIRECT))
+		alignment = get_sector_size();
+
 	if (!zero) {
 #ifndef DEBUG
 	       	if ((srcfd = open(srcname = *argv, source_open_flag)) < 0) {
-- 
1.8.3.1



