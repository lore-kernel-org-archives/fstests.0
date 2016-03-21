Received: from cn.fujitsu.com ([59.151.112.132]:31793 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751371AbcCUIvw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2016 04:51:52 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 2C637408D261
	for <fstests@vger.kernel.org>; Mon, 21 Mar 2016 16:51:38 +0800 (CST)
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: xfs: add necessary version check for xfs/122
Date: Mon, 21 Mar 2016 16:31:28 +0800
Message-ID: <1458549088-468-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>

Since commit c0cfa5651f2d ("xfs/122: update against xfsprogs 4.3"), xfs/122
has been updated against xfsprogs 4.3, so add necessary version check.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/xfs/122 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/xfs/122 b/tests/xfs/122
index 758cb50..8b35bed 100755
--- a/tests/xfs/122
+++ b/tests/xfs/122
@@ -41,6 +41,11 @@ _supported_fs xfs
 _supported_os Linux
 _require_command "$INDENT_PROG" indent
 
+# This test has been updated against xfsprogs 4.3.
+if [ $XFSPROGS_VERSION -lt 40300 ]; then
+	_notrun "this test needs xfsprogs version >= 4.3"
+fi
+
 # filter out known changes to xfs type sizes
 _type_size_filter()
 {
-- 
1.8.3.1



