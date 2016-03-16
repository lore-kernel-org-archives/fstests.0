Received: from mx1.redhat.com ([209.132.183.28]:48953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966633AbcCPPFX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Mar 2016 11:05:23 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] xfs/073: avoid finobt warning from mkfs
Date: Wed, 16 Mar 2016 23:04:44 +0800
Message-Id: <1458140684-4723-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1458129204-31882-1-git-send-email-eguan@redhat.com>
References: <1458129204-31882-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

When testing xfs/073 with MKFS_OPTIONS="-m crc=1,finobt=1" set, it fails
due to extra warning about disabling finobt feature:

 +warning: finobt not supported without CRC support, disabled.

Because xfs/073 disables crc unconditionally and finobt can not be
enabled either.

Fix it by explicitly disabling finobt as well.

Also remove all meta related mkfs options in _scratch_mkfs_xfs_opts() if
mkfs.xfs has no metadata support, not only the crc option. So that test
still passes on distros with such old binaries.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v2:
- disable finobt explicitly, instead of filtering the warning

 common/rc     | 4 ++--
 tests/xfs/073 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index a34c387..73d2ea6 100644
--- a/common/rc
+++ b/common/rc
@@ -444,9 +444,9 @@ _scratch_mkfs_xfs_opts()
 {
 	mkfs_opts=$*
 
-	# remove crc related mkfs options if mkfs.xfs doesn't support v5 xfs
+	# remove metadata related mkfs options if mkfs.xfs doesn't them
 	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
-		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+crc=.//"`
+		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+\S\+//g"`
 	fi
 
 	_scratch_options mkfs
diff --git a/tests/xfs/073 b/tests/xfs/073
index e1335df..e2c1af3 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -138,7 +138,7 @@ _require_loop
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
+_scratch_mkfs_xfs -m crc=0,finobt=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
 _scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
 
 echo
-- 
2.5.0

