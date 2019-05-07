Received: from mail.cn.fujitsu.com ([183.91.158.132]:21148 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbfEGJUC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 May 2019 05:20:02 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A710A4CD7BBD
        for <fstests@vger.kernel.org>; Tue,  7 May 2019 17:19:59 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] ext4/018: Match the value of File ACL accurately
Date: Tue, 7 May 2019 17:19:51 +0800
Message-ID: <1557220791-30347-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Since e2fsprogs v1.44.0, debugfs with stat command shows the output:
---------------------------------------------------------------------
debugfs -R 'stat /attrfile' /dev/sda11 2> /dev/null | grep 'File ACL:'
File ACL: 9258
---------------------------------------------------------------------

Before e2fsprogs v1.44.0, debugfs with stat command shows the output:
----------------------------------------------------------------------
debugfs -R 'stat /attrfile' /dev/sda11 2> /dev/null | grep 'File ACL:'
File ACL: 9258    Directory ACL: 0
----------------------------------------------------------------------

"Directory ACL: XXXX" was removed by commit 578fcbf so running ext4/018
with older e2fsprogs(i.e. before v1.44.0) got the following error:
--------------------------------------------------------------------------
+./tests/ext4/018: line 59: 9258    Directory ACL: 0: syntax error in expression (error token is "Directory ACL: 0")
--------------------------------------------------------------------------

we match the value of File ACL accurately to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/ext4/018 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/018 b/tests/ext4/018
index eb6d827..fed5a8e 100755
--- a/tests/ext4/018
+++ b/tests/ext4/018
@@ -55,7 +55,7 @@ echo "+ check fs"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
 
 echo "+ corrupt image"
-blk="$(debugfs -R 'stat /attrfile' "${SCRATCH_DEV}" 2> /dev/null | grep 'File ACL:' | sed -e 's/^.*File ACL: \([0-9]*\)/\1/g')"
+blk="$(debugfs -R 'stat /attrfile' "${SCRATCH_DEV}" 2> /dev/null | grep 'File ACL:' | sed -e 's/^.*File ACL: \([0-9]*\).*/\1/g')"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 $((blk * blksz + 20)) 8" "${SCRATCH_DEV}" >> $seqres.full
 
 echo "+ mount image"
-- 
1.8.3.1
