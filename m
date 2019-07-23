Received: from szxga06-in.huawei.com ([45.249.212.32]:43816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728809AbfGWJZx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jul 2019 05:25:53 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] common/rc: check quota sysfile feature for f2fs
Date: Tue, 23 Jul 2019 17:25:29 +0800
Message-ID: <20190723092529.112426-3-yuchao0@huawei.com>
In-Reply-To: <20190723092529.112426-1-yuchao0@huawei.com>
References: <20190723092529.112426-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.orga, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

In _require_prjquota(), f2fs missed to check whether we have enabled
quota sysfile feature in the image, add it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/quota | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/quota b/common/quota
index 9af280a2..3f46eb19 100644
--- a/common/quota
+++ b/common/quota
@@ -80,6 +80,8 @@ _require_prjquota()
     if [ "$FSTYP" == "f2fs" ]; then
 	dump.f2fs $_dev 2>&1 | grep -qw project_quota
 	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
+	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
+	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
 	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
 	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
 	return
-- 
2.18.0.rc1
