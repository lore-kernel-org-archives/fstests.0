Received: from mx1.redhat.com ([209.132.183.28]:43376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdCOQda (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Mar 2017 12:33:30 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10F5B128D
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2017 16:33:30 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 1/1] xfstests: fix failing of xfs/191 with small test devices
Date: Wed, 15 Mar 2017 17:33:25 +0100
Message-Id: <20170315163325.29651-1-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add a _require_fs_space and make the necessary size smaller.  It should work
the same with 400 MB instead of 4 GB, and it will have less issues on small
VMs.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 tests/xfs/191-input-validation | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index cff3efa9..5de55170 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -65,10 +65,12 @@ SCRATCH_LOGDEV=
 SCRATCH_RTDEV=
 
 # limit the image size of the filesystem being created to something small
-fssize=$((4 * 1024 * 1024 * 1024))
-logsize=$((4 * 1024 * 1024 * 100))
+fssize=$((400 * 1024 * 1024 ))
+logsize=$((40 * 1024 * 1024 ))
 fsimg=$TEST_DIR/$seq.img
 
+_require_fs_space $TEST_DIR $(( (fssize + (logsize*2))/1024 ))
+
 do_mkfs_pass()
 {
 	echo >> $seqres.full
-- 
2.11.0

