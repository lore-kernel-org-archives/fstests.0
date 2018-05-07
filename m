Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:26847 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752773AbeEGXFz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 May 2018 19:05:55 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fFpCZ-00022W-BL
        for fstests@vger.kernel.org; Tue, 08 May 2018 09:05:51 +1000
Date: Tue, 8 May 2018 09:05:51 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH V2] xfs: test inobt/on disk free state mismatches
Message-ID: <20180507230551.GJ10363@dastard>
References: <20180506225352.4415-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506225352.4415-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


From: Dave Chinner <dchinner@redhat.com>

Fuzzing has recently uncovered a couple of conditions where we don't
detect corruptions that reallocate already allocated inodes. This
test exercises those cases, and checks that we shut down the
filesystem appropriately when such a corruption occurs.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
V2:
- fix method of calling xfs_db to use correct helpers.

 tests/{shared/003 => xfs/450} | 41 ++++++++++++++++++++++-------------------
 tests/xfs/450.out             | 26 ++++++++++++++++++++++++++
 tests/xfs/group               |  1 +
 3 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/tests/shared/003 b/tests/xfs/450
similarity index 59%
copy from tests/shared/003
copy to tests/xfs/450
index 9a9956cf44de..267089738574 100755
--- a/tests/shared/003
+++ b/tests/xfs/450
@@ -1,15 +1,10 @@
 #! /bin/bash
-# FS QA Test 003
+# FS QA Test 450
 #
-# Test mount a needs_recovery partition with noload option.
-# ext4 used to Oops until part of this commit:
-#
-# 744692d ext4: use ext4_get_block_write in buffer write
-#
-# Also test on ext2/3.
+# Catch inobt/on disk inode free state mismatches on V4 filesystems
 #
 #-----------------------------------------------------------------------
-# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
+# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -45,25 +40,33 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 # real QA test starts here
-_supported_fs ext2 ext3 ext4
+
+_supported_fs xfs
 _supported_os Linux
 
-# nofsck as we modify sb via debugfs
+# we intentionally corrupt the filesystem, so don't check it after the test
 _require_scratch_nocheck
 
-# remove previous $seqres.full before test
-rm -f $seqres.full
-echo "Silence is golden"
+# on success, we'll get a shutdown filesystem with a really noisy log message
+# due to transaction cancellation.  Hence we don't want to check dmesg here.
+_disable_dmesg_check
+
+_require_xfs_mkfs_crc
+_scratch_mkfs -m crc=0 > $seqres.full 2>&1
 
-_scratch_mkfs >>$seqres.full 2>&1
+# corrupt an inode in the root inode chunk
+root_ino=$(_scratch_xfs_get_metadata_field 'rootino' 'sb 0')
+corrupt_ino=$((root_ino + 15))
+_scratch_xfs_set_metadata_field 'core.mode' 0100644 "inode $corrupt_ino"
 
-# set needs_recovery feature bit
-debugfs -w -R "feature +needs_recovery" $SCRATCH_DEV \
-	>>$seqres.full 2>&1
+_scratch_mount
 
-# mount with noload option
-_try_scratch_mount "-o noload" >>$seqres.full 2>&1
+# The corrupt inode should be tripped over during these initial file creates.
+touch $SCRATCH_MNT/file{0,1,2,3,4,5}{0,1,2,3,4,5} 2>&1 | _filter_scratch
 
 # success, all done
 status=0
diff --git a/tests/xfs/450.out b/tests/xfs/450.out
new file mode 100644
index 000000000000..379a8d6f6ec9
--- /dev/null
+++ b/tests/xfs/450.out
@@ -0,0 +1,26 @@
+QA output created by 450
+core.mode = 0100644
+touch: cannot touch 'SCRATCH_MNT/file20': Structure needs cleaning
+touch: cannot touch 'SCRATCH_MNT/file21': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file22': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file23': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file24': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file25': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file30': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file31': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file32': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file33': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file34': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file35': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file40': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file41': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file42': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file43': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file44': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file45': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file50': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file51': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file52': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file53': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file54': Input/output error
+touch: cannot touch 'SCRATCH_MNT/file55': Input/output error
diff --git a/tests/xfs/group b/tests/xfs/group
index d62345fc8f96..2a7f5eb68e82 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -442,3 +442,4 @@
 443 auto quick ioctl fsr
 444 auto quick
 445 auto quick filestreams
+450 auto quick
