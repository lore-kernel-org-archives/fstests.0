Received: from mail.cn.fujitsu.com ([183.91.158.132]:56943 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751090AbeCGIah (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Mar 2018 03:30:37 -0500
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs/146: make sure hit all stripes in the case of compression
Date: Wed, 7 Mar 2018 16:30:28 +0800
Message-ID: <20180307083028.3625-1-lufq.fnst@cn.fujitsu.com>
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
 tests/btrfs/146 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index 7071c128..b5d17c49 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -74,9 +74,16 @@ _scratch_pool_mkfs "-d raid0 -m raid1" > $seqres.full 2>&1
 _scratch_mount
 
 # How much do we need to write? We need to hit all of the stripes. btrfs uses
-# a fixed 64k stripesize, so write enough to hit each one
+# a fixed 64k stripesize, so write enough to hit each one. In the case of
+# compression, each 128K input data chunk will be compressed to 4K (because of
+# the characters written are duplicate). Therefore we have to write (128K * 16)
+# to make sure every stripe can be hit.
 number_of_devices=`echo $SCRATCH_DEV_POOL | wc -w`
-write_kb=$(($number_of_devices * 64))
+if ! echo $MOUNT_OPTIONS | grep -qoP 'compress=\K(?!no)\w+'; then
+	write_kb=$(($number_of_devices * 64))
+else
+	write_kb=$(($number_of_devices * 2048))
+fi
 _require_fs_space $SCRATCH_MNT $write_kb
 
 testfile=$SCRATCH_MNT/fsync-err-test
-- 
2.14.3



