Received: from cn.fujitsu.com ([59.151.112.132]:52374 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbcIEF5l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Sep 2016 01:57:41 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] ext4/021: use $XFS_IO_PROG instead of xfs_io
Date: Mon, 5 Sep 2016 13:56:47 +0800
Message-ID: <1473055007-26359-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160905053356.GL27776@eguan.usersys.redhat.com>
References: <20160905053356.GL27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

We should use $XFS_IO_PROG to add "-F" option when we need it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index d758818..d5fad7c 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -80,7 +80,7 @@ fi
 # disk, the s_squence offset to the beginning of journal superblock is 24
 # we do this to let jbd2 start to run with a initial big transaction id,
 # which will reduce the time taken to trigger this bug.
-xfs_io  -c "pwrite -S 0x81 $((offset+24)) 1" \
+$XFS_IO_PROG -c "pwrite -S 0x81 $((offset+24)) 1" \
 	-c "pwrite -S 0xd1 $((offset+25)) 1" \
 	-c "pwrite -S 0xa4 $((offset+26)) 1" \
 	-c "pwrite -S 0x80 $((offset+27)) 1" $SCRATCH_DEV >> $seqres.full 2>&1
-- 
1.8.3.1



