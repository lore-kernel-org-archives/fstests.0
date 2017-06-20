Received: from cn.fujitsu.com ([59.151.112.132]:44945 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752535AbdFTJfy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Jun 2017 05:35:54 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3529E47C6D36
        for <fstests@vger.kernel.org>; Tue, 20 Jun 2017 17:35:37 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/294: fix output for nfs
Date: Tue, 20 Jun 2017 17:35:33 +0800
Message-ID: <1497951333-5925-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

In nfs environment, both mkdir and mknod are optimized and
return EROFS instead of EEXIST when asking to create an
already-existing entity on an RO filesystem.  We add specific
output of nfs to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/294             | 3 +++
 tests/generic/294.cfg         | 1 +
 tests/generic/294.out         | 5 -----
 tests/generic/294.out.default | 5 +++++
 tests/generic/294.out.nfs     | 5 +++++
 5 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 tests/generic/294.cfg
 delete mode 100644 tests/generic/294.out
 create mode 100644 tests/generic/294.out.default
 create mode 100644 tests/generic/294.out.nfs

diff --git a/tests/generic/294 b/tests/generic/294
index fb5d9aa..bc20dad 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -22,6 +22,7 @@
 #-----------------------------------------------------------------------
 #
 
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -48,6 +49,8 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 
+_link_out_file_named $seqfull.out $FSTYP
+
 rm -f $seqres.full
 _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
 
diff --git a/tests/generic/294.cfg b/tests/generic/294.cfg
new file mode 100644
index 0000000..d02b0ce
--- /dev/null
+++ b/tests/generic/294.cfg
@@ -0,0 +1 @@
+nfs: nfs
diff --git a/tests/generic/294.out b/tests/generic/294.out
deleted file mode 100644
index 7802472..0000000
--- a/tests/generic/294.out
+++ /dev/null
@@ -1,5 +0,0 @@
-QA output created by 294
-mknod: SCRATCH_MNT/294.test/testnode: File exists
-mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
-touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
-ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
diff --git a/tests/generic/294.out.default b/tests/generic/294.out.default
new file mode 100644
index 0000000..7802472
--- /dev/null
+++ b/tests/generic/294.out.default
@@ -0,0 +1,5 @@
+QA output created by 294
+mknod: SCRATCH_MNT/294.test/testnode: File exists
+mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
+touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
+ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
diff --git a/tests/generic/294.out.nfs b/tests/generic/294.out.nfs
new file mode 100644
index 0000000..71ebeec
--- /dev/null
+++ b/tests/generic/294.out.nfs
@@ -0,0 +1,5 @@
+QA output created by 294
+mknod: 'SCRATCH_MNT/294.test/testnode': Read-only file system
+mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': Read-only file system
+touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
+ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
-- 
1.8.3.1



