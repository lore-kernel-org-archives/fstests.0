Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53910 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728280AbfHZRuu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Aug 2019 13:50:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common/casefold: only check for the Casefold flag
Date: Mon, 26 Aug 2019 13:50:20 -0400
Message-Id: <20190826175020.28959-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The _casefold_lsattr_dir function lists all of the file attributes.
As result, tests/generic/556.out has an ext4-specific assumption that
files will have the Extents attribute.  That won't be true for all
file systems, and it won't even be true for ext4 file systems that do
not have the extents feature enabled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/casefold       |  6 +++++-
 tests/generic/556.out | 10 +++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/casefold b/common/casefold
index 051fd1d1..2a7ab3eb 100644
--- a/common/casefold
+++ b/common/casefold
@@ -86,5 +86,9 @@ _casefold_unset_attr()
 
 _casefold_lsattr_dir()
 {
-	$LSATTR_PROG -ld "${1}" | _filter_spaces
+	if $LSATTR_PROG -ld "${1}" | grep -q Casefold ; then
+		echo "${1} Casefold"
+	else
+		echo "${1}"
+	fi
 }
diff --git a/tests/generic/556.out b/tests/generic/556.out
index 1573c8b1..47656065 100644
--- a/tests/generic/556.out
+++ b/tests/generic/556.out
@@ -1,9 +1,9 @@
 QA output created by 556
-SCRATCH_MNT/basic Extents, Casefold
-SCRATCH_MNT/basic Extents
-SCRATCH_MNT/casefold_flag_removal Extents, Casefold
-SCRATCH_MNT/casefold_flag_removal Extents, Casefold
-SCRATCH_MNT/flag_inheritance/d1/d2/d3 Extents, Casefold
+SCRATCH_MNT/basic Casefold
+SCRATCH_MNT/basic
+SCRATCH_MNT/casefold_flag_removal Casefold
+SCRATCH_MNT/casefold_flag_removal Casefold
+SCRATCH_MNT/flag_inheritance/d1/d2/d3 Casefold
 SCRATCH_MNT/symlink/ind1/TARGET
 mv: cannot stat 'SCRATCH_MNT/rename/rename': No such file or directory
 # file: SCRATCH_MNT/xattrs/x
-- 
2.23.0
