Received: from imap.thunk.org ([74.207.234.97]:35991 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbcBKF41 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 01/13] check: avoid spurious complaints that tests/$FSTYP/group does not exist
Date: Thu, 11 Feb 2016 00:56:10 -0500
Message-Id: <1455170182-32587-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

There are no tmpfs specific tests, so tests/tmpfs does not exist.
This commit avoids printing a spurious error message when running
specifying a group of tests (e.g., "check -g quick"):

  DEVICE: test:/tmp
  MK2FS OPTIONS:
  MOUNT OPTIONS: -o block_validity
  ./check: line 96: tests/tmpfs/group: No such file or directory
  FSTYP         -- tmpfs
  PLATFORM      -- Linux/i686 kvm-xfstests 4.5.0-rc2ext4-00002-g6df2762
  MKFS_OPTIONS  -- test:/scratch
  MOUNT_OPTIONS -- -o size=1G test:/scratch /test/scratch

  generic/001      [10:31:10][    5.811742] run fstests generic/001
      ...

Similar problems have been reported when testing nfs using xfstests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 check | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/check b/check
index c40d2a8..2986d84 100755
--- a/check
+++ b/check
@@ -90,6 +90,9 @@ get_group_list()
 	grp=$1
 
 	for d in $SRC_GROUPS $FSTYP; do
+		if ! test -d "$SRC_DIR/$d" ; then
+			continue
+		fi
 		l=$(sed -n < $SRC_DIR/$d/group \
 			-e 's/#.*//' \
 			-e 's/$/ /' \
@@ -105,6 +108,9 @@ get_all_tests()
 {
 	touch $tmp.list
 	for d in $SRC_GROUPS $FSTYP; do
+		if ! test -d "$SRC_DIR/$d" ; then
+			continue
+		fi
 		ls $SRC_DIR/$d/* | \
 			grep -v "\..*" | \
 			grep "^$SRC_DIR/$d/$VALID_TEST_NAME"| \
-- 
2.5.0

