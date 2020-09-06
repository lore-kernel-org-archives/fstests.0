Return-Path: <SRS0=Wi2o=CP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C3C43461
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Sep 2020 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEC22078E
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Sep 2020 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B33Ob5Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgIFRzh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:55:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46332 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729092AbgIFRzf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Sep 2020 13:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599414932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTVUFOjmNGPItx0yFc9PQvMYCcQKYhuaxaFrNtS52Ks=;
        b=B33Ob5TcaxHlYpQSDEfL3gl4Hxljna1dENFTYbH2wcZZmOsBcIGtLtZ/Ph/sqzOPA0BV6R
        uBLg++1lzCWB521R1bHzEY/zp7sf1AMQ1HWUUY5px7IMrmz3fn8Fz2tfMvbJYnnX/3fXn6
        wRILQAekSadT3aYSgqjiBYJ7P1XTvg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-43rkGDvJP8irpoLWtEcMjA-1; Sun, 06 Sep 2020 13:55:28 -0400
X-MC-Unique: 43rkGDvJP8irpoLWtEcMjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9097B18A224C;
        Sun,  6 Sep 2020 17:55:27 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-98.pek2.redhat.com [10.72.12.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2DC9CBA;
        Sun,  6 Sep 2020 17:55:25 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     bfoster@redhat.com, io-uring@vger.kernel.org
Subject: [PATCH v4 2/5] fsstress: reduce the number of events when io_setup
Date:   Mon,  7 Sep 2020 01:55:10 +0800
Message-Id: <20200906175513.17595-3-zlang@redhat.com>
In-Reply-To: <20200906175513.17595-1-zlang@redhat.com>
References: <20200906175513.17595-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The original number(128) of aio events for io_setup too big. When try
to run lots of fsstress processes(e.g. -p 1000) always hit io_setup
EAGAIN error, due to the nr_events exceeds the limit of available
events. Due to each fsstress process only does once libaio read/write
operation each time. So reduce the aio events number to 1, to make more
fsstress processes can do AIO test.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 ltp/fsstress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 2c584ef0..b4a51376 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -28,6 +28,7 @@
 #endif
 #ifdef AIO
 #include <libaio.h>
+#define AIO_ENTRIES	1
 io_context_t	io_ctx;
 #endif
 #ifdef URING
@@ -699,8 +700,8 @@ int main(int argc, char **argv)
 			}
 			procid = i;
 #ifdef AIO
-			if (io_setup(128, &io_ctx) != 0) {
-				fprintf(stderr, "io_setup failed");
+			if (io_setup(AIO_ENTRIES, &io_ctx) != 0) {
+				fprintf(stderr, "io_setup failed\n");
 				exit(1);
 			}
 #endif
-- 
2.20.1

