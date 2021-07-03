Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E2C07E97
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Jul 2021 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A461938
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Jul 2021 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhGCQFZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 3 Jul 2021 12:05:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60974 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229463AbhGCQFZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Jul 2021 12:05:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 163G2nB6011342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Jul 2021 12:02:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 361E115C3CE6; Sat,  3 Jul 2021 12:02:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] check: exit with exit code 1 after printing the usage message
Date:   Sat,  3 Jul 2021 12:02:47 -0400
Message-Id: <20210703160247.2558002-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If check is passed an invalid command line option, exit with a
non-zero exit code so that a script calling check can detect the
failure.  The check script already performs an "exit 1" if a valid
option has an invalid argument, so this is consistent with existing
practice.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index c2b8967a..d8252a8b 100755
--- a/check
+++ b/check
@@ -116,7 +116,7 @@ examples:
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
 '
-	    exit 0
+	    exit 1
 }
 
 get_sub_group_list()
-- 
2.31.0

