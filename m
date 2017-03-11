Received: from mail-pf0-f193.google.com ([209.85.192.193]:35535 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbdCKAzu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 19:55:50 -0500
Received: by mail-pf0-f193.google.com with SMTP id 67so12418873pfg.2
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 16:55:49 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic/361: add _require_loop
Date: Fri, 10 Mar 2017 16:55:12 -0800
Message-Id: <20170311005512.129820-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

generic/361 uses a loopback device, so it should have _require_loop.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/361 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/361 b/tests/generic/361
index c09863c3..cdd480f2 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -53,6 +53,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_block_device $SCRATCH_DEV
+_require_loop
 
 # create a small filesystem to hold another filesystem image
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
-- 
2.12.0.246.ga2ecc84866-goog

