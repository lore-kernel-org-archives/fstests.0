Received: from mail-wm0-f67.google.com ([74.125.82.67]:36432 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbcJPIue (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2016 04:50:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id 79so5228502wmy.3
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2016 01:50:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 1/2] fstests: fix call sites that used xfs_io directly
Date: Sun, 16 Oct 2016 11:50:00 +0300
Message-Id: <1476607801-27684-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Convert those few remaining call sites to use the XFS_IO_PROG env var.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/quota      | 4 ++--
 common/rc         | 4 ++--
 tests/generic/043 | 2 +-
 tests/generic/044 | 4 ++--
 tests/generic/045 | 4 ++--
 tests/generic/046 | 4 ++--
 tests/generic/047 | 2 +-
 tests/generic/048 | 2 +-
 tests/generic/049 | 2 +-
 tests/generic/224 | 4 ++--
 tests/xfs/109     | 4 ++--
 tests/xfs/114     | 4 ++--
 tests/xfs/190     | 4 ++--
 tests/xfs/201     | 2 +-
 tests/xfs/229     | 2 +-
 tests/xfs/250     | 2 +-
 tests/xfs/291     | 2 +-
 17 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/common/quota b/common/quota
index fb2b2a0..678bc43 100644
--- a/common/quota
+++ b/common/quota
@@ -139,7 +139,7 @@ _file_as_id()
 
     parent=`dirname $1`
     if [ $3 = p ]; then
-	echo PARENT: xfs_io -r -c "chproj $2" -c "chattr +P" $parent >>$seqres.full
+	echo PARENT: $XFS_IO_PROG -r -c "chproj $2" -c "chattr +P" $parent >>$seqres.full
 	$XFS_IO_PROG -r -c "chproj $2" -c "chattr +P" $parent >>$seqres.full 2>&1
 	magik='$>'	# (irrelevent, above set projid-inherit-on-parent)
     elif [ $3 = u ]; then
@@ -165,7 +165,7 @@ EOF
 #	exec "dd if=/dev/zero of=$1 bs=$4 count=$5 >>$seqres.full 2>&1";
 
     if [ $3 = p ]; then
-	echo PARENT: xfs_io -r -c "chproj 0" -c "chattr -P" $parent >>$seqres.full
+	echo PARENT: $XFS_IO_PROG -r -c "chproj 0" -c "chattr -P" $parent >>$seqres.full
 	$XFS_IO_PROG -r -c "chproj 0" -c "chattr -P" $parent >>$seqres.full 2>&1
     fi
 }
diff --git a/common/rc b/common/rc
index c3da064..565ba67 100644
--- a/common/rc
+++ b/common/rc
@@ -3796,8 +3796,8 @@ init_rc()
 		exit 1
 	fi
 	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
-	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
-	export XFS_IO_PROG="$XFS_IO_PROG -F"
+	$XFS_IO_PROG -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
+		export XFS_IO_PROG="$XFS_IO_PROG -F"
 
 	# xfs_copy doesn't work on v5 xfs yet without -d option
 	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
diff --git a/tests/generic/043 b/tests/generic/043
index bd8eef8..b76a5aa 100755
--- a/tests/generic/043
+++ b/tests/generic/043
@@ -50,7 +50,7 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
diff --git a/tests/generic/044 b/tests/generic/044
index f46e828..0331baa 100755
--- a/tests/generic/044
+++ b/tests/generic/044
@@ -50,13 +50,13 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
 		exit
 	fi
-	xfs_io -c "truncate 64k" $file > /dev/null
+	$XFS_IO_PROG -c "truncate 64k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error truncating file $file
diff --git a/tests/generic/045 b/tests/generic/045
index 4ec7650..874c955 100755
--- a/tests/generic/045
+++ b/tests/generic/045
@@ -50,13 +50,13 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 64k -S 0xff 0 64k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
 		exit
 	fi
-	xfs_io -c "truncate 32k" $file > /dev/null
+	$XFS_IO_PROG -c "truncate 32k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error truncating file $file
diff --git a/tests/generic/046 b/tests/generic/046
index 08f1137..5a894b8 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -50,13 +50,13 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
 		exit
 	fi
-	xfs_io -c "truncate 64k" $file > /dev/null
+	$XFS_IO_PROG -c "truncate 64k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error truncating file $file
diff --git a/tests/generic/047 b/tests/generic/047
index b894ee6..631dc1e 100755
--- a/tests/generic/047
+++ b/tests/generic/047
@@ -81,7 +81,7 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" -c "fsync" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 32k -S 0xff 0 32k" -c "fsync" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
diff --git a/tests/generic/048 b/tests/generic/048
index 6f5f444..51d7efd 100755
--- a/tests/generic/048
+++ b/tests/generic/048
@@ -84,7 +84,7 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 64k -S 0xff 0 10m" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 64k -S 0xff 0 10m" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
diff --git a/tests/generic/049 b/tests/generic/049
index 320318e..1299242 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -81,7 +81,7 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	xfs_io -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
diff --git a/tests/generic/224 b/tests/generic/224
index 391d877..2c30a75 100755
--- a/tests/generic/224
+++ b/tests/generic/224
@@ -59,7 +59,7 @@ _scratch_mount >> $seqres.full 2>&1
 
 # set the reserved block pool to almost empty for XFS
 if [ "$FSTYP" = "xfs" ]; then
-	xfs_io -x -c "resblks 4" $SCRATCH_MNT >> $seqres.full 2>&1
+	$XFS_IO_PROG -x -c "resblks 4" $SCRATCH_MNT >> $seqres.full 2>&1
 fi
 
 FILES=1000
