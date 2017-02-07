Received: from cn.fujitsu.com ([59.151.112.132]:32637 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752983AbdBGJ6o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Feb 2017 04:58:44 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E3BA7477B1F7
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2017 17:58:27 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/fuzzy: discard xfs_io stdout in _scratch_fuzz_modify
Date: Tue, 7 Feb 2017 17:58:19 +0800
Message-ID: <1486461499-4975-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

xfs/083 fails because _scratch_fuzz_modify redirects xfs_io stdout
to $ROUND2_LOG.  _scratch_fuzz_modify function has been modified
by commit 7a7463d362cd3 ("populate: fix some silly errors when
modifying a fs while fuzzing").

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/fuzzy | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/fuzzy b/common/fuzzy
index 75b23e1..304268e 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -39,7 +39,7 @@ _scratch_fuzz_modify() {
 
 	echo "+++ create files"
 	mkdir -p "${SCRATCH_MNT}/test.moo"
-	$XFS_IO_PROG -f -c 'pwrite -S 0x80 0 65536' "${SCRATCH_MNT}/test.moo/urk"
+	$XFS_IO_PROG -f -c 'pwrite -S 0x80 0 65536' "${SCRATCH_MNT}/test.moo/urk" > /dev/null
 	sync
 
 	echo "+++ remove files"
-- 
1.8.3.1



