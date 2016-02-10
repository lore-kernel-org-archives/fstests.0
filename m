Received: from imap.thunk.org ([74.207.234.97]:51034 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097AbcBJBuN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 01/12] check: avoid error messages of tests/$FS does not exist
Date: Tue,  9 Feb 2016 20:49:50 -0500
Message-Id: <1455069001-17846-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

There are no tmpfs specific tests, so tests/tmpfs does not exist.
Avoid print an error message caused by trying to read the file
tests/tmpfs/group (for example).

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

