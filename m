Received: from mx1.redhat.com ([209.132.183.28]:49614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933296AbdIYIlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Sep 2017 04:41:16 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v5 2/3] generic/413: skip dax to nondax dio test if needed
Date: Mon, 25 Sep 2017 16:40:46 +0800
Message-Id: <1506328847-1669-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Since not all devices support dax has struct page backend,
which will not support this test.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/413 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..b86c10f 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -88,6 +88,14 @@ t_nondax_to_dax()
 t_dax_to_nondax()
 {
 	prep_files
+	# dax to nondax dio needs struct page backend, which is
+	# not always avaiable among various devices. Skip this
+	# subtest if not compatible.
+	if ! src/t_mmap_dio $SCRATCH_MNT/tf_s \
+	   $TEST_DIR/tf_d $1 "test" > /dev/null 2>&1 ; then
+		return
+	fi
+
 	src/t_mmap_dio $SCRATCH_MNT/tf_s \
 		$TEST_DIR/tf_d $1 "dio dax to nondax"
 
-- 
1.8.3.1

