Received: from mail-pf1-f172.google.com ([209.85.210.172]:45047 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHJAHB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Aug 2018 20:07:01 -0400
Received: by mail-pf1-f172.google.com with SMTP id k21-v6so3446115pff.11
        for <fstests@vger.kernel.org>; Thu, 09 Aug 2018 14:40:17 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] generic/228: fix restoration of kernel.core_pattern sysctl
Date: Thu,  9 Aug 2018 14:40:12 -0700
Message-Id: <83cc171697f79477991c501939dcda146aa7ba3b.1533850682.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com, Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

generic/228 changes kernel.core_pattern, so it saves it beforehand in
order to restore it. However, it adds an extra space in the process:

$ echo \"$(sysctl kernel.core_pattern | awk -F = '{print $NF}')\"
" |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %e"

Instead of using awk, just use sysctl -n to only print the value.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/228 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/228 b/tests/generic/228
index fd022313..16178c33 100755
--- a/tests/generic/228
+++ b/tests/generic/228
@@ -45,7 +45,7 @@ avail=`df -P $TEST_DIR | awk 'END {print $4}'`
 [ "$avail" -ge 104000 ] || _notrun "Test device is too small ($avail KiB)"
 
 # Suppress core dumped messages
-core_pattern=`sysctl kernel.core_pattern | awk -F = '{print $NF}'`
+core_pattern=`sysctl -n kernel.core_pattern`
 ulimit_c=`ulimit -c`
 sysctl -w kernel.core_pattern=core &>/dev/null
 ulimit -c 0
-- 
2.18.0
