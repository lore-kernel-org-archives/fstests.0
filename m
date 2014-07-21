Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:51803 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750817AbaGUJqQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 21 Jul 2014 05:46:16 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6L9kCLw023729
	for <fstests@vger.kernel.org>; Mon, 21 Jul 2014 17:46:12 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Subject: [PATCH v2] xfs/292: fix format of expected message
Date: Mon, 21 Jul 2014 17:44:43 +0800
Message-ID: <1405935883-16169-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1403694146-16910-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1403694146-16910-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xing Gu <gux.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

In mkfs.xfs, it uses left-align and fixed width format when outputting
device name, so variable length of devicename makes different space's
number between "meta-data=devicename" and "isize". But in the expected
output, the space' number between them is fixed. This behavior often
results in the case failure. So fix the format of expected message.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 tests/xfs/292     |  9 +++++++--
 tests/xfs/292.out | 10 ++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/292 b/tests/xfs/292
index 2910118..b4a392f 100755
--- a/tests/xfs/292
+++ b/tests/xfs/292
@@ -53,9 +53,14 @@ rm -f $fsfile
 $XFS_IO_PROG -f -c "truncate 256g" $fsfile
 
 echo "mkfs.xfs without geometry"
-mkfs.xfs -f $fsfile 2>&1 | sed -e "s:$fsfile:FILENAME:g" | grep meta-data
+mkfs.xfs -f $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
+grep -E 'ddev|isize|agcount|agsize' $tmp.mkfs | \
+    sed -e "s:$fsfile:FILENAME:g"
+
 echo "mkfs.xfs with cmdline geometry"
-mkfs.xfs -f -d su=16k,sw=5 $fsfile 2>&1 | sed -e "s:$fsfile:FILENAME:g" | grep meta-data
+mkfs.xfs -f -d su=16k,sw=5 $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
+grep -E 'ddev|isize|agcount|agsize' $tmp.mkfs | \
+    sed -e "s:$fsfile:FILENAME:g"
 
 rm -f $fsfile
 
diff --git a/tests/xfs/292.out b/tests/xfs/292.out
index fd88105..2837d74 100644
--- a/tests/xfs/292.out
+++ b/tests/xfs/292.out
@@ -1,5 +1,11 @@
 QA output created by 292
 mkfs.xfs without geometry
-meta-data=FILENAME   isize=256    agcount=4, agsize=16777216 blks
+ddev=FILENAME
+isize=256
+agcount=4
+agsize=16777216
 mkfs.xfs with cmdline geometry
-meta-data=FILENAME   isize=256    agcount=16, agsize=4194304 blks
+ddev=FILENAME
+isize=256
+agcount=16
+agsize=4194304
-- 
1.9.3

