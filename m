Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90F5C61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Feb 2023 14:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBBOtp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Feb 2023 09:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjBBOtO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Feb 2023 09:49:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4384367C0
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675349287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BvSUnB4446I071KaXqGLbHFNPW/Glr5oLxIu8HEBOms=;
        b=IjsEMB4jN7XqRY9wqxjO6RRUzkdV13EnDXqgNV5YlQWrx4isdEHv8ty9T5FNIVNWND51yL
        r0Jx3urAg7pBTqEnv0hZhD8lEYHX2LQdQ8etV7Ih1UzLcOw20kDDmapacOqg905a4rWemZ
        86S7MD2mWKe87+0MjL/d3mvVht95x3g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-oWSbYxsuNAyiz1GatroERg-1; Thu, 02 Feb 2023 09:48:05 -0500
X-MC-Unique: oWSbYxsuNAyiz1GatroERg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00128185A794;
        Thu,  2 Feb 2023 14:48:05 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C035E51FF;
        Thu,  2 Feb 2023 14:48:04 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 4233B10C30F0; Thu,  2 Feb 2023 09:48:04 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Eryu Guan <guaneryu@gmail.com>, Jan Kara <jack@suse.cz>,
        fstests@vger.kernel.org
Cc:     Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] generic/676: Unstable d_type handling for NFS READDIR
Date:   Thu,  2 Feb 2023 09:48:04 -0500
Message-Id: <42d3218724fbe3758005f984ad85934a50c33611.1675348307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The NFS client may send READDIR or READDIRPLUS to populate the dentry
cache, and switch between them to optimize for least RPC calls based on the
process' behavior.  When using READDIR, dentries will have d_type =
DT_UNKNOWN but with READDIRPLUS d_type will be set from the mode.

This heuristic will cause generic/676 to fail when comparing dentries
cached from one or the other call, since we compare d_type directly. Fix
this by bypassing the comparison of d_type if any entry is loaded with
DT_UNKNOWN.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 src/t_readdir_3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/t_readdir_3.c b/src/t_readdir_3.c
index e5179ab27c51..8f9bb326dccb 100644
--- a/src/t_readdir_3.c
+++ b/src/t_readdir_3.c
@@ -27,6 +27,7 @@ struct linux_dirent64 {
 static DIR *dir;
 static int dfd;
 static int ignore_error;
+static int ignore_dtype = 0;
 
 struct dir_ops {
 	loff_t (*getpos)(void);
@@ -61,6 +62,10 @@ static void libc_getentry(struct dirent *entry)
 		exit(1);
 	}
 	memcpy(entry, ret, sizeof(struct dirent));
+
+	/* NFS may or may not set d_type, depending on READDIRPLUS */
+	if (!ignore_dtype && entry->d_type == DT_UNKNOWN)
+		ignore_dtype = 1;
 }
 
 static off64_t kernel_getpos(void)
@@ -95,6 +100,10 @@ static void kernel_getentry(struct dirent *entry)
 	entry->d_reclen = lentry->d_reclen;
 	entry->d_type = lentry->d_type;
 	strcpy(entry->d_name, lentry->d_name);
+
+	/* NFS may or may not set d_type, depending on READDIRPLUS */
+	if (!ignore_dtype && entry->d_type == DT_UNKNOWN)
+		ignore_dtype = 1;
 }
 
 struct dir_ops libc_ops = {
@@ -168,8 +177,9 @@ static void test(int count, struct dir_ops *ops)
 		pos = random() % count;
 		ops->setpos(pbuf[pos]);
 		ops->getentry(&entry);
+
 		if (dbuf[pos].d_ino != entry.d_ino ||
-		    dbuf[pos].d_type != entry.d_type ||
+		    (!ignore_dtype && dbuf[pos].d_type != entry.d_type) ||
 		    strcmp(dbuf[pos].d_name, entry.d_name)) {
 			fprintf(stderr,
 				"Mismatch in dir entry %u at pos %llu\n", pos,
-- 
2.31.1

