Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D5C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 10:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiCQKKQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiCQKKO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 06:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3D8A1CD7FF
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647511730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OShdCjSRfPXKfWTwf94U8gmY+g+zCa3SbinXmt8loJg=;
        b=Wtefk7RiHxwGEQyZjkk4Hj1+RnlZiWxfJTDk3BaJapF32MsxAdTZgG8i2qo9PGwNyiVtsc
        WKRRf+SfyltTo5ImKHHco/ZjFK4r17d4iwxqUxfzDXD8i3DzHQCwfCLLUO/GlvOx5DMhAM
        sTovAmF/YQX9r4hBM6RlUDARtQB7hEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-XH5zrZarPhaFlVV4RLTCSA-1; Thu, 17 Mar 2022 06:08:48 -0400
X-MC-Unique: XH5zrZarPhaFlVV4RLTCSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72461811E78
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 364344087D7E;
        Thu, 17 Mar 2022 10:08:46 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     Boyang Xue <bxue@redhat.com>
Subject: [PATCH v1 1/2] generic/674: check for dedupe support on scratch fs
Date:   Thu, 17 Mar 2022 18:08:41 +0800
Message-Id: <20220317100842.1237893-2-bxue@redhat.com>
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
 tests/generic/674 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/674 b/tests/generic/674
index bf0bcffb..7e5e4e29 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -19,6 +19,7 @@ _begin_fstest auto clone quick
 _supported_fs generic
 _require_user
 _require_scratch_reflink
+_require_scratch_dedupe
 _require_xfs_io_command dedupe
 
 _scratch_mkfs >> $seqres.full
-- 
2.27.0

