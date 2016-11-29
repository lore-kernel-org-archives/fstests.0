Received: from cn.fujitsu.com ([222.73.24.84]:38188 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754917AbcK2Hdc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:32 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 04/10] fstests: btrfs/028: Use new wrapped _btrfs_check_scratch_qgroup function
Date: Tue, 29 Nov 2016 15:32:57 +0800
Message-Id: <20161129073303.14776-5-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/028 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 1425609..c4e99c6 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -87,8 +87,8 @@ _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
 _scratch_unmount
 
 # generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-	grep -E "Counts for qgroup.*are different"
+_btrfs_check_scratch_qgroup
+
 echo "Silence is golden"
 status=0
 
-- 
2.7.4



