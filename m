Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:18294 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeBTFq7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Feb 2018 00:46:59 -0500
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] btrfs/150: add _scratch_dev_pool_get/put to run the test as
 expected
Message-ID: <80c576ca-2ca0-ff83-cd9e-9622e2ce28ce@jp.fujitsu.com>
Date: Tue, 20 Feb 2018 14:34:32 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: bo.li.liu@oracle.com, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

btrfs/150 uses RAID1 profile and make SCRATCH_DEV fail for test.
However, if SCRATCH_DEV_POOL consists more than two devices, SCRATCH_DEV
may not be used for RAID1 pair and the tests may not run as expected.

Fix this by add _scratch_dev_pool_get/put like other tests (141, 143
etc.) do.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 tests/btrfs/150 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/150 b/tests/btrfs/150
index 97041b6c..1e4586be 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -55,6 +55,7 @@ _supported_os Linux
 _require_scratch
 _require_fail_make_request
 _require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
 
 SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
 enable_io_failure()
@@ -100,6 +101,7 @@ while [[ -z $result ]]; do
 	disable_io_failure
 done
 
+_scratch_dev_pool_put
 # success, all done
 status=0
 exit
-- 
2.14.3

