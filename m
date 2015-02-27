Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42495 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbbB0BYH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 20:24:07 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] generic/065: f2fs serves 64KB size with zero data
Date: Thu, 26 Feb 2015 17:23:46 -0800
Message-Id: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

The f2fs provides 64KB size with 0 data after fsync was done to directory file.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/generic/065 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/065 b/tests/generic/065
index b5a296d..3d2b437 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -139,6 +139,10 @@ ext3)
 	# a 64Kb file, with all bytes having the value 0xff
 	[ $hello_digest == "ecb99e6ffea7be1e5419350f725da86b" ] && digest_ok=yes
 	;;
+f2fs)
+	# a 64Kb file, with all bytes having the value 0
+	[ $hello_digest == "fcd6bcb56c1689fcef28b57c22475bad" ] && digest_ok=yes
+	;;
 *)
 	# an empty file
 	[ $hello_digest == "d41d8cd98f00b204e9800998ecf8427e" ] && digest_ok=yes
-- 
2.1.1

