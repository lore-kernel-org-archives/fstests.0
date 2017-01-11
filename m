Received: from mx2.suse.de ([195.135.220.15]:57131 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760447AbdAKKsj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Jan 2017 05:48:39 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4B5EAAC4
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2017 10:48:37 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common: use xfs_io to obtain the xfsprogs version
Date: Wed, 11 Jan 2017 11:48:20 +0100
Message-Id: <20170111104820.7367-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

xfs_db is currently used for this, but is otherwise only used for XFS
specific tests. This change allows for the generic tests to be run on a
system without the xfs_db binary.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/config | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index 6cce7ce..1604aa9 100644
--- a/common/config
+++ b/common/config
@@ -226,11 +226,11 @@ export UDEV_SETTLE_PROG
 # Generate a comparable xfsprogs version number in the form of
 # major * 10000 + minor * 100 + release
 #
-# $ xfs_db -V
-# xfs_db version 2.9.7
+# $ xfs_io -V
+# xfs_io version 2.9.7
 #
 # so, 2.9.7 = 20907
-_version=`$XFS_DB_PROG -V | $AWK_PROG '
+_version=`$XFS_IO_PROG -V | $AWK_PROG '
 	/version/ {
 		if (split($3,ver,".") == 3)
 			print (ver[1] * 10000) + (ver[2] * 100) + ver[3];
-- 
2.10.2

