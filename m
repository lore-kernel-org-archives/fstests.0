Received: from cn.fujitsu.com ([59.151.112.132]:44565 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751560AbdGSDGx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jul 2017 23:06:53 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/rc: update _require_seek_data_hole()
Date: Wed, 19 Jul 2017 11:06:47 +0800
Message-ID: <1500433607-4223-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170718131852.GX2478@eguan.usersys.redhat.com>
References: <20170718131852.GX2478@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

_require_seek_data_hole() could not skip tests if filesystem does not support
fallocate or unwritten extent.  We could update _require_seek_data_hole() to
catch both of them.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index fa1314c..b064f53 100644
--- a/common/rc
+++ b/common/rc
@@ -2297,7 +2297,7 @@ _require_seek_data_hole()
     testfile=$TEST_DIR/$$.seek
     testseek=`$here/src/seek_sanity_test -t $testfile 2>&1`
     rm -f $testfile &>/dev/null
-    echo $testseek | grep -q "Kernel does not support" && \
+    echo $testseek | grep -q "not support" && \
         _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
 }
 
-- 
1.8.3.1



