Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054DC4332F
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiBIWSw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:18:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBIWSv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF1C102FD8
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nZ4rv4B2BEaTEpMULbqseHpbts1amhVOc2IxOGa6Xcc=; b=WTcn7FueIB2f9WrMWLA8VBtgKR
        YR8cP1crx0QX1wUj46MBiT+Ez6zGn39AHxWIxv+m6f5SkodLiOTclS1m9JjVbahrDhB2dDAcU8WO8
        XNQYPbjw2m76xwLljXS36jPJHRjUzF7In/iHgvxABBKWUTvrNCvRJ2fKa9o14F8GvGyzXaRdFNLLc
        LBTeRH4tyK1Xcruyk1DLYLmHEyYEEX/8lxhe4MGF+iCFEzop3TUd2NHKyccD/M6kI4n3Ku0OfN0eQ
        1GOTXvAj3hsEnGt/dQBMKVKeg7H5t6zzKHb6R/rWcjdRQ1c3U2swB8N7hGZDP6xhcbeCBwda9b2JF
        NzJWXgfg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvIa-001p4p-Fq; Wed, 09 Feb 2022 22:18:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/4] libnfs: Include stdint.h
Date:   Wed,  9 Feb 2022 14:18:48 -0800
Message-Id: <20220209221849.434616-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

Changes in kernel headers break build unless this is included.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 libnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libnfs.c b/libnfs.c
index edbcd61..e853e47 100644
--- a/libnfs.c
+++ b/libnfs.c
@@ -21,6 +21,7 @@
 #include "mount.h"
 #include "nfs.h"
 #include "libnfs.h"
+#include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-- 
2.34.1

