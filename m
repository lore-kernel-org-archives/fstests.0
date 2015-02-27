Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:19086 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754229AbbB0Dbu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 22:31:50 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1R3UuvF032638
	for <fstests@vger.kernel.org>; Fri, 27 Feb 2015 11:30:56 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v2 1/2] xfstests: fix a typo in _require_block_device()
Date: Fri, 27 Feb 2015 11:30:35 +0800
Message-ID: <b16ee3a4b85e6bed307f752e66c839b100df4744.1425007753.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

We need to check "$1" instead "$SCRATCH_DEV" in this function.

Changelog v1->v2:
  Use tab instead of space to fit new code style.
  Suggested by: Dave Chinner <david@fromorbit.com>

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1ed9df5..23193c8 100644
--- a/common/rc
+++ b/common/rc
@@ -1288,7 +1288,7 @@ _require_block_device()
 		echo "Usage: _require_block_device <dev>" 1>&2
 		exit 1
 	fi
-	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
+	if [ "`_is_block_dev "$1"`" == "" ]; then
 		_notrun "require $1 to be valid block disk"
 	fi
 }
-- 
1.8.5.1

