Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD773C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiBIW0N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiBIW0M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0533E00F7E0
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=3McOI736+PjDQeC6GocdHHCpWSWi3e6E10oZax+3gLw=; b=epxaetaZED8qT3PEE5McXXN/tx
        BQOyelDFmAg9kZioewOQspu7p26H97vbRCZEasgmCLzvQVGCiO5SYskTRuHzrrvf8auL+PrqLBGBp
        aLzT1BS52peT1p3eBaUPflb8FYWvDG7jDKVichelaPm4MnCtMely0B4pdy00AlEWJPPiI6DQ1uxpI
        pU5qBD5dfhelwZReETNBjhUvUxtM+oyBe0VnWT3A73VxPDljr01IP6TkCkDS5iruV4Op/P1UFmhqi
        fYdOe61d3VLUSL091T124/ERItbZbfyozwJfiMla5o4MKE80dwxwBI8c1cqILlnmiYH9K4AsgO54u
        wscA1AuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5h-KI; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 04/25] child: fix data type comparison on child_run
Date:   Wed,  9 Feb 2022 14:25:49 -0800
Message-Id: <20220209222610.438470-5-mcgrof@kernel.org>
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

Use an unsigned int when comparing values returned by
strlen(). This fixes this compile warning:

child.c:447:39: warning: comparison of integer expressions of different
signedness: ‘int’ and ‘size_t’ {aka ‘long unsigned int’}
[-Wsign-compare]
  447 |                               if (len > strlen(line +13)) {
      |

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/child.c b/child.c
index 04bc474..d340860 100644
--- a/child.c
+++ b/child.c
@@ -441,7 +441,7 @@ loop_again:
 			int count = RWBUFSIZE;
 			
 			while (count > 0) {
-			      int len;
+			      unsigned int len;
 
 			      len = count;
 			      if (len > strlen(line +13)) {
-- 
2.34.1

