Received: from mx1.redhat.com ([209.132.183.28]:56194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754026AbcLUD1Y (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Dec 2016 22:27:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5781D83F47
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 03:27:24 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] Revert "generic/38[3-6]: require project quota to be enabled on SCRATCH_DEV"
Date: Wed, 21 Dec 2016 11:26:54 +0800
Message-Id: <20161221032654.24197-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Commit 23f60ef304d ("generic/38[3-6]: require project quota to be
enabled on SCRATCH_DEV") introduced a regression that leads
_require_projquota, which uses src/feature to call a quotactl,
operate before the filesystem is mounted, and results in tests not
run on XFS and ext4.

Revert the problematic patch first, because don't want to lose
project quota test coverage on XFS and ext4. We can fix the false
failure on ext3/2 later,

Reported-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/383 | 1 -
 tests/generic/384 | 2 +-
 tests/generic/385 | 2 +-
 tests/generic/386 | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/generic/383 b/tests/generic/383
index 93836ea..be5b19b 100755
--- a/tests/generic/383
+++ b/tests/generic/383
@@ -54,7 +54,6 @@ _require_xfs_quota_foreign
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
-_require_prjquota $SCRATCH_DEV
 
 do_project_test()
 {
diff --git a/tests/generic/384 b/tests/generic/384
index 4784e47..452d26e 100755
--- a/tests/generic/384
+++ b/tests/generic/384
@@ -73,10 +73,10 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
-_require_prjquota $SCRATCH_DEV
 
 _qmount_option "prjquota"
 _qmount
+_require_prjquota $SCRATCH_DEV
 
 report_quota()
 {
diff --git a/tests/generic/385 b/tests/generic/385
index b7c5bd3..f07ae5d 100755
--- a/tests/generic/385
+++ b/tests/generic/385
@@ -71,9 +71,9 @@ quota_cmd="$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
-_require_prjquota $SCRATCH_DEV
 _qmount_option "prjquota"
 _qmount
+_require_prjquota $SCRATCH_DEV
 
 #
 # Create the project root
diff --git a/tests/generic/386 b/tests/generic/386
index 0ceb14d..3aede60 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -127,10 +127,10 @@ echo $proj_num:$proj_dir > "$my_projects"
 
 _scratch_mkfs					>> "$seqres.full" 2>&1
 _scratch_enable_pquota
-_require_prjquota $SCRATCH_DEV
 
 _qmount_option "prjquota"
 _qmount
+_require_prjquota $SCRATCH_DEV
 
 mkdir -p "${proj_dir}"
 
-- 
2.9.3

