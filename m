Received: from mail-pf0-f195.google.com ([209.85.192.195]:36411 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdCNVYU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2017 17:24:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id j5so20522284pfb.3
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2017 14:24:19 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic/397: test renaming encrypted files without key
Date: Tue, 14 Mar 2017 14:23:58 -0700
Message-Id: <20170314212358.46169-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Update generic/397 to test another behavior when accessing encrypted
files without the key: renames should be forbidden, even though they may
be possible cryptographically.  Test both a regular rename and a cross
rename.  (It happens that generic/398 also covers the cross rename case,
but it's primarily for a different reason.)

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/397     | 13 +++++++++++++
 tests/generic/397.out |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tests/generic/397 b/tests/generic/397
index 7077d048..0d3ab4c1 100755
--- a/tests/generic/397
+++ b/tests/generic/397
@@ -46,6 +46,7 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 . ./common/encrypt
+. ./common/renameat2
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
@@ -56,6 +57,7 @@ _supported_os Linux
 _require_scratch_encryption
 _require_xfs_io_command "set_encpolicy"
 _require_command "$KEYCTL_PROG" keyctl
+_requires_renameat2
 
 _new_session_keyring
 
@@ -135,6 +137,17 @@ mkdir $SCRATCH_MNT/edir/0123456789abcdef |& filter_create_errors | _filter_scrat
 ln -s foo $SCRATCH_MNT/edir/newlink |& filter_create_errors | _filter_scratch
 ln -s foo $SCRATCH_MNT/edir/0123456789abcdef |& filter_create_errors | _filter_scratch
 
+# Try to rename files in the encrypted directory.  This should fail with ENOKEY.
+# As noted above, encrypted filenames are unpredictable, so this needs to be
+# written in a way that does not assume any particular filenames.
+# Regression test for:
+#	173b8439e1ba ("ext4: don't allow encrypted operations without keys")
+#	363fa4e078cb ("f2fs: don't allow encrypted operations without keys")
+efile1=$(find $SCRATCH_MNT/edir -maxdepth 1 -type f | head -1)
+efile2=$(find $SCRATCH_MNT/edir -maxdepth 1 -type f | tail -1)
+mv $efile1 $efile2 |& _filter_scratch | sed 's|edir/[a-zA-Z0-9+,_]\+|edir/FILENAME|g'
+src/renameat2 -x $efile1 $efile2
+
 # Delete the encrypted directory (should succeed)
 rm -r $SCRATCH_MNT/edir
 stat $SCRATCH_MNT/edir |& _filter_scratch
diff --git a/tests/generic/397.out b/tests/generic/397.out
index 2f55c5d6..3cf57aab 100644
--- a/tests/generic/397.out
+++ b/tests/generic/397.out
@@ -10,4 +10,6 @@ mkdir: cannot create directory 'SCRATCH_MNT/edir/newdir': Required key not avail
 mkdir: cannot create directory 'SCRATCH_MNT/edir/0123456789abcdef': Required key not available
 ln: failed to create symbolic link 'SCRATCH_MNT/edir/newlink': Required key not available
 ln: failed to create symbolic link 'SCRATCH_MNT/edir/0123456789abcdef': Required key not available
+mv: cannot move 'SCRATCH_MNT/edir/FILENAME' to 'SCRATCH_MNT/edir/FILENAME': Required key not available
+Required key not available
 stat: cannot stat 'SCRATCH_MNT/edir': No such file or directory
-- 
2.12.0.367.g23dc2f6d3c-goog

