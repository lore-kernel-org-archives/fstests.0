Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B437CCA480
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiF2Mpr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiF2Mpp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:45:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497B523175
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:45:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCjfEt023614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656506742; bh=8xanglkN43VBugMwl8Hkn6Aw6FFf9nySfPvIfCCfQOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H0qv74+2QW6qM1VyrkowtsUqZk/UUSJOC9lhehXplLFKnS+dZXDrOYlihGLHqwFHM
         RVhsAtUdxVOGGklYfRrIv8ygTjMTPzaHBG9KoiVGiN2Y3kJGh3Ak3kpDHWejXwHNvG
         tiwjhFHqLR1ExMAsvxrns3lOY1ITLWCJLH9aOMbzRNSXSk7vHUZ6VWT/mtQWt0FXrf
         PwXPLtYF4mwjBWaez/ua4xNkbjGUQ9eoQ/v73WWUequu+PCzMKWUmijVc+D9IvuZwz
         v1x+kSFAx2quNGG34Cy3IwJZnwIVc9nTOfmRelwROLCtzTj1d7xDnn2WZXwPjLh4pQ
         ukc3cphdPgtEw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3171415C432C; Wed, 29 Jun 2022 08:45:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v3 2/7] ext4/044: skip test if the file system does not have a journal
Date:   Wed, 29 Jun 2022 08:45:35 -0400
Message-Id: <20220629124540.175775-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629124540.175775-1-tytso@mit.edu>
References: <20220629124540.175775-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test mounts the file system using "mount -t ext3"; if the file
system config creates the file system without the jbd2 journal, the
"mount -t ext3" will fail.  So skip this test in that case.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/044 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/044 b/tests/ext4/044
index 46e44053..158e2ac5 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -16,6 +16,7 @@ _begin_fstest auto quick
 _supported_fs ext4
 _require_scratch
 _require_test_program "t_get_file_time"
+_require_metadata_journaling
 
 echo "Silence is golden"
 
-- 
2.31.0

