Received: from mail-pf0-f182.google.com ([209.85.192.182]:35064 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbcLETXZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2016 14:23:25 -0500
Received: by mail-pf0-f182.google.com with SMTP id i88so64890089pfk.2
        for <fstests@vger.kernel.org>; Mon, 05 Dec 2016 11:23:25 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3 3/6] generic: test validation of encryption policy structure
Date: Mon,  5 Dec 2016 11:21:06 -0800
Message-Id: <1480965669-39714-4-git-send-email-ebiggers@google.com>
In-Reply-To: <1480965669-39714-1-git-send-email-ebiggers@google.com>
References: <1480965669-39714-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Add an xfstest which verifies the kernel performs basic validation of
the encryption policy structure.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/401     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/401.out | 18 +++++++++++
 tests/generic/group   |  1 +
 3 files changed, 102 insertions(+)
 create mode 100755 tests/generic/401
 create mode 100644 tests/generic/401.out

diff --git a/tests/generic/401 b/tests/generic/401
new file mode 100755
index 0000000..553c547
--- /dev/null
+++ b/tests/generic/401
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FS QA Test generic/401
+#
+# Test that FS_IOC_SET_ENCRYPTION_POLICY correctly validates the fscrypt_policy
+# structure that userspace passes to it.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Google, Inc.  All Rights Reserved.
+#
+# Author: Eric Biggers <ebiggers@google.com>
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
+. ./common/encrypt
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4 f2fs
+_supported_os Linux
+_require_xfs_io_command "set_encpolicy"
+_require_scratch
+_require_encryption
+
+_scratch_mkfs_encrypted >> $seqres.full
+_scratch_mount
+mkdir $SCRATCH_MNT/dir
+cd $SCRATCH_MNT
+
+echo -e "\n*** Invalid contents encryption mode ***"
+$XFS_IO_PROG -c "set_encpolicy -c 0xFF" dir
+
+echo -e "\n*** Invalid filenames encryption mode ***"
+$XFS_IO_PROG -c "set_encpolicy -n 0xFF" dir
+
+echo -e "\n*** Invalid flags ***"
+$XFS_IO_PROG -c "set_encpolicy -f 0xFF" dir
+
+echo -e "\n*** Invalid policy version ***"
+$XFS_IO_PROG -c "set_encpolicy -v 0xFF" dir
+
+# Currently, the only supported combination of modes is AES-256-XTS for contents
+# and AES-256-CTS for filenames.  Nothing else should be accepted.
+echo -e "\n*** Invalid combinations of modes ***"
+$XFS_IO_PROG -c "set_encpolicy -c AES-256-CTS -n AES-256-CTS" dir
+$XFS_IO_PROG -c "set_encpolicy -c AES-256-CTS -n AES-256-XTS" dir
+$XFS_IO_PROG -c "set_encpolicy -c AES-256-XTS -n AES-256-XTS" dir
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/401.out b/tests/generic/401.out
new file mode 100644
index 0000000..eb6142e
--- /dev/null
+++ b/tests/generic/401.out
@@ -0,0 +1,18 @@
+QA output created by 401
+
+*** Invalid contents encryption mode ***
+dir: failed to set encryption policy: Invalid argument
+
+*** Invalid filenames encryption mode ***
+dir: failed to set encryption policy: Invalid argument
+
+*** Invalid flags ***
+dir: failed to set encryption policy: Invalid argument
+
+*** Invalid policy version ***
+dir: failed to set encryption policy: Invalid argument
+
+*** Invalid combinations of modes ***
+dir: failed to set encryption policy: Invalid argument
+dir: failed to set encryption policy: Invalid argument
+dir: failed to set encryption policy: Invalid argument
diff --git a/tests/generic/group b/tests/generic/group
index e6619ca..a455c29 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -397,3 +397,4 @@
 392 auto quick metadata
 393 auto quick rw
 400 auto quick encrypt
+401 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

