Received: from mail-pf0-f195.google.com ([209.85.192.195]:42371 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeDLFHj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Apr 2018 01:07:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id o16so2633394pfk.9
        for <fstests@vger.kernel.org>; Wed, 11 Apr 2018 22:07:39 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 2/2] common/rc: raise mixed mode threshold to 1GB
Date: Wed, 11 Apr 2018 22:07:29 -0700
Message-Id: <0dfb46a79e393cdb6ef24e567e6c78c8cc230a9a.1523509644.git.osandov@fb.com>
In-Reply-To: <d928f86c748db034ca4efd849e01c5c2bf805199.1523509644.git.osandov@fb.com>
References: <d928f86c748db034ca4efd849e01c5c2bf805199.1523509644.git.osandov@fb.com>
In-Reply-To: <d928f86c748db034ca4efd849e01c5c2bf805199.1523509644.git.osandov@fb.com>
References: <d928f86c748db034ca4efd849e01c5c2bf805199.1523509644.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

generic/427 creates a 256 MB filesystem and then writes a 200 MB file,
which fails on Btrfs if mixed mode is not enabled. Raise the threshold
to 1GB, which is where we typically recommend mixed mode.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 5dbb8fe5..dc0062de 100644
--- a/common/rc
+++ b/common/rc
@@ -999,7 +999,7 @@ _scratch_mkfs_sized()
 	;;
     btrfs)
 	local mixed_opt=
-	(( fssize <= 100 * 1024 * 1024 )) && mixed_opt='--mixed'
+	(( fssize <= 1024 * 1024 * 1024 )) && mixed_opt='--mixed'
 	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 	;;
     jfs)
-- 
2.17.0

