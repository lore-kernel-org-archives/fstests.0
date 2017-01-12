Received: from mx2.suse.de ([195.135.220.15]:41508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbdALRTB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jan 2017 12:19:01 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D6C1AC81
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2017 17:18:59 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/3] common: remove unused XFSPROGS_VERSION check
Date: Thu, 12 Jan 2017 18:18:48 +0100
Message-Id: <20170112171849.10784-2-ddiss@suse.de>
In-Reply-To: <20170112171849.10784-1-ddiss@suse.de>
References: <20170112132656.7caa64dd@suse.de>
 <20170112171849.10784-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

This was only used to check for mkfs.xfs -n version=ci support, which is
carried in xfsprogs >= 2.10. _require_xfs_mkfs_ciname() is now used to
explicitly check for the mkfs parameter.

Suggested-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/config | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/common/config b/common/config
index 6cce7ce..0706aca 100644
--- a/common/config
+++ b/common/config
@@ -223,21 +223,6 @@ if [ "$UDEV_SETTLE_PROG" == "" ]; then
 fi
 export UDEV_SETTLE_PROG
 
-# Generate a comparable xfsprogs version number in the form of
-# major * 10000 + minor * 100 + release
-#
-# $ xfs_db -V
-# xfs_db version 2.9.7
-#
-# so, 2.9.7 = 20907
-_version=`$XFS_DB_PROG -V | $AWK_PROG '
-	/version/ {
-		if (split($3,ver,".") == 3)
-			print (ver[1] * 10000) + (ver[2] * 100) + ver[3];
-	}'`
-[ -z "$_version" ] && _fatal "xfsprogs version cannot be found"
-export XFSPROGS_VERSION="$_version"
-
 case "$HOSTOS" in
     IRIX*)
         export MKFS_XFS_PROG="`set_prog_path mkfs_xfs`"
-- 
2.10.2

