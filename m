Received: from mx2.mpynet.fi ([82.197.21.85]:44478 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755821AbdLTRXQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 20 Dec 2017 12:23:16 -0500
From: Ari Sundholm <ari@tuxera.com>
Subject: [PATCH] generic/399: Use dd instead of xfs_io pwrite to fill volume
Date: Wed, 20 Dec 2017 19:22:44 +0200
Message-ID: <1513790564-24236-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ari Sundholm <ari@tuxera.com>
List-ID: <fstests@vger.kernel.org>

As recently discussed on the fstests mailing list, the way
generic/399 checks for the filesystem having become full only
works on filesystems that behave like ext4, and even on those,
actually only works by accident.

The problem is that xfs_io does not give a nonzero exit value
when the pwrite operation fails due to ENOSPC. However, if the
filesystem also happens to be unable to create new empty files
when it is full, the check will do its job because open() fails
with ENOSPC. Not all filesystems behave like this, however.

As it seems to be nontrivial to get xfs_io fixed for this case,
I propose simply replacing the xfs_io pwrite command with dd
for now. AFAICS, this works with all filesystems, and should also
preserve the nature of the test case.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/399 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/399 b/tests/generic/399
index 8f5fcdc..5056b20 100755
--- a/tests/generic/399
+++ b/tests/generic/399
@@ -101,7 +101,7 @@ total_file_size=0
 i=1
 while true; do
 	file=$SCRATCH_MNT/encrypted_dir/file$i
-	if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> $tmp.out; then
+	if ! dd if=/dev/zero of=$file bs=4k count=256 &> $tmp.out; then
 		if ! grep -q 'No space left on device' $tmp.out; then
 			echo "FAIL: unexpected pwrite failure"
 			cat $tmp.out
-- 
2.7.4

