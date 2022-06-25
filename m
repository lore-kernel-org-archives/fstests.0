Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505BDCCA485
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiFYDIQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiFYDHi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:07:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B296803A
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:07:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25P37XJS010347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 23:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656126454; bh=40xglbfH65cVdYg2Tzb+ttMm2oeA1aBJ3SR9rqRk4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Hiw1iA+LAFUMp2aA/ykOnHB738qQbDnYwSLd3bfCJelsyLRZpsuDfcnq38+70XRVX
         nRfPXF1bsmfQ8yo0Mr6NpovTVYjLbkUuhIZZmJzoyrR10rUiMAwwTd19CwX2FFviPu
         T2CMXH36b67zMXXRv+Sg5V4nKqwPF/PUJK7Affg3ph+/1qZwhWhe3j8ot0TK1Vhkg8
         2639E8BRl5XjNnjYAA6YGycruospRcy945cEhKd5eRegKdD04wmKKv/h5zpiSwCrx3
         CsSEZQN3UN9rnQ7YqgZcAsKZbbU5nr+bhaI/Xd/4+aXSXyAS+OXzYQIteBDb9Zbk/X
         eB/XdC4TO/ugw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C975C15C4312; Fri, 24 Jun 2022 23:07:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/5] ext4/045: clean up unnecessary arguments to _require_e2fsprogs
Date:   Fri, 24 Jun 2022 23:07:16 -0400
Message-Id: <20220625030718.1215980-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220625030718.1215980-1-tytso@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/045 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/045 b/tests/ext4/045
index ee7c0de3..4f0ad4aa 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -22,7 +22,7 @@ _supported_fs ext4
 _require_scratch
 _require_test_program "t_create_short_dirs"
 _require_test_program "t_create_long_dirs"
-_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
+_require_dumpe2fs
 
 echo "Silence is golden"
 
-- 
2.31.0

