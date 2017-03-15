Received: from mx1.redhat.com ([209.132.183.28]:55894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdCOQdw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Mar 2017 12:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C9E264DA1
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2017 16:33:52 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH] xfstests: xfs/191 update
Date: Wed, 15 Mar 2017 17:33:47 +0100
Message-Id: <20170315163347.29743-1-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

The removed 'do_mkfs_pass -l size=3D4096b' was against man page
(-b section). Other entries are things that weren't covered before.

Specifically, a standalone "-l size=3D4096b" should fail, because:
To  specify any options on the command line in units of filesys=E2=80=90
tem blocks, this option must be  specified  first  so  that  the
filesystem block size is applied consistently to all options.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 tests/xfs/191-input-validation | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validat=
ion
index 5de55170..e22f9bfc 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -114,6 +114,9 @@ do_mkfs_fail -d sectsize=3D2foo $SCRATCH_DEV
 do_mkfs_fail -l sectsize=3Dnggh $SCRATCH_DEV
 do_mkfs_fail -l sectsize=3D2nggh $SCRATCH_DEV
=20
+# option respecification should fail
+do_mkfs_fail -d agcount=3D32,agcount=3D32 $SCRATCH_DEV
+
 # conflicting sector/block sizes
 do_mkfs_fail -s size=3D512 -d sectsize=3D1024 $SCRATCH_DEV
 do_mkfs_fail -s size=3D512 -l sectsize=3D1024 $SCRATCH_DEV
@@ -191,6 +194,12 @@ do_mkfs_fail -d sectsize=3D512s,agsize=3D65536s $SCR=
ATCH_DEV
=20
 reset_fsimg
=20
+# some sectsize/blocksize combinations
+do_mkfs_pass -s size=3D512 -b size=3D8s $SCRATCH_DEV
+do_mkfs_fail -s size=3D512s $SCRATCH_DEV
+
+reset_fsimg
+
 # file section, should pass
 do_mkfs_pass $fsimg
 do_mkfs_pass -d file=3D0 $SCRATCH_DEV
@@ -218,7 +227,6 @@ reset_fsimg
 # log section, should pass
 do_mkfs_pass -l size=3D$logsize -d size=3D$fssize $SCRATCH_DEV
 do_mkfs_pass -l agnum=3D2 $SCRATCH_DEV
-do_mkfs_pass -l size=3D4096b $SCRATCH_DEV
 do_mkfs_pass -l sectsize=3D512 $SCRATCH_DEV
 do_mkfs_pass -l sunit=3D64 $SCRATCH_DEV
 do_mkfs_pass -l sunit=3D64 -d sunit=3D8,swidth=3D8 $SCRATCH_DEV
@@ -237,6 +245,7 @@ do_mkfs_pass -l version=3D2 -m crc=3D0 $SCRATCH_DEV
 do_mkfs_pass -l version=3D2 $SCRATCH_DEV
=20
 # log section, should fail
+do_mkfs_fail -l size=3D4096b $SCRATCH_DEV
 do_mkfs_fail -l size=3D${fssize}b $SCRATCH_DEV
 do_mkfs_fail -l size=3D${fssize}s $SCRATCH_DEV
 do_mkfs_fail -l size=3D${fssize}yerk $SCRATCH_DEV
--=20
2.11.0

