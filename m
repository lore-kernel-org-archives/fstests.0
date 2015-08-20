Received: from cn.fujitsu.com ([59.151.112.132]:54515 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751015AbbHTCf3 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 19 Aug 2015 22:35:29 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7K2ZMMR022919
	for <fstests@vger.kernel.org>; Thu, 20 Aug 2015 10:35:22 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] Fix test fail of btrfs/006 caused by updated _filter_uuid()
Date: Thu, 20 Aug 2015 10:33:49 +0800
Message-ID: <5e1bb4aacc6c5b57585e6f66a708b8c21ce032ab.1440037988.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

_filter_uuid() get updated and changed output from:
 uuid: <UUID>
 ->
 uuid:  <UUID>

It is a typo introduced by xfs/077, this patch fixed this.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/filter     | 2 +-
 tests/xfs/077.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/filter b/common/filter
index 8db1b3e..af456c9 100644
--- a/common/filter
+++ b/common/filter
@@ -277,7 +277,7 @@ _filter_uuid()
 		UUID=$1
 		sed -e "s/\(uuid[ :=]\+\) $UUID/\1 <EXACTUUID>/i"
 	else
-		sed -e "s/\(uuid[ :=]\+\) *[0-9a-f-][0-9a-f-]*/\1 <UUID>/ig"
+		sed -e "s/\(uuid[ :=]\+\) [0-9a-f-][0-9a-f-]*/\1 <UUID>/ig"
 	fi
 }
 
diff --git a/tests/xfs/077.out b/tests/xfs/077.out
index fdc7d72..4e18087 100644
--- a/tests/xfs/077.out
+++ b/tests/xfs/077.out
@@ -2,7 +2,7 @@ QA output created by 077
 == Generate new UUID
 Clearing log and setting UUID
 writing all SBs
-new UUID =  <UUID>
+new UUID = <UUID>
 == Rewrite UUID
 old UUID = <EXACTUUID>
 Clearing log and setting UUID
-- 
1.8.5.1

