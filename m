Received: from mx1.redhat.com ([209.132.183.28]:46667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbcFPM2u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 16 Jun 2016 08:28:50 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21580C04B309
	for <fstests@vger.kernel.org>; Thu, 16 Jun 2016 12:28:49 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-179.bos.redhat.com [10.18.41.179])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5GCSm2B026146
	for <fstests@vger.kernel.org>; Thu, 16 Jun 2016 08:28:49 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] xfstests: support check for uuidgen utility
Date: Thu, 16 Jun 2016 08:28:48 -0400
Message-Id: <1466080128-14544-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

A recent test uses the uuidgen utility to generate UUID-based filenames,
but this package is not necessarily installed as part of the core
packages of every distro.

As such, add the UUID_PROG environment variable to the common
configuration and update the test to require the existence of uuidgen to
run.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

I assume the test is ultimately going to be renumbered so this could
also just be folded into the initial commit, if that is more
convenient...

Brian

 README        | 3 ++-
 common/config | 1 +
 tests/xfs/399 | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 3800df7..2647e12 100644
--- a/README
+++ b/README
@@ -8,7 +8,8 @@ Building Linux:
 	  For example, for Ubuntu:
 		"sudo apt-get install xfslibs-dev uuid-dev libtool-bin e2fsprogs
 		 automake gcc libuuid1 quota attr libattr1-dev make
-		 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench"
+		 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench
+		 uuid-runtime"
 	- run make
 	- run make install
 	- create fsgqa test user ("sudo useradd fsgqa")
diff --git a/common/config b/common/config
index cacd815..7ba8758 100644
--- a/common/config
+++ b/common/config
@@ -195,6 +195,7 @@ export DUMP_PROG="`set_prog_path dump`"
 export RESTORE_PROG="`set_prog_path restore`"
 export LVM_PROG="`set_prog_path lvm`"
 export CHATTR_PROG="`set_prog_path chattr`"
+export UUIDGEN_PROG="`set_prog_path uuidgen`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/xfs/399 b/tests/xfs/399
index 8cea305..82656d8 100755
--- a/tests/xfs/399
+++ b/tests/xfs/399
@@ -51,6 +51,7 @@ _supported_os Linux
 
 _require_scratch_nocheck	# check complains about single AG fs
 _require_xfs_io_command "fpunch"
+_require_command $UUIDGEN_PROG uuidgen
 
 rm -f $seqres.full
 
@@ -63,7 +64,7 @@ _scratch_mount
 # sufficiently populates a 64k directory block.
 mkdir $SCRATCH_MNT/src
 for i in $(seq 0 1023); do
-	touch $SCRATCH_MNT/src/`uuidgen`
+	touch $SCRATCH_MNT/src/`$UUIDGEN_PROG`
 done
 
 # precreate target dirs while we still have free space for inodes
-- 
2.5.5

