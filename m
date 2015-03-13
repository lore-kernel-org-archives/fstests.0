Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:43205 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751547AbbCMIxN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 13 Mar 2015 04:53:13 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2D8piAF009014
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2015 16:51:44 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] fix "utility required warning" with empty utility name
Date: Fri, 13 Mar 2015 16:51:28 +0800
Message-ID: <fb898cb6df594265e8677fc99e374e858b4cebea.1426236677.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

In generic/019, if we hadn't install fio, we will get following output:
 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 lenovo 4.0.0-rc3_HEAD_9eccca0843205f87c00404b663188b88eb248051_
 MKFS_OPTIONS  -- /dev/sda6
 MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6 /var/ltf/tester/scratch_mnt

 generic/019      [not run]  utility required, skipped this test <- *
 Not run: generic/019
 Passed all 0 tests

Reason of blank utility name is:
$1 and $2 are reversed in _require_command(), this patch fixed
this error.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1ed9df5..febad8c 100644
--- a/common/rc
+++ b/common/rc
@@ -1276,7 +1276,7 @@ _require_realtime()
 #
 _require_command()
 {
-    [ -n "$1" ] && _cmd="$1" || _cmd="$2"
+    [ -n "$2" ] && _cmd="$2" || _cmd="$1"
     [ -n "$1" -a -x "$1" ] || _notrun "$_cmd utility required, skipped this test"
 }
 
-- 
1.8.5.1

