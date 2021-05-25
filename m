Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C29C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5596140F
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhEYNhF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233184AbhEYNgz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxwlSGmCSrWeQ2GpVh6u/1cYyhZJFKSKkGb/Kj2uty0=;
        b=THQBBqsl5Y37BZpdviC+JAlIxAAggLM1ulf9rDIO8oXUAuXaJq3JvPX5OsaH2P+hG533T3
        gPgE4MFRyuG1ccXrKY1GFSIeM2gxSGByBdckwbSZwWLVAQefJr2JqJvFsAZVUnMsU5JLCl
        IQ36k5BdKdqY37cc8ojVvNhIQ2Mc29A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-LOT3TpPXPOSu49_ke0-rRQ-1; Tue, 25 May 2021 09:35:23 -0400
X-MC-Unique: LOT3TpPXPOSu49_ke0-rRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D1510AFAC0;
        Tue, 25 May 2021 13:34:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 690196060F;
        Tue, 25 May 2021 13:34:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 8/9] generic/465: Fix handling of DIO alignment < sizeof(long)
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:42 +0100
Message-ID: <162194968267.4011860.3593730881184557924.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

generic/465 will fail if the minimun DIO alignment is less than the minimum
size permitted by the posix_memalign() syscall calls made in
aio-dio-append-write-read-race.  AFS has a DIO alignment of 1.

Fix this by setting the minimum alignment to sizeof(long).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 .../aio-dio-append-write-read-race.c               |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
index 911f2723..8268fb4e 100644
--- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
+++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
@@ -110,7 +110,7 @@ int main(int argc, char *argv[])
 	int i, j, c;
 	int use_aio = 1;
 	int ret = 0;
-	int io_align = 4096;
+	int io_align = 4096, mem_align;
 	char *prog;
 	char *testfile;
 
@@ -146,14 +146,15 @@ int main(int argc, char *argv[])
 		goto err;
 	}
 
-	ret = posix_memalign((void **)&wbuf, io_align, blksize);
+	mem_align = (io_align >= sizeof(long) ? io_align : sizeof(long));
+	ret = posix_memalign((void **)&wbuf, mem_align, blksize);
 	if (ret) {
 		fail("failed to alloc memory: %s\n", strerror(ret));
 		ret = 1;
 		goto err;
 	}
 
-	ret = posix_memalign((void **)&rbuf, io_align, blksize);
+	ret = posix_memalign((void **)&rbuf, mem_align, blksize);
 	if (ret) {
 		fail("failed to alloc memory: %s\n", strerror(ret));
 		ret = 1;


