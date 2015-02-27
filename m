Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:32931 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753337AbbB0Dbu convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 22:31:50 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1R3UvGQ032642
	for <fstests@vger.kernel.org>; Fri, 27 Feb 2015 11:30:57 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v4 2/2] Fix warning of "Usage: _is_block_dev dev"
Date: Fri, 27 Feb 2015 11:30:36 +0800
Message-ID: <d52aa3ce8d066f0adb21acdb2704b60b424ecae3.1425007754.git.zhaolei@cn.fujitsu.com>
In-Reply-To: <b16ee3a4b85e6bed307f752e66c839b100df4744.1425007753.git.zhaolei@cn.fujitsu.com>
References: <b16ee3a4b85e6bed307f752e66c839b100df4744.1425007753.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

_is_block_dev() will show above warning when "$dev" is not exist.
It happened when the program check $TEST_DEV with blank $SCRATCH_DEV
which is optional.

Changelog v3->v4:
 Fix problem by adding quotes to _is_block_dev()'s argument.
 Suggested by: Lukáš Czerner <lczerner@redhat.com>

Changelog v2->v3:
 Separate __same_block_dev() from _is_block_dev() to make code
 self documenting.
 Suggested by: Dave Chinner <david@fromorbit.com>

Changelog v1->v2:
 Rewrite _is_block_dev() to make caller code simple.
 Suggested by: Dave Chinner <david@fromorbit.com>

Suggested-by: Lukáš Czerner <lczerner@redhat.com>
Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 23193c8..7ae0933 100644
--- a/common/rc
+++ b/common/rc
@@ -1095,11 +1095,11 @@ _require_scratch_nocheck()
 		fi
 		;;
 	*)
-		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
+		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
 		 then
 		     _notrun "this test requires a valid \$SCRATCH_DEV"
 		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
+		 if [ "`_is_block_dev "$SCRATCH_DEV"`" = "`_is_block_dev "$TEST_DEV"/`" ]
 		 then
 		     _notrun "this test requires a valid \$SCRATCH_DEV"
 		 fi
@@ -1167,11 +1167,11 @@ _require_test()
 		fi
 		;;
 	*)
-		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
+		 if [ -z "$TEST_DEV" -o "`_is_block_dev "$TEST_DEV"`" = "" ]
 		 then
 		     _notrun "this test requires a valid \$TEST_DEV"
 		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
+		 if [ "`_is_block_dev "$SCRATCH_DEV"`" = "`_is_block_dev "$TEST_DEV"`" ]
 		 then
 		     _notrun "this test requires a valid \$TEST_DEV"
 		 fi
@@ -2236,10 +2236,10 @@ _require_scratch_dev_pool()
 	esac
 
 	for i in $SCRATCH_DEV_POOL; do
-		if [ "`_is_block_dev $i`" = "" ]; then
+		if [ "`_is_block_dev "$i"`" = "" ]; then
 			_notrun "this test requires valid block disk $i"
 		fi
-		if [ "`_is_block_dev $i`" = "`_is_block_dev $TEST_DEV`" ]; then
+		if [ "`_is_block_dev "$i"`" = "`_is_block_dev "$TEST_DEV"`" ]; then
 			_notrun "$i is part of TEST_DEV, this test requires unique disks"
 		fi
 		if _mount | grep -q $i; then
-- 
1.8.5.1

