Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeEUB7E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 20 May 2018 21:59:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 292EC4201AE6
        for <fstests@vger.kernel.org>; Mon, 21 May 2018 01:59:04 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD95AFD68
        for <fstests@vger.kernel.org>; Mon, 21 May 2018 01:59:02 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs: test inode allocation state missmatch corruption
Date: Mon, 21 May 2018 09:58:57 +0800
Message-Id: <20180521015857.7339-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There's a situation where the directory structure and the inobt
thinks the inode is free, but the inode on disk thinks it is still
in use. XFS should detect it and prevent the kernel from oopsing
on lookup.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Re-send this case due to we can use it to test different code
paths, refer to:
https://marc.info/?l=fstests&m=152662117205960&w=2

V2 did below changes:
1) Fix Copyright
2) Use 'convert' command of xfs_db to get agino from inode number.

V1 and related reply as below:
https://marc.info/?l=fstests&m=152229518811044&w=2

Thanks,
Zorro

 tests/xfs/999     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |   2 +
 tests/xfs/group   |   1 +
 3 files changed, 117 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 00000000..be26420a
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,114 @@
+#! /bin/bash
+# FS QA Test No. 999
+#
+# Test a corruption when the directory structure and the inobt thinks the inode
+# is free, but the inode on disk thinks it is still in use.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch_nocheck
+_require_no_xfs_bug_on_assert
+
+_filter_dmesg()
+{
+	local warn1="Internal error xfs_trans_cancel.*fs/xfs/xfs_trans\.c.*"
+	local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
+
+	sed -e "s#$warn1#Intentional error in xfs_trans_cancel#" \
+	    -e "s#$warn2#Intentional warnings in assfail#"
+}
+
+# Use crc=0, due to this crash is only possible on v4 XFS or v5 XFS mounted
+# with the ikeep mount option. For all other V5 XFS, this problem cannot
+# occur because we don't read inodes we are allocating from disk - we simply
+# overwrite them with the new inode information.
+_scratch_mkfs_xfs -m crc=0 >> $seqres.full 2>&1
+blksz=$(_scratch_xfs_get_sb_field blocksize)
+agcount=$(_scratch_xfs_get_sb_field agcount)
+
+_scratch_mount
+# Create a directory for later allocation in same AG (AG 0, due to this's an
+# empty XFS for now)
+mkdir $SCRATCH_MNT/dir
+
+# Allocate 1 block for testfile
+$XFS_IO_PROG -fc 'pwrite 0 $blksz' -c fsync $SCRATCH_MNT/dir/testfile >> $seqres.full
+inum=`stat -c %i $SCRATCH_MNT/dir/testfile`
+_scratch_unmount
+
+# Find the AG which contains testfile
+agi=`_scratch_xfs_db -c "convert inode $inum agno" | sed -e 's/^.*(\([0-9]*\).*$/\1/g'`
+
+# Due to we only allocate 1 block for testfile, and this's the only one data
+# block we use. So we use single level inobt, So the ${agi}->root->recs[1]
+# should be the only one record points the chunk which contains testfile's
+# inode.
+# An exmaple of inode record is as below:
+#   recs[1] = [startino,freecount,free] 1:[1024,59,0xffffffffffffffe0]
+freecount=$(_scratch_xfs_get_metadata_field "recs[1].freecount" \
+					    "agi $agi" "addr root")
+fmask=$(_scratch_xfs_get_metadata_field "recs[1].free" "agi $agi" "addr root")
+
+# fmask shift right 1 bit, and freecount++, to mark testfile inode as free in
+# inobt. (But the inode itself isn't freed, it still has allocated block)
+freecount="$((freecount + 1))"
+fmask="$((fmask / 2))"
+_scratch_xfs_set_metadata_field "recs[1].freecount" "$freecount" \
+				"agi $agi" "addr root" >/dev/null
+_scratch_xfs_set_metadata_field "recs[1].free" "$fmask" \
+				"agi $agi" "addr root" >/dev/null
+
+# Mount again and create a new inode cover that inode we just 'freed' from inobt
+_scratch_mount
+$XFS_IO_PROG -fc 'pwrite 0 $blksz' -c fsync $SCRATCH_MNT/dir/newfile 2>&1 | \
+	grep -i "Structure needs cleaning" | _filter_scratch
+
+# filter a intentional internal errors
+_check_dmesg _filter_dmesg
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 00000000..cb8d9e34
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+SCRATCH_MNT/dir/newfile: Structure needs cleaning
diff --git a/tests/xfs/group b/tests/xfs/group
index 32bf4f71..ec3cca62 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -442,3 +442,4 @@
 443 auto quick ioctl fsr
 444 auto quick
 445 auto quick filestreams
+999 auto quick
-- 
2.14.3

