Received: from cn.fujitsu.com ([59.151.112.132]:46158 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754323AbcA2L46 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 29 Jan 2016 06:56:58 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
	by cn.fujitsu.com (Postfix) with ESMTP id 7196D418911F
	for <fstests@vger.kernel.org>; Fri, 29 Jan 2016 19:56:14 +0800 (CST)
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Subject: [PATCH] xfs/083: disable dmesg check
Date: Fri, 29 Jan 2016 19:54:04 +0800
Message-ID: <1454068444-23926-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This test fuzzes the metadata and accesses the corrupted fs later,
which always produces error info in dmesg and causes test fail,
so fix this.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 tests/xfs/083 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/xfs/083 b/tests/xfs/083
index 8e14e88..558b964 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -102,6 +102,11 @@ scratch_repair() {
 }
 
 rm -f $seqres.full
+
+# We will access the corrupted fs later, which always produces error
+# info in dmesg. We do not want the test to fail because of this.
+_disable_dmesg_check
+
 echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
 SRCDIR=`pwd`
 test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-3 -n 32"
-- 
1.8.4.2



