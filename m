Received: from mail-pf0-f180.google.com ([209.85.192.180]:36815 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbcLFBBr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2016 20:01:47 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so66647833pfz.3
        for <fstests@vger.kernel.org>; Mon, 05 Dec 2016 17:01:47 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] generic/35[67]: disable swapfile tests on Btrfs
Date: Mon,  5 Dec 2016 17:01:28 -0800
Message-Id: <f0b9fc441b46d15ddcdb126d3aabb27784c3e758.1480985305.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Btrfs doesn't support swapfiles (yet?), so generic/356 fails
erroneously, and generic/357 only passes by accident. Let's add a
_require_scratch_swapfile helper and add it to these tests.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
I have some code enabling swapfiles for Btrfs [1], but there's some ABBA
deadlock issues with i_rwsem and mmap_sem on swap-over-NFS that I
haven't had time to sort out. In the meantime, let's just skip these
tests.

1: https://github.com/osandov/linux/tree/btrfs-swap

 common/rc         | 22 ++++++++++++++++++++++
 tests/generic/356 |  1 +
 tests/generic/357 |  1 +
 3 files changed, 24 insertions(+)

diff --git a/common/rc b/common/rc
index 2719b23..d863e56 100644
--- a/common/rc
+++ b/common/rc
@@ -1790,6 +1790,28 @@ _require_odirect()
 	rm -f $testfile 2>&1 > /dev/null
 }
 
+# Check that the filesystem supports swapfiles
+_require_scratch_swapfile()
+{
+	_require_scratch
+
+	_scratch_mkfs >/dev/null
+	_scratch_mount
+
+	# Minimum size for mkswap is 10 pages
+	local size=$(($(get_page_size) * 10))
+
+	_pwrite_byte 0x61 0 "$size" "$SCRATCH_MNT/swap" >/dev/null 2>&1
+	mkswap "$SCRATCH_MNT/swap" >/dev/null 2>&1
+	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
+		_scratch_unmount
+		_notrun "swapfiles are not supported"
+	fi
+
+	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
+	_scratch_unmount
+}
+
 # Check that a fs has enough free space (in 1024b blocks)
 #
 _require_fs_space()
diff --git a/tests/generic/356 b/tests/generic/356
index 6bb90c0..51eeb65 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
 
diff --git a/tests/generic/357 b/tests/generic/357
index 439b314..0dd0c10 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -44,6 +44,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
 
-- 
2.10.2

