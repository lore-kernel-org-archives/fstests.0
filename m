Received: from mx1.redhat.com ([209.132.183.28]:35307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759395AbcAKLc2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jan 2016 06:32:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id AE9EF13933
	for <fstests@vger.kernel.org>; Mon, 11 Jan 2016 11:32:28 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/3] generic/23[23]: some cleanups
Date: Mon, 11 Jan 2016 19:32:02 +0800
Message-Id: <1452511924-21872-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1452511924-21872-1-git-send-email-eguan@redhat.com>
References: <1452511924-21872-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

1. remove $seqres.full before test
2. no need to check return values of _fsstress and _check_quota_usage
   calls, the golden image could catch the failures.
3. remove unused FSX related variables

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/232 | 17 ++++-------------
 tests/generic/233 | 20 ++++----------------
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/tests/generic/232 b/tests/generic/232
index b3f6b7e..1323809 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -71,23 +71,14 @@ _require_scratch
 _require_quota
 _need_to_be_root
 
-_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mkfs > $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
 chmod 777 $SCRATCH_MNT
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
 
-if ! _fsstress; then
-	_scratch_unmount 2>/dev/null
-	exit
-fi
-
-if ! _check_quota_usage; then
-	_scratch_unmount 2>/dev/null
-	status=1
-	exit
-fi
-
-_scratch_unmount 2>/dev/null
+_fsstress
+_check_quota_usage
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/233 b/tests/generic/233
index 95255f8..d50d280 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -38,9 +38,6 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 . ./common/filter
 . ./common/quota
 
-FSX_FILE_SIZE=64000000
-FSX_ARGS="-q -l $FSX_FILE_SIZE -o 65536 -S 191110531 -N 100000"
-
 _filter_num()
 {
 	tee -a $seqres.full |\
@@ -79,24 +76,15 @@ _require_quota
 _require_user
 _need_to_be_root
 
-_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mkfs > $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
 chmod 777 $SCRATCH_MNT
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
 setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
 
-if ! _fsstress; then
-	_scratch_unmount 2>/dev/null
-	exit
-fi
-
-if ! _check_quota_usage; then
-	_scratch_unmount 2>/dev/null
-	status=1
-	exit
-fi
-
-_scratch_unmount 2>/dev/null
+_fsstress
+_check_quota_usage
+_scratch_unmount
 status=0
 exit
-- 
2.5.0

