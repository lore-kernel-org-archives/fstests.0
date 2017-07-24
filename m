Received: from cn.fujitsu.com ([59.151.112.132]:16700 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751951AbdGXG5t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2017 02:57:49 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0090946B5DF4
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2017 14:57:42 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/449: remove unused _require_test
Date: Mon, 24 Jul 2017 14:57:38 +0800
Message-ID: <1500879458-3673-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/449 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/449 b/tests/generic/449
index fb776b3..755a84a 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -52,7 +52,6 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_test
 _require_acls
 _require_attrs
 
-- 
1.8.3.1



