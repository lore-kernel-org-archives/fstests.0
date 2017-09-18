Received: from mail.cn.fujitsu.com ([183.91.158.132]:30884 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751348AbdIRB3F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Sep 2017 21:29:05 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0FEBC47CA461
        for <fstests@vger.kernel.org>; Mon, 18 Sep 2017 09:29:03 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/115: add missing 115 into group file
Date: Mon, 18 Sep 2017 09:29:00 +0800
Message-ID: <1505698140-3414-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: xiao yang <yangx.jy@cn.fujitsu.com>

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/group | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/group b/tests/xfs/group
index 0a449b9..b0a8119 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -112,6 +112,7 @@
 112 fuzzers
 113 fuzzers
 114 auto quick clone rmap
+115 auto quick fuzzers dangerous
 116 quota auto quick
 117 fuzzers
 118 auto quick fsr dangerous
-- 
1.8.3.1



