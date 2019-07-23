Received: from szxga07-in.huawei.com ([45.249.212.35]:41018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfGWJZw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jul 2019 05:25:52 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] generic/38[3456]: adjust to check prjquota before mount
Date: Tue, 23 Jul 2019 17:25:27 +0800
Message-ID: <20190723092529.112426-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.orga, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

Move _require_prjquota() to front of _qmount() since we do the
check on device directly instead of mountpoint, it can avoid
potential failure if filesystem utils needs exclusive open on
device.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/383 | 2 +-
 tests/generic/384 | 2 +-
 tests/generic/385 | 2 +-
 tests/generic/386 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/383 b/tests/generic/383
index 2c8c5923..cf5ac255 100755
--- a/tests/generic/383
+++ b/tests/generic/383
@@ -39,6 +39,7 @@ _require_xfs_quota_foreign
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 
 do_project_test()
 {
@@ -76,7 +77,6 @@ EOF
 # Test project
 _qmount_option "usrquota,prjquota"
 _qmount
-_require_prjquota $SCRATCH_DEV
 do_project_test
 
 # success, all done
diff --git a/tests/generic/384 b/tests/generic/384
index b7c940d7..2c0cd00b 100755
--- a/tests/generic/384
+++ b/tests/generic/384
@@ -57,10 +57,10 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
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
index 937131a9..56ce6eb0 100755
--- a/tests/generic/385
+++ b/tests/generic/385
@@ -56,9 +56,9 @@ quota_cmd="$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 _qmount_option "prjquota"
 _qmount
-_require_prjquota $SCRATCH_DEV
 
 #
 # Create the project root
diff --git a/tests/generic/386 b/tests/generic/386
index 462c5869..e4f7d23b 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -112,10 +112,10 @@ echo $proj_num:$proj_dir > "$my_projects"
 
 _scratch_mkfs					>> "$seqres.full" 2>&1
 _scratch_enable_pquota
+_require_prjquota $SCRATCH_DEV
 
 _qmount_option "prjquota"
 _qmount
-_require_prjquota $SCRATCH_DEV
 
 mkdir -p "${proj_dir}"
 
-- 
2.18.0.rc1
