Received: from mx1.redhat.com ([209.132.183.28]:59792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932446AbcJSO1a (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Oct 2016 10:27:30 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CC9C624AC
        for <fstests@vger.kernel.org>; Wed, 19 Oct 2016 10:51:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/004: Check resulting file permissions
Date: Wed, 19 Oct 2016 12:51:07 +0200
Message-Id: <1476874267-16499-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Check the file permissions resulting from linking an O_TMPFILE file into
the namespace: they should be the same as creating a normal file.

(Note that this patch depends on patch "xfs_io: Fix initial -m option"
for xfsprogs.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/004     | 14 +++++++++++++-
 tests/generic/004.out |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/generic/004 b/tests/generic/004
index d0926f1..f9a7520 100755
--- a/tests/generic/004
+++ b/tests/generic/004
@@ -52,12 +52,24 @@ rm -f $seqres.full
 testfile="${TEST_DIR}/tst-tmpfile-flink"
 
 # test creating a r/w tmpfile, do I/O and link it into the namespace
-$XFS_IO_PROG -T \
+echo umask 022
+umask 022
+$XFS_IO_PROG -T -m 0666 \
 	-c "pwrite 0 4096" \
 	-c "pread 0 4096" \
 	-c "flink ${testfile}" \
 	${TEST_DIR} | _filter_xfs_io
+stat -c '%a' ${testfile}
+rm ${testfile}
 
+echo umask 027
+umask 027
+$XFS_IO_PROG -T -m 0666 \
+	-c "pwrite 0 4096" \
+	-c "pread 0 4096" \
+	-c "flink ${testfile}" \
+	${TEST_DIR} | _filter_xfs_io
+stat -c '%a' ${testfile}
 rm ${testfile}
 
 # test creating a r/o tmpfile.  Should fail
diff --git a/tests/generic/004.out b/tests/generic/004.out
index 527b2c2..11f44e7 100644
--- a/tests/generic/004.out
+++ b/tests/generic/004.out
@@ -1,6 +1,14 @@
 QA output created by 004
+umask 022
 wrote 4096/4096 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+644
+umask 027
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+640
 TEST_DIR: Invalid argument
-- 
2.7.4

