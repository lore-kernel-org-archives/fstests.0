Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbbESDc2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 May 2015 23:32:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4J3WSMt031454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 18 May 2015 23:32:28 -0400
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4J3WQ0k018680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Mon, 18 May 2015 23:32:27 -0400
Message-ID: <555AAECA.4040102@redhat.com>
Date: Mon, 18 May 2015 22:32:26 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] fix up xfs/111 a bit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

xfs/111 is failing today, primarily because it obliterates the
root inode chunk and the verifiers fail the mount - i.e. the test
fails to properly test the thing it's meant to test.

Change the test so that the induced corruption is further into the
filesystem, but still hitting the inodes which have been created
for the test, so that the fs can mount and continue.

This requires that the helper binary (itrash) take an offset, which
we will figure out by using xfs_db.

This changes the locations of the inodes we hit; we're not really
going to be able to predict that terribly well, so remove the
output which shows inode offsets, and just keep track of whether
we managed to obliterate any at all.

The test still fails, because the fs is corrupted; this was done
intentionally, so run xfs_repair before the test exits to fix
things up.

(This test doesn't run often; it's not in the auto group, and
all the failures are extremely noisy and time consuming...)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/src/itrash.c b/src/itrash.c
index 21e1c5c..42692d0 100644
--- a/src/itrash.c
+++ b/src/itrash.c
@@ -8,6 +8,7 @@
 #include <fcntl.h>
 
 char buffer[32768];
