Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E5C433E2
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 07:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F253B2075A
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 07:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9+f5XEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIKHQ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgIKHQ1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 03:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599808585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlhIGoXNfcqDJQ1A41DuftfwPhAVONhJpSYSNuyAfD4=;
        b=a9+f5XENzZXxeGkZDfmsMzV5t1Kxz7twW9TMXasX10iJUcq/63UEohkeIxFJRA5PhRVm63
        yAWZhwEPRnsHlu9vd99oUJkVbAORSu+vjwbRB+IAMF00HwR/mol3cNtSTP+ZZrHTaZ9Lpv
        Rk6zT2rBj5A78gVvY8+++8BetoXq00U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-xWGW3BUBNuGMzqCs4jUE-Q-1; Fri, 11 Sep 2020 03:16:24 -0400
X-MC-Unique: xWGW3BUBNuGMzqCs4jUE-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FABB64082
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 07:16:23 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D4E21001281
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 07:16:21 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 5/5] fsx: add IO_URING test
Date:   Fri, 11 Sep 2020 15:15:55 +0800
Message-Id: <20200911071555.31506-6-zlang@redhat.com>
In-Reply-To: <20200911071555.31506-1-zlang@redhat.com>
References: <20200911071555.31506-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

New IO_URING test for fsx, use -U option to enable IO_URING test.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 3 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 92f506ba..0abd7de1 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -34,6 +34,9 @@
 #ifdef AIO
 #include <libaio.h>
 #endif
+#ifdef URING
+#include <liburing.h>
+#endif
 #include <sys/syscall.h>
 
 #ifndef MAP_FILE
@@ -176,6 +179,7 @@ int	integrity = 0;			/* -i flag */
 int	fsxgoodfd = 0;
 int	o_direct;			/* -Z */
 int	aio = 0;
+int	uring = 0;
 int	mark_nr = 0;
 
 int page_size;
@@ -2237,7 +2241,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -2260,8 +2264,11 @@ usage(void)
 	-y synchronize changes to a file\n"
 
 #ifdef AIO
-"	-A: Use the AIO system calls\n"
+"	-A: Use the AIO system calls, -A excludes -U\n"
 #endif
+#ifdef URING
+"	-U: Use the IO_URING system calls, -U excludes -A\n"
+ #endif
 "	-D startingop: debug output starting at specified operation\n"
 #ifdef HAVE_LINUX_FALLOC_H
 "	-F: Do not use fallocate (preallocation) calls\n"
@@ -2429,6 +2436,112 @@ aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 }
 #endif
 
+#ifdef URING
+
+struct io_uring ring;
+#define URING_ENTRIES	1024
+
+int
+uring_setup()
+{
+	int ret;
+
+	ret = io_uring_queue_init(URING_ENTRIES, &ring, 0);
+	if (ret != 0) {
+		fprintf(stderr, "uring_setup: io_uring_queue_init failed: %s\n",
+				strerror(ret));
+		return -1;
+	}
+	return 0;
+}
+
+int
+uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+{
+	struct io_uring_sqe     *sqe;
+	struct io_uring_cqe     *cqe;
+	struct iovec            iovec;
+	int ret;
+	int res = 0;
+	char *p = buf;
+	unsigned l = len;
+	unsigned o = offset;
+
+	/*
+	 * Due to io_uring tries non-blocking IOs (especially read), that
+	 * always cause 'normal' short reading. To avoid this short read
+	 * fail, try to loop read/write (escpecilly read) data.
+	 */
+	while (l > 0) {
+		sqe = io_uring_get_sqe(&ring);
+		if (!sqe) {
+			fprintf(stderr, "uring_rw: io_uring_get_sqe failed: %s\n",
+					strerror(errno));
+			return -1;
+		}
+
+		iovec.iov_base = p;
+		iovec.iov_len = l;
+		if (rw == READ) {
+			io_uring_prep_readv(sqe, fd, &iovec, 1, o);
+		} else {
+			io_uring_prep_writev(sqe, fd, &iovec, 1, o);
+		}
+
+		ret = io_uring_submit_and_wait(&ring, 1);
+		if (ret != 1) {
+			fprintf(stderr, "errcode=%d\n", -ret);
+			fprintf(stderr, "uring %s: io_uring_submit failed: %s\n",
+					rw == READ ? "read":"write", strerror(-ret));
+			goto uring_error;
+		}
+
+		ret = io_uring_wait_cqe(&ring, &cqe);
+		if (ret != 0) {
+			fprintf(stderr, "errcode=%d\n", -ret);
+			fprintf(stderr, "uring %s: io_uring_wait_cqe failed: %s\n",
+					rw == READ ? "read":"write", strerror(-ret));
+			goto uring_error;
+		}
+
+		ret = cqe->res;
+		io_uring_cqe_seen(&ring, cqe);
+
+		if (ret > 0) {
+			o += ret;
+			l -= ret;
+			p += ret;
+			res += ret;
+		} else if (ret < 0) {
+			fprintf(stderr, "errcode=%d\n", -ret);
+			fprintf(stderr, "uring %s: io_uring failed: %s\n",
+					rw == READ ? "read":"write", strerror(-ret));
+			goto uring_error;
+		} else {
+			fprintf(stderr, "uring %s bad io length: %d instead of %u\n",
+					rw == READ ? "read":"write", res, len);
+			break;
+		}
+	}
+	return res;
+
+ uring_error:
+	/*
+	 * The caller expects error return in traditional libc
+	 * convention, i.e. -1 and the errno set to error.
+	 */
+	errno = -ret;
+	return -1;
+}
+#else
+int
+uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+{
+	fprintf(stderr, "io_rw: need IO_URING support!\n");
+	exit(111);
+}
+#endif
+
 int
 fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 {
@@ -2436,6 +2549,8 @@ fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 
 	if (aio) {
 		ret = aio_rw(rw, fd, buf, len, offset);
+	} else if (uring) {
+		ret = uring_rw(rw, fd, buf, len, offset);
 	} else {
 		if (rw == READ)
 			ret = read(fd, buf, len);
@@ -2498,7 +2613,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
+				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2606,6 +2721,9 @@ main(int argc, char **argv)
 		case 'A':
 			aio = 1;
 			break;
+		case 'U':
+			uring = 1;
+			break;
 		case 'D':
 			debugstart = getnum(optarg, &endp);
 			if (debugstart < 1)
@@ -2696,6 +2814,11 @@ main(int argc, char **argv)
 	if (argc != 1)
 		usage();
 
+	if (aio && uring) {
+		fprintf(stderr, "-A and -U shouldn't be used together\n");
+		usage();
+	}
+
 	if (integrity && !dirpath) {
 		fprintf(stderr, "option -i <logdev> requires -P <dirpath>\n");
 		usage();
@@ -2786,6 +2909,10 @@ main(int argc, char **argv)
 	if (aio) 
 		aio_setup();
 #endif
+#ifdef URING
+	if (uring)
+		uring_setup();
+#endif
 
 	if (!(o_flags & O_TRUNC)) {
 		off_t ret;
-- 
2.20.1

