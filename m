Received: from mx1.redhat.com ([209.132.183.28]:55912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfDGO3z (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Apr 2019 10:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6728C04BE09
        for <fstests@vger.kernel.org>; Sun,  7 Apr 2019 14:29:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C170F600C8
        for <fstests@vger.kernel.org>; Sun,  7 Apr 2019 14:29:54 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfstests: aio random write and verify stress test
Date: Sun,  7 Apr 2019 22:29:49 +0800
Message-Id: <20190407142949.3811-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We found some AIO write related bugs recently, so I think a AIO
random write test is needed. By the new aio-aio-write-verify.c tool,
we can do this easily.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This patch need "[PATCH v3] generic: unaligned direct AIO write test" at first:
https://marc.info/?l=fstests&m=155395889909063&w=2

Thanks,
Zorro

 tests/generic/998     | 87 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/998.out |  2 +
 tests/generic/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/generic/998
 create mode 100644 tests/generic/998.out

diff --git a/tests/generic/998 b/tests/generic/998
new file mode 100755
index 00000000..54b79691
--- /dev/null
+++ b/tests/generic/998
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 998
+#
+# Randomly direct AIO write&verify stress test
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_aiodio aio-dio-write-verify
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+localfile=$SCRATCH_MNT/testfile
+diosize=`_min_dio_alignment $SCRATCH_DEV`
+
+# The maximum write size and offset are both 32k diosize. So the maximum
+# file size will be (32 * 2)k
+free_size_k=`df -kP $SCRATCH_MNT | grep -v Filesystem | awk '{print $4}'`
+max_io_size_b=$((32 * 1024))
+if [ $max_io_size_b -gt $((free_size_k * 1024 / 2 / diosize)) ]; then
+	max_io_size_b=$((free_size_k * 1024 / 2 / diosize))
+fi
+
+do_test()
+{
+	local num_oper
+	local oper_list=""
+	local size
+	local off
+	local truncsize
+
+	# the number of AIO write operation
+	num_oper=$((RANDOM % 64 + 1))
+
+	for ((i=0; i<num_oper; i++)); do
+		size=$(((RANDOM % max_io_size_b + 1) * diosize))
+		off=$((RANDOM % max_io_size_b * diosize))
+		oper_list="$oper_list -a size=$size,off=$off"
+	done
+	truncsize=$(((RANDOM * diosize + RANDOM % diosize) % max_io_size_b))
+
+	$AIO_TEST -t $truncsize $oper_list $localfile
+	if [ $? -ne 0 ];then
+		echo "$AIO_TEST -t $truncsize $oper_list $localfile"
+		echo "==========^^ Fail ^^=========="
+	fi
+}
+
+testimes=$((LOAD_FACTOR * 100))
+while [ $testimes -gt 0 ]; do
+	echo > $localfile
+	do_test
+	((testimes--))
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/998.out b/tests/generic/998.out
new file mode 100644
index 00000000..d2679ae0
--- /dev/null
+++ b/tests/generic/998.out
@@ -0,0 +1,2 @@
+QA output created by 998
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 0c3016fd..36b180c3 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -540,4 +540,5 @@
 535 auto quick log
 536 auto quick rw shutdown
 537 auto quick trim
+998 auto stress aio
 999 auto quick aio
-- 
2.17.2