+int overwrote;
 
 void die(char *func)
 {
@@ -21,20 +22,32 @@ void nuke()
 	for (i = 2048; i < 32768-1; i++)
 		if (buffer[i] == 'I' && buffer[i+1] == 'N') {
 			buffer[i] = buffer[i+1] = 'X';
-			printf("Overwrote IN @offset %d\n", i);
+			overwrote = 1;
 		}
 }
 
 int main(int argc, char* argv[])
 {
-	int f = open(argv[1], O_RDWR);
+	int f;
+	loff_t offset;
+
+	if (argc != 3) {
+		printf("%s <device> <offset>\n", argv[0]);
+		exit(1);
+	}
+
+	f = open(argv[1], O_RDWR);
+	offset = atoll(argv[2]);
+
 	if (f < 0) die("open");
-	if (lseek(f, 32768, SEEK_SET) < 0) die("lseek");
+	if (lseek(f, offset, SEEK_SET) < 0) die("lseek");
 	if (read(f, buffer, 32768) != 32768) die("read");
 	printf("Starting overwrite\n");
 	nuke();
-	if (lseek(f, 32768, SEEK_SET) < 0) die("lseek");
+	if (lseek(f, offset, SEEK_SET) < 0) die("lseek");
 	if (write(f, buffer, 32768) != 32768) die("write");
+	if (!overwrote)
+		printf("Did not overwrite any inodes\n");
 	printf("Overwrite complete\n");
 	close(f);
 	return 0;
diff --git a/tests/xfs/111 b/tests/xfs/111
index f33f339..7c8f263 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -40,6 +40,8 @@ _supported_fs xfs
 _supported_os Linux
 _require_scratch
 
+rm -f $seqres.full
+
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
 
 # real QA test starts here
@@ -56,16 +58,27 @@ do
     $XFS_IO_PROG -f -c "pwrite 0 512" $SCRATCH_MNT/${I} > /dev/null
     let I=$I+1
 done
+
+# Roughly the middle of the created inodes
+INO=`ls -i $SCRATCH_MNT/512 | awk '{print $1}'`
 umount $SCRATCH_DEV
 
+# Figure out where that middle inode starts
+BYTE=`$XFS_DB_PROG -c "convert inode $INO byte" $SCRATCH_DEV \
+	| awk '{print $2}' | sed s/[\(\)]//g`
+
 echo Blat inode clusters
-src/itrash $SCRATCH_DEV
+src/itrash $SCRATCH_DEV $BYTE
 
-_scratch_mount
+_scratch_mount || _fail "Couldn't mount after itrash"
 
 echo Attempting bulkstat
 #src/bstat -q $SCRATCH_MNT
-xfs_fsr $SCRATCH_MNT
+$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch
+
+# Fix up intentional corruption so test can pass
+umount $SCRATCH_DEV
+$XFS_REPAIR_PROG $SCRATCH_DEV >> $seqres.full 2>&1
 
 status=0
 exit
diff --git a/tests/xfs/111.out b/tests/xfs/111.out
index 88a5c99..fd56c3c 100644
--- a/tests/xfs/111.out
+++ b/tests/xfs/111.out
@@ -8,93 +8,6 @@ realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 Create some files
 Blat inode clusters
 Starting overwrite
-Overwrote IN @offset 2048
-Overwrote IN @offset 2304
-Overwrote IN @offset 2560
-Overwrote IN @offset 2816
-Overwrote IN @offset 3072
-Overwrote IN @offset 3328
-Overwrote IN @offset 3584
-Overwrote IN @offset 3840
-Overwrote IN @offset 4096
-Overwrote IN @offset 4352
-Overwrote IN @offset 4608
-Overwrote IN @offset 4864
-Overwrote IN @offset 5120
-Overwrote IN @offset 5376
-Overwrote IN @offset 5632
-Overwrote IN @offset 5888
-Overwrote IN @offset 6144
-Overwrote IN @offset 6400
-Overwrote IN @offset 6656
-Overwrote IN @offset 6912
-Overwrote IN @offset 7168
-Overwrote IN @offset 7424
-Overwrote IN @offset 7680
-Overwrote IN @offset 7936
-Overwrote IN @offset 8192
-Overwrote IN @offset 8448
-Overwrote IN @offset 8704
-Overwrote IN @offset 8960
-Overwrote IN @offset 9216
-Overwrote IN @offset 9472
-Overwrote IN @offset 9728
-Overwrote IN @offset 9984
-Overwrote IN @offset 10240
-Overwrote IN @offset 10496
-Overwrote IN @offset 10752
-Overwrote IN @offset 11008
-Overwrote IN @offset 11264
-Overwrote IN @offset 11520
-Overwrote IN @offset 11776
-Overwrote IN @offset 12032
-Overwrote IN @offset 12288
-Overwrote IN @offset 12544
-Overwrote IN @offset 12800
-Overwrote IN @offset 13056
-Overwrote IN @offset 13312
-Overwrote IN @offset 13568
-Overwrote IN @offset 13824
-Overwrote IN @offset 14080
-Overwrote IN @offset 14336
-Overwrote IN @offset 14592
-Overwrote IN @offset 14848
-Overwrote IN @offset 15104
-Overwrote IN @offset 15360
-Overwrote IN @offset 15616
-Overwrote IN @offset 15872
-Overwrote IN @offset 16128
-Overwrote IN @offset 24576
-Overwrote IN @offset 24832
-Overwrote IN @offset 25088
-Overwrote IN @offset 25344
-Overwrote IN @offset 25600
-Overwrote IN @offset 25856
-Overwrote IN @offset 26112
-Overwrote IN @offset 26368
-Overwrote IN @offset 26624
-Overwrote IN @offset 26880
-Overwrote IN @offset 27136
-Overwrote IN @offset 27392
-Overwrote IN @offset 27648
-Overwrote IN @offset 27904
-Overwrote IN @offset 28160
-Overwrote IN @offset 28416
-Overwrote IN @offset 28672
-Overwrote IN @offset 28928
-Overwrote IN @offset 29184
-Overwrote IN @offset 29440
-Overwrote IN @offset 29696
-Overwrote IN @offset 29952
-Overwrote IN @offset 30208
-Overwrote IN @offset 30464
-Overwrote IN @offset 30720
-Overwrote IN @offset 30976
-Overwrote IN @offset 31232
-Overwrote IN @offset 31488
-Overwrote IN @offset 31744
-Overwrote IN @offset 32000
-Overwrote IN @offset 32256
-Overwrote IN @offset 32512
 Overwrite complete
 Attempting bulkstat
+SCRATCH_MNT start inode=0




