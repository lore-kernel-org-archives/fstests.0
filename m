Received: from mx1.redhat.com ([209.132.183.28]:49140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755125AbcH3Hff (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Aug 2016 03:35:35 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/187: fix new sb_features2 ftype stop case running
Date: Tue, 30 Aug 2016 15:35:32 +0800
Message-Id: <1472542532-16497-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

This case is too old, at that time there's no "ftype" feature for
XFS. Due to this case need to clear features2 bits when mkfs.xfs,
so ftype bit stop case running for long time.

We care 6 features2 bits in this case:

  "ATTR2, LAZYSBCOUNT, PROJID32BIT, CRC, FTYPE, FINOBT"

ATTR2 and LAZYSBCOUNT bits will be tested in case. FINBOT will be
disabled if CRC=0. So this patch only check and disable PROJID32BIT,
CRC and FTYPE features when mkfs.xfs.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

I think we shouldn't skip this case if user doesn't specify suitable
MKFS_OPTIONS and MOUNT_OPTIONS. Because this case need complex options,
nearly no one will specify these all options for xfstests at same time.

Thanks,
Zorro

 tests/xfs/187 | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/tests/xfs/187 b/tests/xfs/187
index 836b924..5e7c677 100755
--- a/tests/xfs/187
+++ b/tests/xfs/187
@@ -31,7 +31,6 @@ seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
-here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -58,24 +57,32 @@ _supported_os Linux
 
 _require_scratch
 _require_attrs
-_require_attr_v1
-_require_projid16bit
 
 rm -f $seqres.full
-
+_scratch_mkfs >/dev/null 2>&1
 # Reset the options so that we can control what is going on here
-export MKFS_OPTIONS=""
-export MOUNT_OPTIONS=""
-
-# lazysb, attr2 and other feature bits are held in features2 and will require
-# morebitsbit on So test with lazysb and without it to see if the morebitsbit is
-# okay etc. If the mkfs defaults change, these need to change as well.
-export MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
-export MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
+MKFS_OPTIONS=""
+MOUNT_OPTIONS=""
+ver2=`$XFS_DB_PROG -c version $SCRATCH_DEV | sed -n -e "s/,/ /g" \
+						   -e "s/.*MOREBITS\(.*\)/\1/p"`
+# clear features2 bits which we won't test
+for b in $ver2; do
+	case $b in
+	CRC)
+		MKFS_OPTIONS="$MKFS_OPTIONS -m crc=0"
+		;;
+	PROJID32BIT)
+		MKFS_OPTIONS="$MKFS_OPTIONS -i projid32bit=0"
+		;;
+	FTYPE)
+		MKFS_OPTIONS="$MKFS_OPTIONS -n ftype=0"
+		;;
+	esac
+done
 
 # Make sure that when we think we are testing with morebits off
 # that we really are.
-_scratch_mkfs -i attr=1 $MKFS_NO_LAZY  >/dev/null 2>&1
+_scratch_mkfs -i attr=1 -l lazy-count=0 >/dev/null 2>&1
 $XFS_DB_PROG -c version $SCRATCH_DEV 2>&1 >$tmp.db
 if grep -i morebits $tmp.db
 then
@@ -90,13 +97,13 @@ echo "*** 1. test attr2 mkfs and then noattr2 mount ***"
 echo ""
 echo "attr2 fs"
 echo ""
-_scratch_mkfs -i attr=2 $MKFS_NO_LAZY >/dev/null 2>&1
+_scratch_mkfs -i attr=2 -l lazy-count=0 >/dev/null 2>&1
 $XFS_DB_PROG -r -c version $SCRATCH_DEV 2>&1 | _filter_version
 echo ""
 echo "noattr2 fs"
 echo ""
 _scratch_mount -o noattr2
-$UMOUNT_PROG $SCRATCH_MNT
+_scratch_unmount
 $XFS_DB_PROG -r -c version $SCRATCH_DEV 2>&1 | _filter_version
 
 # adding an EA will ensure the ATTR1 flag is turned on
@@ -105,7 +112,7 @@ echo "*** 2. test attr2 mkfs and then noattr2 mount with 1 EA ***"
 echo ""
 echo "attr2 fs"
 echo ""
-_scratch_mkfs -i attr=2 $MKFS_NO_LAZY >/dev/null 2>&1
+_scratch_mkfs -i attr=2 -l lazy-count=0 >/dev/null 2>&1
 $XFS_DB_PROG -r -c version $SCRATCH_DEV 2>&1 | _filter_version
 echo ""
 echo "noattr2 fs"
@@ -115,8 +122,8 @@ cd $SCRATCH_MNT
 touch testfile
 $SETFATTR_PROG -n user.test -v 0xbabe testfile
 $GETFATTR_PROG testfile
-cd $here
-$UMOUNT_PROG $SCRATCH_MNT
+cd - >/dev/null
+_scratch_unmount
 $XFS_DB_PROG -r -c version $SCRATCH_DEV 2>&1 | _filter_version
 
 echo ""
@@ -125,16 +132,14 @@ echo ""
 echo ""
 echo "attr2 fs"
 echo ""
-_scratch_mkfs -i attr=2 $MKFS_LAZY >/dev/null 2>&1
+_scratch_mkfs -i attr=2 -l lazy-count=1 >/dev/null 2>&1
 $XFS_DB_PROG -r -c version $SCRATCH_DEV 2>&1 | _filter_version
 echo ""
 echo "noattr2 fs"
 echo ""
 _scratch_mount -o noattr2
-cd $SCRATCH_MNT
-touch testfile
-cd $here
-$UMOUNT_PROG $SCRATCH_MNT
+touch $SCRATCH_MNT/testfile
+_scratch_unmount
 $XFS_DB_PROG -r -c version $SCRATCH_DEV 2>&1 | _filter_version
 
 # success, all done
-- 
2.7.4

