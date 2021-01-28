Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B15AC433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 21:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F228F64DEC
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 21:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhA1VdL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhA1VdK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Jan 2021 16:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611869504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WMwiDMVqm5BzI22Xw1+YLOD64lFvv1e0P77bWIuwqwI=;
        b=JXR3ZIx/wEcNKN1nNVo32XEyE4Pxty0MVrIqO3zxlAn+SBHQRkJyzk2+U1oSKaFRyWM6HL
        hugwLRr09urNIRs/EF9EKPQejonxvy4YN/IHxMNiDQoySlaYOMEmiJ17N6KcdciLvZlltA
        SkIKyukB2+SGgjyb4Q5H/dmAdWQRhzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-jDL219L2OHqChE8v8w3uPg-1; Thu, 28 Jan 2021 16:31:42 -0500
X-MC-Unique: jDL219L2OHqChE8v8w3uPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 476BA9CC03
        for <fstests@vger.kernel.org>; Thu, 28 Jan 2021 21:31:41 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9615B4A4;
        Thu, 28 Jan 2021 21:31:40 +0000 (UTC)
To:     fstests@vger.kernel.org
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] ltp/fsstress: don't fail on io_uring ENOSYS
Cc:     Zorro Lang <zlang@redhat.com>
Message-ID: <7a7b7128-ba62-59e1-552b-3b1fd6b1eb50@redhat.com>
Date:   Thu, 28 Jan 2021 15:31:40 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We might have URING #defined at build time, but be running on a kernel
which does not support it.

For that reason, we should not exit with an error if 
io_uring_queue_init() fails with ENOSYS. We can just note the lack of
support and skip all future io_uring operations.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 22df5e38..73751935 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -35,6 +35,7 @@ io_context_t	io_ctx;
 #include <liburing.h>
 #define URING_ENTRIES	1
 struct io_uring	ring;
+bool have_io_uring;			/* to indicate runtime availability */
 #endif
 #include <sys/syscall.h>
 #include <sys/xattr.h>
@@ -706,9 +707,15 @@ int main(int argc, char **argv)
 			}
 #endif
 #ifdef URING
+			have_io_uring = true;
+			/* If ENOSYS, just ignore uring, other errors are fatal. */
 			if (io_uring_queue_init(URING_ENTRIES, &ring, 0)) {
-				fprintf(stderr, "io_uring_queue_init failed\n");
-				exit(1);
+				if (errno == ENOSYS) {
+					have_io_uring = false;
+				} else {
+					fprintf(stderr, "io_uring_queue_init failed\n");
+					exit(1);
+				}
 			}
 #endif
 			for (i = 0; !loops || (i < loops); i++)
@@ -720,7 +727,8 @@ int main(int argc, char **argv)
 			}
 #endif
 #ifdef URING
-			io_uring_queue_exit(&ring);
+			if (have_io_uring)
+				io_uring_queue_exit(&ring);
 #endif
 			cleanup_flist();
 			free(freq_table);
@@ -2208,6 +2216,9 @@ do_uring_rw(int opno, long r, int flags)
 	struct iovec	iovec;
 	int		iswrite = (flags & (O_WRONLY | O_RDWR)) ? 1 : 0;
 
+	if (!have_io_uring)
+		return;
+
 	init_pathname(&f);
 	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
 		if (v)

