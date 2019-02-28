Received: from mail-pg1-f171.google.com ([209.85.215.171]:40411 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB1AD2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Feb 2019 19:03:28 -0500
Received: by mail-pg1-f171.google.com with SMTP id u9so8746204pgo.7
        for <fstests@vger.kernel.org>; Wed, 27 Feb 2019 16:03:27 -0800 (PST)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4/035: Verify directory shrinking
Date: Wed, 27 Feb 2019 16:03:16 -0800
Message-Id: <20190228000316.238620-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
List-ID: <fstests@vger.kernel.org>

Add test to verify that directory shrinking works for ext4 and also
doing so repeatedly does not introduce any errors in file system.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 tests/ext4/035     | 109 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/035.out |   9 ++++
 tests/ext4/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100644 tests/ext4/035
 create mode 100644 tests/ext4/035.out

diff --git a/tests/ext4/035 b/tests/ext4/035
new file mode 100644
index 00000000..46898d99
--- /dev/null
+++ b/tests/ext4/035
@@ -0,0 +1,109 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Google, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 035
+#
+# Verify that directory shrinking works and that it does not introduce any
+# errors.
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
+    cd /
+    #rm -f $tmp.*
+}
+
+_make_files()
+{
+    dirname=$1
+    num_files=$2
+    for x in `seq 1 $num_files`; do
+        fname="$(printf "%.255s\n" "$(perl -e "print \"${x}_\" x 500;")")"
+        touch "${dirname}/${fname}"
+    done
+}
+
+_make_dirs_and_files()
+{
+    parent_dir=$1
+    num_dirs=$2
+    num_files=$3
+    for x in `seq 1 $num_dirs`; do
+	mkdir ${parent_dir}/${x}
+        _make_files "${parent_dir}/${x}" $num_files
+    done
+}
+
+_remove_dirs()
+{
+    parent_dir=$1
+    num_dirs=$2
+    for x in `seq 1 $num_dirs`; do
+        find ${parent_dir}/${x} -type f -exec rm '{}' \;
+    done
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+
+_require_scratch
+# test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
+_require_attrs
+
+rm -f $seqres.full
+TESTDIR="${SCRATCH_MNT}/scratchdir"
+TESTFILE="${TESTDIR}/testfile"
+
+echo "+ create scratch fs"
+_scratch_mkfs_ext4 > /dev/null 2>&1
+
+echo "+ mount fs image"
+_scratch_mount
+
+mkdir -p ${SCRATCH_MNT}/test
+
+echo "+ create files"
+blksz="$(stat -f -c '%s' "${SCRATCH_MNT}")"
+_make_files ${SCRATCH_MNT}/test $((blksz * 4 / 256))
+
+size_before=$(du -s "${SCRATCH_MNT}/test" | gawk '{print $1}')
+
+echo "+ remove files"
+rm ${SCRATCH_MNT}/test/*
+
+size_after=$(du -s "${SCRATCH_MNT}/test" | gawk '{print $1}')
+
+if [ $size_after -lt $size_before ]; then
+  echo "+ directory shrinked"
+else
+  _fail "directory did not shrink"
+fi
+
+echo "+ create many directories and files"
+_make_dirs_and_files ${SCRATCH_MNT} 4 10240
+
+echo "+ empty dirs"
+_remove_dirs ${SCRATCH_MNT} 4
+
+umount "${SCRATCH_MNT}"
+
+echo "+ check fs"
+e2fsck -fn ${SCRATCH_DEV} >> $seqres.full 2>&1 || _fail "fsck should not fail"
+
+status=0
+exit
diff --git a/tests/ext4/035.out b/tests/ext4/035.out
new file mode 100644
index 00000000..2d9a34e1
--- /dev/null
+++ b/tests/ext4/035.out
@@ -0,0 +1,9 @@
+QA output created by 035
++ create scratch fs
++ mount fs image
++ create files
++ remove files
++ directory shrinked
++ create many directories and files
++ empty dirs
++ check fs
diff --git a/tests/ext4/group b/tests/ext4/group
index eb744a12..c25205dd 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -37,6 +37,7 @@
 032 auto quick ioctl resize
 033 auto ioctl resize
 034 auto quick quota
+035 auto
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.21.0.rc2.261.ga7da99ff1b-goog
