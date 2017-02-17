Received: from mail-pg0-f51.google.com ([74.125.83.51]:33896 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbdBQGzi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 01:55:38 -0500
Received: by mail-pg0-f51.google.com with SMTP id z67so13181933pgb.1
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 22:55:38 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 1/2] common/rc: remove unnecessary cat in _ddt
Date: Thu, 16 Feb 2017 22:54:51 -0800
Message-Id: <7e55bbd20c8e6515e0b76b1ee4c348fb6066c502.1487314416.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Identical to v1

 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 76515e2b..6304d690 100644
--- a/common/rc
+++ b/common/rc
@@ -2417,7 +2417,7 @@ _die()
 # convert urandom incompressible data to compressible text data
 _ddt()
 {
-	cat /dev/urandom | od | dd iflag=fullblock ${*}
+	od /dev/urandom | dd iflag=fullblock ${*}
 }
 
 #takes files, randomdata
-- 
2.11.1

