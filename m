Received: from imap.thunk.org ([74.207.234.97]:33742 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbdBEGxq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 01:53:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] generic: filter out lost+found when running "ls $SCRATCH_MNT"
Date: Sun,  5 Feb 2017 01:53:36 -0500
Message-Id: <20170205065336.14994-3-tytso@mit.edu>
In-Reply-To: <20170205065336.14994-1-tytso@mit.edu>
References: <20170205065336.14994-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The generic/052 and generic/054 tests run ls on the root directory,
and on ext4 we have a lost+found directory which is not in the golden
output.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/filter     | 5 +++++
 tests/generic/052 | 2 +-
 tests/generic/054 | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/common/filter b/common/filter
index e39ac0e2..43281599 100644
--- a/common/filter
+++ b/common/filter
@@ -401,5 +401,10 @@ _filter_mknod()
 	sed -e "s/mknod: [\`']\(.*\)': File exists/mknod: \1: File exists/"
 }
 
+_filter_lostfound()
+{
+	sed -e '/^lost+found$/d'
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/052 b/tests/generic/052
index 74cf5b62..f7cdd09c 100755
--- a/tests/generic/052
+++ b/tests/generic/052
@@ -82,7 +82,7 @@ _scratch_mount $mnt >>$seqres.full 2>&1 \
     || _fail "mount failed: $mnt $MOUNT_OPTIONS"
 
 echo "ls SCRATCH_MNT"
-ls $SCRATCH_MNT
+ls $SCRATCH_MNT | _filter_lostfound
 
 echo "unmount"
 _scratch_unmount
diff --git a/tests/generic/054 b/tests/generic/054
index 238741c1..8375e574 100755
--- a/tests/generic/054
+++ b/tests/generic/054
@@ -102,7 +102,7 @@ for s in sync nosync ; do
 
 	# check before on what FS should look like
 	_echofull "ls SCRATCH_MNT"
-	ls $SCRATCH_MNT
+	ls $SCRATCH_MNT | _filter_lostfound
 
 	_echofull "godown"
 	src/godown -v -f $SCRATCH_MNT >> $seqres.full
@@ -120,7 +120,7 @@ for s in sync nosync ; do
 
 	# check on what FS looks like after log recovery
 	_echofull "ls SCRATCH_MNT"
-	ls $SCRATCH_MNT
+	ls $SCRATCH_MNT | _filter_lostfound
 
 	_echofull "unmount"
 	_scratch_unmount
-- 
2.11.0.rc0.7.gbe5a750

