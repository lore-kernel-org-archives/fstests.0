Received: from cn.fujitsu.com ([59.151.112.132]:55416 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754868AbcIEF0E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Sep 2016 01:26:04 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id D6B264042409
        for <fstests@vger.kernel.org>; Mon,  5 Sep 2016 13:25:53 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] ext4/021: add -F flag for xfs_io
Date: Fri, 2 Sep 2016 21:55:35 +0800
Message-ID: <1472824535-24928-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

xfs_io needs -F flag to write data in non-XFS filesystem on xfsprogs 3.1.1.
The -F flag has been removed from usage() & man pages since xfsprogs 3.1.8,
but is still accepted.  Please see the following commit d1b8818
("xfs_io: deprecate the "-F" foreign flag")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index d758818..f82d7fb 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -80,7 +80,7 @@ fi
 # disk, the s_squence offset to the beginning of journal superblock is 24
 # we do this to let jbd2 start to run with a initial big transaction id,
 # which will reduce the time taken to trigger this bug.
-xfs_io  -c "pwrite -S 0x81 $((offset+24)) 1" \
+xfs_io -F -c "pwrite -S 0x81 $((offset+24)) 1" \
 	-c "pwrite -S 0xd1 $((offset+25)) 1" \
 	-c "pwrite -S 0xa4 $((offset+26)) 1" \
 	-c "pwrite -S 0x80 $((offset+27)) 1" $SCRATCH_DEV >> $seqres.full 2>&1
-- 
1.8.3.1



