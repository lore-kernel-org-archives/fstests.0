Received: from szxga06-in.huawei.com ([45.249.212.32]:49976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727961AbfBRBxr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 17 Feb 2019 20:53:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19FEE625F0E2E1922B49
        for <fstests@vger.kernel.org>; Mon, 18 Feb 2019 09:53:45 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH v2] generic/299: limit max file size
Date: Mon, 18 Feb 2019 09:57:41 +0800
Message-ID: <20190218015741.7996-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

For some filesystem, such as vfat, the max support file size
is 4G. We limit the max size and let the test go on running.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 common/rc         | 9 +++++++++
 tests/generic/299 | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index e5da6484..94148029 100644
--- a/common/rc
+++ b/common/rc
@@ -3785,6 +3785,15 @@ _require_scratch_feature()
 	esac
 }
 
+# get mount point filesystem max file size
+_get_file_max_size()
+{
+	local mnt_point=$1
+
+	bits=`getconf FILESIZEBITS ${mnt_point}`
+	echo "$((2**bits-1))"
+}
+
 # The maximum filesystem label length, /not/ including terminating NULL
 _label_get_max()
 {
diff --git a/tests/generic/299 b/tests/generic/299
index c4d74fc8..175aa6f2 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -33,6 +33,11 @@ NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 FILE_SIZE=$((BLK_DEV_SIZE * 512))
 
+# filesystem limit max file size
+max_file_size=$(_get_file_max_size $SCRATCH_MNT)
+FILE_SIZE=$([ $max_file_size -le $FILE_SIZE ] && \
+		echo "$max_file_size" || echo "$FILE_SIZE")
+
 cat >$fio_config <<EOF
 ###########
 # $seq test fio activity
-- 
2.16.2.dirty
