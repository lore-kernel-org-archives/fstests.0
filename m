Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63202C07E95
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Jul 2021 03:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409A361416
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Jul 2021 03:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGCDIW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Jul 2021 23:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhGCDIW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Jul 2021 23:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3976B61410;
        Sat,  3 Jul 2021 03:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625281549;
        bh=MtrrVIPGsVoNoocYPauTneaOr4zmBeDoxs6fG8xCldk=;
        h=Date:From:To:Cc:Subject:From;
        b=sB5N+qRtwwYsrIEGJ3FCJjrT4aeu2eUpqnkdTzVZ9JgpwiVxIHfpLoR7nsZPM67V/
         WkMjcQTBZuMsnCH4saDeuKQKfo0Z/r0O94wIxmv4mgCrW+MCs5JCjpQJCfwiIIwpD8
         e6mWN7qcB6Ojq1TElIyFbaJ+GwXFY2zsn1yfl0QKBTQF3HQUjZVSkMrI8ZuVhrtyRf
         EsVf+Xwg65ptbIZLDKwbIHFhmM/+/dWYfRzgg96auunkGOCUJaVdw6AYqgpxvb1aGQ
         hYQt4Wd5D+fZ0pCYNplZFEqVeXwp4m9+a0+blB/SZB7LnyGngiT1+ewmA+ubyFfTH3
         0aiMbzHme/JDw==
Date:   Fri, 2 Jul 2021 20:05:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH] tools: make convert-group ignore converted test files
Message-ID: <20210703030548.GA24770@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Teach the tool that rewrites tests files to use _begin_fstest group
tagging to ignore tests that have already been treated.  This will make
it easier for people to rebase their dev branches.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tools/convert-group |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/convert-group b/tools/convert-group
index 81ad9934..981aa87c 100755
--- a/tools/convert-group
+++ b/tools/convert-group
@@ -16,6 +16,8 @@ obliterate_group_file() {
 		elif [ ! -e "$test" ]; then
 			echo "Ignoring unknown test file \"$test\"."
 			continue
+		elif grep -q '^_begin_fstest' "$test"; then
+			continue
 		fi
 
 		# Replace all the open-coded test preparation code with a
