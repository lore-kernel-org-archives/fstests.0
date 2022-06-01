Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59719C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 06:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349917AbiFAGhj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbiFAGhi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 02:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A74D62D
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 23:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C5F61261
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BB2C385A5
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654065455;
        bh=MxKTX8uMGvK8utZIhJtg6e4jaCHKzxNkyt8nTdKPnSs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rlqwEmMVs9vFKZa9ZmrNAX+EArTSO6LwbrH7X88ijyhv3sOZNLJQcZ14Oh+8aw7/K
         90JXJfs7hW7pXm5RMSpMKcaNYeVPNbordNx6EXZ+8KTi9vF3lUWXmzG/z/uqNuZoCK
         3GfPLxVucYRy+3fPDnEThxpGQ9ue/FH6/6Je9Q0g5o5jtuslDDSvL1d9U2WRdFB6cJ
         6k5Cpt34UzK66cEnhe2CcCGFMS1Ej98FCdUAjms68+BJQ3ywP3VEzzNRZv74SyiT+5
         3nX5epDodkMPfHpgpYM9lkgGcR6AlsHeBk8WBPXhrZ3+34gyfbOitEZaRT0xPVuGdU
         gCXI6ItzsQMiQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 2/5] generic/506: call _require_quota before _qmount
Date:   Wed,  1 Jun 2022 14:37:27 +0800
Message-Id: <20220601063730.1726879-3-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601063730.1726879-1-zlang@kernel.org>
References: <20220601063730.1726879-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The g/506 fails on some filesystems (e.g. overlay) which doesn't
support prjquota:

  MOUNT_OPTIONS =  -o prjquota
  qmount failed

To avoid this failure, call _require_quota before doing real quota
mount.

Signed-off-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/506 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/506 b/tests/generic/506
index 25a5b0f8..ec91af78 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -27,6 +27,7 @@ _begin_fstest shutdown auto quick metadata quota
 _supported_fs generic
 
 _require_scratch
+_require_quota
 _require_scratch_shutdown
 
 _scratch_mkfs >/dev/null 2>&1
-- 
2.31.1

