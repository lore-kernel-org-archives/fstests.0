Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27123C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 21 May 2022 05:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiEUFn6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 May 2022 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiEUFn5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 May 2022 01:43:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D4185414
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 22:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71A09B82E2A
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 05:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DB8C385A5;
        Sat, 21 May 2022 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653111833;
        bh=VO1WlaSQsqSsh+YEn0lRZ2cbuTvXgQD8wmXA6pz9QVo=;
        h=From:To:Cc:Subject:Date:From;
        b=E0wUm16vhigdJqWoNaomwHtL9SnufjZxLuXF0lNK1OfLksmnDCh109tGHht04B15U
         gfxY5Sqy2qyQcupOO0qZpJu4t1arbXwS3gBDj6/pUCR7nRf2pvSgEXkCivMaRKS9tj
         B5sRfci0m4IkEntUudolEN3vAFVK7tZNPCv54uKSlSELP+BNVFiCI5I9XJI5k0f8if
         luf0s8h2+Wvm4+ED1mwOYkwKyQuiugMYbKcVciC8G1ULJ/r2v940xSlt35uC1zsOdr
         P4eRHL+vEwC6zlRyyvliUt0EPdXsU0cSQdGYaRfNBc0WNJ5dICM4SqxK9cmfMrh0we
         hRmA4ibWHb2dQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, david@fromorbit.com
Subject: [PATCH] tools/mkgroupfile: help the cases of group.list in number order
Date:   Sat, 21 May 2022 13:43:49 +0800
Message-Id: <20220521054349.1691473-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The mkgroupfile doesn't sort cases in number order, that cause
fstests' ./new script can't find a proper number which isn't taken.
The unsorted case number might cause more problems, so fix it.

Fixes: 441606d28681 ("fstests: faster group file creation")
Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

If you'd like to fix this issue seperately, I can merge this patch with Dave's
"[PATCH 04/12] fstests: fix group list generation for whacky test names"
together.

Thanks,
Zorro

 tools/mkgroupfile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/mkgroupfile b/tools/mkgroupfile
index 24435898..bab85046 100755
--- a/tools/mkgroupfile
+++ b/tools/mkgroupfile
@@ -60,7 +60,8 @@ ENDL
 
 	# Aggregate the groups each test belongs to for the group file
 	grep -I -R "^_begin_fstest" $test_dir/ | \
-		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
+		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' | \
+		sort -ug >> $new_groups
 
 	# Create the list of unique groups for existence checking
 	grep -I -R "^_begin_fstest" $test_dir/ | \
-- 
2.31.1

