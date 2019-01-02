Received: from mx1.redhat.com ([209.132.183.28]:37396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfABEDe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Jan 2019 23:03:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C01F5275A
        for <fstests@vger.kernel.org>; Wed,  2 Jan 2019 04:03:34 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3430C60123
        for <fstests@vger.kernel.org>; Wed,  2 Jan 2019 04:03:32 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 2/2] xfs/139-140: skip testing on large scratch dev
Date: Wed,  2 Jan 2019 12:03:19 +0800
Message-Id: <20190102040319.7668-2-zlang@redhat.com>
In-Reply-To: <20190102040319.7668-1-zlang@redhat.com>
References: <20190102040319.7668-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

x/139 and x/140 makes XFS with very small agsize. That agsize is too
small for a large fs. And it's not necessary to test on large fs, so
skip it directly if scratch dev is large dev.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/139 | 3 +++
 tests/xfs/140 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/xfs/139 b/tests/xfs/139
index 3a20ce50..4c498ff2 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -29,6 +29,9 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+# Below agsize (16384 * $blksz) is too small for a large fs, and it's not
+# necessary to test on large fs
+_require_no_large_scratch_dev
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/xfs/140 b/tests/xfs/140
index 7385dc42..863b1e6f 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -29,6 +29,9 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+# Below agsize is too small for a large fs, and it's not necessary to test on
+# large fs
+_require_no_large_scratch_dev
 _require_scratch_reflink
 _require_cp_reflink
 
-- 
2.17.2
