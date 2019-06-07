Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12510 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFGCec (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jun 2019 22:34:32 -0400
From: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests: btrfs/163: make readahead run on the seed device
Date: Fri,  7 Jun 2019 11:34:22 +0900
Message-Id: <20190607023422.28928-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: fdmanana@gmail.com, Naohiro Aota <naohiro.aota@wdc.com>
List-ID: <fstests@vger.kernel.org>

There is a long lived bug that btrfs wait for readahead to finish
indefinitely when readahead zone is inserted into seed devices.

Current write size to the file "foobar" is too small to run readahead
before the replacing on seed device. So, increase the write size to
reproduce the issue.

Following patch fixes it:

	"btrfs: start readahead also in seed devices"

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/163 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 8c93e83b970a..24c725afb6b9 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -50,7 +50,7 @@ create_seed()
 {
 	_mkfs_dev $dev_seed
 	run_check _mount $dev_seed $SCRATCH_MNT
-	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\
 		/dev/null
 	echo -- gloden --
 	od -x $SCRATCH_MNT/foobar
-- 
2.21.0
