Return-Path: <fstests-owner@vger.kernel.org>
Received: from smtpbg303.qq.com ([184.105.206.26]:57798 "EHLO smtpbg303.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbEUAnU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 May 2015 20:43:20 -0400
From: Wang Sheng-Hui <shhuiw@foxmail.com>
Subject: [PATCH] xfstests: correct comment in generic/135
Date: Thu, 21 May 2015 08:42:57 +0800
Message-Id: <1432168977-4330-1-git-send-email-shhuiw@foxmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

xfs_io '-d' specifies direct IO, not sync IO.

Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
---
 tests/generic/135 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/135 b/tests/generic/135
index 79558f5..2444803 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -63,7 +63,7 @@ $XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x12 0 4k' async_file > /dev/null
 # create file with sync I/O
 $XFS_IO_PROG -f -s -c 'pwrite -b 4k -S 0x34 0 4k' sync_file > /dev/null
 
-# create file with sync I/O
+# create file with direct I/O
 $XFS_IO_PROG -f -d -c 'pwrite -b 4k -S 0x56 0 4k' direct_file > /dev/null
 
 # create file, truncate and then dirty again
-- 
1.8.3.2


