Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712ADC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiF2Mpq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiF2Mpp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:45:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F62F673
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:45:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCjfvC023613
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656506742; bh=40xglbfH65cVdYg2Tzb+ttMm2oeA1aBJ3SR9rqRk4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CP9bEx2c/iwmCT4/8e9pM7W+ziIkIOYmpU5Dezi0Ws+12JWJ9j8KvG5uyUexAfexP
         7Ho8bTTNtukUsAtEoXyX69EgMkWOk+QKhOjUo89df8cl3fgZ5KNpTDPed40DpHiNnT
         JaP1fSJAR6RYsZT9fJbcdIv4dq6Y6PUOCBJqdCySRzAdResIwiq8RA3ouKMK9j/VtQ
         Xk8DhQkN1dWfUcanem17pvMT8eq8gIhqtz/vu0SXGxE8+Oi3P+sjjHkZd3j5TGMTjN
         YfTQt5LHB7K5wm0fe681aFfsoE6dzKGNN32qx1n1/6DFM+9vf7dXZEMxTQvzsDrN6/
         KV649q2FLjfZQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3342415C432E; Wed, 29 Jun 2022 08:45:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v3 3/7] ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
Date:   Wed, 29 Jun 2022 08:45:36 -0400
Message-Id: <20220629124540.175775-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629124540.175775-1-tytso@mit.edu>
References: <20220629124540.175775-1-tytso@mit.edu>
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

