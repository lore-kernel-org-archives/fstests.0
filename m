Received: from mail-pg0-f66.google.com ([74.125.83.66]:35759 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbdGFFdG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2017 01:33:06 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so1421407pgc.2
        for <fstests@vger.kernel.org>; Wed, 05 Jul 2017 22:33:06 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] generic/095, generic/247: unmount correct devices
Date: Wed,  5 Jul 2017 22:31:36 -0700
Message-Id: <20170706053136.6825-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

In commit d55123c080cb ("generic/247: filter out expected XFS warnings
for mixed mmap/direct I/O"), _scratch_unmount was removed from
generic/095 and added to generic/247.  But actually generic/095 *should*
be unmounting SCRATCH_DEV; and generic/247 should be unmounting
TEST_DEV, not SCRATCH_DEV, since it doesn't use a scratch device (it was
failing if SCRATCH_DEV was not defined).  Fix it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/095 | 4 ++++
 tests/generic/247 | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 9dff1bc1..050215d4 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -122,6 +122,10 @@ $FIO_PROG $fio_config >>$seqres.full 2>&1
 # to be potent, we don't want to simply _disable_dmesg_check which could miss
 # other potential bugs. So filter out the intentional WARNINGs, make sure test
 # doesn't fail because of this warning and fails on other WARNINGs.
+
+# umount before checking dmesg in case umount triggers any WARNING or Oops
+_scratch_unmount
+
 if [ "$FSTYP" == "xfs" ]; then
 	_check_dmesg _filter_xfs_dmesg
 else
diff --git a/tests/generic/247 b/tests/generic/247
index 509e8808..aac70780 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -82,7 +82,7 @@ echo "Silence is golden."
 
 # unmount and check dmesg, filtering out expected XFS warnings about mixed
 # mmap/dio
-_scratch_unmount
+_test_unmount
 if [ "$FSTYP" == "xfs" ]; then
 	_check_dmesg _filter_xfs_dmesg
 else
-- 
2.13.2

