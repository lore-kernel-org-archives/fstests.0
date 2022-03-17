Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14AAC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 10:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiCQKKR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiCQKKP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 06:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1A6B1DDFC6
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647511734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xO5z5WFY6QtlZ42uDYLyjm6MFUT7Gd7vsO2ULole8xY=;
        b=hM4XknW+khd1eZjew67rnvv+7n28w0r79IGzIHQasvPDpGAN4NMlZtYN8TqjzDEldKXGRO
        ltR4QE7MwE0MymH5jwMsR56ime60MO0woTFm1tXcRe+9+8tQt3yHfgFW4v8oxck69C8nwY
        e4zf/IsdhhpjJCHU4o3CXx3CfzXKRBU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-QFHF9I7cPeGOMggFWpJAHg-1; Thu, 17 Mar 2022 06:08:50 -0400
X-MC-Unique: QFHF9I7cPeGOMggFWpJAHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DA4F18A659C
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 126F14087D82;
        Thu, 17 Mar 2022 10:08:48 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     Boyang Xue <bxue@redhat.com>
Subject: [PATCH v1 2/2] generic/513,675: check for security namespace support
Date:   Thu, 17 Mar 2022 18:08:42 +0800
Message-Id: <20220317100842.1237893-3-bxue@redhat.com>
In-Reply-To: <20220317100842.1237893-1-bxue@redhat.com>
References: <20220317100842.1237893-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 tests/generic/513 | 2 ++
 tests/generic/675 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/513 b/tests/generic/513
index dc082787..6e897fa0 100755
--- a/tests/generic/513
+++ b/tests/generic/513
@@ -12,10 +12,12 @@ _begin_fstest auto quick clone
 # Import common functions.
 . ./common/filter
 . ./common/reflink
+. ./common/attr
 
 # real QA test starts here
 _supported_fs generic
 _require_scratch_reflink
+_require_attrs security
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 
diff --git a/tests/generic/675 b/tests/generic/675
index 23b7e545..311860dc 100755
--- a/tests/generic/675
+++ b/tests/generic/675
@@ -12,12 +12,14 @@ _begin_fstest auto clone quick
 # Import common functions.
 . ./common/filter
 . ./common/reflink
+. ./common/attr
 
 # real QA test starts here
 
 # Modify as appropriate.
 _supported_fs generic
 _require_user
+_require_attrs security
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 _require_scratch_reflink
-- 
2.27.0