@@ -71,7 +71,7 @@ for i in `seq 0 1 $FILES`; do
 	# tripped over.
         (
 		sleep 5
-		xfs_io -f -c "truncate 10485760" $SCRATCH_MNT/testfile.$i
+		$XFS_IO_PROG -f -c "truncate 10485760" $SCRATCH_MNT/testfile.$i
 		dd if=/dev/zero of=$SCRATCH_MNT/testfile.$i bs=4k conv=notrunc
 	) > /dev/null 2>&1 &
 done
diff --git a/tests/xfs/109 b/tests/xfs/109
index ac20619..e0fdec3 100755
--- a/tests/xfs/109
+++ b/tests/xfs/109
@@ -50,7 +50,7 @@ populate()
 	i=0
 	while [ $i -le $files -a "X$faststart" = "X" ]; do
 		file=$SCRATCH_MNT/f$i
-		xfs_io -f -d -c 'pwrite -b 64k 0 64k' $file >/dev/null
+		$XFS_IO_PROG -f -d -c 'pwrite -b 64k 0 64k' $file >/dev/null
 		let i=$i+1
 	done
 
@@ -77,7 +77,7 @@ allocate()
 		{
 			j=0
 			while [ $j -lt 100 ]; do
-				xfs_io -f -c 'pwrite -b 64k 0 16m' $file \
+				$XFS_IO_PROG -f -c 'pwrite -b 64k 0 16m' $file \
 					>/dev/null 2>&1
 				rm $file
 				let j=$j+1
diff --git a/tests/xfs/114 b/tests/xfs/114
index 50cc71b..24474f7 100755
--- a/tests/xfs/114
+++ b/tests/xfs/114
@@ -44,7 +44,7 @@ _check_paths()
 	sync; sleep 1
 	echo ""
 	echo "Check parent"
-	if ! xfs_io -x -c 'parent -c' $SCRATCH_MNT | _filter_num; then
+	if ! $XFS_IO_PROG -x -c 'parent -c' $SCRATCH_MNT | _filter_num; then
 		exit 1
 	fi
 }
@@ -55,7 +55,7 @@ _print_names()
 	echo "Print out hardlink names for given path, $1"
 	echo ""
 
-	xfs_io -x -c parent $1 | awk '/p_ino.*=/ {$3 = "inodeXXX"; print; next} {print}' 
+	$XFS_IO_PROG -x -c parent $1 | awk '/p_ino.*=/ {$3 = "inodeXXX"; print; next} {print}'
 }
 
 _test_create()
diff --git a/tests/xfs/190 b/tests/xfs/190
index 614a80c..d688216 100755
--- a/tests/xfs/190
+++ b/tests/xfs/190
@@ -62,8 +62,8 @@ dd if=/dev/zero of=$SCRATCH_MNT/$filename bs=1024k count=10 >> $seqres.full 2>&1
 echo Punching holes in file
 echo Punching holes in file >> $seqres.full
 for i in $holes ; do
-	echo xfs_io -c "unresvsp `echo $i |$SED_PROG 's/:/ /g'`" $SCRATCH_MNT/$filename >> $seqres.full
-	xfs_io -c "unresvsp `echo $i |$SED_PROG 's/:/ /g'`" $SCRATCH_MNT/$filename ;
+	echo $XFS_IO_PROG -c "unresvsp `echo $i |$SED_PROG 's/:/ /g'`" $SCRATCH_MNT/$filename >> $seqres.full
+	$XFS_IO_PROG -c "unresvsp `echo $i |$SED_PROG 's/:/ /g'`" $SCRATCH_MNT/$filename ;
 done
 
 echo Verifying holes are in the correct spots:
diff --git a/tests/xfs/201 b/tests/xfs/201
index ac8abf4..45dc42f 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -56,7 +56,7 @@ do_pwrite()
 	end=`expr $2 \* $min_align`
 	length=`expr $end - $offset`
 
-	xfs_io -d -f $file -c "pwrite $offset $length" >/dev/null
+	$XFS_IO_PROG -d -f $file -c "pwrite $offset $length" >/dev/null
 }
 
 _require_scratch
diff --git a/tests/xfs/229 b/tests/xfs/229
index b8fd914..0a42bcf 100755
--- a/tests/xfs/229
+++ b/tests/xfs/229
@@ -60,7 +60,7 @@ EXTSIZE="256k"
 mkdir ${TDIR}
 
 # Set the test directory extsize
-xfs_io -c "extsize ${EXTSIZE}" ${TDIR}
+$XFS_IO_PROG -c "extsize ${EXTSIZE}" ${TDIR}
 
 # Create a set of holey files
 echo "generating ${NFILES} files"
diff --git a/tests/xfs/250 b/tests/xfs/250
index 0cdc382..f807c5a 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -81,7 +81,7 @@ _test_loop()
 	mount -t xfs -o loop $LOOP_DEV $LOOP_MNT
 
 	echo "*** preallocate large file"
-	xfs_io -f -c "resvsp 0 $fsize" $LOOP_MNT/foo | _filter_io
+	$XFS_IO_PROG -f -c "resvsp 0 $fsize" $LOOP_MNT/foo | _filter_io
 
 	echo "*** unmount loop filesystem"
 	umount $LOOP_MNT > /dev/null 2>&1
diff --git a/tests/xfs/291 b/tests/xfs/291
index 808f333..c1cbe32 100755
--- a/tests/xfs/291
+++ b/tests/xfs/291
@@ -69,7 +69,7 @@ done
 sync
 
 # Soak up any remaining freespace
-xfs_io -f -c "pwrite 0 16m" -c "fsync" $SCRATCH_MNT/space_file.large >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite 0 16m" -c "fsync" $SCRATCH_MNT/space_file.large >> $seqres.full 2>&1
 
 # Take a look at freespace for any post-mortem on the test
 _scratch_unmount
-- 
2.7.4

