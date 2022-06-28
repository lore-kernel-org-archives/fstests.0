Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD8ECCA479
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 18:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiF1SZ5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiF1SZz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 14:25:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD721267
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 11:25:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25SIPn6N025897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656440750; bh=40xglbfH65cVdYg2Tzb+ttMm2oeA1aBJ3SR9rqRk4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oK0sSL2vXpmYUO7zkDkUhVYemczTcfAUCzkiQ3alat+mB1Kgga+w6hAt0ovCikLIK
         H1ebSw09xAPQ78Of+onoTiVXmmY5IoBveRknq9OoHpHpktvMP3kXA97oqjz0tmI4sE
         iJO1AiCsGJjTTBOzmCW92GF1+uk/bHpXsQdH8ym7hULYB1FaArmxtEzwQN9ernkJXf
         ah5dihHoCFgv7V38O12uIh4MCME8UeH6gGxiKL2QiBoEgg9/2GK2a5M/D8DyA8G9Sk
         1NNLx+5nlNC6FAiEAYn+7W/O359mpd4qIlIY7CYNoi9oxrQGuaEYoWdQ7mpde32trR
         gwgJprVt6cvmQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7FE9D15C4316; Tue, 28 Jun 2022 14:25:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/6] ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
Date:   Tue, 28 Jun 2022 14:25:42 -0400
Message-Id: <20220628182545.1834145-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220628182545.1834145-1-tytso@mit.edu>
References: <20220628182545.1834145-1-tytso@mit.edu>
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

