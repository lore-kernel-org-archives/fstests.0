Received: from mail-pg0-f66.google.com ([74.125.83.66]:34583 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPQ5I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 12:57:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id k2-v6so563849pgc.1
        for <fstests@vger.kernel.org>; Wed, 16 May 2018 09:57:08 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 1/4] generic: enable swapfile tests on Btrfs
Date: Wed, 16 May 2018 09:56:57 -0700
Message-Id: <c05e3925acae64cb82c411452159f41610aeec7f.1526489529.git.osandov@fb.com>
In-Reply-To: <cover.1526489529.git.osandov@fb.com>
References: <cover.1526489529.git.osandov@fb.com>
In-Reply-To: <cover.1526489529.git.osandov@fb.com>
References: <cover.1526489529.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Commit 8c96cfbfe530 ("generic/35[67]: disable swapfile tests on Btrfs")
disabled the swapfile tests on Btrfs because it did not support
swapfiles at the time. Now that we're adding support, we want these
tests to run, but they don't. _require_scratch_swapfile always fails for
Btrfs because swapfiles on Btrfs must be set to nocow. After fixing
that, generic/356 and generic/357 fail for the same reason. After fixing
_that_, both tests still fail because we don't allow reflinking a
non-checksummed extent (which nocow implies) to a checksummed extent. Do
the chattrs everywhere, which gets these tests running on kernels
supporting Btrfs swapfiles.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 common/rc         | 3 +++
 tests/generic/356 | 6 +++++-
 tests/generic/357 | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ffe53236..5405f7d0 100644
--- a/common/rc
+++ b/common/rc
@@ -2233,6 +2233,9 @@ _require_scratch_swapfile()
 	# Minimum size for mkswap is 10 pages
 	local size=$(($(get_page_size) * 10))
 
+	touch "$SCRATCH_MNT/swap"
+	chmod 0600 "$SCRATCH_MNT/swap"
+	chattr +C "$SCRATCH_MNT/swap" >/dev/null 2>&1
 	_pwrite_byte 0x61 0 "$size" "$SCRATCH_MNT/swap" >/dev/null 2>&1
 	mkswap "$SCRATCH_MNT/swap" >/dev/null 2>&1
 	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
diff --git a/tests/generic/356 b/tests/generic/356
index 51eeb652..09c146a9 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -59,7 +59,11 @@ blocks=160
 blksz=65536
 
 echo "Initialize file"
-echo >> $seqres.full
+touch "$testdir/file1"
+chmod 0600 "$testdir/file1"
+chattr +C "$testdir/file1" >/dev/null 2>&1
+touch "$testdir/file2"
+chattr +C "$testdir/file2" >/dev/null 2>&1
 _pwrite_byte 0x61 0 $((blocks * blksz)) $testdir/file1 >> $seqres.full
 mkswap -U 27376b42-ff65-42ca-919f-6c9b62292a5c $testdir/file1 >> $seqres.full
 swapon $testdir/file1
diff --git a/tests/generic/357 b/tests/generic/357
index 0dd0c10f..742f37d1 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -59,7 +59,11 @@ blocks=160
 blksz=65536
 
 echo "Initialize file"
-echo >> $seqres.full
+touch "$testdir/file1"
+chmod 0600 "$testdir/file1"
+chattr +C "$testdir/file1" >/dev/null 2>&1
+touch "$testdir/file2"
+chattr +C "$testdir/file2" >/dev/null 2>&1
 _pwrite_byte 0x61 0 $((blocks * blksz)) $testdir/file1 >> $seqres.full
 mkswap -U 27376b42-ff65-42ca-919f-6c9b62292a5c $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 2>&1 | _filter_scratch
-- 
2.17.0

