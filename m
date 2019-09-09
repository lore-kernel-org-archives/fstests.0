Received: from mail.cn.fujitsu.com ([183.91.158.132]:33764 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728358AbfIIKO4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Sep 2019 06:14:56 -0400
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/566:  skip this test if -f option is non-supported
Date: Mon, 9 Sep 2019 18:14:46 +0800
Message-ID: <1568024086-2151-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This test will use xfs_quota -f option, this option was introduced
since xfsprogs v4.10.0-rc1. On old version, we should skip this case.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/566 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/566 b/tests/generic/566
index e8491e54..173974ad 100755
--- a/tests/generic/566
+++ b/tests/generic/566
@@ -34,6 +34,7 @@ _supported_os Linux
 _supported_fs generic
 _require_scratch
 _require_quota
+_require_xfs_quota_foreign
 _require_user
 
 rm -f $seqres.full
-- 
2.18.1
