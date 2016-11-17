Received: from cn.fujitsu.com ([222.73.24.84]:18724 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754320AbcKQCHV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Nov 2016 21:07:21 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: Introduce check for explicit SHARED extent flag reporting
Date: Thu, 17 Nov 2016 10:06:48 +0800
Message-Id: <20161117020648.19685-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

For fs support reflink, some of them (OK, btrfs again) doesn't split
SHARED flag for extent fiemap reporting.

For example:
  0         4K         8K
   / File1: Extent 0  \
  /                    \
  |<- On disk Extent-->|
  |        /
  | File2 /
    Extent: 0

Fs supports explicit SHARED extent reporting should report fiemap like:
File1: 2 extents
Extent 0-4K: SHARED
Extent 4-8K:
File2: 1 extents
Extent 0-4K: SHARED

Fs doesn't support explicit reporting will report fiemap like:
File1: 1 extent
Extent 0-8K: SHARED
File2: 1 extent
Extent 0-4K: SHARED

Test case like generic/372 require explicit reporting will cause false
alert on btrfs.

Add such runtime check for that requirememt.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/reflink    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/372 |  1 +
 2 files changed, 45 insertions(+)

diff --git a/common/reflink b/common/reflink
index 8b34046..9ada2e8 100644
--- a/common/reflink
+++ b/common/reflink
@@ -78,6 +78,50 @@ _require_scratch_reflink()
 	_scratch_unmount
 }
 
+# this test requires scratch fs to report explicit SHARED flag
+# e.g.
+#   0         4K         8K
+#    / File1: Extent 0  \
+#   /                    \
+#   |<- On disk Extent-->|
+#   |        /
+#   | File2 /
+#     Extent: 0
+# Fs supports explicit SHARED extent reporting should report fiemap like:
+# File1: 2 extents
+# Extent 0-4K: SHARED
+# Extent 4-8K:
+# File2: 1 extents
+# Extent 0-4K: SHARED
+#
+# Fs doesn't support explicit reporting will report fiemap like:
+# File1: 1 extent
+# Extent 0-8K: SHARED
+# File2: 1 extent
+# Extent 0-4K: SHARED
+_require_scratch_explicit_shared_extents()
+{
+	_require_scratch
+	_require_fiemap
+	_require_scratch_reflink
+	_require_xfs_io_command "reflink"
+	local nr_extents
+
+	_scratch_mkfs > /dev/null
+	_scratch_mount
+
+	_pwrite_byte 0x61 0 128k $SCRATCH_MNT/file1
+	_reflink_range $SCRATCH_MNT/file1 0 $SCRATCH_MNT/file2 0 64k
+
+	_scratch_cycle_mount
+
+	nr_extents=$(_count_extents $SCRATCH_MNT/file1)
+	if [ $nr_extents -eq 1 ]; then
+		_notrun "Explicit SHARED flag reporting not support by filesystem type: $FSTYP"
+	fi
+	_scratch_unmount
+}
+
 # this test requires the test fs support dedupe...
 _require_test_dedupe()
 {
diff --git a/tests/generic/372 b/tests/generic/372
index 31dff20..51a3eca 100755
--- a/tests/generic/372
+++ b/tests/generic/372
@@ -47,6 +47,7 @@ _supported_os Linux
 _supported_fs generic
 _require_scratch_reflink
 _require_fiemap
+_require_scratch_explicit_shared_extents
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.7.4



