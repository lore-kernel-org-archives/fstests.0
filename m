Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49213C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiBIW0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiBIW0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C556BE01645B
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=7Il0Euxol344BZBPASZC2uXMSVMFlhzRHesNoHCtBJ4=; b=X8bkqfV6ZJilQy7Rbb0/U2EUzf
        2NLH8LtB/f27hKCe0IGwAQHNXQTAGL2QAmMc30USAE2pV+mFj3wJ5K4yu1dVvHNGObYwCT0lbRes9
        gdK4qU8OqCnJRLBuFDrauPF0n0LYNSn748LEGDvsdoxEuVSzD5BfS0Pbhxf6zw0vKa0uPWasfbweC
        IyNWwC0f31qCF8ZDwHoBXGCh9Vo0+atVAS719Wa0n4AyC+FKmPtsgTmB6Ogf6oJkwHsXMt1ovN/Xn
        1G6cZpbgiq+yTDIkV4vX4N63GVmn+CitSrNZVfxjbirvSjw1LiIIrQ1DBoodqZu8u3FfKPCCLsyFc
        3FTj4ckw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q7H-GC; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 24/25] libiscsi: fix compile warning on data types
Date:   Wed,  9 Feb 2022 14:26:09 -0800
Message-Id: <20220209222610.438470-25-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This fixes this compilation warning:

libiscsi.c: In function ‘iscsi_write10’:
libiscsi.c:119:40: warning: pointer targets in passing argument 4 of
‘iscsi_write10_sync’ differ in signedness [-Wpointer-sign]
  119 |                                        data, xferlen*512, 512,
      |                                        ^~~~
      |                                        |
      |                                        char *
In file included from libiscsi.c:26:
/usr/include/iscsi/iscsi.h:1200:35: note: expected ‘unsigned char *’ but
argument is of type ‘char *’
 1200 |                    unsigned char *data, uint32_t datalen, int
      blocksize,
      |                    ~~~~~~~~~~~~~~~^~~~
   CC

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 libiscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libiscsi.c b/libiscsi.c
index 3bc5771..128a7d5 100644
--- a/libiscsi.c
+++ b/libiscsi.c
@@ -99,7 +99,7 @@ static void iscsi_write10(struct dbench_op *op)
 	uint32_t xferlen = op->params[1];	
 	int fua = op->params[2];
 	unsigned int data_size=1024*1024;
-	char data[data_size];
+	unsigned char data[data_size];
 
 	sd = op->child->private;
 
-- 
2.34.1

