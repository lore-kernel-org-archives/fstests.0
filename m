Received: from szxga04-in.huawei.com ([45.249.212.190]:3198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387858AbfG2L4u (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Jul 2019 07:56:50 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] common/quota: enable project quota correctly on f2fs
Date: Mon, 29 Jul 2019 19:56:20 +0800
Message-ID: <20190729115620.127160-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

Add a case for f2fs on _scratch_enable_pquota() to enable
dependent features of project quota by mkfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/quota | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/common/quota b/common/quota
index 659c6219..38aa9470 100644
--- a/common/quota
+++ b/common/quota
@@ -111,12 +111,17 @@ _require_getnextquota()
 # prior to mount.  This is a relatively new feature ...
 _scratch_enable_pquota()
 {
-	[[ "$FSTYP" != ext[234] ]] && return
-
+    case $FSTYP in
+    ext2|ext3|ext4)
 	tune2fs -O quota,project $SCRATCH_DEV >>$seqres.full 2>&1
 	_try_scratch_mount >/dev/null 2>&1 \
 		|| _notrun "kernel doesn't support project feature on $FSTYP"
 	_scratch_unmount
+	;;
+    f2fs)
+	_scratch_mkfs "-O extra_attr -O quota -O project_quota" >> $seqres.full 2>&1
+	;;
+    esac
 }
 
 #
-- 
2.18.0.rc1
