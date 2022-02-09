Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4113C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiBIW0S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiBIW0N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF17E015264
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UuC51os8Fs33I57pBPtfouUQuWuJRu1lDBeX7RYG/Xw=; b=NpdQTK0V9iPUgPyfgyZaW6TUB2
        c5nqXADVxqX+2ivhA9hstMGai9T+P3KQM3w4AdzYQKrf+EYGiYCAUg9cEaCnIc3E10S5w14YG8jYG
        dVIMNXS7ZBt4iKz/ukCr+nkJXn0QSKTIl+pj+cz9K5pTH7EQu9b6WxbbV+zNfoTZ8DGOv5B5VulVZ
        DRZZ6Tiidvm0OqlJpe1UE51/ezY5JXFdx//AimM6Udte8h7+vfUQI/ldt1cKAod01hNs8xXdrVyrY
        IeD2E7cZCqIhVE9+g1qUmpoaBqVqSqJzQfvaeWuN8yxgvEI0Zm3DcqTvhE/EdKXPW0IJXSyBut9bf
        bYgo06Zg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q6D-RS; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 10/25] nfsio.c: include dbench.h before nfs.h
Date:   Wed,  9 Feb 2022 14:25:55 -0800
Message-Id: <20220209222610.438470-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is so _GNU_SOURCE is defined so asprintf() is declared
when including <stdio.h>.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 nfsio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfsio.c b/nfsio.c
index 7583110..1b49bd3 100644
--- a/nfsio.c
+++ b/nfsio.c
@@ -17,8 +17,8 @@
 
 #define _FILE_OFFSET_BITS 64
 
-#include "nfs.h"
 #include "dbench.h"
+#include "nfs.h"
 
 #include <stdio.h>
 #include "mount.h"
-- 
2.34.1

