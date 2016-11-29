Received: from cn.fujitsu.com ([222.73.24.84]:38188 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1755980AbcK2Hdg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:36 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 07/10] fstests: btrfs/099: Add extra verification for qgroup
Date: Tue, 29 Nov 2016 15:33:00 +0800
Message-Id: <20161129073303.14776-8-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/099 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/btrfs/099 b/tests/btrfs/099
index 70f07b5..9cc9a3d 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -82,6 +82,9 @@ sync
 $XFS_IO_PROG -f -c "pwrite -b $BLOCKSIZE 0 $(($FILESIZE - $BLOCKSIZE))" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
 
+_scratch_unmount
+_btrfs_check_scratch_qgroup
+
 # success, all done
 status=0
 exit
-- 
2.7.4



