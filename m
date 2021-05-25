Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BC0C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B97C6108D
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 13:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhEYNhJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 09:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233351AbhEYNhG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 09:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621949735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OZkafoH8eLa3Y42DKNphTIE7IUlTjFIQb5ah3cbvjA=;
        b=UcIMRQsZiHjWY7Qg9GgSAxeI9ARa7LiCc+PAuNzc2anBu7yIXXF3KVCBIuM3S7+SjMtrkH
        AQR1uAvCrmyE1jSGYA/EBtCoTKPAYkLh5Wr4jVE2aC5SA0YkuqbQcFJ+E3Q95Q/BtnhVxU
        L1YAerCa9iaXS3Pj6QNTOZ7GNZmdTj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-tzWezfxaML2teqFgHvmZ2A-1; Tue, 25 May 2021 09:35:32 -0400
X-MC-Unique: tzWezfxaML2teqFgHvmZ2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A526B100A86A;
        Tue, 25 May 2021 13:34:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 082EC5D9C0;
        Tue, 25 May 2021 13:34:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 9/9] Fix other posix_memalign() alignment issues
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org
Date:   Tue, 25 May 2021 14:34:49 +0100
Message-ID: <162194968922.4011860.12953203511925579729.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fix the passing of an alignment that's less than sizeof(long) to
posix_memalign() in some other places by making sure the minimum is used
(AFS has a DIO alignment of 1).

Note that I haven't altered randholes.c as that has an explicit check for a
small alignment and gives an error in such a case.  Possibly this should
just round it up to sizeof(long) instead.

Another alternative is that rather than using posix_memalign() is to
allocate a buffer big enough that the base pointer we're going to actually
use can be cranked forward to the appropriate alignment.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 src/aio-dio-regress/aiocp.c          |    2 ++
 src/aio-dio-regress/aiodio_sparse2.c |    3 ++-
 src/dio-interleaved.c                |    5 ++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/aio-dio-regress/aiocp.c b/src/aio-dio-regress/aiocp.c
index 7e71cc5c..880c49d2 100644
--- a/src/aio-dio-regress/aiocp.c
+++ b/src/aio-dio-regress/aiocp.c
@@ -81,6 +81,8 @@ int init_iocb(int n, int iosize)
 	for (i = 0; i < n; i++) {
 		if (!(iocb_free[i] = (struct iocb *) malloc(sizeof(struct iocb))))
 			return -1;
+		if (alignment < sizeof(long))
+			alignment = sizeof(long);
 		if (posix_memalign(&buf, alignment, iosize))
 			return -1;
 		if (debug > 1) {
diff --git a/src/aio-dio-regress/aiodio_sparse2.c b/src/aio-dio-regress/aiodio_sparse2.c
index 51ede5bb..57350e22 100644
--- a/src/aio-dio-regress/aiodio_sparse2.c
+++ b/src/aio-dio-regress/aiodio_sparse2.c
@@ -115,9 +115,10 @@ void aiodio_sparse(char *filename, int align, int writesize, int startoffset, in
 	 */
 	offset = startoffset;
 	for (i = 0; i < num_aio; i++) {
+		unsigned int mem_align = (align >= sizeof(long) ? align : sizeof(long));
 		void *bufptr;
 
-		w = posix_memalign(&bufptr, align, writesize);
+		w = posix_memalign(&bufptr, mem_align, writesize);
 		if (w) {
 			fprintf(stderr, "cannot malloc aligned memory: %s\n",
 				strerror(w));
diff --git a/src/dio-interleaved.c b/src/dio-interleaved.c
index 6b04c993..0fa74d3e 100644
--- a/src/dio-interleaved.c
+++ b/src/dio-interleaved.c
@@ -24,11 +24,14 @@ struct dio_thread_data {
 static void *dio_thread(void *arg)
 {
 	struct dio_thread_data *data = arg;
+	unsigned long mem_align;
 	off_t off;
 	ssize_t ret;
 	void *buf;
 
-	if ((errno = posix_memalign(&buf, extent_size / 2, extent_size / 2))) {
+	mem_align = extent_size / 2;
+	mem_align = (mem_align >= sizeof(long) ? mem_align : sizeof(long));
+	if ((errno = posix_memalign(&buf, mem_align, extent_size / 2))) {
 		perror("malloc");
 		return NULL;
 	}


