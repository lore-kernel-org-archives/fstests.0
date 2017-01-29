Received: from mail-wm0-f52.google.com ([74.125.82.52]:35057 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdA2N4l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Jan 2017 08:56:41 -0500
Received: by mail-wm0-f52.google.com with SMTP id r126so179133344wmr.0
        for <fstests@vger.kernel.org>; Sun, 29 Jan 2017 05:56:40 -0800 (PST)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH] generic/074: _cleanup potentially removes local FS files
Date: Sun, 29 Jan 2017 15:56:20 +0200
Message-Id: <20170129135620.25464-1-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omer Zilberberg <omzg@plexistor.com>
List-ID: <fstests@vger.kernel.org>

fstest_dir is set after _cleanup() is defined and _require_test is
called. If _require_test fails (due to some unrelated bug in tested FS),
_cleanup will attempt to remove $fstest_dir.*, which expands to .*
This has the unfortunate effect of removing xfstests' .git and
.gitignore.

Here is the 074.out.bad file for this case:
QA output created by 074
mount: permission denied
common/rc: retrying test device mount with external set
mount: permission denied
common/rc: could not mount /dev/pmem0 on /mnt
rm: refusing to remove '.' or '..' directory: skipping '.'
rm: refusing to remove '.' or '..' directory: skipping '..'
----

The only other test which could face the same problem is generic/285.
However, that test defines _cleanup after the _require* calls, and so on
_require_test failure, 285.out.bad contains the harmless:
./common/rc: line 1: _cleanup: command not found

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
---
 tests/generic/074 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/074 b/tests/generic/074
index 55264bd..ef84263 100755
--- a/tests/generic/074
+++ b/tests/generic/074
@@ -33,7 +33,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    rm -rf $fstest_dir.* $tmp.*
+    [ -n "$fstest_dir" ] && rm -rf $fstest_dir.*
+    rm -rf $tmp.*
 }
 
 # get standard environment, filters and checks
-- 
2.9.3

