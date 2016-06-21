Received: from mx1.redhat.com ([209.132.183.28]:41779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcFUMCz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 08:02:55 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/186: run test on expected XFS configuration
Date: Tue, 21 Jun 2016 20:01:47 +0800
Message-Id: <1466510507-17548-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Usually xfs/186 _notrun on crc enabled XFS because of
_require_attr_v1, since v2 attr format is always enabled on v5 XFS.

But when testing on 512B block size XFS, i.e. MKFS_OPTIONS="-m crc=0
-b size=512", test fails. This is because crc enalbed XFS was
created in the end, not 512B block size XFS with crc disabled, and
that's not what we want to test.

The reason why _scratch_mkfs_xfs creates a different XFS than
expected is that, it may ignore $MKFS_OPTIONS if mkfs fails due to
conflicts between $MKFS_OPTIONS and the provided mkfs options.

In the case of xfs/186, "-b size=512" conflicts with "-i size=512",
and the first mkfs fails, then it ends up with a 4k block size XFS
with crc enabled (the default config).

Fix it by checking crc enablement status and attr version in the
test, to make sure it's testing on expected XFS.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/186 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/186 b/tests/xfs/186
index 9b64d6c..192a8c8 100755
--- a/tests/xfs/186
+++ b/tests/xfs/186
@@ -156,7 +156,20 @@ _require_attr_v1
 
 rm -f $seqres.full
 
-_scratch_mkfs -i attr=2,size=512 -l lazy-count=1 >/dev/null 2>&1
+_scratch_mkfs -i attr=2,size=512 -l lazy-count=1 | _filter_mkfs \
+	>>$seqres.full 2>$tmp.mkfs
+# import crc status and attr version
+. $tmp.mkfs
+
+# _scratch_mkfs may ignore $MKFS_OPTIONS if mkfs fails due to conflicts between
+# $MKFS_OPTIONS and the provided mkfs options, which could result in creating
+# an XFS we don't want. Check crc status and attr version to be sure.
+if [ $_fs_has_crcs -eq 1 ]; then
+	_notrun "attr v1 not supported on $SCRATCH_DEV"
+fi
+if [ $attr -ne 2 ]; then
+	_notrun "need attr v2 on $SCRATCH_DEV"
+fi
 
 # set inum to root dir ino
 # we'll add in dirents and EAs into the root directory
-- 
2.5.5

