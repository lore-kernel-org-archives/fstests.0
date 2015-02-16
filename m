Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:12381 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751108AbbBPGvy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Feb 2015 01:51:54 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1G6p2FM005676
	for <fstests@vger.kernel.org>; Mon, 16 Feb 2015 14:51:02 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
Date: Mon, 16 Feb 2015 14:50:39 +0800
Message-ID: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

We need to check "$1" instead "$SCRATCH_DEV" in this function.
And make tabs same with other code.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 7449a1d..76522d4 100644
--- a/common/rc
+++ b/common/rc
@@ -1284,13 +1284,13 @@ _require_command()
 # $1 - device
 _require_block_device()
 {
-	if [ -z "$1" ]; then
-		echo "Usage: _require_block_device <dev>" 1>&2
-		exit 1
-	fi
-	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
-		_notrun "require $1 to be valid block disk"
-	fi
+    if [ -z "$1" ]; then
+	echo "Usage: _require_block_device <dev>" 1>&2
+	exit 1
+    fi
+    if [ "`_is_block_dev $1`" == "" ]; then
+	_notrun "require $1 to be valid block disk"
+    fi
 }
 
 # this test requires the device mapper flakey target
-- 
1.8.5.1

