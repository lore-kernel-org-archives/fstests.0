Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:20528 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752766AbbBLMtg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 12 Feb 2015 07:49:36 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1CCmbbA032440
	for <fstests@vger.kernel.org>; Thu, 12 Feb 2015 20:48:37 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] Fix warning of "Usage: _is_block_dev dev"
Date: Thu, 12 Feb 2015 20:48:14 +0800
Message-ID: <1423745294-20408-1-git-send-email-zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

_is_block_dev() will show above warning when "$dev" is not exist.
It happened when user hadn't set $SCRATCH_DEV(optional) and check
$TEST_DEV.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/common/rc b/common/rc
index 5377ba0..d9815c7 100644
--- a/common/rc
+++ b/common/rc
@@ -1167,19 +1167,22 @@ _require_test()
 		fi
 		;;
 	*)
-		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
-		 then
-		     _notrun "this test requires a valid \$TEST_DEV"
-		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
-		 then
-		     _notrun "this test requires a valid \$TEST_DEV"
-		 fi
+		if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
+		then
+		    _notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ -n "$SCRATCH_DEV" ]
+		then
+		    if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
+		    then
+			_notrun "this test requires a valid \$TEST_DEV"
+		    fi
+		fi
 		if [ ! -d "$TEST_DIR" ]
 		then
-		     _notrun "this test requires a valid \$TEST_DIR"
+		    _notrun "this test requires a valid \$TEST_DIR"
 		fi
-		 ;;
+		;;
     esac
 
     # mounted?
-- 
1.8.5.1

