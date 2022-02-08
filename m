Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11156C38A05
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Feb 2022 22:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387034AbiBHW0q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386970AbiBHVh4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 16:37:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C3C0612B8
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 13:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cs0I3DoUp+wrTDNhEUtCjkOiMVdIlSGB0QYP0Au6lPI=; b=TzjmTjg60+LqD1takL6tEUXtfv
        eB1bB4VtEFNvd1WxN6EixtEhMa+PoQZpaujtXqu/FbCt8RWvuSMXrPzTR5JBI73x8JK4e1DhCFZJ+
        8jbL7XA6/l543abC9NpCUoz/kvA1OHTkkB8MW/aHohzWl7hqVXmrYRy7MOOLFDwTT2Th+dQyK7q0U
        5LjIW0ydsKEYbSGZnpiOpRYSM75f6c1tZmXciud/U3pxfNnHzXwmtx0oW8cf2QglhAjt+W3ry0lWo
        jRAivrizlkx8gkc/EStIx3wlZiizRwWKeeFY0LI+O1OYeaw3BAfUdpToQUhMUeD+1gF6fi1oWATdv
        v/CLTSDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHYBP-00FcqL-Db; Tue, 08 Feb 2022 21:37:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common/config: fix use of MODPROBE_RM_PATIENT_TIMEOUT_ARGS
Date:   Tue,  8 Feb 2022 13:37:54 -0800
Message-Id: <20220208213754.3724193-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When patient module removal support is detected on kmod
(note that this is not yet even merged onto kmod yet but
work in progress) the arguments required for it are not being
set yet. This was a typo, fix this.

This issue was spotted using shellcheck from blktests when adding
patient module removal support there. I'll post a patch next to
let folks evaluate if we should embrace shellcheck on fstests as
well.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 2b357746..5fe2a5e8 100644
--- a/common/config
+++ b/common/config
@@ -280,7 +280,7 @@ else
 		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
 		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
 	fi
-	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_TIMEOUT_ARGS"
+	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
 fi
 export MODPROBE_REMOVE_PATIENT
 
-- 
2.34.1

