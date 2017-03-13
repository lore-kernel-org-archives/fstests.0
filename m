Received: from mx2.suse.de ([195.135.220.15]:34712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbdCMSHd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Mar 2017 14:07:33 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH] common/rc: Use -v option with findmnt
Date: Mon, 13 Mar 2017 13:07:26 -0500
Message-Id: <20170313180726.1967-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since btrfs puts in the subvol name in the device, we should
use -v option to not print the bind mounts or btrfs volumes.

Fixes: 5e6892d ("common/rc: use findmnt to check mounted device")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index d53f679..d7a5321 100644
--- a/common/rc
+++ b/common/rc
@@ -1463,7 +1463,7 @@ _check_mounted_on()
 	local type=$5
 
 	# find $dev as the source, and print result in "$dev $mnt" format
-	local mount_rec=`findmnt -rnc -S $dev -o SOURCE,TARGET`
+	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
 	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
 
 	# if it's mounted, make sure its on $mnt
-- 
2.10.2

