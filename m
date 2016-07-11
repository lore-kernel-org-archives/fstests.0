Received: from mail-pf0-f173.google.com ([209.85.192.173]:33678 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcGKW1v (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 11 Jul 2016 18:27:51 -0400
Received: by mail-pf0-f173.google.com with SMTP id i123so39919934pfg.0
        for <fstests@vger.kernel.org>; Mon, 11 Jul 2016 15:27:50 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH RESEND v2] fstests: btrfs/079: Fix wrong value passed to available space check.
Date: Mon, 11 Jul 2016 15:27:17 -0700
Message-Id: <54913a3d3aca9142fe5ebf3ee06ff6e7a7736678.1468275843.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, Qu Wenruo <quwenruo@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Qu Wenruo <quwenruo@cn.fujitsu.com>

Wrong value is passed to _require_fs_space, which should be in unit of
kilobyte(1024), but passed in unit of gigabyte(1024^3).

Fix it.

Reviewed-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
This is from January of last year, looks like it fell through the cracks.

 tests/btrfs/079 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/079 b/tests/btrfs/079
index 6aee3a373f91..ed4eb727ee2b 100755
--- a/tests/btrfs/079
+++ b/tests/btrfs/079
@@ -72,7 +72,7 @@ rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-_require_fs_space $SCRATCH_MNT $(($filesize / 1024 / 1024 / 1024))
+_require_fs_space $SCRATCH_MNT $(($filesize / 1024))
 $XFS_IO_PROG -f -c "falloc 0 $filesize" $testfile
 
 dd_work() {
-- 
2.9.0

