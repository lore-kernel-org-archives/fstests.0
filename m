Received: from mail.kernel.org ([198.145.29.136]:43396 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbbJNIqk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 14 Oct 2015 04:46:40 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs/112: add missing _require_xfs_io_command for falloc
Date: Tue, 13 Oct 2015 22:24:59 +0100
Message-Id: <1444771499-2151-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

I forgot to add the requirement for the xfs_io command "falloc", which
the test makes use of. Also fixed a weird indentation (mix of spaces
and tabs) for one line of a comment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/112 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/112 b/tests/btrfs/112
index f4fad49..45f68fc 100755
--- a/tests/btrfs/112
+++ b/tests/btrfs/112
@@ -49,6 +49,7 @@ _require_scratch
 _require_cloner
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
@@ -61,7 +62,7 @@ test_cloning_inline_extents()
 	_scratch_mount $mount_opts
 
 	# File bar, the source for all the following clone operations, consists
-        # of a # single inline extent (50 bytes).
+	# of a single inline extent (50 bytes).
 	$XFS_IO_PROG -f -c "pwrite -S 0xbb 0 50" $SCRATCH_MNT/bar \
 		| _filter_xfs_io
 
-- 
2.1.3

