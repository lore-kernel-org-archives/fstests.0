Received: from szxga05-in.huawei.com ([45.249.212.191]:16669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbeL2Cba (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Dec 2018 21:31:30 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E87DEC4C6A105
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 10:31:25 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH 1/5] check: use _try_scratch_mount instead of _scratch_mount to mount SCRATCH_DEV
Date: Sat, 29 Dec 2018 10:34:48 +0800
Message-ID: <20181229023452.28074-2-houtao1@huawei.com>
In-Reply-To: <20181229023452.28074-1-houtao1@huawei.com>
References: <20181229023452.28074-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

Else there won't be any error messages when mounting SCRATCH_DEV failed,
because _scratch_mount exits early by invoking _fail.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index e85f40ac..e4d76737 100755
--- a/check
+++ b/check
@@ -607,7 +607,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	  # call the overridden mount - make sure the FS mounts with
 	  # the same options that we'll mount with later.
-	  if ! _scratch_mount >$tmp.err 2>&1
+	  if ! _try_scratch_mount >$tmp.err 2>&1
 	  then
 	      echo "our local mount routine ..."
 	      cat $tmp.err
-- 
2.16.2.dirty
