Received: from cn.fujitsu.com ([59.151.112.132]:14844 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750710AbcIIIvW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Sep 2016 04:51:22 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/263: skip test if Q_XGETQSTATV hasn't been supported by kernel or xfsprogs
Date: Fri, 9 Sep 2016 16:47:44 +0800
Message-ID: <1473410864-7780-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/263 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/xfs/263 b/tests/xfs/263
index 1dc47ae..07f7ebc 100755
--- a/tests/xfs/263
+++ b/tests/xfs/263
@@ -58,6 +58,10 @@ _require_xfs_quota
 _require_xfs_mkfs_crc
 _require_xfs_crc
 
+# check if Q_XGETQSTATV has been supported by kernel and xfsprogs
+grep -q 'Q_XGETQSTATV' /usr/include/linux/dqblk_xfs.h || _notrun "Q_XGETQSTATV hasn't been supported by kernel"
+grep -q 'Q_XGETQSTATV' /usr/include/xfs/xqm.h || _notrun "Q_XGETQSTATV hasn't been supported by xfsprogs"
+
 rm -f $seqres.full
 
 function option_string()
-- 
1.8.3.1



