Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C0DC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiBIW0h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiBIW0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A189BE01644C
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1owq6WpTajZpQ8LNMVy+jFMB/p1pTY56eQLew6SX8ac=; b=tDpT1wIsRZBoorf5aLMnT+5kzc
        8pQZZjTr4ymLf+zfuFW3PYIRckTe2u7WXmhqVjH9JyIhbyIppOc886ihtz4PAbN3PIwq5j4tkuF5Y
        Ktu6GEcg3XlO5n0xP+62bDXCHI2zG7yWH/9ztJgXjd1Dr1kbpCkwTJtfwm8PmWh+YlHi8KetuTqN8
        29bJzuQOdGyFkzhNkYxlLUbC+niYkQNiIbIGm+ZTQFkBToBJnMi/6akt/bAZbSo/9ymRGOUThWf66
        5Anr5zcdWqHS2SsqGyvr1qCRE2uiCZ2fBrwf8U+jzy4eABCcH2tesF0XtAQM/XNfMbuORPaWbtkGz
        8M6AUU2w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6t-8u; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 20/25] linux_scsi.c: fix redeclaration of _GNU_SOURCE
Date:   Wed,  9 Feb 2022 14:26:05 -0800
Message-Id: <20220209222610.438470-21-mcgrof@kernel.org>
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
 linux_scsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux_scsi.c b/linux_scsi.c
index 3306cd0..a8ef61f 100644
--- a/linux_scsi.c
+++ b/linux_scsi.c
@@ -16,10 +16,6 @@
 */
 #include "dbench.h"
 
-#define _GNU_SOURCE
-#include <stdio.h>
-#undef _GNU_SOURCE
-
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <scsi/sg.h>
-- 
2.34.1

