Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E43C432BE
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E49260F46
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhHNKtb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237924AbhHNKta (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 06:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1967F60551;
        Sat, 14 Aug 2021 10:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628938142;
        bh=vA5+HCuKH4RjLD8leyBLnX+q2M2uhFWIR5LZ1vBgsfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwfkucVDU83zpGrfJVUhunkgm6P102fZctk2hGGK3tC4lqyWconUcBhLJKvbcIt0i
         vBJsU9fzyfH+T84plvzf2TxmdwuCSS7KqCWrcPBQO0r57mdbjVJDqVrO0wkeJerSK/
         IVny+4xubEl8kLM6gh2DKKCA3R95SjVzLFkxxZuqZzVXPJsH3KYjWK16X8eTK5oYdp
         oV+4A3Ut36fmR8D3GYyPt1aMYNzmODdCjJp4c8F+nWg3Y00Zlt/EEoFOt/rj0QQVjf
         +AP0euHbKKdMuU8aFuIvV1Y98Y01cV0YOuXhJwgiRDUw1gP+UfHwAvLNoU0l4wGfn2
         rJirAn2n1k7ug==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 1/8] idmapped-mounts: use die() helper
Date:   Sat, 14 Aug 2021 12:47:58 +0200
Message-Id: <20210814104805.1124023-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814104805.1124023-1-brauner@kernel.org>
References: <20210814104805.1124023-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; h=from:subject; bh=16IyFvZM6WS9OijQR/d7cFs8KFHl0u9OGgR3F87JG6M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSKzw87q+NxZTL/kUCv7/aCp0+y7Jw8Va/6WmafbEHMzXvT d7562lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRwi0M/7MFFZIP9gik3glZsPidxP M7l4QnZpc94ja+bP1rRqLvAXeGf0qzlk8TlK7WWjwj5Z12ykz5iTOPX/V64bta/+fNZceNAlkB
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Use the dedicated helper to report an error and exit with failure
instead of hand-rolling it.

Cc: fstests@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
- Christoph Hellwig <hch@lst.de>:
  - Split into separate patch.

/* v4 */
unchanged
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

