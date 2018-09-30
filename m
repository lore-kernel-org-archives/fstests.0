Received: from szxga04-in.huawei.com ([45.249.212.190]:13591 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeI3P7e (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Sep 2018 11:59:34 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] common/quota: adapt _require_prjquota() for f2fs
Date: Sun, 30 Sep 2018 17:26:53 +0800
Message-ID: <20180930092653.122684-2-yuchao0@huawei.com>
In-Reply-To: <20180930092653.122684-1-yuchao0@huawei.com>
References: <20180930092653.122684-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

In _require_prjquota(), let's check project quota support as below for
f2fs:
- For image support, check 'project_quota' on enabled feature list of
specified device.
- For kernel support, check /sys/fs/f2fs/features/project_quota sysfs
entry status.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/quota | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/quota b/common/quota
index 9ab091817804..9b8641350a4d 100644
--- a/common/quota
+++ b/common/quota
@@ -82,6 +82,13 @@ _require_prjquota()
 	dumpe2fs -h $_dev 2>&1 | grep -qw project || \
 		_notrun "Project quota not available on this $FSTYP"
     fi
+    if [ "$FSTYP" == "f2fs" ]; then
+	dump.f2fs $_dev 2>&1 | grep -qw project_quota
+	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
+	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
+	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
+	return
+    fi
     src/feature -P $_dev
     [ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
     if [ "$USE_EXTERNAL" = yes -a ! -z "$_dev" ]; then
-- 
2.18.0.rc1
