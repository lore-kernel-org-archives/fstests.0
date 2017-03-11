Received: from mail-pg0-f66.google.com ([74.125.83.66]:35589 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbdCKA4E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 19:56:04 -0500
Received: by mail-pg0-f66.google.com with SMTP id g2so7392655pge.2
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 16:56:03 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] btrfs/020: add _require_loop
Date: Fri, 10 Mar 2017 16:55:53 -0800
Message-Id: <20170311005553.129977-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

btrfs/020 uses a loopback device, so it should have _require_loop.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/btrfs/020 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/020 b/tests/btrfs/020
index 3752dcff..6e3dd4a5 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -56,6 +56,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 _supported_fs btrfs
 _supported_os Linux
 _require_test
+_require_loop
 
 rm -f $seqres.full
 echo "Silence is golden"
-- 
2.12.0.246.ga2ecc84866-goog

