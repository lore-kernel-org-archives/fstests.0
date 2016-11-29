Received: from cn.fujitsu.com ([222.73.24.84]:11304 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1756020AbcK2Hdj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:39 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 03/10] fstests: btrfs/022: Add extra qgroup verification after each work
Date: Tue, 29 Nov 2016 15:32:56 +0800
Message-Id: <20161129073303.14776-4-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The old code is using rescan to verify the number.

It will never hurt to add extra qgroup verification using btrfsck.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/022 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 56d4f3d..d1ac921 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -125,20 +125,25 @@ _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _basic_test
 _scratch_unmount
+_btrfs_check_scratch_qgroup
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _rescan_test
 _scratch_unmount
+_btrfs_check_scratch_qgroup
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _limit_test_exceed
 _scratch_unmount
+_btrfs_check_scratch_qgroup
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _limit_test_noexceed
+_scratch_unmount
+_btrfs_check_scratch_qgroup
 
 # success, all done
 echo "Silence is golden"
-- 
2.7.4



