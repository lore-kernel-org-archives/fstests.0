Received: from cn.fujitsu.com ([59.151.112.132]:64484 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750743AbcGLFlx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 Jul 2016 01:41:53 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
	by cn.fujitsu.com (Postfix) with ESMTP id A603F41C0B8A
	for <fstests@vger.kernel.org>; Tue, 12 Jul 2016 13:41:43 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/083: disable dmesg check
Date: Tue, 12 Jul 2016 13:41:44 +0800
Message-ID: <1468302104-15288-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

xfs/083 will corrupt the fs intentionally, there will be WARNINGs
in dmesg as expected, so here disable dmesg check.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/083 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/xfs/083 b/tests/xfs/083
index d897754..040f3b6 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -102,6 +102,10 @@ scratch_repair() {
 }
 
 rm -f $seqres.full
+# This test will corrupt fs intentionally, so there will be WARNINGs
+# in dmesg as expected
+_disable_dmesg_check
+
 echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
 SRCDIR=`pwd`
 test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-3 -n 32"
-- 
1.8.3.1



