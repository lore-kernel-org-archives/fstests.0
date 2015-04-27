Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbbD0LdW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Apr 2015 07:33:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 697738F2E5
	for <fstests@vger.kernel.org>; Mon, 27 Apr 2015 11:33:22 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic: add _require_metadata_journaling to more tests
Date: Mon, 27 Apr 2015 19:32:20 +0800
Message-Id: <1430134340-15919-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: esandeen@redhat.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic tests 039, 059 and 325 need _require_metadata_journaling too,
they use dm_flakey to trigger log replay. I've seen 039 and 059 failed
post-test fsck on ext2, 325 could possibly fail too.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/039 | 1 +
 tests/generic/059 | 1 +
 tests/generic/325 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/039 b/tests/generic/039
index 4997aac..4bbfc50 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -57,6 +57,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
+_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/059 b/tests/generic/059
index 375b9a9..13dfb09 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -60,6 +60,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
+_require_metadata_journaling $SCRATCH_DEV
 _require_xfs_io_command "fpunch"
 
 rm -f $seqres.full
diff --git a/tests/generic/325 b/tests/generic/325
index e62ac95..965a47c 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -55,6 +55,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
+_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
-- 
2.1.0

