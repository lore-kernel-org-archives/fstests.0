Received: from szxga06-in.huawei.com ([45.249.212.32]:35530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbfBTB4B (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Feb 2019 20:56:01 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC21E19FF123B0B2C436
        for <fstests@vger.kernel.org>; Wed, 20 Feb 2019 09:55:57 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH 2/5] generic/299: limit max file size
Date: Wed, 20 Feb 2019 09:59:52 +0800
Message-ID: <20190220015955.26342-3-yuyufen@huawei.com>
In-Reply-To: <20190220015955.26342-1-yuyufen@huawei.com>
References: <20190220015955.26342-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We limit the max size and let the test go on running.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 tests/generic/299 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/299 b/tests/generic/299
index c4d74fc8..4d474032 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -33,6 +33,11 @@ NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 FILE_SIZE=$((BLK_DEV_SIZE * 512))
 
+max_file_size=$(_get_max_file_size)
+if [ $max_file_size -lt $FILE_SIZE ]; then
+	FILE_SIZE=$max_file_size
+fi
+
 cat >$fio_config <<EOF
 ###########
 # $seq test fio activity
-- 
2.16.2.dirty
