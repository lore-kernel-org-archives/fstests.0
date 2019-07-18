Received: from szxga05-in.huawei.com ([45.249.212.191]:2283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfGRJMJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jul 2019 05:12:09 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] common/rc: set max label length for f2fs
Date: Thu, 18 Jul 2019 17:11:54 +0800
Message-ID: <20190718091154.37327-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

f2fs can support FS_IOC_{GET,SET}FSLABEL now, set max label length
to enable generic/492 testcase for f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 75ca6324..45781619 100644
--- a/common/rc
+++ b/common/rc
@@ -3955,6 +3955,9 @@ _label_get_max()
 	btrfs)
 		echo 255
 		;;
+	f2fs)
+		echo 255
+		;;
 	*)
 		_notrun "$FSTYP does not define maximum label length"
 		;;
-- 
2.18.0.rc1
