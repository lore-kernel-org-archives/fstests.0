Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAFFC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Sep 2021 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759BA611ED
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Sep 2021 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhIURwi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Sep 2021 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhIURwh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Sep 2021 13:52:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB35C061574
        for <fstests@vger.kernel.org>; Tue, 21 Sep 2021 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hqv4tDNzBFtkL0xxSTYYM4qDXefjA2yuhqAt/GrXt6w=; b=a+D1AQbNihfqYCeYYLNpDCD+02
        tqhtFTiKJtwwqtpX6ZvXGqQcZ/sYShzyIpM1LEgqlnKCWiDu4IuG1eIJx+uygSu9rMRXY9ZlDyd+0
        HvE3t1n5nlEjXL6oh5Q6Avg9hVX72cErKg2RyYRWMO+UcjRmmH8DgXABWCK5EDZI1qtYPhSIEafr2
        d0uBGRmeYeHXUbuPKHUzw1CU6JwCWG65eBbgXhlRbM5Dc2kSwS33oxEHfhBjAEkhir2nHNSR6WhWM
        ErkqN4IbwC2PuojElUSPXI/CRDUcO9P/WjAyW4vjET50tf/rXPcv3gQux+FJjQIxxboVX4PWJbH1R
        C78N9cgA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSjv3-005Owb-Me; Tue, 21 Sep 2021 17:51:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        kaixuxia <kaixuxia@tencent.com>,
        Brian Foster <bfoster@redhat.com>
Subject: [PATCH] fsstress: fix bogus compile warning do_renameat2()
Date:   Tue, 21 Sep 2021 10:50:59 -0700
Message-Id: <20210921175059.1287420-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

gcc complains with:

fsstress.c:4629:4: warning: 'oldparid' may be used uninitialized in this function [-Wmaybe-uninitialized]
 4629 |    printf("%d/%d: rename source entry: id=%d,parent=%d\n",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4630 |     procid, opno, oldid, oldparid);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fsstress.c:4629:4: warning: 'oldid' may be used uninitialized in this function [-Wmaybe-uninitialized]

But the varaibles are sure to be initialized, it is just that the
heuristics are broken since another check is used later which confuses
gcc. So just initialize the variables, to shup the compile warning.

Cc: kaixuxia <kaixuxia@tencent.com>
Cc: Brian Foster <bfoster@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 ltp/fsstress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index d2f09901..0d620d7b 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -4517,9 +4517,9 @@ do_renameat2(int opno, long r, int mode)
 	flist_t		*flp;
 	int		id;
 	pathname_t	newf;
-	int		oldid;
+	int		oldid = 0;
 	int		parid;
-	int		oldparid;
+	int		oldparid = 0;
 	int		which;
 	int		v;
 	int		v1;
-- 
2.30.2

