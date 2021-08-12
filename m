Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355AC4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2103D6103A
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 16:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhHLQEJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhHLQEH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Aug 2021 12:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F06D6103A;
        Thu, 12 Aug 2021 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628784222;
        bh=BvJfgZvzyjAVTopP5uHTTAU7RtJlKBr4y4i/BIOw+io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huRFfP4Yixz9t5ql+Xi7QH9iti1AomuuJzTbq//PbTcTomDh9M9VQ5llbKObmB772
         XAJyjlJiCU9JpouCORWiiq4PYSmVYZ9QQEkvo8MJ3in4Oq2qbHQMxYhmKydp8XnO+t
         nxf1jAwB3AY+NQdP8fGyaII7HYGoAVceR8Rj8NLs9cgJivOAprKJJ0jxyG1hMOiL3h
         7wfkZBpxQo2t5kiFl5tpdBg60K4d9cnQIBRGrsizGe6KOVwg/OuIh+U/4lUrt9KmEi
         HeLYYYYMnf1Lv82XlZ4BrHk1oyqflqkAXlcmGpQ1YyvQt2MZfOEmQNQo9wsrEwe6ag
         DymncXgQe3/DA==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 1/8] idmapped-mounts: use die() helper
Date:   Thu, 12 Aug 2021 18:01:33 +0200
Message-Id: <20210812160140.990229-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812160140.990229-1-brauner@kernel.org>
References: <20210812160140.990229-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; h=from:subject; bh=ZYzo4oE/HOpeigGQxHXByXH90wgqFFE8xdoODQXV3FM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKut5zOHl2Z7uq5ca21f2LdI9KszNODCg5GhzvLGOSyNMp +MC+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL1pxgZjioISBvasjf8art/K3q5yc PYhM1F/25ZSNld8nPJmxNvw/A/pIRP+0nv3kj3e6312u79KTrpf6QTTK47i79cvKE8YR4DAA==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Use the dedicated helper to report an error and exit with failure
instead of hand-rolling it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Split into separate patch.
---
 src/idmapped-mounts/idmapped-mounts.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 2c212131..69dcc027 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8804,10 +8804,8 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 
 		if (pid == 0) {
 			ret = t->test();
-			if (ret) {
-				fprintf(stderr, "failure: %s\n", t->description);
-				exit(EXIT_FAILURE);
-			}
+			if (ret)
+				die("failure: %s", t->description);
 
 			exit(EXIT_SUCCESS);
 		}
-- 
2.30.2

