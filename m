Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A9CDB474
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Oct 2023 13:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJPNLx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Oct 2023 09:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjJPNLh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2023 09:11:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB6218E
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2023 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RXc0SkLuyVsPWibDgXv8Uar1l4fFdE4RMTqGV2fSV4c=; b=Q2TP5Ovszz6jgkS07/NRdK0kyk
        nTLw9dOYUfV0s5uhyJVB+PLL3zo3C2edm7exfU/xWa35QHYsIU5wHZNJw0fhaRRsckNY/HQ3eraSy
        kVgnPqpJq/CoT2DnO+jL2h6yp6Ks6eaK4t5UYShDy3zX8pRw0tI3WBehZjBOMMMtUCoGM+vV4eOzZ
        KqTm6s5WaiqxHtSDtqG7wqfoPMrveP4vCfTsiNdsLQDq588+wUygaO/JDxCgqMrDc/6pJg0j+B09y
        aBb3XP8CAzztF7dl/eEG8HE653GFQZJih0s4QEb4guhz4PTeSYCRD4gTTG54f5S93U/LskxXqAFPP
        ySm2VftA==;
Received: from 213-147-167-190.nat.highway.webapn.at ([213.147.167.190] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsNNE-009hC0-2Q
        for fstests@vger.kernel.org;
        Mon, 16 Oct 2023 13:11:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/2] xfs/556: call _require_dm_target later
Date:   Mon, 16 Oct 2023 15:11:02 +0200
Message-Id: <20231016131103.966920-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_require_dm_target tries to use $SCRATCH_DEV, so move it after we've
established that the configuration has a valid $SCRATCH_DEV.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/556 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/556 b/tests/xfs/556
index 66908a54..061d8d57 100755
--- a/tests/xfs/556
+++ b/tests/xfs/556
@@ -25,10 +25,10 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs xfs
-_require_dm_target error
 _require_scratch
 _require_scratch_xfs_crc
 _require_scrub
+_require_dm_target error
 
 filter_scrub_errors() {
 	_filter_scratch | sed \
-- 
2.39.2

