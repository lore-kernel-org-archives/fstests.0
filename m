Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758567AbeD0Qd3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 12:33:29 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH][RESEND] generic/441: whitelist gfs2 for full test
Date: Fri, 27 Apr 2018 12:33:27 -0400
Message-Id: <20180427163327.20442-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

gfs2 passes the full-scale generic/441 test with the patch that
converts it to use errseq_t reporting for fsync.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 tests/generic/441 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/441 b/tests/generic/441
index 5fbfececadc0..be903fbf94f8 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -58,7 +58,7 @@ case $FSTYP in
 	btrfs)
 		_notrun "btrfs has a specialized test for this"
 		;;
-	ext3|ext4|xfs)
+	ext3|ext4|gfs2|xfs)
 		# Do the more thorough test if we have a logdev
 		_has_logdev && sflag=''
 		;;
-- 
2.14.3

