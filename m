Received: from smtp2.provo.novell.com ([137.65.250.81]:59110 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeFAIil (ORCPT
        <rfc822;groupwise-fstests@vger.kernel.org:0:0>);
        Fri, 1 Jun 2018 04:38:41 -0400
From: Yong Sun <yosun@suse.com>
Subject: [PATCH] xfstests/btrfs: adapt ppc64le node size at least 65536
Date: Fri,  1 Jun 2018 16:37:27 +0800
Message-Id: <20180601083727.13709-1-yosun@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: yosun <yosun@suse.com>
List-ID: <fstests@vger.kernel.org>

From: yosun <yosun@suse.com>

node size(leaf size) in ppc64le at least 65536, so mkfs with --nodesize smaller than that number will cause a fail on 057 and 122.

Signed-off-by: Yong Sun <yosun@suse.com>
---
 tests/btrfs/057 | 6 ++++++
 tests/btrfs/122 | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/057 b/tests/btrfs/057
index a834b763..69d096fb 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -48,6 +48,12 @@ _require_scratch
 
 rm -f $seqres.full
 
+# the nodesize in ppc64le is at least 65536, it will mismatch output
+HARDWARE_PLATFORM=`uname -i`
+if [ "$HARDWARE_PLATFORM" = "ppc64le" ]; then
+        _notrun "Not supported on ppc64le with nodesize > 4096"
+fi
+
 # use small leaf size to get higher btree height.
 run_check _scratch_mkfs "-b 1g --nodesize 4096"
 
diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 213a27f8..50003ad0 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -55,7 +55,13 @@ rm -f $seqres.full
 
 # Force a small leaf size to make it easier to blow out our root
 # subvolume tree
-_scratch_mkfs "--nodesize 16384" >/dev/null
+# Exception: leaf size at least 65536 in ppc64le
+HARDWARE_PLATFORM=`uname -i`
+if [ "$HARDWARE_PLATFORM" = "ppc64le" ]; then
+        _scratch_mkfs "--nodesize 65536" >/dev/null
+else
+        _scratch_mkfs "--nodesize 16384" >/dev/null
+fi
 _scratch_mount
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 
-- 
2.13.6

