Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E9FC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8EA61A25
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhCXWtE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhCXWse (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 18:48:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71CC06174A
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 15:48:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 79FD21F45F01
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     fstests@vger.kernel.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        "Lakshmipathi . G" <lakshmipathi.ganapathi@collabora.com>,
        Eryu Guan <guaneryu@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/2] generic/556: Fix rename test
Date:   Wed, 24 Mar 2021 19:48:17 -0300
Message-Id: <20210324224817.103503-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210324224817.103503-1-andrealmeid@collabora.com>
References: <20210324224817.103503-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Casefold rename test should check if renaming a file to an equivalent
name fails as expect (e.g. renaming from "file.txt" to "FILE.TXT") and
`mv` correctly identifies that those names refers to the same file.
Currently, the test doesn't do what is expected given that it doesn't
have the file to be renamed, and `mv` returns "No such file or
directory". Fix that by creating test files and checking the correct
output.

Fixes: 12b7dddbc265fcb ("generic: Add tests for filename casefolding feature")
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tests/generic/556     | 4 +++-
 tests/generic/556.out | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/556 b/tests/generic/556
index 3efd0510..3145188c 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -341,8 +341,10 @@ test_file_rename()
 	mkdir -p ${basedir}
 	_casefold_set_attr ${basedir}
 
+	touch ${basedir}/rename
+
 	# Move to an equivalent name should not work
-	mv ${basedir}/rename ${basedir}/rename 2>&1 | \
+	mv ${basedir}/rename ${basedir}/RENAME 2>&1 | \
 		_filter_scratch
 
 	_casefold_check_exact_name ${basedir} "rename" || \
diff --git a/tests/generic/556.out b/tests/generic/556.out
index 47656065..f9dd9542 100644
--- a/tests/generic/556.out
+++ b/tests/generic/556.out
@@ -5,7 +5,7 @@ SCRATCH_MNT/casefold_flag_removal Casefold
 SCRATCH_MNT/casefold_flag_removal Casefold
 SCRATCH_MNT/flag_inheritance/d1/d2/d3 Casefold
 SCRATCH_MNT/symlink/ind1/TARGET
-mv: cannot stat 'SCRATCH_MNT/rename/rename': No such file or directory
+mv: 'SCRATCH_MNT/rename/rename' and 'SCRATCH_MNT/rename/RENAME' are the same file
 # file: SCRATCH_MNT/xattrs/x
 user.foo="bar"
 
-- 
2.31.0

