Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679FDC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiBIW0e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85636E015649
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TyH2K6J/nRkjCZKRXC5/O5q4Hk5e+lxhUfKjvbioAYU=; b=Bio8x8CdgVWDGibneSl/yU0Dbt
        Mt8AzBCEby7DO6YNxIErc4sNfYPhtIE33ccmbjQTyqUDXRZ1rvWQ/OWxH1DCDDQIRacC/PfLj1HZ7
        YHyX+G15wsEQWvsth8hi26SUG2hCVQZADZmp6Xc/pkCcoMiQrVkTuPKIFoX3NQcayLY6N8esrPabn
        QpD/w/4ke68WgAKAoOOrfbQ/ni/ILZT59v13ezYFVslsy1ztFDcsIHEJ9CFIFJBIJ8D0d0mFqSlY0
        COTqgYp1LFYOUX9TWAnyQp1Z2Xi8M492FZm7PRhW1KRGf44/tOof98ApKGkg7y3XTxer5OeQVFpWN
        WY9PTKzw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6h-45; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 17/25] libnfs: fix compilation warning for inet_tons
Date:   Wed,  9 Feb 2022 14:26:02 -0800
Message-Id: <20220209222610.438470-18-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 libnfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libnfs.c b/libnfs.c
index 1600701..50f914e 100644
--- a/libnfs.c
+++ b/libnfs.c
@@ -27,6 +27,10 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
 #define discard_const(ptr) ((void *)((intptr_t)(ptr)))
 
 typedef struct _data_t {
-- 
2.34.1

