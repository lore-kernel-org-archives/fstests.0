Received: from cn.fujitsu.com ([59.151.112.132]:49411 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751195AbdCOKhf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Mar 2017 06:37:35 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 7D30648A2975
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2017 18:37:34 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/config: apply specific mount options for nfs in _test_mount_opts
Date: Wed, 15 Mar 2017 18:37:26 +0800
Message-ID: <1489574246-6073-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

NFS_MOUNT_OPTIONS is always not applied by TEST_DEV when it has been defined.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/config b/common/config
index 0c7335a..a7f8a5a 100644
--- a/common/config
+++ b/common/config
@@ -341,6 +341,9 @@ _test_mount_opts()
 	ceph)
 		export TEST_FS_MOUNT_OPTS=$CEPHFS_MOUNT_OPTIONS
 		;;
+	nfs)
+		export TEST_FS_MOUNT_OPTS=$NFS_MOUNT_OPTIONS
+		;;
 	*)
 		;;
 	esac
-- 
1.8.3.1



