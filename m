Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:8716 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751598AbaFYLlk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 25 Jun 2014 07:41:40 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5PBfNqi023756
	for <fstests@vger.kernel.org>; Wed, 25 Jun 2014 19:41:23 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Subject: [PATCH] xfs/300: redirect mkfs output to results/xfs directory
Date: Wed, 25 Jun 2014 19:40:06 +0800
Message-ID: <1403696406-18763-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xing Gu <gux.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 tests/xfs/300 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/300 b/tests/xfs/300
index 0958f76..db83fd4 100755
--- a/tests/xfs/300
+++ b/tests/xfs/300
@@ -51,7 +51,7 @@ getenforce | grep -q "Enforcing\|Permissive" || _notrun "SELinux not enabled"
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs -i size=256 >> $seq.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_xfs -i size=256 >> $seqres.full 2>&1 || _fail "mkfs failed"
 
 # Manually mount to avoid fs-wide context set by default in xfstests
 mount $SCRATCH_DEV $SCRATCH_MNT
-- 
1.9.3

