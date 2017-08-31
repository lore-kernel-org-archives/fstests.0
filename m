Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58291 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750757AbdHaGe7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2017 02:34:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7V6Yeo0062161
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2017 02:34:58 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cpa77vgcs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2017 02:34:58 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 31 Aug 2017 00:34:58 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V2] overlay: Test constant d_ino feature
Date: Thu, 31 Aug 2017 12:05:32 +0530
Message-Id: <20170831063532.7505-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: amir73il@gmail.com, eguan@redhat.com
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, fstests@vger.kernel.org, miklos@szeredi.hu, linux-unionfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This commit adds a test to verify constant d_ino feature. The following
scenarios are checked,
- Parent's (i.e. "..") d_ino must always be calculated because a pure
  dir can be residing inside a merged dir.
- d_ino for "." must always be calculated because the present directory
  can have a copy-up origin.
- Verify d_ino values corresponding to "." and ".." entries of a pure
  lower dir.
- Verify d_ino of ".." entry of a merged dir.
- Verify pure lower residing in dir which has another lower layer pure
  lower residing in dir which has another lower layer.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
Changelog:
v1->v2:
1. Removed tests copied over from overlay/017.
2. Removed src/t_dir_ino.c.
3. Add code for testing,
   - d_ino of . and .. entries of pure_lower_dir.
   - d_ino of .. entry of merged_dir.
   - Verify pure lower residing in dir which has another lower layer.
   Thanks to Amir for suggesting these tests.

 tests/overlay/037     | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/037.out |   2 +
 tests/overlay/group   |   1 +
 3 files changed, 147 insertions(+)
 create mode 100755 tests/overlay/037
 create mode 100644 tests/overlay/037.out

diff --git a/tests/overlay/037 b/tests/overlay/037
new file mode 100755
index 0000000..225d2b9
--- /dev/null
+++ b/tests/overlay/037
@@ -0,0 +1,144 @@
+#! /bin/bash
+# FSQA Test No. 037
+#
+# Test constant d_ino numbers
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2017 IBM Corporation. All Rights Reserved.
+# Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
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
+# real QA test starts here
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+_require_test_program "af_unix"
+_require_test_program "t_dir_type"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+
+# Create our test files.
+lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
+mkdir -p $lowerdir
+
+pure_lower_dir=$lowerdir/pure_lower_dir
+impure_dir=$lowerdir/impure_dir
+merged_dir=$lowerdir/merged_dir
+
+mkdir $pure_lower_dir
+mkdir $impure_dir
+mkdir $merged_dir
+
+impure_dir_st_ino=$(stat -c '%i' $impure_dir)
+pure_lower_dir_st_ino=$(stat -c '%i' $pure_lower_dir)
+
+_scratch_mount
+
+impure_dir=$SCRATCH_MNT/impure_dir
+pure_upper_dir=$impure_dir/pure_upper_dir
+
+mkdir -p $pure_upper_dir
+
+# Parent's (i.e. "..") d_ino must always be calculated because a pure
+# dir can be residing inside a merged dir.
+parent_d=$($here/src/t_dir_type $pure_upper_dir $impure_dir_st_ino)
+[[ $parent_d != ".. d" ]] && \
+	echo "Pure dir inside a merged dir: Invalid d_ino reported for .."
+
+# d_ino for "." must always be calculated because the present
+# directory can have a copy-up origin.
+current_d=$($here/src/t_dir_type $impure_dir $impure_dir_st_ino)
+[[ $current_d != ". d" ]] && echo "Impure dir: Invalid d_ino reported for ."
+
+# Verify d_ino values corresponding to "." and ".." entries of a
+# pure lower dir.
+ovl_root_st_ino=$(stat -c '%i' $SCRATCH_MNT/)
+pure_lower_dir=$SCRATCH_MNT/pure_lower_dir
+
+parent_d=$($here/src/t_dir_type $pure_lower_dir $ovl_root_st_ino)
+[[ $parent_d != ".. d" ]] && echo "Pure lower dir: Invalid d_ino reported for .."
+
+current_d=$($here/src/t_dir_type $pure_lower_dir $pure_lower_dir_st_ino)
+[[ $current_d != ". d" ]] && echo "Pure lower dir: Invalid d_ino reported for ."
+
+# Verify d_ino of ".." entry of a merged dir.
+merged_dir=$SCRATCH_MNT/merged_dir
+touch $merged_dir/file.bin
+
+parent_d=$($here/src/t_dir_type $merged_dir $ovl_root_st_ino)
+[[ $parent_d != ".. d" ]] && echo "Merged dir: Invalid d_ino reported for .."
+
+_scratch_unmount
+
+# Verify pure lower residing in dir which has another lower layer
+_scratch_mkfs
+
+OVL_LOWER0=${OVL_LOWER}0
+OVL_LOWER1=${OVL_LOWER}1
+
+mkdir -p $OVL_BASE_SCRATCH_MNT/$OVL_LOWER0
+mkdir -p $OVL_BASE_SCRATCH_MNT/$OVL_LOWER1
+mkdir -p $OVL_BASE_SCRATCH_MNT/$OVL_UPPER
+mkdir -p $OVL_BASE_SCRATCH_MNT/$OVL_WORK
+
+lowerdir0=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER0
+lowerdir1=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER1
+upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
+workdir=$OVL_BASE_SCRATCH_MNT/$OVL_WORK
+
+mkdir -p $lowerdir0/dir0
+mkdir -p $lowerdir1/dir0/dir1
+
+dir0_st_ino=$(stat -c '%i' $lowerdir0/dir0)
+
+$MOUNT_PROG -t overlay overlay -o lowerdir=$lowerdir0:$lowerdir1 \
+	    -o upperdir=$upperdir -o workdir=$workdir $SCRATCH_MNT
+
+# Copy-up dir0
+touch $SCRATCH_MNT/dir0/file.bin
+
+parent_d=$($here/src/t_dir_type $SCRATCH_MNT/dir0/dir1 $dir0_st_ino)
+[[ $parent_d != ".. d" ]] && \
+	echo "Pure lower in dir which has another lower layer: Invalid d_ino reported for .."
+
+$UMOUNT_PROG $SCRATCH_MNT
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/overlay/037.out b/tests/overlay/037.out
new file mode 100644
index 0000000..5c3a30a
--- /dev/null
+++ b/tests/overlay/037.out
@@ -0,0 +1,2 @@
+QA output created by 037
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 4cc1d74..b2460e1 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -39,3 +39,4 @@
 034 auto quick copyup hardlink
 035 auto quick mount
 036 auto quick mount
+037 auto quick copyup
-- 
2.9.5

