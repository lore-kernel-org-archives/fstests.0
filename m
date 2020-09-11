Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A8C2BC11
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 07:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF7D22206
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 07:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EovliEpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgIKHQ0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:16:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21556 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgIKHQY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 03:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599808582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rt6Kn4ld0tHdCI5yNqBMzjXzNbrsGJujxH5HRp8yV0A=;
        b=EovliEpGy41RUYtzewKibfeWzi+qKtpgNW2/Y4SUOPOEflvhFMZWCYjE5sp90UhY/tyB0C
        mAIfBJw7fbyC4HOEtmJ49Taxlw7qZiT5yr3oU1PIgP2Gt5GnFrZ4CfDp/YyQ8vF0UlgmG9
        /O7DpJB2l+jU+hydEShj1cTbXsmOiHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-i459qmqwOyup7wHYYU1DXw-1; Fri, 11 Sep 2020 03:16:20 -0400
X-MC-Unique: i459qmqwOyup7wHYYU1DXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BD8781F00B
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 07:16:19 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAE6C1001281
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 07:16:18 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 4/5] fsx: introduce fsx_rw to combine aio_rw with general read and write
Date:   Fri, 11 Sep 2020 15:15:54 +0800
Message-Id: <20200911071555.31506-5-zlang@redhat.com>
In-Reply-To: <20200911071555.31506-1-zlang@redhat.com>
References: <20200911071555.31506-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The fsx contains different read and write operations, especially the
AIO and general IO read/write. The fsx chooses one kind of read/write
from AIO and general IO to run. To make the logic clear, use a common
fsx_rw() function to swith between these two kinds of read/write.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 7c76655a..92f506ba 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -181,16 +181,11 @@ int	mark_nr = 0;
 int page_size;
 int page_mask;
 int mmap_mask;
-#ifdef AIO
-int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
+int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
 #define READ 0
 #define WRITE 1
-#define fsxread(a,b,c,d)	aio_rw(READ, a,b,c,d)
-#define fsxwrite(a,b,c,d)	aio_rw(WRITE, a,b,c,d)
-#else
-#define fsxread(a,b,c,d)	read(a,b,c)
-#define fsxwrite(a,b,c,d)	write(a,b,c)
-#endif
+#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
+#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
 
 const char *replayops = NULL;
 const char *recordops = NULL;
@@ -2347,7 +2342,8 @@ getnum(char *s, char **e)
 io_context_t	io_ctx;
 struct iocb 	iocb;
 
-int aio_setup()
+int
+aio_setup()
 {
 	int ret;
 	ret = io_queue_init(QSZ, &io_ctx);
@@ -2360,7 +2356,7 @@ int aio_setup()
 }
 
 int
-__aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 {
 	struct io_event event;
 	static struct timespec ts;
@@ -2425,13 +2421,21 @@ out_error:
 	errno = -ret;
 	return -1;
 }
+#else
+aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+{
+	fprintf(stderr, "io_rw: need AIO support!\n");
+	exit(111);
+}
+#endif
 
-int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+int
+fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 {
 	int ret;
 
 	if (aio) {
-		ret = __aio_rw(rw, fd, buf, len, offset);
+		ret = aio_rw(rw, fd, buf, len, offset);
 	} else {
 		if (rw == READ)
 			ret = read(fd, buf, len);
@@ -2441,8 +2445,6 @@ int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 	return ret;
 }
 
-#endif
-
 #define test_fallocate(mode) __test_fallocate(mode, #mode)
 
 int
@@ -2602,7 +2604,7 @@ main(int argc, char **argv)
 			do_fsync = 1;
 			break;
 		case 'A':
-		        aio = 1;
+			aio = 1;
 			break;
 		case 'D':
 			debugstart = getnum(optarg, &endp);
-- 
2.20.1

