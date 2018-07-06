Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753653AbeGFGHh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Jul 2018 02:07:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80AF0401DEAB
        for <fstests@vger.kernel.org>; Fri,  6 Jul 2018 06:07:36 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-128.pek2.redhat.com [10.72.12.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 690127C20
        for <fstests@vger.kernel.org>; Fri,  6 Jul 2018 06:07:35 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs: skip copy fs test on large device
Date: Fri,  6 Jul 2018 14:07:28 +0800
Message-Id: <20180706060728.6606-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When test on large SCRATCH_DEV, copy a huge size XFS to TEST_DIR
will fill the TEST_DIR soon, and xfs_copy process will be blocked
there. Due to copy LARGE_SCRATCH_DEV won't add any more test
coverage, so skip this kind of tests if LARGE_SCRATCH_DEV is yes.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Refer to "a82e9464 xfs: skip growfs test on large device", xfs_copy a
huge size XFS will be blocked, so skip this kind of tests too.

Thanks,
Zorro

 tests/xfs/077 | 1 +
 tests/xfs/284 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/xfs/077 b/tests/xfs/077
index 3eaa5ffd..02bcc9f7 100755
--- a/tests/xfs/077
+++ b/tests/xfs/077
@@ -38,6 +38,7 @@ _supported_os Linux
 # xfs_copy does not support realtime devices
 _require_no_realtime
 _require_scratch
+_require_no_large_scratch_dev
 _require_xfs_crc
 _require_meta_uuid
 
diff --git a/tests/xfs/284 b/tests/xfs/284
index fc51af0e..07f71031 100755
--- a/tests/xfs/284
+++ b/tests/xfs/284
@@ -38,6 +38,7 @@ _supported_os Linux
 _require_no_realtime
 _require_test
 _require_scratch
+_require_no_large_scratch_dev
 
 function filter_mounted()
 {
-- 
2.14.4

