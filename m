Received: from mx1.redhat.com ([209.132.183.28]:53696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbcIVJGG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Sep 2016 05:06:06 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25EC86CB33
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2016 09:06:06 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] fstests: require scratch dev in tests using dm targets
Date: Thu, 22 Sep 2016 17:05:53 +0800
Message-Id: <1474535153-15183-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

We build dm device on top of scratch dev so we require $SCRATCH_DEV
to be a valid block device in _require_dm_target(). And we need to
_require_scratch before _require_dm_target, otherwise test fails if
there's no SCRATCH_DEV defined, where it should _notrun.

  +Usage: _require_block_device <dev>

So add _require_scratch_nocheck to generic/347 (we do the fs check
on thinp device), move _require_scratch before _require_dm_target in
xfs/006 and xfs/264.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/347 | 1 +
 tests/xfs/006     | 2 +-
 tests/xfs/264     | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/generic/347 b/tests/generic/347
index 7e6b5e6..3adc674 100755
--- a/tests/generic/347
+++ b/tests/generic/347
@@ -70,6 +70,7 @@ _workout()
 
 _supported_fs generic
 _supported_os Linux
+_require_scratch_nocheck
 _require_dm_target thin-pool
 
 _setup_thin
diff --git a/tests/xfs/006 b/tests/xfs/006
index d8674f4..982a161 100755
--- a/tests/xfs/006
+++ b/tests/xfs/006
@@ -49,8 +49,8 @@ rm -f $seqres.full
 # real QA test starts here
 _supported_fs xfs
 _supported_os Linux
-_require_dm_target error
 _require_scratch
+_require_dm_target error
 _require_fs_sysfs error/fail_at_unmount
 
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/xfs/264 b/tests/xfs/264
index d3e920c..245b0ad 100755
--- a/tests/xfs/264
+++ b/tests/xfs/264
@@ -49,8 +49,8 @@ rm -f $seqres.full
 # real QA test starts here
 _supported_fs xfs
 _supported_os Linux
-_require_dm_target error
 _require_scratch
+_require_dm_target error
 _require_fs_sysfs error/fail_at_unmount
 _require_fs_sysfs error/metadata/EIO/max_retries
 _require_fs_sysfs error/metadata/EIO/retry_timeout_seconds
-- 
2.7.4

