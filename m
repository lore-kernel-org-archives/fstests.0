Received: from mail.cn.fujitsu.com ([183.91.158.132]:19451 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbeIDKun (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Sep 2018 06:50:43 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 97BE84B6AE18
        for <fstests@vger.kernel.org>; Tue,  4 Sep 2018 14:26:56 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/498: don't call _cleanup_flakey repeatedly
Date: Tue, 4 Sep 2018 14:26:50 +0800
Message-ID: <20180904062650.26695-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since exit always traps into _cleanup function which contains
_cleanup_flakey, don't need _cleanup_flakey twice.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 tests/generic/498 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/498 b/tests/generic/498
index 1cf73bda3b60..71f5091c30af 100755
--- a/tests/generic/498
+++ b/tests/generic/498
@@ -58,7 +58,6 @@ _flakey_drop_and_remount
 [ -f $SCRATCH_MNT/B/foo ] || echo "file B/foo is missing"
 
 _unmount_flakey
-_cleanup_flakey
 
 echo "Silence is golden"
 status=0
-- 
2.18.0
