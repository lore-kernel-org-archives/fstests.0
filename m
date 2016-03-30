Received: from mail.kernel.org ([198.145.29.136]:36000 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcCaADQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 30 Mar 2016 20:03:16 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] attr: adjust acl_max of f2fs if inline_xattr is set
Date: Wed, 30 Mar 2016 16:58:19 -0700
Message-Id: <1459382299-71068-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

If f2fs gets inline_xattr, it enlarges the whole xattr space, which also enables
to cover more acl entries up to 531 from 506.
This patch detects the mount option, inline_xattr, and changes the result of
_acl_get_max for generic/026.

Fixes: 9f7bf79d0c34 ("attr: add maximum acl count for f2fs")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/attr | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/attr b/common/attr
index 0efc26d..ce2d76a 100644
--- a/common/attr
+++ b/common/attr
@@ -43,7 +43,12 @@ _acl_get_max()
 		echo 8191
 		;;
 	f2fs)
-		echo 506
+		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
+		if [ $? -eq 0 ]; then
+			echo 531
+		else
+			echo 506
+		fi
 		;;
 	*)
 		echo 0
-- 
2.6.3

