Return-Path: <SRS0=h6Hu=7Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE739C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C393D20747
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 12:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKMlk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:41:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgFKMlk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Jun 2020 08:41:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82879AE19;
        Thu, 11 Jun 2020 12:41:42 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     fstests@vger.kernel.org
Cc:     Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v2] README: add note about 123456-fsgqa user creation step
Date:   Thu, 11 Jun 2020 14:41:33 +0200
Message-Id: <20200611124133.23417-1-aaptel@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611120959.21359-1-aaptel@suse.com>
References: <20200611120959.21359-1-aaptel@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
changes from v1: typo: add missing "if"

 README | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README b/README
index 094a7742..451ced7b 100644
--- a/README
+++ b/README
@@ -22,6 +22,9 @@ _______________________
 - create fsgqa test user ("sudo useradd -m fsgqa")
 - create fsgqa group ("sudo groupadd fsgqa")
 - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
+  this 2nd user creation step can be safely skipped if your system
+  doesn't support names starting with digits, only a handful of tests
+  require it.
 
 ______________________
 USING THE FSQA SUITE
-- 
2.26.2

