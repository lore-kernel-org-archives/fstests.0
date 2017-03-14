Received: from mx2.suse.de ([195.135.220.15]:38652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbdCNR37 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 13:29:59 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH] btrfs/009: Unmount scratch to allow creation of new fs in next tests
Date: Tue, 14 Mar 2017 12:29:53 -0500
Message-Id: <20170314172953.19225-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

5e6892d ("common/rc: use findmnt to check mounted device")
added findmnt in _check_mounted_on.
This would result the mountrec in
/dev/vdc[/newvol] /scratch format, and hence would fail because
the device name had the volume name with it. This would fail
_require_scratch which is usually in the starting of the tests.

Adding _scratch_unmount at the end of btrfs/009 solves this issue.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 tests/btrfs/009 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/009 b/tests/btrfs/009
index 2ffb817..8fb51e5 100755
--- a/tests/btrfs/009
+++ b/tests/btrfs/009
@@ -60,6 +60,7 @@ $BTRFS_UTIL_PROG subvolume set-default $subvolid $SCRATCH_MNT >> $seqres.full 2>
 $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/newvol >> $seqres.full 2>&1
 _scratch_unmount
 _scratch_mount || _fail "mount should have succeeded"
+_scratch_unmount
 
 echo "Silence is golden"
 status=0 ; exit
-- 
2.10.2

