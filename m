Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:12889 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdIAFjy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2017 01:39:54 -0400
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH 1/2] Add new common filter function
Message-ID: <5f6cd84d-6e12-2b23-09fc-c0f744d1d2f2@jp.fujitsu.com>
Date: Fri, 1 Sep 2017 14:39:44 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Several tests uses both _filter_test_dir and _filter_scratch
concatenated by pipe to filter $TEST_DIR and $SCRATCH_MNT. However, this
would fail if the shorter string is a substring of the other (like
"/mnt" and "/mnt2").

This patch introduces new common filter function to safely call both
_filter_test_dir and _filter_scratch.

I chedked this with btrfs/029, generic/409,410,411, and generic/381,383,
xfs/106,108 (which calls _filter_quota). Thanks Eryu for advice.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 common/filter | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/filter b/common/filter
index 1ef342b..75570f9 100644
--- a/common/filter
+++ b/common/filter
@@ -295,6 +295,17 @@ _filter_scratch()
 	    -e "/.use_space/d"
 }
 
+_filter_testdir_and_scratch()
+{
+	# filter both $TEST_DIR and $SCRATCH_MNT, but always filter the longer
+	# string first if the other string is a substring of the first one
+	if echo "$TEST_DIR" | grep -q "$SCRATCH_MNT"; then
+	  _filter_test_dir | _filter_scratch
+	else
+	  _filter_scratch | _filter_test_dir
+	fi
+}
+
 # Turn any device in the scratch pool into SCRATCH_DEV
 _filter_scratch_pool()
 {
-- 
2.9.5

