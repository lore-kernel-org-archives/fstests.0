Received: from cn.fujitsu.com ([222.73.24.84]:39314 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbcK2Hdf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:35 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 05/10] fstests: btrfs/042: Add extra qgroup verification
Date: Tue, 29 Nov 2016 15:32:58 +0800
Message-Id: <20161129073303.14776-6-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Use newly introduced _btrfs_check_scratch_qgroup() to double check if
qgroup numbers are correct.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/042 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/btrfs/042 b/tests/btrfs/042
index 498ccc9..003b7af 100755
--- a/tests/btrfs/042
+++ b/tests/btrfs/042
@@ -89,6 +89,9 @@ if [ $total_written -gt $LIMIT_SIZE ];then
 	_fail "total written should be less than $LIMIT_SIZE"
 fi
 
+_scratch_unmount
+_btrfs_check_scratch_qgroup
+
 # success, all done
 echo "Silence is golden"
 status=0
-- 
2.7.4



