Received: from mail.cn.fujitsu.com ([183.91.158.132]:50416 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966024AbeCHF44 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Mar 2018 00:56:56 -0500
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH v2] fstests: btrfs/146: make sure hit all stripes in the case of compression
Date: Thu, 8 Mar 2018 13:56:45 +0800
Message-ID: <20180308055645.22917-1-lufq.fnst@cn.fujitsu.com>
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

V2: Modify the regular expression to ensure that it matches various
compress mount options.

 tests/btrfs/146 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index 7071c128ca0a..a51eda68eaf3 100755
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
+if ! echo $MOUNT_OPTIONS | grep -qoP 'compress(-force)?(=(?!no)|,|$)'; then
+	write_kb=$(($number_of_devices * 64))
+else
+	write_kb=$(($number_of_devices * 2048))
+fi
 _require_fs_space $SCRATCH_MNT $write_kb
 
 testfile=$SCRATCH_MNT/fsync-err-test
-- 
2.16.2



