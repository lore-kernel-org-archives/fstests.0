Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18377 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFGFjP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jun 2019 01:39:15 -0400
From: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] fstests: btrfs/163: make readahead run on the seed device
Date: Fri,  7 Jun 2019 14:39:10 +0900
Message-Id: <20190607053910.2127-1-naohiro.aota@wdc.com>
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
changelog:
v2:
- Update the expected output as well.
---
 tests/btrfs/163     | 2 +-
 tests/btrfs/163.out | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
index 50f46da6df86..91f6f5b6f48a 100644
--- a/tests/btrfs/163.out
+++ b/tests/btrfs/163.out
@@ -2,8 +2,8 @@ QA output created by 163
 -- gloden --
 0000000 abab abab abab abab abab abab abab abab
 *
-1000000
+20000000
 -- sprout --
 0000000 abab abab abab abab abab abab abab abab
 *
-1000000
+20000000
-- 
2.21.0
