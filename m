Return-Path: <SRS0=C4aD=EO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A01CC5517A
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DDF206ED
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bne5OUTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKHM0k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Nov 2020 07:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgKHM0k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Nov 2020 07:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604838398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1hwf1JxJoAI9E+A6q57cvY5ODrs5/Txh3u3tM7Co3c=;
        b=Bne5OUTpOHlXh7aN10eofcZITU/k+QuS3YCh0JtQzNL945ncewHXOtCrEF6WS+/svyS44v
        CvA0Hih9gmimqYks328DHUAFuXbUCXOsXnYb6hRkHKUhMjYto6C4jngRtK3jQP/QSaSRpb
        0p2XvlJdLTYHilh1EvaJVhdR2YgNsVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-CQ3sECxnMcuYx_5zKBG4Hg-1; Sun, 08 Nov 2020 07:26:36 -0500
X-MC-Unique: CQ3sECxnMcuYx_5zKBG4Hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5BBF56BE3
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:35 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C835B4B5
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:34 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/3] src/feature: add IO_URING feature checking
Date:   Sun,  8 Nov 2020 20:26:21 +0800
Message-Id: <20201108122623.12980-2-zlang@redhat.com>
In-Reply-To: <20201108122623.12980-1-zlang@redhat.com>
References: <20201108122623.12980-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

IO_URING is a new feature for GNU/Linux system, if someone case of
xfstests tests this feature, better to check if current system
supports it, or need _notrun.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 src/Makefile  |  4 ++++
 src/feature.c | 41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 643c1916..f1422c5c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -65,6 +65,10 @@ SUBDIRS += aio-dio-regress
 LLDLIBS += -laio
 endif
 
+ifeq ($(HAVE_URING), true)
+LLDLIBS += -luring
+endif
+
 CFILES = $(TARGETS:=.c)
 LDIRT = $(TARGETS) fssum
 
diff --git a/src/feature.c b/src/feature.c
index a7eb7595..df550cf6 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -19,6 +19,7 @@
  *
  * Test for machine features
  *   -A  test whether AIO syscalls are available
+ *   -R  test whether IO_URING syscalls are available
  *   -o  report a number of online cpus
  *   -s  report pagesize
  *   -w  report bits per long
@@ -39,6 +40,10 @@
 #include <libaio.h>
 #endif
 
+#ifdef HAVE_LIBURING_H
+#include <liburing.h>
+#endif
+
 #ifndef USRQUOTA
 #define USRQUOTA  0
 #endif
@@ -59,7 +64,7 @@ usage(void)
 	fprintf(stderr, "Usage: feature [-v] -<q|u|g|p|U|G|P> <filesystem>\n");
 	fprintf(stderr, "       feature [-v] -c <file>\n");
 	fprintf(stderr, "       feature [-v] -t <file>\n");
-	fprintf(stderr, "       feature -A | -o | -s | -w\n");
+	fprintf(stderr, "       feature -A | -R | -o | -s | -w\n");
 	exit(1);
 }
 
@@ -215,6 +220,29 @@ check_aio_support(void)
 #endif
 }
 
+static int
+check_uring_support(void)
+{
+#ifdef HAVE_LIBURING_H
+	struct io_uring ring;
+	int err;
+
+	err = io_uring_queue_init(1, &ring, 0);
+	if (err == 0)
+		return 0;
+
+	if (err == -ENOSYS) /* CONFIG_IO_URING=n */
+		return 1;
+
+	fprintf(stderr, "unexpected error from io_uring_queue_init(): %s\n",
+		strerror(-err));
+	return 2;
+#else
+	/* liburing is unavailable, assume IO_URING is unsupported */
+	return 1;
+#endif
+}
+
 
 int
 main(int argc, char **argv)
@@ -228,6 +256,7 @@ main(int argc, char **argv)
 	int	pflag = 0;
 	int	Pflag = 0;
 	int	qflag = 0;
+	int	Rflag = 0;
 	int	sflag = 0;
 	int	uflag = 0;
 	int	Uflag = 0;
@@ -235,7 +264,7 @@ main(int argc, char **argv)
 	int	oflag = 0;
 	char	*fs = NULL;
 
-	while ((c = getopt(argc, argv, "ActgGopPqsuUvw")) != EOF) {
+	while ((c = getopt(argc, argv, "ActgGopPqRsuUvw")) != EOF) {
 		switch (c) {
 		case 'A':
 			Aflag++;
@@ -264,6 +293,9 @@ main(int argc, char **argv)
 		case 'q':
 			qflag++;
 			break;
+		case 'R':
+			Rflag++;
+			break;
 		case 's':
 			sflag++;
 			break;
@@ -289,7 +321,7 @@ main(int argc, char **argv)
 		if (optind != argc-1)	/* need a device */
 			usage();
 		fs = argv[argc-1];
-	} else if (Aflag || wflag || sflag || oflag) {
+	} else if (Aflag || Rflag || wflag || sflag || oflag) {
 		if (optind != argc)
 			usage();
 	} else 
@@ -317,6 +349,9 @@ main(int argc, char **argv)
 	if (Aflag)
 		return(check_aio_support());
 
+	if (Rflag)
+		return(check_uring_support());
+
 	if (sflag) {
 		printf("%d\n", getpagesize());
 		exit(0);
-- 
2.25.4

