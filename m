Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:35679 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeHCIv3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Aug 2018 04:51:29 -0400
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] fstests: btrfs/057: Update test case to keep subvolume in any
 kernel version
References: <cover.1533278551.git.misono.tomohiro@jp.fujitsu.com>
Message-ID: <4b4e3480-ccb7-d0aa-2a37-ea51699728e8@jp.fujitsu.com>
Date: Fri, 3 Aug 2018 15:44:37 +0900
MIME-Version: 1.0
In-Reply-To: <cover.1533278551.git.misono.tomohiro@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since commit a79a464d5675 ("btrfs: Allow rmdir(2) to delete an empty
subvolume"), rm -r can delete a subvolume too.

This test assumes that rm -r does not delete a subvolume.
Currently the commit does not affect the test since qgroup items
still exist after subvolume deletion, but we plan to change the
behavior and remove them along with subvolume deletion.

So update the test and keep subvolume (and qgroup item) in any kernel
version.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tests/btrfs/057 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 6743f774..b019f4e1 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -53,8 +53,9 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 \
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 
-# ignore removing subvolume errors
-rm -rf $SCRATCH_MNT/* >& /dev/null
+# remove all file/dir other than subvolume
+rm -rf $SCRATCH_MNT/snap1/* >& /dev/null
+rm -rf $SCRATCH_MNT/p* >& /dev/null
 
 _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
 units=`_btrfs_qgroup_units`
-- 
2.14.4


