Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC5C77B7A
	for <linux-fstests@archiver.kernel.org>; Mon, 29 May 2023 13:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjE2NSf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 May 2023 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjE2NSe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 May 2023 09:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F9B7
        for <fstests@vger.kernel.org>; Mon, 29 May 2023 06:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F1FA62440
        for <fstests@vger.kernel.org>; Mon, 29 May 2023 13:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F75C4339B;
        Mon, 29 May 2023 13:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685366284;
        bh=wlFqRXGTycWjUAA7jiPPKLThp5Qb2TEusrQvdLw6o2A=;
        h=From:To:Cc:Subject:Date:From;
        b=RjQ5l0l/n3tgO9iDGNusIb1NAUC8BLmywcKN6lFaY8N/vRqwgm/Df5PmQ5h0NcBAG
         BpcMnzs7IVpuRVQDkspVBqVCWOzXP0Mg0ZtSCTmDZsokHe4ldBVEWx3q22NO7igcgp
         l3+w1pZAsix5wTVkvqvivMkyMn47wV5uXZx+NNL82TLbz/PUcWxOkStpZvMwnBHV4r
         IaGInQU/uMZ7Tf6LjQ7GvR3yzxGdhADYUlmKKOhvb8O793NdXuW/nAuC2Y0sG2Hgje
         tHt9lULR7N39wnTL/n4Pw/+io48xC1kArldALFSfwVeqHr661z9aZpbkwaikgpC8qt
         wVkEE8UfGhmxQ==
From:   Chao Yu <chao@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     jaegeuk@kernel.org, fstests@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] generic/506: fix to call _scratch_enable_pquota()
Date:   Mon, 29 May 2023 21:17:41 +0800
Message-Id: <20230529131741.2642570-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Otherwise, this testcase will fail due to project quota feature is not
enabled in the image.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/generic/506 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/506 b/tests/generic/506
index ec91af78..d4aac68b 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -31,6 +31,7 @@ _require_quota
 _require_scratch_shutdown
 
 _scratch_mkfs >/dev/null 2>&1
+_scratch_enable_pquota
 _require_metadata_journaling $SCRATCH_DEV
 _qmount_option "prjquota"
 _qmount
-- 
2.40.1

