Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:14918 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751583AbaLVIof (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Dec 2014 03:44:35 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBM8i7rH032249
	for <fstests@vger.kernel.org>; Mon, 22 Dec 2014 16:44:07 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Subject: [PATCH v2] xfs/111: fix cp of missing file
Date: Mon, 22 Dec 2014 16:41:03 +0800
Message-ID: <1419237663-11015-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1419061802-27324-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1419061802-27324-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xing Gu <gux.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

After installing the test suite, src directory only contains binary
programs in the final building directory. Here executing "cp src/itrash.c
$SCRATCH_MNT/${I}" will output "cp: cannot stat 'src/itrash.c': No
such file or directory" error message. Fix it.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 tests/xfs/111 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/111 b/tests/xfs/111
index bedead8..f33f339 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -53,7 +53,7 @@ echo Create some files
 I=0
 while [ $I -lt 1000 ]
 do
-    cp src/itrash.c $SCRATCH_MNT/${I}
+    $XFS_IO_PROG -f -c "pwrite 0 512" $SCRATCH_MNT/${I} > /dev/null
     let I=$I+1
 done
 umount $SCRATCH_DEV
-- 
1.9.3

