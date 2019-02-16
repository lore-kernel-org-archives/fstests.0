Received: from szxga06-in.huawei.com ([45.249.212.32]:48392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbfBPMDM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 16 Feb 2019 07:03:12 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C472E496DB7AF37A2A4C
        for <fstests@vger.kernel.org>; Sat, 16 Feb 2019 20:03:09 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] generic/299: limit max file size
Date: Sat, 16 Feb 2019 20:07:17 +0800
Message-ID: <20190216120717.114983-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

For some filesystem, such as vfat, the max support file size
is 4G. We limit the max size and let the test go on running.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 common/rc         | 13 +++++++++++++
 tests/generic/299 |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/common/rc b/common/rc
index d7687a64..0a8f3d07 100644
--- a/common/rc
+++ b/common/rc
@@ -3889,6 +3889,19 @@ _require_scratch_feature()
 	esac
 }
 
+_get_file_max_size()
+{
+	case $FSTYP in
+	vfat|jffs2)
+		echo $((2**32-1)) #0xffffffff
+		;;
+	*)
+		echo "0"
+		;;
+	esac
+
+}
+
 # The maximum filesystem label length, /not/ including terminating NULL
 _label_get_max()
 {
diff --git a/tests/generic/299 b/tests/generic/299
index c4d74fc8..5d462204 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -33,6 +33,14 @@ NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 FILE_SIZE=$((BLK_DEV_SIZE * 512))
 
+# filesystem limit max file size
+max_file_size=$(_get_file_max_size)
+if [ $max_file_size -ne 0 ]
+then
+	FILE_SIZE=$([ $max_file_size -le $FILE_SIZE ] && \
+		echo "$max_file_size" || echo "$FILE_SIZE")
+fi
+
 cat >$fio_config <<EOF
 ###########
 # $seq test fio activity
-- 
2.16.2.dirty
