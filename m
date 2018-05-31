Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeEaPC0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 31 May 2018 11:02:26 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [fstests PATCH] generic: test reporting of wb errors via syncfs
Date: Thu, 31 May 2018 11:02:24 -0400
Message-Id: <20180531150224.24933-1-jlayton@kernel.org>
In-Reply-To: <20180531112945.8629-1-jlayton@kernel.org>
References: <20180531112945.8629-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com, linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

Add a test for new syncfs error reporting behavior. When an inode fails
to be written back, ensure that we report an error to a subsequent call
to syncfs().

Because we don't want to grow struct file in order to support this, we
only do this if the file was opened with O_PATH flag.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 tests/generic/999     | 99 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  8 ++++
 tests/generic/group   |  1 +
 3 files changed, 108 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

This is the companion testcase patch to this series:

    [PATCH v2 0/5] vfs: allow syncfs to return an error when inode writeback fails

We probably don't want to merge this until it's clear that treating
syncfs differently on an O_PATH open is OK.

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..e468d0108ce5
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,99 @@
+#! /bin/bash
+# FS QA Test No. 999
+#
+# Open a file and write to it and fsync. Then, flip the data device to throw
+# errors, write to it again and do an fdatasync. Then open an O_PATH fd on the
+# same file and call syncfs against it and ensure that an error is reported,
+# then call syncfs again and ensure that no error is reported. Finally, repeat
+# the open and syncfs and ensure that there is no error reported.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018, Jeff Layton <jlayton@redhat.com>
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
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_dmerror_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmerror
+
+# real QA test starts here
+_supported_os Linux
+_require_xfs_io_command 'open' '-P'
+_require_scratch_nocheck
+# This test uses "dm" without taking into account the data could be on
+# realtime subvolume, thus the test will fail with rtinherit=1
+_require_no_rtinherit
+_require_dm_target error
+
+rm -f $seqres.full
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_dmerror_init
+_dmerror_mount
+
+datalen=65536
+_require_fs_space $SCRATCH_MNT $datalen
+
+# use fd 5 to hold file open
+testfile=$SCRATCH_MNT/syncfs-reports-errors
+exec 5>$testfile
+
+# write some data to file and fsync it out
+$XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
+
+# flip device to non-working mode
+_dmerror_load_error_table
+
+# rewrite the data, and do fdatasync
+$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile
+
+# heal the device error
+_dmerror_load_working_table
+
+# open again and call syncfs twice
+echo "One of the following syncfs calls should fail with EIO:"
+$XFS_IO_PROG -P -c syncfs -c syncfs $testfile
+echo "done"
+
+echo "This syncfs call should succeed:"
+$XFS_IO_PROG -P -c syncfs $testfile
+echo "done"
+
+# close file
+exec 5>&-
+
+# success, all done
+_dmerror_cleanup
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..950a2ba42503
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,8 @@
+QA output created by 999
+Format and mount
+fdatasync: Input/output error
+One of the following syncfs calls should fail with EIO:
+syncfs: Input/output error
+done
+This syncfs call should succeed:
+done
diff --git a/tests/generic/group b/tests/generic/group
index 752ee35ed3f7..e35491f69e97 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -497,3 +497,4 @@
 493 auto quick swap
 494 auto quick swap
 495 auto quick swap
+999 auto quick
-- 
2.17.0

