Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE07C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Oct 2022 14:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJMOsy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Oct 2022 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJMOsx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Oct 2022 10:48:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733DDF036F
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 07:48:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29DEmmCE028654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1665672529; bh=v3Z+UXAy42nYLpqrysp8RDP2hwklvoT+jGsq4kWxfT4=;
        h=From:To:Cc:Subject:Date;
        b=kvjVS9aTCVh1rxypQ8ey6u+nMhQu0VI4rbfboybhoGFQ90eOCXtx3lEs90Bv/5EnU
         qbaifL7R2BKkt6zyT+pBMWoPbajXZzQ/CUv0RsJFe9JWPv2mRqugjOBZEbK7BUK/Xr
         +5nsY6FPU9tOscCEduDODHrXUZIdncfU2N8XM1amP1bQmDEwtRaPkjcu+9/qZOqqQp
         OjoCx7n1CJox5KxRDsicmGDqAPkA0NRZXQ3d47wz0bFot+fsiMnhTFdINe2X+pkLqn
         LIObl4Np0mUsCQzrMd0LjPzio8q5oXVH3vpP5vsWzCm1W+uuMBY8nt3KOawZaBpF9T
         lx4+Vtnoby1yw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36E1815C3AC9; Thu, 13 Oct 2022 10:48:48 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/053: remove test for i_version mount option
Date:   Thu, 13 Oct 2022 10:48:44 -0400
Message-Id: <20221013144844.90320-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The i_version mount option is deprecated in favor of iversion and is
advertised to be removed in 5.20.  It was removed in commit
1ff20307393e ("ext4: unconditionally enable the i_version counter") in
Linux v6.1.  So remove the test from ext4/053.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/053 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/ext4/053 b/tests/ext4/053
index 5d2c478aa..4f20d217d 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -480,7 +480,6 @@ for fstype in ext2 ext3 ext4; do
 	mnt barrier=1 barrier
 	mnt barrier=99 barrier
 	mnt -t nobarrier
-	mnt i_version
 	mnt stripe=512
 	only_ext4 mnt delalloc
 	only_ext4 mnt -t nodelalloc
-- 
2.31.0

