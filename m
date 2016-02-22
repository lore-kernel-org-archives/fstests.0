Received: from imap.thunk.org ([74.207.234.97]:34164 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbcBVE0U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 23:26:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/4] common: filter warning messages from mkfs.ext4
Date: Sun, 21 Feb 2016 23:26:11 -0500
Message-Id: <1456115171-13191-5-git-send-email-tytso@mit.edu>
In-Reply-To: <1456115171-13191-1-git-send-email-tytso@mit.edu>
References: <1456115171-13191-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Commit 4a5cda8102828 ("xfstests: do not unmount tmpfs during remount")
changed generic/135 to no longer redirect stderr to /dev/null when
running _scratch_mkfs.  This caused ext4 using a 1k block size to fail
when running this test because mkfs.ext4 would issue a warning message
about the use of a non-block size that wasn't expected by golden
output for the test.  Fix this by filtering out warning messages in
_scratch_mkfs_ext4.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index f07b274..5fb3282 100644
--- a/common/rc
+++ b/common/rc
@@ -655,7 +655,7 @@ _scratch_mkfs_ext4()
 	fi
 
 	# output stored mkfs output
-	cat $tmp_dir.mkfserr >&2
+	grep -v ^Warning: $tmp_dir.mkfserr >&2
 	cat $tmp_dir.mkfsstd
 	rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
 
-- 
2.5.0

