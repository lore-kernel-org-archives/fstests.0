Received: from mail.cn.fujitsu.com ([183.91.158.132]:58506 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935317AbeCHIbF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Mar 2018 03:31:05 -0500
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH v3] fstests: btrfs/146: make sure hit all stripes in the case of compression
Date: Thu, 8 Mar 2018 16:30:53 +0800
Message-ID: <20180308083053.3604-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In the case of compression, each 128K input data chunk will be compressed
to 4K (because of the characters written are duplicate). Therefore we have
to write (128K * 16) to make sure every stripe can be hit.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
V3: Write ($number_of_devices * 2048)K data unconditionally.
V2: Modify the regular expression to ensure that it matches various
compress mount options.

 tests/btrfs/146 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index 7071c128ca0a..246baba1427a 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -74,9 +74,12 @@ _scratch_pool_mkfs "-d raid0 -m raid1" > $seqres.full 2>&1
 _scratch_mount
 
 # How much do we need to write? We need to hit all of the stripes. btrfs uses
-# a fixed 64k stripesize, so write enough to hit each one
+# a fixed 64k stripesize, so write enough to hit each one. In the case of
+# compression, each 128K input data chunk will be compressed to 4K (because of
+# the characters written are duplicate). Therefore we have to write (128K * 16)
+# to make sure every stripe can be hit.
 number_of_devices=`echo $SCRATCH_DEV_POOL | wc -w`
-write_kb=$(($number_of_devices * 64))
+write_kb=$(($number_of_devices * 2048))
 _require_fs_space $SCRATCH_MNT $write_kb
 
 testfile=$SCRATCH_MNT/fsync-err-test
-- 
2.16.2



