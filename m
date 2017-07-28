Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbdG1Ksa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Jul 2017 06:48:30 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] generic/441: whitelist gfs2 for full test
Date: Fri, 28 Jul 2017 06:48:27 -0400
Message-Id: <20170728104827.7260-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, cluster-devel@redhat.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

gfs2 passes the full-scale generic/441 test with the patch that
converts it to use errseq_t reporting for fsync.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 tests/generic/441 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/441 b/tests/generic/441
index 075d87723ca1..b98f709cb6eb 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -55,7 +55,7 @@ case $FSTYP in
 	btrfs)
 		_notrun "btrfs has a specialized test for this"
 		;;
-	ext3|ext4|xfs)
+	ext3|ext4|gfs2|xfs)
 		# Do the more thorough test if we have a logdev
 		_has_logdev && sflag=''
 		;;
-- 
2.13.3

