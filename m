Received: from mail-wm0-f46.google.com ([74.125.82.46]:54547 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdJJNb7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Oct 2017 09:31:59 -0400
Received: by mail-wm0-f46.google.com with SMTP id i124so5356546wmf.3
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2017 06:31:59 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Subject: [PATCH] xfs/246: add _require_scratch
Date: Tue, 10 Oct 2017 15:31:16 +0200
Message-Id: <1507642276-16205-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Javier Gonzales <jg@lightnvm.io>, Hans Holmberg <hans.holmberg@cnexlabs.com>
List-ID: <fstests@vger.kernel.org>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The test uses a scratch device, so add _require_scratch so
the test will be skipped instead of failing when $SCRATCH_DEV
has not been specified.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 tests/xfs/246 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/246 b/tests/xfs/246
index bf471cc..61d2545 100755
--- a/tests/xfs/246
+++ b/tests/xfs/246
@@ -43,6 +43,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs xfs
 _require_xfs_io_command "bmap" "-c"
+_require_scratch
 
 rm -f $seqres.full
 
-- 
2.7.4

