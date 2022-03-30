Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F83C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 04:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiC3EbM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 00:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiC3EbJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 00:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6371819297
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 21:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648614564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w3JbzWjI51zN44YCmvrJUAp2xiXAGrf5RHxbu/J9Plw=;
        b=a5n7EQx/9HKDlZ28cvAnLMvD2orXvFQPqK1N+9rmAEYY6ex/Km2kYwL/zsz/wNAtobFXC+
        PSr9mOmvrlFrCApbwLItWG1TBYAG+P2XnmdCdGlXSC6MiF+hafmv0HQKsacAL+ES+OSkjX
        5fnt/O2TSEDueYGpDvLDALnI3S+WSho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-a5-8p196PyWjaUoyzIMrHQ-1; Wed, 30 Mar 2022 00:29:20 -0400
X-MC-Unique: a5-8p196PyWjaUoyzIMrHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADFDB3C01D98;
        Wed, 30 Mar 2022 04:29:19 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16303200B41A;
        Wed, 30 Mar 2022 04:29:17 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, Boyang Xue <bxue@redhat.com>
Subject: [PATCH v2] generic/674: replace _require_scratch_reflink with _require_scratch_dedupe
Date:   Wed, 30 Mar 2022 12:29:07 +0800
Message-Id: <20220330042907.1526317-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
Changes from v1:
In v1, keep "_require_scratch_reflink" and add "_require_scratch_dedupe"
In v2, replace "_require_scratch_reflink" with "_require_scratch_dedupe"

Please help review. Thanks!

-Boyang

 tests/generic/674 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/674 b/tests/generic/674
index bf0bcffb..920ed5f2 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -18,7 +18,7 @@ _begin_fstest auto clone quick
 # Modify as appropriate.
 _supported_fs generic
 _require_user
-_require_scratch_reflink
+_require_scratch_dedupe
 _require_xfs_io_command dedupe
 
 _scratch_mkfs >> $seqres.full
-- 
2.27.0

