Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E245CC433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 06:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiC3GFm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 02:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiC3GFi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 02:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2411711172
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648620230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Q1i2sbtxjkS5+Ewm8OS9J46uq/WBqgT1iaxNw44870=;
        b=W+RYUHjwSFGbwiHAdujAUhS38PqI0K45ojp26SnIbEcr0Kfjm3kPXDzIKl2yJ9j3osu9TF
        W6WyL3WfrOH3pfP2hPUMGWkolsagUYU304RSOLyasfmS2Y4FldV0Hug7Uzzh3yppZnNTLE
        6GHca2fkIGDNKnvfY9CS4++TegdGHYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-Fi5Fe69FOfCX76FRXq_rqA-1; Wed, 30 Mar 2022 02:03:48 -0400
X-MC-Unique: Fi5Fe69FOfCX76FRXq_rqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A9E080029D;
        Wed, 30 Mar 2022 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5926400E132;
        Wed, 30 Mar 2022 06:03:46 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, Boyang Xue <bxue@redhat.com>
Subject: [PATCH v2] generic/674: replace _require_scratch_reflink with _require_scratch_dedupe
Date:   Wed, 30 Mar 2022 14:03:39 +0800
Message-Id: <20220330060339.1528398-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
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

