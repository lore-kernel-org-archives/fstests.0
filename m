Received: from cn.fujitsu.com ([59.151.112.132]:58195 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbdEaJKu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 May 2017 05:10:50 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 354A047C6522
        for <fstests@vger.kernel.org>; Wed, 31 May 2017 17:10:48 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 1/2] xfs/055: add missing 055.cfg
Date: Wed, 31 May 2017 17:10:26 +0800
Message-ID: <1496221827-22720-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

_link_output_file sets output file suffix to null because 055.cfg is
missing, so add it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/055.cfg | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tests/xfs/055.cfg

diff --git a/tests/xfs/055.cfg b/tests/xfs/055.cfg
new file mode 100644
index 0000000..7ffdfc0
--- /dev/null
+++ b/tests/xfs/055.cfg
@@ -0,0 +1,2 @@
+irix: irix
+linux: linux
-- 
1.8.3.1



