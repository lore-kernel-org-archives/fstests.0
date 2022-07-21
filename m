Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE557C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 02:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGUCa1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUCa0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 22:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7B33FA3E
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658370624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5py8VgE9FEVg8HqvZe0dJsCNU7ePBFNOOjN2yznygs=;
        b=LC1B619C4G91kAXsWdhwrNCFJXPcnKeGsHS2oIADsXPk/IQZRdq/4rNi0zkXhnBLCXgzfZ
        nGtaA3DNFCJEg79T6Om3mr+8EUM0g9bEmE4mWf4KdMhKJjqF+KXbBwukaXHizBjQCzSxCZ
        WaJVqqbrmopahGzQkxRRd3F+x5itwGc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-e2kMAqzaPZG_XPJzLr0BNA-1; Wed, 20 Jul 2022 22:30:23 -0400
X-MC-Unique: e2kMAqzaPZG_XPJzLr0BNA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B02F32812C22
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74DCE492C3B;
        Thu, 21 Jul 2022 02:30:21 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     Boyang Xue <bxue@redhat.com>
Subject: [PATCH v1] generic/476: requires 27GB scratch size
Date:   Thu, 21 Jul 2022 10:29:59 +0800
Message-Id: <20220721022959.4189726-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

The test requires larger scratch dev size when running on top of NFS other
than ext4 and xfs. It requires at least 27GB in my test. Without this
requirement, the test run never finishes on NFS, leaving 100% scratch disk
space use.

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
Hi,

I find generic/476 easily goes into an infinite run on top of NFS. When it
happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
`nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a large
enough SCRATCH_MNT, the problem disappears. So I post this patch to add the size
requirement.

Please help review this patch. Thanks!

-Boyang

 tests/generic/476 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/476 b/tests/generic/476
index 212373d1..dcc7c3da 100755
--- a/tests/generic/476
+++ b/tests/generic/476
@@ -24,6 +24,7 @@ _cleanup()
 _supported_fs generic
 
 _require_scratch
+_require_scratch_size $((27 * 1024 * 1024)) # 27GB
 _require_command "$KILLALL_PROG" "killall"
 
 echo "Silence is golden."
-- 
2.27.0

