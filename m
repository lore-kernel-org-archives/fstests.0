Received: from mailout3.samsung.com ([203.254.224.33]:48228 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcBZFg2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 26 Feb 2016 00:36:28 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3500CHB3KEJG70@mailout3.samsung.com> for
 fstests@vger.kernel.org; Fri, 26 Feb 2016 14:36:26 +0900 (KST)
From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] common/attr: add maximum acl count for f2fs
Date: Fri, 26 Feb 2016 13:35:42 +0800
Message-id: <017201d17057$a270c460$e7524d20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: zh-cn
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Add a max acl count into common/attr for f2fs in order to make
f2fs passing generic/026 test case.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 common/attr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/attr b/common/attr
index 86fe181..0efc26d 100644
--- a/common/attr
+++ b/common/attr
@@ -42,6 +42,9 @@ _acl_get_max()
 	jfs)
 		echo 8191
 		;;
+	f2fs)
+		echo 506
+		;;
 	*)
 		echo 0
 		;;
-- 
2.7.0


