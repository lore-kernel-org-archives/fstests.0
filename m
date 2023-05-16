Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC757C77B7F
	for <linux-fstests@archiver.kernel.org>; Tue, 16 May 2023 10:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjEPKZj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 May 2023 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjEPKZF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2023 06:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A34C2F
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684232613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1R2Zfzf+OxU2fUr/DTdRQej3S5XnDhCe6siXLHEuuFk=;
        b=dQHvR/8/GwfNMcKSZSxj5eQLqujYOhqx3AFX25vQt9SBMI8H0mjF8qHmEvJVYkM69uCrso
        bY6XSYaWyjX7UPrimijeChqkopiyXi4ma/Oh9WzUqZpLokm5ATUxzLazK3wyuFCxsQP31W
        7riag+9eDppwFsCkv2TzwGD52a49fFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-2NHQ1RWFPMKWcdwOMQz1-Q-1; Tue, 16 May 2023 06:23:32 -0400
X-MC-Unique: 2NHQ1RWFPMKWcdwOMQz1-Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f4fa463282so23827705e9.0
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232611; x=1686824611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R2Zfzf+OxU2fUr/DTdRQej3S5XnDhCe6siXLHEuuFk=;
        b=C55O5veXlsqIuNSLIzdfifQdHBPo2iLP/s7GMQWzAE3io/lgu+wYhyiJXHgWS4Tv8n
         zaoDrDzj/MOUQlp1S0yyW9R6/oXB8mlqA9sEsD3TXHuVv0qWYhks9lUgN2nAs1EqZWMb
         3DJyAuUlk9RLHK3XiTPL6CrpX0NNV9rM6DdFzUaYySlFfUB5aZXm8KlxlIn7mknsQX2D
         EEdsko3HN8d7NRIBXUcssYThxVVLQhLJ0Y+H0D3o2/PRiNfQ41kXs5SVDldx5R1nnEh/
         6i2Ry7+CZwojfWtLbgO5AyOb6j/wSgb1yYan/jr4oedPQ7f3BZNx8/2n8ChNjTGNxIUU
         ZZXA==
X-Gm-Message-State: AC+VfDwfX9UJPfBbOvEhKKz5URZ8iBbGaLgqjnKC+gc8/jnEbs8fPhhv
        BRUwggZOGixnuhoRmRnO2Fs2Ba4zxCPIBZTm5vXUcl9d6TVVR4ihdHEh+sTR1gMzbyNMFZirPbg
        jC2BEnlEkIlVFJwlHeVoDJ+Op13Hbaf9NjkLUn3iqsNtVsFZkxdMOiM5YY+ad67V4hWawpwryzZ
        ue
X-Received: by 2002:a1c:720c:0:b0:3f4:27ff:7d54 with SMTP id n12-20020a1c720c000000b003f427ff7d54mr19204423wmc.3.1684232610829;
        Tue, 16 May 2023 03:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gsUp/AzjK1A9eXIVWF2pvJe47STEdAGcy2ll5/5FPQFAQEdc9hNEQAazw/zfwAYC2KbmMig==
X-Received: by 2002:a1c:720c:0:b0:3f4:27ff:7d54 with SMTP id n12-20020a1c720c000000b003f427ff7d54mr19204405wmc.3.1684232610452;
        Tue, 16 May 2023 03:23:30 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bcb87000000b003f4290720d0sm1765772wmi.47.2023.05.16.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 03:23:30 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] fstests: fix compilation error in splice2pipe on old (<C99) compilers
Date:   Tue, 16 May 2023 12:23:03 +0200
Message-Id: <20230516102301.571503-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Compilation fails on system with compiler which uses older C dialect
(e.g. RHEL7; gcc with gnu90) with:

splice2pipe.c: In function 'prepare_pipe':
splice2pipe.c:54:2: error: 'for' loop initial declarations are only allowed in C99 mode
  for (unsigned r = pipe_size; r > 0;) {

Fix it by declaring 'r' outside of the loop.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 src/splice2pipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/splice2pipe.c b/src/splice2pipe.c
index bd33ff67..00b3a23a 100644
--- a/src/splice2pipe.c
+++ b/src/splice2pipe.c
@@ -41,6 +41,7 @@
  */
 static void prepare_pipe(int p[2])
 {
+	unsigned int r = 0;
 	if (pipe(p)) {
 		perror("pipe failed");
 		abort();
@@ -51,7 +52,7 @@ static void prepare_pipe(int p[2])
 
 	/* fill the pipe completely; each pipe_buffer will now have
 	   the PIPE_BUF_FLAG_CAN_MERGE flag */
-	for (unsigned r = pipe_size; r > 0;) {
+	for (r = pipe_size; r > 0;) {
 		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
 		write(p[1], buffer, n);
 		r -= n;
@@ -59,7 +60,7 @@ static void prepare_pipe(int p[2])
 
 	/* drain the pipe, freeing all pipe_buffer instances (but
 	   leaving the flags initialized) */
-	for (unsigned r = pipe_size; r > 0;) {
+	for (r = pipe_size; r > 0;) {
 		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
 		read(p[0], buffer, n);
 		r -= n;
-- 
2.31.1

