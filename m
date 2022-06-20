Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4CCCA482
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiFTTaH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiFTTaD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A51C12F
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A93121990
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYh/vgmmDIfTIn20IM19bfRXaanI1p2bXSV/WQTOeaE=;
        b=WKg4hqlUwrQneSUbgtgTGoyTLKOXZ8+JQ6owy4ecs30BwO/Ns0f9rLTs8RKUA59vyXCxA/
        QMLZxywhGmHbyBshXDJ4sdFRd17I6sYlkH0q1xwltyP7V7KwACQq2hurCtJTCzJA51yz8X
        PBRh6zy9X7Ty3tHZR3rj+7FPy9HZBiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYh/vgmmDIfTIn20IM19bfRXaanI1p2bXSV/WQTOeaE=;
        b=fhZOQXgSjKbqHQesHPnMDl6af4GTZ/RtQrpCWBElMaQyxMDLaXu37RHvbkRrfELRR6T08q
        Jk87L39d/F8ztrCg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 177E32C145;
        Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/6] report: drop unused _xunit_make_section_report parameter
Date:   Mon, 20 Jun 2022 21:29:31 +0200
Message-Id: <20220620192934.21694-4-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/report | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/report b/common/report
index 6cac71fc..bf05afa9 100644
--- a/common/report
+++ b/common/report
@@ -152,7 +152,7 @@ _make_section_report()
 	for report in $REPORT_LIST; do
 		case "$report" in
 		"xunit")
-			_xunit_make_section_report "$test_status"
+			_xunit_make_section_report
 			;;
 		*)
 			_dump_err "format '$report' is not supported"
-- 
2.35.3

