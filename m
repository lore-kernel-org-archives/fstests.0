Received: from mx1.redhat.com ([209.132.183.28]:57645 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933443AbcCPLyD (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Mar 2016 07:54:03 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/073: filter out finobt warning from mkfs.xfs
Date: Wed, 16 Mar 2016 19:53:24 +0800
Message-Id: <1458129204-31882-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

When testing xfs/073 with MKFS_OPTIONS="-m crc=1,finobt=1" set, it fails
due to extra warning about disabling finobt feature:

 +warning: finobt not supported without CRC support, disabled.

Because xfs/073 disables crc unconditionally and finobt can not be
enabled either.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/073 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/073 b/tests/xfs/073
index e1335df..909231b 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -61,6 +61,11 @@ _filter_path()
 	sed -e "s,$1,<MNTPATH>,g" | LC_COLLATE=POSIX sort
 }
 
+filter_finobt_warn()
+{
+	sed -e "s/warning: finobt .*without CRC.*disabled.//"
+}
+
 _populate_scratch()
 {
 	POSIXLY_CORRECT=yes \
@@ -138,7 +143,8 @@ _require_loop
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
+_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 2>&1 | filter_finobt_warn | \
+	_filter_mkfs 2>/dev/null
 _scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
 
 echo
-- 
2.5.0

