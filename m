Received: from mx1.redhat.com ([209.132.183.28]:40002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbeKFOHD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Nov 2018 09:07:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB9843084022
        for <fstests@vger.kernel.org>; Tue,  6 Nov 2018 04:43:44 +0000 (UTC)
Received: from dhcp-12-158.nay.redhat.com (dhcp-12-158.nay.redhat.com [10.66.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFDE15ED53
        for <fstests@vger.kernel.org>; Tue,  6 Nov 2018 04:43:43 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] generic: verify FIBMAP address overlap
Date: Tue,  6 Nov 2018 12:43:38 +0800
Message-Id: <20181106044338.10552-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfstests doesn't cover FIBMAP test, it cause we brought in a
regression bug fixed by "79b3dbe4adb3 fs: fix iomap_bmap position
calculation".

Although FIBMAP is old, there're still some programs use it, likes
LILO. This case tests if there's physical address overlap returned
by FIBMAP.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V2 did below changes:
1) New _require_fibmap() function in common/rc.
2) Change $TESTFILE to $testfile.
3) Simplify the logic of function verify_filefrag().

Thanks,
Zorro

 common/rc             |  14 +++++++
 tests/generic/999     | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |   3 ++
 tests/generic/group   |   1 +
 4 files changed, 122 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/common/rc b/common/rc
index d20bb36c..821975de 100644
--- a/common/rc
+++ b/common/rc
@@ -3843,6 +3843,20 @@ _require_scratch_btime()
 	_scratch_unmount
 }
 
+_require_fibmap()
+{
+	_require_command "$FILEFRAG_PROG" filefrag
+
+	local file="$TEST_DIR/fibmap_testfile"
+
+	echo "XX" > $file
+	${FILEFRAG_PROG} -B $file 2>&1 | grep -q "FIBMAP[[:space:]]*unsupported"
+	if [ $? -eq 0 ]; then
+		_notrun "FIBMAP isn't supported on current fs"
+	fi
+	rm -f $file
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..d6d012f2
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,104 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 999
+#
+# Verify if there's physical address overlap returned by FIBMAP, cover:
+# 79b3dbe4adb3 fs: fix iomap_bmap position calculation
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
+_require_command "$FILEFRAG_PROG" filefrag
+_require_fibmap
+
+testfile="$SCRATCH_MNT/$seq-testfile"
+
+# Use filefrag -B option to force the use of the older FIBMAP ioctl instead of
+# the FIEMAP ioctl. Then verify if there's map overlap.
+verify_filefrag()
+{
+	local n=1
+
+	# record details in .full file
+	${FILEFRAG_PROG} -Bes -v $testfile >> $seqres.full
+
+	# Due to physical things can't be golden image, so only output logical
+	# information at here
+	${FILEFRAG_PROG} -Be $testfile | _filter_filefrag | \
+		cut -d# -f1-2 > $tmp.filefrag
+
+	# Verify there's not physical address overlay
+	for i in `cat $tmp.filefrag`; do
+		# Get the start(v1) and end(v2) addresses will be verified
+		v1=`sed -n "${n}p" $tmp.filefrag | cut -d# -f1`
+		v2=`sed -n "${n}p" $tmp.filefrag | cut -d# -f2`
+		# The 2nd value is length, so the real end is:
+		v2=$((v1 + v2))
+
+		# Remove the line need to be verified ($i), compare with other
+		# lines one by one
+		sed -e "${n}d" $tmp.filefrag > $tmp.filefrag.tmp
+		for j in `cat $tmp.filefrag.tmp`; do
+			# Get 'next' line start(e1) and end(e2) addresses
+			e1=`echo $j | cut -d# -f1`
+			e2=`echo $j | cut -d# -f2`
+			# The 2nd value is length, so the real end is:
+			e2=$((e1 + e2))
+
+			# Verify there's not:
+			#       [ e1 ... e2 ]
+			#             [ v1 ... v2 ]
+			# Or:
+			#       [ e1 ... e2 ]
+			# [ v1 ... v2 ]
+			if ! [ ${v1} -ge ${e2} -o ${v2} -le ${e1} ]; then
+				echo "find physical addr overlap [$i] vs [$j]"
+			fi
+		done
+		((n++))
+	done
+}
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+# Test
+echo "== FIBMAP on empty file =="
+$XFS_IO_PROG -f -c "truncate 0" $testfile > /dev/null
+verify_filefrag
+
+echo "== FIBMAP on sparse file =="
+$XFS_IO_PROG -f -t -c "pwrite -S 0xaa 0 1m" \
+	     -c "pwrite -S 0xaa 2m 1m" \
+	     -c "pwrite -S 0xaa 4m 1m" \
+	     $testfile > /dev/null
+verify_filefrag
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..d3edbccf
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,3 @@
+QA output created by 999
+== FIBMAP on empty file ==
+== FIBMAP on sparse file ==
diff --git a/tests/generic/group b/tests/generic/group
index 54d71d55..beac6f73 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -519,3 +519,4 @@
 514 auto quick clone
 515 auto quick clone
 516 auto quick dedupe clone
+999 auto quick
-- 
2.14.5
