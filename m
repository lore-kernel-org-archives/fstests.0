Received: from mx1.redhat.com ([209.132.183.28]:52252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfDPIPK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Apr 2019 04:15:10 -0400
From: Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH v2] generic/294: add golden output for nfs
Date: Tue, 16 Apr 2019 16:14:57 +0800
Message-Id: <20190416081457.10442-1-xzhou@redhat.com>
In-Reply-To: <20190415040309.GN2824@desktop>
References: <20190415040309.GN2824@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, fstests@vger.kernel.org
Cc: bcodding@redhat.com, Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Because NFS handles this differently, returning different values.
Details:
http://people.redhat.com/bcodding/nfs/2016/10/07/nfs_xfstest_generic/#generic294

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---

v2:
   add a new golden output for nfs instead of _notrun.

 tests/generic/294         | 7 +++++++
 tests/generic/294.out.nfs | 5 +++++
 2 files changed, 12 insertions(+)
 create mode 100644 tests/generic/294.out.nfs

diff --git a/tests/generic/294 b/tests/generic/294
index b74579ac..a355c612 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -7,6 +7,7 @@
 # Tests for EEXIST (not EROFS) for inode creations, if
 # we ask to create an already-existing entity on an RO filesystem
 #
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -27,6 +28,12 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
+# link correct .out file
+if [ $FSTYP == "nfs" ]; then
+	rm -f $seqfull.out
+	ln -sf $seq.out.nfs $seqfull.out
+fi
+
 
 # Modify as appropriate.
 _supported_fs generic
diff --git a/tests/generic/294.out.nfs b/tests/generic/294.out.nfs
new file mode 100644
index 00000000..71ebeecd
--- /dev/null
+++ b/tests/generic/294.out.nfs
@@ -0,0 +1,5 @@
+QA output created by 294
+mknod: 'SCRATCH_MNT/294.test/testnode': Read-only file system
+mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': Read-only file system
+touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
+ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
-- 
2.21.0
