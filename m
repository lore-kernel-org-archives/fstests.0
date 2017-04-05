Received: from cn.fujitsu.com ([59.151.112.132]:34177 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752164AbdDED0i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Apr 2017 23:26:38 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 243F949FD522
        for <fstests@vger.kernel.org>; Wed,  5 Apr 2017 11:26:31 +0800 (CST)
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: Remove IRIX os support from template
Date: Wed, 5 Apr 2017 11:26:28 +0800
Message-ID: <20170405032628.22370-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since the last release of IRIX is already 10 years ago and support for
it has ended after 2014, there is no need to support IRIX any way.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 new | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/new b/new
index c21d8db..eb7da0f 100755
--- a/new
+++ b/new
@@ -207,7 +207,7 @@ rm -f \$seqres.full
 
 # Modify as appropriate.
 _supported_fs generic
-_supported_os IRIX Linux
+_supported_os Linux
 _require_test
 
 # if error
-- 
2.9.3



