Received: from imap.thunk.org ([74.207.234.97]:34538 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbcBMRlP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 10/16] generic: do not unmount before calling _check_scratch_fs()
Date: Sat, 13 Feb 2016 12:41:03 -0500
Message-Id: <1455385269-26319-11-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Junho Ryu <jayr@google.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Junho Ryu <jayr@google.com>

Fix generic/053 so it works on tmpfs by relying on _check_scratch_fs
to unmount before checking the file system and remounting it
afterwards.  Many other tests rely on this, and since tmpfs does not
have a file system consistency checker, this allows the test to
succeed because the files don't disappear when the tmpfs file system
is unmounted.

Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/053     | 2 --
 tests/generic/053.out | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tests/generic/053 b/tests/generic/053
index a0e7280..cf46a93 100755
--- a/tests/generic/053
+++ b/tests/generic/053
@@ -81,9 +81,7 @@ list_acls()
 
 echo "acls before repair:"
 list_acls
-_do 'unmount $SCRATCH_DEV' '_scratch_unmount'
 _do 'repair filesystem' '_check_scratch_fs'
-_do 'mount filesytem' '_scratch_mount'
 echo "acls after repair: "
 list_acls
 
diff --git a/tests/generic/053.out b/tests/generic/053.out
index cd71cbb..d57857a 100644
--- a/tests/generic/053.out
+++ b/tests/generic/053.out
@@ -10,9 +10,7 @@ $SCRATCH_MNT/test.4 [u::---,g::r-x,o::rwx]
 $SCRATCH_MNT/test.5 [u::---,u:id2:r-x,g::---,m::rwx,o::---]
 $SCRATCH_MNT/test.6 [u::rwx,g::r-x,o::r--]
 $SCRATCH_MNT/test.7 [u::---,g::---,g:id2:r-x,m::-w-,o::---]
-unmount $SCRATCH_DEV... done
 repair filesystem... done
-mount filesytem... done
 acls after repair: 
 $SCRATCH_MNT/test.0 [u::r--,g::rwx,o::rw-]
 $SCRATCH_MNT/test.1 [u::r-x,g::---,o::---]
-- 
2.5.0

