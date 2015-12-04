Received: from mail.kernel.org ([198.145.29.136]:53966 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbbLDWPx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 17:15:53 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] common/config: add mkfs options for f2fs
Date: Fri,  4 Dec 2015 14:15:44 -0800
Message-Id: <1449267345-79400-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
References: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch adds an interface to give mkfs option for f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/config b/common/config
index dca7aad..a534329 100644
--- a/common/config
+++ b/common/config
@@ -352,6 +352,9 @@ _mkfs_opts()
 	jfs)
 		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
 		;;
+	f2fs)
+		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
+		;;
 	*)
 		;;
 	esac
-- 
2.4.9 (Apple Git-60)

