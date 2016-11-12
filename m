Received: from mx1.redhat.com ([209.132.183.28]:56038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966447AbcKLSlP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 12 Nov 2016 13:41:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26D1F8553D
        for <fstests@vger.kernel.org>; Sat, 12 Nov 2016 18:41:15 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/38[3-6]: require project quota to be enabled on SCRATCH_DEV
Date: Sun, 13 Nov 2016 02:41:05 +0800
Message-Id: <1478976065-2060-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic/38[3-6] are made generic from xfs tests to test project
quota on other filesystems, e.g. ext4. But we should make sure
project quota is enabled in between of _scratch_enable_pquota and
_qmount. Otherwise mount will fail if there's no project quota
support on SCRATCH_DEV, e.g. ext2 and ext3.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/383 | 1 +
 tests/generic/384 | 2 +-
 tests/generic/385 | 2 +-
 tests/generic/386 | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/generic/383 b/tests/generic/383
index be5b19b..93836ea 100755
--- a/tests/generic/383
+++ b/tests/generic/383
@@ -54,6 +54,7 @@ _require_xfs_quota_foreign
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 
 do_project_test()
 {
diff --git a/tests/generic/384 b/tests/generic/384
index 452d26e..4784e47 100755
--- a/tests/generic/384
+++ b/tests/generic/384
@@ -73,10 +73,10 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 
 _qmount_option "prjquota"
 _qmount
-_require_prjquota $SCRATCH_DEV
 
 report_quota()
 {
diff --git a/tests/generic/385 b/tests/generic/385
index f07ae5d..b7c5bd3 100755
--- a/tests/generic/385
+++ b/tests/generic/385
@@ -71,9 +71,9 @@ quota_cmd="$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 _qmount_option "prjquota"
 _qmount
-_require_prjquota $SCRATCH_DEV
 
 #
 # Create the project root
diff --git a/tests/generic/386 b/tests/generic/386
index 3aede60..0ceb14d 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -127,10 +127,10 @@ echo $proj_num:$proj_dir > "$my_projects"
 
 _scratch_mkfs					>> "$seqres.full" 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 
 _qmount_option "prjquota"
 _qmount
-_require_prjquota $SCRATCH_DEV
 
 mkdir -p "${proj_dir}"
 
-- 
2.7.4

