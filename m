Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4EEC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Feb 2022 04:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiBBE3t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Feb 2022 23:29:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42250 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiBBE3s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Feb 2022 23:29:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C1BB1F380
        for <fstests@vger.kernel.org>; Wed,  2 Feb 2022 04:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643776187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WfD6RIBs9wAu0X2u9QVf8Mwucbv4JxXviP4Pu4GhSv8=;
        b=FXc94HsOhdOzt46851u4Mv5rSMV0zR4W/xRfqyKvS/lvc33tUHScIhUQOgHnWMx4l/yiWU
        STCiLWg7CFUcl1GxxxZthT1WxM/lB/wQWsxJSNFYbM+IMO+hWOxKydWYuqzO6K3Pzq6S7/
        F/sRb9y0KZX+3dz8kAAZCeVhodGU0Ok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E22A413B8A
        for <fstests@vger.kernel.org>; Wed,  2 Feb 2022 04:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kujsKroI+mFBVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <fstests@vger.kernel.org>; Wed, 02 Feb 2022 04:29:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] src/fssum: use newer EVP_* interface to replace deprecated MD5_* interace
Date:   Wed,  2 Feb 2022 12:29:29 +0800
Message-Id: <8093f1fb417c961791e2cb5b1b4ef7919c80cf4c.1643776132.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In OpenSSL 3.0, MD_Init/Update/Final() interfaces are marked deprecated,
and we have to go EVP_DigestInit/Update/Final() instead.

Personally I'm not a fan of this, especially the new EVP_MD_CTX
structure can no longer be stack allocated, thus we have to dynamically
allocate and free EVP_MD_CTX in sum_init() and sum_free().

Hopes this is proper way to go and would solve the problem until OpenSSL
chooses to change their interface again.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 src/fssum.c | 23 +++++++++++++++++++++++
 src/md5.h   |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/fssum.c b/src/fssum.c
index 3d97a70bf02f..390bfde02c7d 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -48,7 +48,11 @@ struct excludes {
 };
 
 typedef struct _sum {
+#ifdef HAVE_OPENSSL
+	EVP_MD_CTX	*ctx;
+#else
 	MD5_CTX 	md5;
+#endif
 	unsigned char	out[16];
 } sum_t;
 
@@ -175,19 +179,38 @@ alloc(size_t sz)
 void
 sum_init(sum_t *cs)
 {
+#ifdef HAVE_OPENSSL
+	cs->ctx = EVP_MD_CTX_new();
+	if (!cs->ctx) {
+		fprintf(stderr, "evp md ctx allocation failed\n");
+		exit(-1);
+	}
+	EVP_DigestInit(cs->ctx, EVP_md5());
+#else
 	MD5_Init(&cs->md5);
+#endif
 }
 
 void
 sum_fini(sum_t *cs)
 {
+#ifdef HAVE_OPENSSL
+	EVP_DigestFinal(cs->ctx, cs->out, NULL);
+	EVP_MD_CTX_free(cs->ctx);
+	cs->ctx = NULL;
+#else
 	MD5_Final(cs->out, &cs->md5);
+#endif
 }
 
 void
 sum_add(sum_t *cs, void *buf, int size)
 {
+#ifdef HAVE_OPENSSL
+	EVP_DigestUpdate(cs->ctx, buf, size);
+#else
 	MD5_Update(&cs->md5, buf, size);
+#endif
 }
 
 void
diff --git a/src/md5.h b/src/md5.h
index 2da44bf355a3..07c03ca304df 100644
--- a/src/md5.h
+++ b/src/md5.h
@@ -24,7 +24,7 @@
  */
 
 #ifdef HAVE_OPENSSL
-#include <openssl/md5.h>
+#include <openssl/evp.h>
 #elif !defined(_MD5_H)
 #define _MD5_H
 
-- 
2.35.0

