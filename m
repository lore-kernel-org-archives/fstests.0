Received: from mail-pg0-f66.google.com ([74.125.83.66]:35456 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758202AbcLUVYm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 16:24:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id i5so7985711pgh.2
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 13:24:37 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v5 3/6] generic: test validation of encryption policy structure
Date: Wed, 21 Dec 2016 13:21:59 -0800
Message-Id: <1482355322-74978-4-git-send-email-ebiggers3@gmail.com>
In-Reply-To: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
References: <1482355322-74978-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Sandeen <sandeen@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add an xfstest which verifies the kernel performs basic validation of
the encryption policy structure.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/401     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/401.out | 18 +++++++++++
 tests/generic/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100755 tests/generic/401
 create mode 100644 tests/generic/401.out

diff --git a/tests/generic/401 b/tests/generic/401
new file mode 100755
index 0000000..1c9d964
--- /dev/null
+++ b/tests/generic/401
@@ -0,0 +1,82 @@
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
+_supported_fs generic
+_supported_os Linux
+_require_scratch_encryption
+_require_xfs_io_command "set_encpolicy"
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+dir=$SCRATCH_MNT/dir
+mkdir $dir
+
+echo -e "\n*** Invalid contents encryption mode ***"
+$XFS_IO_PROG -c "set_encpolicy -c 0xFF" $dir |& _filter_scratch
+
+echo -e "\n*** Invalid filenames encryption mode ***"
+$XFS_IO_PROG -c "set_encpolicy -n 0xFF" $dir |& _filter_scratch
+
+echo -e "\n*** Invalid flags ***"
+$XFS_IO_PROG -c "set_encpolicy -f 0xFF" $dir |& _filter_scratch
+
+echo -e "\n*** Invalid policy version ***"
+$XFS_IO_PROG -c "set_encpolicy -v 0xFF" $dir |& _filter_scratch
+
+# Currently, the only supported combination of modes is AES-256-XTS for contents
+# and AES-256-CTS for filenames.  Nothing else should be accepted.
+echo -e "\n*** Invalid combinations of modes ***"
+$XFS_IO_PROG -c "set_encpolicy -c AES-256-CTS -n AES-256-CTS" $dir |& _filter_scratch
+$XFS_IO_PROG -c "set_encpolicy -c AES-256-CTS -n AES-256-XTS" $dir |& _filter_scratch
+$XFS_IO_PROG -c "set_encpolicy -c AES-256-XTS -n AES-256-XTS" $dir |& _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/401.out b/tests/generic/401.out
new file mode 100644
index 0000000..ea349cc
--- /dev/null
+++ b/tests/generic/401.out
@@ -0,0 +1,18 @@
+QA output created by 401
+
+*** Invalid contents encryption mode ***
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
+
+*** Invalid filenames encryption mode ***
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
+
+*** Invalid flags ***
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
+
+*** Invalid policy version ***
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
+
+*** Invalid combinations of modes ***
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
+SCRATCH_MNT/dir: failed to set encryption policy: Invalid argument
diff --git a/tests/generic/group b/tests/generic/group
index 3ecd8e9..3fa745d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -398,3 +398,4 @@
 393 auto quick rw
 394 auto quick
 400 auto quick encrypt
+401 auto quick encrypt
-- 
2.8.0.rc3.226.g39d4020

