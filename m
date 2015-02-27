Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42514 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbbB0BYJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 20:24:09 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] generic/066: add _require_metadata_replay
Date: Thu, 26 Feb 2015 17:23:47 -0800
Message-Id: <1425000227-69601-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.com>, Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

This patch adds _require_metadata_replay to detect whether or not filesystem
supports metadata replay.

This should be used when:

1. create file A
2. write file A
3. fsync file A

4. write file A

5. create file B
6. fsync file B
7. crash!

In this case, if filesystem supports metadata_replay, file A's data written
by #4 should be recovered.
Otherwise, file A is recovered to #3.

Cc: Filipe Manana <fdmanana@suse.com>
Cc: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc         | 18 ++++++++++++++++++
 tests/generic/066 |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1ed9df5..e6e8d1f 100644
--- a/common/rc
+++ b/common/rc
@@ -2372,6 +2372,24 @@ _require_metadata_journaling()
 	esac
 }
 
+# Does this filesystem support metadata replay?
+# Filesystem is able to recover metadata which were not written by fsync
+# exlicitly. But another fsync'ed metadata should be followed by them.
+_require_metadata_replay()
+{
+	_require_metadata_journaling $1
+
+	case "$FSTYP" in
+	f2fs)
+		# f2fs supports metadata_journaling, but does not recover any
+		# intermediate metadata which was not fsync'ed explicitly.
+		_notrun "$FSTYP does not support metadata replay"
+		;;
+	*)
+		;;
+	esac
+}
+
 # Does fiemap support?
 _require_fiemap()
 {
diff --git a/tests/generic/066 b/tests/generic/066
index cb36506..3fefda4 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -61,7 +61,7 @@ _need_to_be_root
 _require_scratch
 _require_dm_flakey
 _require_attrs
-_require_metadata_journaling $SCRATCH_DEV
+_require_metadata_replay $SCRATCH_DEV
 
 _crash_and_mount()
 {
-- 
2.1.1

