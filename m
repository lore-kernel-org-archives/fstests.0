Return-Path: <SRS0=7+VG=AG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CDC433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Jun 2020 12:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13DC206BE
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Jun 2020 12:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404285AbgFYMhs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:37:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404610AbgFYMhs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Jun 2020 08:37:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC829AC90;
        Thu, 25 Jun 2020 12:37:46 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     guaneryu@gmail.com
Cc:     fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] common/config: Allow sections names to contain hyphen
Date:   Thu, 25 Jun 2020 15:37:44 +0300
Message-Id: <20200625123744.17812-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Current regular expression in get_config_sections allows section names
to consist of alphanumeric character and underscore. Extend it to
also allow the hyphen '-' character.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 8023273da115..63d486125a76 100644
--- a/common/config
+++ b/common/config
@@ -449,7 +449,7 @@ known_hosts()
 # in the section name otherwise the section will not be resognised.
 # Section name must be contained between square brackets.
 get_config_sections() {
-	sed -n -e "s/^\[\([[:alnum:]_]*\)\]/\1/p" < $1
+	sed -n -e "s/^\[\([[:alnum:]_-]*\)\]/\1/p" < $1
 }
 
 if [ ! -f "$HOST_OPTIONS" ]; then
-- 
2.17.1

