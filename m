Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C73C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiBIW0X (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60657E015642
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/1tTMU7dVY7QHyrZw+ejALGWqEkhmZJUkQf3d7UF0DE=; b=H+aecQLhArdsJkgCKPwN695+S7
        PNTXmPqpOBs0MyQkYnCNudXQm4S4Z8vjE8/PdCG+2kksvIlWP3eWrYgt9vjJ1+U6heVpi6P2cZPiX
        SY4e0FnUXmQY38G7oKK1sXlPsbsYvCNuPekem7cD6FzSreXGemK8+SrERHlRBYBysUOW4/6g1Vv1K
        0r/SuTVhzmM+6Y45vh4aTiu+lq/6zaGwUEc3TxLIfly8yg+OMck2Gan/nzAFLlw7/IXDLdMlkcM9R
        FT00aHKRk6UAOfb89LTX1I6glu2HqtliQgrzN3IGigl4PZs+efHrHGdY1Bn9ByEL3iUWD1MnFGbrs
        xdSiKu/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6X-0h; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 15/25] sockio.c: use uint32_t
Date:   Wed,  9 Feb 2022 14:26:00 -0800
Message-Id: <20220209222610.438470-16-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Avoid the ambiguous uint32.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 sockio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sockio.c b/sockio.c
index 6eb9e0f..f64cfc7 100644
--- a/sockio.c
+++ b/sockio.c
@@ -29,7 +29,7 @@ struct sockio {
 static void do_packets(struct child_struct *child, int send_size, int recv_size)
 {
 	struct sockio *sockio = (struct sockio *)child->private;
-	uint32 *ubuf = (uint32 *)sockio->buf;
+	uint32_t *ubuf = (uint32_t *)sockio->buf;
 
 	ubuf[0] = htonl(send_size-4);
 	ubuf[1] = htonl(recv_size-4);
-- 
2.34.1

