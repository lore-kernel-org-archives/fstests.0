Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A28C4167E
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 02:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiBICjZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiBICCb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 21:02:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C8C061353
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 18:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fHX01Uv1CO0hKp3SeIiwWsUvqactZ5BlTqGY5XH0z3Y=; b=sBBgR8EkUGlQ8sQUS8m4/5Wpd+
        RAOk/TvcvQF/kRGRouafzojzTKbsz5oJ3NzJdtNjyv+8GKHW1TVVEQgHajV8+ueZndvOQDwfxSLSa
        iNBNhk1VLTmKBdYBq0h43/HMJwTwUM6hLj669/M2LgReCYaqlLgQpzAP80LR7H5zSF3ylCi4Q7WRy
        0ltx4ivbathgdc5+i4K4y8X9THWvZvMm17KGY50092v0yGK6B+YY80q0x39AQwUAe9KaXlOVcujOk
        Kh0UYNWGEonc09BliFiGd85n2kGEVmvz0Sn3wUWiai21wF/3maHMkTbVFqBzp/Vxq1HcLIWtz8AMg
        j+zbs07g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHcJO-00Fxxj-6O; Wed, 09 Feb 2022 02:02:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/4] libnfs.c: fix compilation due to intptr_t move
Date:   Tue,  8 Feb 2022 18:02:23 -0800
Message-Id: <20220209020223.3805346-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209020223.3805346-1-mcgrof@kernel.org>
References: <20220209020223.3805346-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

intptr_t is now part of thread_db.h, so include that
file to make it compile again.

dbench now at least compiles on debian testing.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 libnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libnfs.c b/libnfs.c
index 1f60ef0..edbcd61 100644
--- a/libnfs.c
+++ b/libnfs.c
@@ -17,6 +17,7 @@
    along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
 #define _FILE_OFFSET_BITS 64
+#include <thread_db.h>
 #include "mount.h"
 #include "nfs.h"
 #include "libnfs.h"
-- 
2.34.1

