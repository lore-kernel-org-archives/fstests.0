Received: from mx2.suse.de ([195.135.220.15]:33334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbdGYOda (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Jul 2017 10:33:30 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D38CAE6E
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2017 14:33:29 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] Ignore "yes: standard output: Broken pipe" errors
Date: Tue, 25 Jul 2017 16:33:20 +0200
Message-Id: <20170725143320.10882-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Recently, some tests started failing because they had

yes: standard output: Broken pipe

in their output. Fix the problem by discarding errors from yes(1)
program.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc         | 12 ++++++------
 tests/generic/081 |  2 +-
 tests/generic/108 |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index bd989bb5f4dd..d3a0b5ea9023 100644
--- a/common/rc
+++ b/common/rc
@@ -736,7 +736,7 @@ _test_mkfs()
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
     *)
-	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
+	yes 2>/dev/null | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
     esac
 }
@@ -765,7 +765,7 @@ _mkfs_dev()
 	;;
 
     *)
-	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
+	yes 2>/dev/null | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
 		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
     esac
@@ -858,11 +858,11 @@ _scratch_mkfs()
 		mkfs_filter="cat"
 		;;
 	ocfs2)
-		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
+		mkfs_cmd="yes 2>/dev/null | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
 		;;
 	*)
-		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
+		mkfs_cmd="yes 2>/dev/null | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
 		;;
 	esac
@@ -1061,7 +1061,7 @@ _scratch_mkfs_sized()
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
     ocfs2)
-	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	yes 2>/dev/null | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
     udf)
 	$MKFS_UDF_PROG $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
@@ -1142,7 +1142,7 @@ _scratch_mkfs_blocksized()
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
 	;;
     ocfs2)
-	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
+	yes 2>/dev/null | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
 	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
diff --git a/tests/generic/081 b/tests/generic/081
index 426766d9bddb..56b41e2875e3 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -69,7 +69,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
-yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+yes 2>/dev/null | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
 # wait for lvcreation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
 
diff --git a/tests/generic/108 b/tests/generic/108
index 1525dfb64a47..1de16c2cf3c9 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -74,7 +74,7 @@ $LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
-yes | $LVM_PROG lvcreate -i 2 -I 4m -l 100%FREE -n $lvname $vgname \
+yes 2>/dev/null | $LVM_PROG lvcreate -i 2 -I 4m -l 100%FREE -n $lvname $vgname \
 	>>$seqres.full 2>&1
 # wait for lv creation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
-- 
2.12.3

