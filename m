Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752302AbeENOmA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 10:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC0A4402290A
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 14:41:59 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-160.pek2.redhat.com [10.72.12.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C29392024CA9
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 14:41:58 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] xfs: skip growfs test on large device
Date: Mon, 14 May 2018 22:41:53 +0800
Message-Id: <20180514144153.14638-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When test on large SCRATCH_DEV, grow a small XFS to huge size is a
horrible thing (e.g grow 128M to 500T). So skip this kind of tests
if LARGE_SCRATCH_DEV is yes.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V3 drops all _scratch_xfs_growfs related code. Turn to use
_require_no_large_scratch_dev.


 tests/xfs/002 | 1 +
 tests/xfs/127 | 1 +
 tests/xfs/233 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/xfs/002 b/tests/xfs/002
index 741117be..a6114748 100755
--- a/tests/xfs/002
+++ b/tests/xfs/002
@@ -51,6 +51,7 @@ _cleanup()
 _supported_fs xfs
 _supported_os Linux
 _require_scratch_nocheck
+_require_no_large_scratch_dev
 
 # So we can explicitly turn it _off_:
 _require_xfs_mkfs_crc
diff --git a/tests/xfs/127 b/tests/xfs/127
index 9df99904..60597fbf 100755
--- a/tests/xfs/127
+++ b/tests/xfs/127
@@ -45,6 +45,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs xfs
 _require_scratch_reflink
+_require_no_large_scratch_dev
 _require_cp_reflink
 
 echo "Format and mount"
diff --git a/tests/xfs/233 b/tests/xfs/233
index e61c444d..b20dd4f1 100755
--- a/tests/xfs/233
+++ b/tests/xfs/233
@@ -44,6 +44,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs xfs
 _require_xfs_scratch_rmapbt
+_require_no_large_scratch_dev
 
 echo "Format and mount"
 _scratch_mkfs_sized $((2 * 4096 * 4096)) > $seqres.full 2>&1
-- 
2.14.3

