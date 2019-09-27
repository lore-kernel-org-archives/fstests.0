Received: from mx2.suse.de ([195.135.220.15]:44222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbfI0Kwi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:52:38 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] common/rc: Remove special handing of 'dup' argument for btrfs
Date: Fri, 27 Sep 2019 13:52:32 +0300
Message-Id: <20190927105233.14926-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

_scratch_pool_mkfs special cases the command executed when 'dup' option
is used when creating a filesystem. This is wrong since 'dup' works
for all profiles and number of devices. This bug manifested while
exercising btrfs' balance argument combinations test.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/rc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 9f2c252e5aa5..1b150cbad2f6 100644
--- a/common/rc
+++ b/common/rc
@@ -885,13 +885,7 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
-        # if dup profile is in mkfs options call _scratch_mkfs instead
-        # because dup profile only works with single device
-        if [[ "$*" =~ dup ]]; then
-            _scratch_mkfs $*
-        else
-            $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
-        fi
+        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
         ;;
     *)
         echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
-- 
2.7.4
