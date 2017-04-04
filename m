Received: from mail.kernel.org ([198.145.29.136]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933608AbdDEKwZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Apr 2017 06:52:25 -0400
From: fdmanana@kernel.org
Subject: [PATCH 1/3] common/rc: test that xfs_io's falloc command supports specific flags
Date: Tue,  4 Apr 2017 07:34:29 +0100
Message-Id: <1491287671-23097-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

For example NFS 4.2 supports fallocate but it does not support its
KEEP_SIZE flag, so we want to skip tests that use fallocate with that
flag on filesystems that don't support it.

Suggested-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index e1ab2c6..3d0f089 100644
--- a/common/rc
+++ b/common/rc
@@ -2021,8 +2021,8 @@ _require_xfs_io_command()
 	"chproj")
 		testio=`$XFS_IO_PROG -F -f -c "chproj 0" $testfile 2>&1`
 		;;
-	"falloc" )
-		testio=`$XFS_IO_PROG -F -f -c "falloc 0 1m" $testfile 2>&1`
+	"falloc*" )
+		testio=`$XFS_IO_PROG -F -f -c "$command 0 1m" $testfile 2>&1`
 		;;
 	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
 		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
-- 
2.7.0.rc3

