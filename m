Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE96C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Nov 2021 02:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CFF630EF
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Nov 2021 02:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhKPDAu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344478AbhKPDAN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Nov 2021 22:00:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751BEC0EE333
        for <fstests@vger.kernel.org>; Mon, 15 Nov 2021 15:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=20/k1pS//WzH+Y/FE2zQsCVQlSHoyXaqUEyrARVvqmU=; b=26OE7OuPBOeXismUnpI4A40aoD
        h6hfIvIE0zGoJvIr+MD8gbwXaHupc8oCIcftW+8f6L+IlWR2kfAxEIqj+rWcnFHGyuISdBUUP3b8x
        te+/hpzF04YA1DAWG99ZIi6T3LpCbzVCUqj1fsb0TELydJw7tfKPbEfRZMuarzTkNDlXs+rVkNvRz
        Uh/X2H6fQPUNCVprVr7QxV7MPff/XBm+wW3TWYG58RcOC8WX+Koq2jzBoZKd/huwK9QQ98PPIxdsd
        clM0o6gA9fbErmZXlqJncBe3TaFvjaHiZW7UxKxilCRf5l/eAkaicpHop07JPySvzZ5NvMtFSR5nF
        1UIGutSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmlOu-00HI7b-5W; Mon, 15 Nov 2021 23:28:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common/module: fix patient module remover when module is not present
Date:   Mon, 15 Nov 2021 15:28:34 -0800
Message-Id: <20211115232834.4121190-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When module is not present and the open coded patient module
remover is called we'll end up in a loop which never ends.
Fix this.

I actually found this issue not in fstests, but when applying this
open coded solution to blktests. In fstest we tend to only call
module remove when we have a module loaded. blktests is different,
and so I immediately spotted the issue there.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/module | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/module b/common/module
index ead0f881..6efab71d 100644
--- a/common/module
+++ b/common/module
@@ -180,6 +180,8 @@ _patient_rmmod()
 				continue
 			fi
 			let max_tries=$max_tries-1
+		else
+			break
 		fi
 	done
 
-- 
2.33.0

