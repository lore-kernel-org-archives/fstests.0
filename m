Received: from mx1.redhat.com ([209.132.183.28]:55198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbcCCEix (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Mar 2016 23:38:53 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/137: require scratch to be CRC enabled XFS
Date: Thu,  3 Mar 2016 12:38:19 +0800
Message-Id: <1456979899-7221-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

This test is only valid for CRC enabled XFS, and test fails with
MKFS_OPTIONS="-m crc=0" being set (no mount failure detected).

Fix it by adding _require_scratch_xfs_crc, which ensures scratch device
has CRC support and enabled.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/137 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/137 b/tests/xfs/137
index f162264..dec9fc9 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -52,7 +52,7 @@ rm -f $seqres.full
 _supported_fs xfs
 _supported_os Linux
 _require_scratch
-_require_xfs_crc
+_require_scratch_xfs_crc
 _require_xfs_db_command "logformat"
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
-- 
2.5.0

