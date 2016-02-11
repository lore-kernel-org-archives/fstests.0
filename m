Received: from mx1.redhat.com ([209.132.183.28]:42118 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcBKJ3R (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 04:29:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 4265B7AE94
	for <fstests@vger.kernel.org>; Thu, 11 Feb 2016 09:29:17 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/072: limit max cpu number to 8 to avoid long run time and high system pressure
Date: Thu, 11 Feb 2016 17:28:46 +0800
Message-Id: <1455182926-7782-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Right now generic/072 scales the loop count based on the cpu count. But
on hosts with many cpus(100+), generic/072 runs for hours and generates
very high system load.

Given that the original bug can be reproduced easily on unpatched
kernel, the great number of loops and long run time are not needed. So
limiting the cpu number to 8 (which gives around 20 seconds run time on
my test vm with 8 vcpus) seems reasonable.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/072 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/072 b/tests/generic/072
index 6e59d84..ece71fb 100755
--- a/tests/generic/072
+++ b/tests/generic/072
@@ -51,6 +51,10 @@ _require_xfs_io_command "fcollapse"
 
 testfile=$TEST_DIR/testfile.$seq
 NCPUS=`$here/src/feature -o`
+# cap NCPUS to 8 at maximum to avoid long run time on hosts with many cpus
+if [ $NCPUS -gt 8 ]; then
+	NCPUS=8
+fi
 OUTER_LOOPS=$((10 * $NCPUS * $LOAD_FACTOR))
 INNER_LOOPS=$((50 * $NCPUS * $LOAD_FACTOR))
 # fcollapse/truncate continuously and simultaneously a same file
-- 
2.5.0

