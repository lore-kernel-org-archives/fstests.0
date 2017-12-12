Received: from imap.thunk.org ([74.207.234.97]:33012 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdLLFTn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Dec 2017 00:19:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common/populate: fix S_IFDIR.FMT_BLOCK and ATTR.FMT_LOCAL for ext4 encryption
Date: Tue, 12 Dec 2017 00:19:37 -0500
Message-Id: <20171212051937.25984-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

When ext4 encryption is enabled, the directory entries are encrypted
so we need to create fewer directory entries to guarantee that they
will all fit in a single block.

Also, the encryption metadata takes up extended attribute room so we
can only add a single xattr to guarantee that the xattrs will fit in
the inode.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/populate | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/populate b/common/populate
index b77c5081..07ea7e60 100644
--- a/common/populate
+++ b/common/populate
@@ -343,7 +343,7 @@ _scratch_ext4_populate() {
 
 	# - BLOCK
 	echo "+ block dir"
-	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_BLOCK" "$((dblksz / 24))"
+	__populate_create_dir "${SCRATCH_MNT}/S_IFDIR.FMT_BLOCK" "$((dblksz / 32))"
 
 	# - HTREE
 	echo "+ htree dir"
@@ -369,7 +369,7 @@ _scratch_ext4_populate() {
 	# Attribute formats
 	# LOCAL
 	echo "+ local attr"
-	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_LOCAL" 1
+	__populate_create_attr "${SCRATCH_MNT}/ATTR.FMT_LOCAL" 0
 
 	# BLOCK
 	echo "+ block attr"
-- 
2.11.0.rc0.7.gbe5a750

