Received: from imap.thunk.org ([74.207.234.97]:34546 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 07/16] Rename _scratch_mount to _scratch_cycle_mount
Date: Sat, 13 Feb 2016 12:41:00 -0500
Message-Id: <1455385269-26319-8-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This makes it clear when we are using "mount ; umount" versus "mount
-o remount" for most file systems.  The reason for this distinction is
(a) tests may want to test the difference between what happens on the
remount versus the munt paths, (b) with tmpfs, "mount ; umount" will
cause the contents of all of the files to disappear which makes many
tests sad, and (c) some mount options may not be changed using "mount
-o remount".

Currently _scratch_mount performs "_scratch_mount ; _scratch_umount"
so mechnically rename this function to _scratch_cycle_mount.  This was
done mechnically using the script fragment:

git grep "_scratch_remount" | \
	awk -F: '{print $1}' | sort -u | \
	xargs sed -i 's/_scratch_remount/_scratch_cycle_mount/g'

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/defrag     | 2 +-
 common/rc         | 2 +-
 tests/btrfs/001   | 6 +++---
 tests/btrfs/005   | 2 +-
 tests/btrfs/026   | 2 +-
 tests/btrfs/052   | 2 +-
 tests/btrfs/081   | 2 +-
 tests/btrfs/088   | 2 +-
 tests/btrfs/102   | 2 +-
 tests/btrfs/103   | 2 +-
 tests/btrfs/104   | 2 +-
 tests/btrfs/106   | 2 +-
 tests/f2fs/001    | 2 +-
 tests/generic/029 | 6 +++---
 tests/generic/030 | 6 +++---
 tests/generic/031 | 2 +-
 tests/generic/032 | 2 +-
 tests/generic/033 | 2 +-
 tests/generic/071 | 2 +-
 tests/generic/098 | 2 +-
 tests/generic/161 | 2 +-
 tests/generic/162 | 2 +-
 tests/generic/163 | 2 +-
 tests/generic/164 | 2 +-
 tests/generic/165 | 2 +-
 tests/generic/166 | 2 +-
 tests/generic/167 | 2 +-
 tests/generic/168 | 2 +-
 tests/generic/170 | 2 +-
 tests/generic/171 | 2 +-
 tests/generic/172 | 2 +-
 tests/generic/173 | 2 +-
 tests/generic/174 | 2 +-
 tests/generic/175 | 2 +-
 tests/generic/176 | 2 +-
 tests/generic/183 | 4 ++--
 tests/generic/185 | 4 ++--
 tests/generic/186 | 6 +++---
 tests/generic/187 | 6 +++---
 tests/generic/188 | 4 ++--
 tests/generic/189 | 4 ++--
 tests/generic/190 | 4 ++--
 tests/generic/191 | 4 ++--
 tests/generic/194 | 4 ++--
 tests/generic/195 | 4 ++--
 tests/generic/196 | 4 ++--
 tests/generic/197 | 4 ++--
 tests/generic/199 | 4 ++--
 tests/generic/200 | 4 ++--
 tests/generic/201 | 2 +-
 tests/generic/202 | 4 ++--
 tests/generic/203 | 4 ++--
 tests/generic/205 | 4 ++--
 tests/generic/206 | 4 ++--
 tests/generic/216 | 4 ++--
 tests/generic/217 | 4 ++--
 tests/generic/218 | 4 ++--
 tests/generic/220 | 4 ++--
 tests/generic/222 | 4 ++--
 tests/generic/227 | 4 ++--
 tests/generic/229 | 4 ++--
 tests/generic/238 | 4 ++--
 tests/generic/242 | 4 ++--
 tests/generic/243 | 4 ++--
 tests/generic/253 | 6 +++---
 tests/generic/254 | 6 +++---
 tests/generic/259 | 6 +++---
 tests/generic/261 | 6 +++---
 tests/generic/262 | 6 +++---
 tests/generic/264 | 6 +++---
 tests/generic/277 | 4 ++--
 tests/generic/284 | 4 ++--
 tests/generic/287 | 4 ++--
 tests/generic/289 | 4 ++--
 tests/generic/290 | 4 ++--
 tests/generic/291 | 4 ++--
 tests/generic/292 | 4 ++--
 tests/generic/293 | 4 ++--
 tests/generic/295 | 4 ++--
 tests/generic/296 | 4 ++--
 tests/generic/301 | 4 ++--
 tests/generic/302 | 4 ++--
 tests/generic/305 | 4 ++--
 tests/generic/307 | 4 ++--
 tests/generic/326 | 4 ++--
 tests/generic/327 | 2 +-
 tests/generic/328 | 2 +-
 tests/generic/330 | 4 ++--
 tests/generic/332 | 4 ++--
 tests/generic/333 | 2 +-
 tests/generic/334 | 2 +-
 tests/xfs/127     | 2 +-
 tests/xfs/139     | 4 ++--
 tests/xfs/140     | 4 ++--
 tests/xfs/180     | 4 ++--
 tests/xfs/182     | 4 ++--
 tests/xfs/184     | 4 ++--
 tests/xfs/192     | 4 ++--
 tests/xfs/193     | 4 ++--
 tests/xfs/198     | 4 ++--
 tests/xfs/200     | 4 ++--
 tests/xfs/204     | 4 ++--
 tests/xfs/207     | 8 ++++----
 tests/xfs/208     | 4 ++--
 tests/xfs/209     | 2 +-
 tests/xfs/211     | 4 ++--
 tests/xfs/212     | 4 ++--
 tests/xfs/213     | 4 ++--
 tests/xfs/214     | 4 ++--
 tests/xfs/215     | 4 ++--
 tests/xfs/218     | 4 ++--
 tests/xfs/219     | 4 ++--
 tests/xfs/221     | 4 ++--
 tests/xfs/223     | 4 ++--
 tests/xfs/224     | 4 ++--
 tests/xfs/225     | 4 ++--
 tests/xfs/226     | 4 ++--
 tests/xfs/228     | 4 ++--
 tests/xfs/230     | 4 ++--
 tests/xfs/231     | 2 +-
 tests/xfs/232     | 2 +-
 tests/xfs/233     | 2 +-
 tests/xfs/239     | 4 ++--
 tests/xfs/241     | 4 ++--
 tests/xfs/243     | 2 +-
 tests/xfs/245     | 2 +-
 tests/xfs/248     | 4 ++--
 tests/xfs/249     | 4 ++--
 tests/xfs/251     | 4 ++--
 tests/xfs/254     | 4 ++--
 tests/xfs/255     | 4 ++--
 tests/xfs/256     | 4 ++--
 tests/xfs/257     | 4 ++--
 tests/xfs/258     | 4 ++--
 134 files changed, 237 insertions(+), 237 deletions(-)

diff --git a/common/defrag b/common/defrag
index d2b137e..942593e 100644
--- a/common/defrag
+++ b/common/defrag
@@ -144,7 +144,7 @@ _defrag()
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
 	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
 
-	_scratch_remount
+	_scratch_cycle_mount
 	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
 	[ ! -z $csum ] && CSUM_AFTER=`md5sum $1`
 
diff --git a/common/rc b/common/rc
index 9006392..509e524 100644
--- a/common/rc
+++ b/common/rc
@@ -329,7 +329,7 @@ _scratch_unmount()
 	esac
 }
 
-_scratch_remount()
+_scratch_cycle_mount()
 {
     _scratch_unmount
     _scratch_mount
diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 8258d06..005791d 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -80,7 +80,7 @@ dd if=/dev/zero of=$SCRATCH_MNT/subvol/bar bs=1M count=1 &> /dev/null
 echo "Setting subvol to the default"
 subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT subvol)
 $BTRFS_UTIL_PROG subvolume set-default $subvolid $SCRATCH_MNT | _filter_scratch
-_scratch_remount
+_scratch_cycle_mount
 echo "List root dir which is now subvol"
 ls $SCRATCH_MNT
 _scratch_unmount
@@ -90,7 +90,7 @@ echo "List root dir"
 ls $SCRATCH_MNT
 echo "Setting the root dir as the default again"
 $BTRFS_UTIL_PROG subvolume set-default 0 $SCRATCH_MNT | _filter_scratch
-_scratch_remount
+_scratch_cycle_mount
 echo "List root dir"
 ls $SCRATCH_MNT
 
@@ -102,7 +102,7 @@ $BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
 $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/snap | _filter_btrfs_subvol_delete
 echo "List root dir"
 ls $SCRATCH_MNT
-_scratch_remount
+_scratch_cycle_mount
 echo "List root dir"
 ls $SCRATCH_MNT
 
diff --git a/tests/btrfs/005 b/tests/btrfs/005
index c048ab5..9236501 100755
--- a/tests/btrfs/005
+++ b/tests/btrfs/005
@@ -88,7 +88,7 @@ _btrfs_online_defrag()
 		fi
 	fi
 	ret_val=$?
-	_scratch_remount
+	_scratch_cycle_mount
 	# Older defrag returned "20" for success
 	# e9393c2 btrfs-progs: defrag return zero on success
 	if [ $ret_val -ne 0 -a $ret_val -ne 20 ]; then
diff --git a/tests/btrfs/026 b/tests/btrfs/026
index 0477ed4..60908cc 100644
--- a/tests/btrfs/026
+++ b/tests/btrfs/026
@@ -99,7 +99,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 256M 3M 256M" $SCRATCH_MNT/bar \
 echo "File digests before remounting the file system:"
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 md5sum $SCRATCH_MNT/bar | _filter_scratch
-_scratch_remount
+_scratch_cycle_mount
 echo "File digests after remounting the file system:"
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 md5sum $SCRATCH_MNT/bar | _filter_scratch
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index b760b92..babc127 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -149,7 +149,7 @@ test_btrfs_clone_same_file()
 	# Check that after defragmenting the file and re-mounting, the file
 	# content remains exactly the same as before.
 	_run_btrfs_util_prog filesystem defragment $SCRATCH_MNT/foo
-	_scratch_remount
+	_scratch_cycle_mount
 	od -t x1 $SCRATCH_MNT/foo | _filter_od
 
 	# Verify that there are no consistency errors.
diff --git a/tests/btrfs/081 b/tests/btrfs/081
index 51d0e84..40fa426 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -127,7 +127,7 @@ md5sum $SCRATCH_MNT/bar | _filter_scratch
 
 # Validate the content of bar still matches foo's content even after
 # clearing all of bar's data from the page cache.
-_scratch_remount
+_scratch_cycle_mount
 echo "Verifying target file digest after umount + mount"
 md5sum $SCRATCH_MNT/bar | _filter_scratch
 
diff --git a/tests/btrfs/088 b/tests/btrfs/088
index ca11c25..79268ec 100755
--- a/tests/btrfs/088
+++ b/tests/btrfs/088
@@ -121,7 +121,7 @@ $FSTRIM_PROG $SCRATCH_MNT
 
 # We expect to be able to mount the fs again and have available all metadata and
 # data that got persisted in the first transaction.
-_scratch_remount
+_scratch_cycle_mount
 
 # We now expect file's foo content to match what it had when the first
 # transaction was committed because the second transaction was aborted and we
diff --git a/tests/btrfs/102 b/tests/btrfs/102
index a94e3f6..9f0bea0 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -74,7 +74,7 @@ _run_btrfs_util_prog balance start -dusage=0 $SCRATCH_MNT
 # object was marked as full when initialized (because it had 0 total bytes),
 # which prevented the file write path from attempting to allocate a data block
 # group and fail immediately with ENOSPC.
-_scratch_remount
+_scratch_cycle_mount
 echo "hello world" > $SCRATCH_MNT/foobar
 
 echo "Silence is golden"
diff --git a/tests/btrfs/103 b/tests/btrfs/103
index 9d11d0f..a5a252a 100755
--- a/tests/btrfs/103
+++ b/tests/btrfs/103
@@ -95,7 +95,7 @@ test_clone_and_read_compressed_extent()
 	# exclusively in the read path). The issue happened only if the same
 	# readpages() call targeted pages belonging to the first and second
 	# ranges that point to the same compressed extent.
-	_scratch_remount
+	_scratch_cycle_mount
 
 	echo "File contents after mounting filesystem again:"
 	# Must match the same contents we got before.
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 80161a3..efc0d74 100644
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -132,7 +132,7 @@ _run_btrfs_util_prog quota enable $SCRATCH_MNT
 _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 
 # Remount to clear cache, force everything to disk
-_scratch_remount
+_scratch_cycle_mount
 
 # Finally, delete snap1 to trigger btrfs_drop_snapshot(). This
 # snapshot is most interesting to delete because it will cause some
diff --git a/tests/btrfs/106 b/tests/btrfs/106
index 30c43fa..c7e61f7 100755
--- a/tests/btrfs/106
+++ b/tests/btrfs/106
@@ -82,7 +82,7 @@ test_clone_and_read_compressed_extent()
 	# bug exclusively in the read path of compressed extents, the correct
 	# data was stored on disk, btrfs just failed to fill in the pages
 	# correctly.
-	_scratch_remount
+	_scratch_cycle_mount
 
 	echo "File contents after remount:"
 	# Must match the digest we got before.
diff --git a/tests/f2fs/001 b/tests/f2fs/001
index 9c4425a..c84dbde 100755
--- a/tests/f2fs/001
+++ b/tests/f2fs/001
@@ -76,7 +76,7 @@ $testfile | _filter_xfs_io
 
 echo "==== check data contents ===="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 hexdump -C $testfile
 
 rm $testfile
diff --git a/tests/generic/029 b/tests/generic/029
index 854794e..a83d02d 100755
--- a/tests/generic/029
+++ b/tests/generic/029
@@ -69,7 +69,7 @@ $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
@@ -94,7 +94,7 @@ $testfile | _filter_xfs_io
  
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
@@ -114,7 +114,7 @@ $testfile | _filter_xfs_io
  
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
diff --git a/tests/generic/030 b/tests/generic/030
index 9947b96..8e6827d 100755
--- a/tests/generic/030
+++ b/tests/generic/030
@@ -74,7 +74,7 @@ $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
@@ -103,7 +103,7 @@ $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
@@ -139,7 +139,7 @@ $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
diff --git a/tests/generic/031 b/tests/generic/031
index 7d615c0..fcb5f89 100755
--- a/tests/generic/031
+++ b/tests/generic/031
@@ -64,7 +64,7 @@ $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
 hexdump -C $testfile
-_scratch_remount
+_scratch_cycle_mount
 echo "==== Post-Remount =="
 hexdump -C $testfile
 
diff --git a/tests/generic/032 b/tests/generic/032
index 53fb3de..8f48884 100755
--- a/tests/generic/032
+++ b/tests/generic/032
@@ -104,7 +104,7 @@ kill $syncpid
 wait
 
 # clear page cache and dump the file
-_scratch_remount
+_scratch_cycle_mount
 hexdump $SCRATCH_MNT/file
 
 status=0
diff --git a/tests/generic/033 b/tests/generic/033
index d221fcd..4f8bb92 100755
--- a/tests/generic/033
+++ b/tests/generic/033
@@ -77,7 +77,7 @@ for i in $(seq 4096 8192 $endoff); do
 	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
 done
 
-_scratch_remount
+_scratch_cycle_mount
 hexdump $file
 
 status=0
diff --git a/tests/generic/071 b/tests/generic/071
index 7aaaed7..1b0f558 100755
--- a/tests/generic/071
+++ b/tests/generic/071
@@ -68,7 +68,7 @@ $XFS_IO_PROG -c "falloc 0 512K" $SCRATCH_MNT/foo
 
 # Now ummount and mount again the fs. After this we expect the file's size to
 # be 512Kb.
-_scratch_remount
+_scratch_cycle_mount
 
 # Now check that all data we wrote before are available and the file size is
 # 512Kb.
diff --git a/tests/generic/098 b/tests/generic/098
index 77dd492..4945630 100755
--- a/tests/generic/098
+++ b/tests/generic/098
@@ -80,7 +80,7 @@ $XFS_IO_PROG -c "pwrite -S 0xbb 256K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
 # up being written to disk.
 $XFS_IO_PROG -c "truncate 160K" $SCRATCH_MNT/foo
 
-_scratch_remount
+_scratch_cycle_mount
 
 # We expect to see a file with a size of 160Kb, with the first 128Kb of data all
 # having the value 0xaa and the remaining 32Kb of data all having the value 0x00
diff --git a/tests/generic/161 b/tests/generic/161
index 7776b83..c62e0fb 100755
--- a/tests/generic/161
+++ b/tests/generic/161
@@ -61,7 +61,7 @@ echo "Initialize files"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Delete while rewriting"
 rm -rf $testdir/file1 &
diff --git a/tests/generic/162 b/tests/generic/162
index 6d5bb7a..c42c25a 100755
--- a/tests/generic/162
+++ b/tests/generic/162
@@ -61,7 +61,7 @@ echo "Initialize files"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 overwrite() {
 	while [ ! -e $testdir/finished ]; do
diff --git a/tests/generic/163 b/tests/generic/163
index b9b0cd7..4e916c6 100755
--- a/tests/generic/163
+++ b/tests/generic/163
@@ -61,7 +61,7 @@ echo "Initialize files"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 overwrite() {
 	while [ ! -e $testdir/finished ]; do
diff --git a/tests/generic/164 b/tests/generic/164
index 6c12724..e2ef55f 100755
--- a/tests/generic/164
+++ b/tests/generic/164
@@ -64,7 +64,7 @@ echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file3
-_scratch_remount
+_scratch_cycle_mount
 
 fbytes() {
 	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
diff --git a/tests/generic/165 b/tests/generic/165
index 1ae08a4..fc2ac1b 100755
--- a/tests/generic/165
+++ b/tests/generic/165
@@ -65,7 +65,7 @@ echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file3
-_scratch_remount
+_scratch_cycle_mount
 
 fbytes() {
 	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
diff --git a/tests/generic/166 b/tests/generic/166
index a1e4ff4..831b598 100755
--- a/tests/generic/166
+++ b/tests/generic/166
@@ -63,7 +63,7 @@ blksz=65536
 echo "Initialize file"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 # Snapshot creator...
 snappy() {
diff --git a/tests/generic/167 b/tests/generic/167
index 76969c1..355a2bf 100755
--- a/tests/generic/167
+++ b/tests/generic/167
@@ -62,7 +62,7 @@ blksz=65536
 echo "Initialize file"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 # Snapshot creator...
 snappy() {
diff --git a/tests/generic/168 b/tests/generic/168
index bb4a5a1..98e6f30 100755
--- a/tests/generic/168
+++ b/tests/generic/168
@@ -62,7 +62,7 @@ echo "Initialize files"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 # Direct I/O overwriter...
 overwrite() {
diff --git a/tests/generic/170 b/tests/generic/170
index 0f29b3a..4f34f3b 100755
--- a/tests/generic/170
+++ b/tests/generic/170
@@ -63,7 +63,7 @@ echo "Initialize files"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 0 $((loops * blksz)) $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 # Direct I/O overwriter...
 overwrite() {
diff --git a/tests/generic/171 b/tests/generic/171
index 8a3f246..f391685 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -87,7 +87,7 @@ echo ${out} >> $seqres.full 2>&1
 echo ${out}
 
 echo "Remount and try CoW again"
-_scratch_remount
+_scratch_cycle_mount
 
 out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
diff --git a/tests/generic/172 b/tests/generic/172
index 3e32644..26fb305 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -87,7 +87,7 @@ echo ${out} >> $seqres.full 2>&1
 echo ${out}
 
 echo "Remount and try CoW again"
-_scratch_remount
+_scratch_cycle_mount
 
 out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
diff --git a/tests/generic/173 b/tests/generic/173
index fe085a6..c5fac9e 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -88,7 +88,7 @@ if [ $err -lt 128 ]; then
 fi
 
 echo "Remount and try CoW again"
-_scratch_remount
+_scratch_cycle_mount
 
 out="$(_mwrite_byte 0x62 0 $((blksz * nr_blks)) $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
 err="$?"
diff --git a/tests/generic/174 b/tests/generic/174
index edfc2bc..8077d76 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -88,7 +88,7 @@ echo ${out} >> $seqres.full 2>&1
 echo ${out}
 
 echo "Remount and try CoW again"
-_scratch_remount
+_scratch_cycle_mount
 
 out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile -d 2>&1)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
diff --git a/tests/generic/175 b/tests/generic/175
index 56e9919..964580c 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -67,7 +67,7 @@ for i in $(seq 0 $fnr); do
 	n=$(( (2 ** i) * blksz))
 	_reflink_range "$testdir/file1" 0 "$testdir/file1" $n $n >> "$seqres.full"
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Reflink the big file"
 blks=$((2 ** (fnr + 1) ))
diff --git a/tests/generic/176 b/tests/generic/176
index a77a16d..f7d6495 100755
--- a/tests/generic/176
+++ b/tests/generic/176
@@ -79,7 +79,7 @@ echo "creating $blocks_needed blocks..." >> "$seqres.full"
 echo "punching..." >> "$seqres.full"
 "$here/src/punch-alternating" "$testdir/file1" >> "$seqres.full"
 echo "...done" >> "$seqres.full"
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Reflink the big file"
 bytes=$((blocks_needed * blksz))
diff --git a/tests/generic/183 b/tests/generic/183
index 0ab4afe..24adf97 100755
--- a/tests/generic/183
+++ b/tests/generic/183
@@ -74,7 +74,7 @@ seq 1 2 $((nr-1)) | while read f; do
 	_reflink_range $testdir/file2 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
 	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -87,7 +87,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/185 b/tests/generic/185
index 28826d0..49feaf3 100755
--- a/tests/generic/185
+++ b/tests/generic/185
@@ -73,7 +73,7 @@ seq 1 2 $((nr-1)) | while read f; do
 	_reflink_range $testdir/file2 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
 	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -86,7 +86,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/186 b/tests/generic/186
index 9839a22..70a0280 100755
--- a/tests/generic/186
+++ b/tests/generic/186
@@ -116,10 +116,10 @@ seq 1 2 $((nr-1)) | while read f; do
 	_reflink_range $testdir/file2 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
 	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 _fragment_freesp $testdir/bigfile >> $seqres.full 2>&1
 filesize=$((blksz * nr))
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -132,7 +132,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/187 b/tests/generic/187
index ac6037d..25cbcd9 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -117,10 +117,10 @@ seq 1 2 $((nr-1)) | while read f; do
 	_reflink_range $testdir/file2 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
 	_pwrite_byte 0x62 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 _fragment_freesp $testdir/bigfile >> $seqres.full 2>&1
 filesize=$((blksz * nr))
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -133,7 +133,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/188 b/tests/generic/188
index bb293b1..19d3f56 100755
--- a/tests/generic/188
+++ b/tests/generic/188
@@ -65,7 +65,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -77,7 +77,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/189 b/tests/generic/189
index 5b409be..14cfef9 100755
--- a/tests/generic/189
+++ b/tests/generic/189
@@ -64,7 +64,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,7 +76,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/190 b/tests/generic/190
index b4de3ed..3009bfe 100755
--- a/tests/generic/190
+++ b/tests/generic/190
@@ -65,7 +65,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -77,7 +77,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/191 b/tests/generic/191
index cfedcde..36af284 100755
--- a/tests/generic/191
+++ b/tests/generic/191
@@ -64,7 +64,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,7 +76,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/194 b/tests/generic/194
index f67e567..9edbe2c 100755
--- a/tests/generic/194
+++ b/tests/generic/194
@@ -66,7 +66,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -79,7 +79,7 @@ cowsz=$((filesize / 2))
 _weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/195 b/tests/generic/195
index 51f10f3..98954d5 100755
--- a/tests/generic/195
+++ b/tests/generic/195
@@ -65,7 +65,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -78,7 +78,7 @@ cowsz=$((filesize / 2))
 _weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/196 b/tests/generic/196
index 3fcf522..69e7c04 100755
--- a/tests/generic/196
+++ b/tests/generic/196
@@ -65,7 +65,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -77,7 +77,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/197 b/tests/generic/197
index b40ea93..0fc0c5e 100755
--- a/tests/generic/197
+++ b/tests/generic/197
@@ -64,7 +64,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,7 +76,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/199 b/tests/generic/199
index 04380ed..0ac4762 100755
--- a/tests/generic/199
+++ b/tests/generic/199
@@ -71,7 +71,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -85,7 +85,7 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 # now cow
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/200 b/tests/generic/200
index 2aa0315..5d7da84 100755
--- a/tests/generic/200
+++ b/tests/generic/200
@@ -71,7 +71,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -85,7 +85,7 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 # now cow
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/201 b/tests/generic/201
index 634dec9..547f194 100755
--- a/tests/generic/201
+++ b/tests/generic/201
@@ -66,7 +66,7 @@ seq 0 2 $((nr-1)) | while read f; do
 	_reflink_range $testdir/file1 $((blksz * f)) $testdir/file3 $((blksz * f)) $blksz >> $seqres.full
 	_pwrite_byte 0x61 $((blksz * f)) $blksz $testdir/file3.chk >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/202 b/tests/generic/202
index a7f4004..14c94af 100755
--- a/tests/generic/202
+++ b/tests/generic/202
@@ -59,7 +59,7 @@ blksz=65536
 _pwrite_byte 0x61 0 $((blksz + 17)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2
 _pwrite_byte 0x61 0 $((blksz + 17)) $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -69,7 +69,7 @@ md5sum $testdir/file2.chk | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) 17" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) 17" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/203 b/tests/generic/203
index 2ffb311..a7d0bcc 100755
--- a/tests/generic/203
+++ b/tests/generic/203
@@ -60,7 +60,7 @@ blksz=65536
 _pwrite_byte 0x61 0 $((blksz + 17)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2
 _pwrite_byte 0x61 0 $((blksz + 17)) $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -70,7 +70,7 @@ md5sum $testdir/file2.chk | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 $blksz $blksz" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $blksz $blksz" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/205 b/tests/generic/205
index 683849e..65c3563 100755
--- a/tests/generic/205
+++ b/tests/generic/205
@@ -77,7 +77,7 @@ _pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -86,7 +86,7 @@ cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't mat
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/206 b/tests/generic/206
index 6b3e200..0d8006f 100755
--- a/tests/generic/206
+++ b/tests/generic/206
@@ -78,7 +78,7 @@ _pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -87,7 +87,7 @@ cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't mat
 echo "CoW and unmount"
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/216 b/tests/generic/216
index d9f7e21..29fa6a0 100755
--- a/tests/generic/216
+++ b/tests/generic/216
@@ -78,7 +78,7 @@ _pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -87,7 +87,7 @@ cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't mat
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/217 b/tests/generic/217
index ce8e0a1..3843a8b 100755
--- a/tests/generic/217
+++ b/tests/generic/217
@@ -79,7 +79,7 @@ _pwrite_byte 0x00 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -88,7 +88,7 @@ cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't mat
 echo "CoW and unmount"
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/218 b/tests/generic/218
index ecc009a..6e7f465 100755
--- a/tests/generic/218
+++ b/tests/generic/218
@@ -72,7 +72,7 @@ $XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -81,7 +81,7 @@ cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't mat
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/220 b/tests/generic/220
index 3bce21b..d3ee888 100755
--- a/tests/generic/220
+++ b/tests/generic/220
@@ -73,7 +73,7 @@ $XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -82,7 +82,7 @@ cmp -s $testdir/file2 $testdir/file2.chk || _fail "file2 and file2.chk don't mat
 echo "CoW and unmount"
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/222 b/tests/generic/222
index 58ca8f5..7de8ad6 100755
--- a/tests/generic/222
+++ b/tests/generic/222
@@ -72,7 +72,7 @@ $XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -87,7 +87,7 @@ _pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/227 b/tests/generic/227
index 00985d3..daac550 100755
--- a/tests/generic/227
+++ b/tests/generic/227
@@ -73,7 +73,7 @@ $XFS_IO_PROG -f -c "truncate $pagesz" $testdir/file2.chk >> $seqres.full
 
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) $blksz >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
@@ -88,7 +88,7 @@ _pwrite_byte 0x61 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/229 b/tests/generic/229
index b6359e8..a307408 100755
--- a/tests/generic/229
+++ b/tests/generic/229
@@ -107,7 +107,7 @@ runtest() {
 
 	_reflink_range $dir/file1 $blksz $dir/file2 $((blksz * 2)) $blksz >> $seqres.full
 	_pwrite_byte 0x61 $((blksz * 2)) $blksz $dir/file2.chk >> $seqres.full
-	_scratch_remount
+	_scratch_cycle_mount
 
 	echo "Compare files"
 	! cmp -s $dir/file1 $dir/file2 || _fail "file1 and file2 don't match."
@@ -126,7 +126,7 @@ runtest() {
 
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $dir/file2 >> $seqres.full
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $((blksz + 17)) $((blksz * 3 - 34))" $dir/file2.chk >> $seqres.full
-	_scratch_remount
+	_scratch_cycle_mount
 
 	echo "Compare files"
 	! cmp -s $dir/file1 $dir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/238 b/tests/generic/238
index 3b46492..38e3aac 100755
--- a/tests/generic/238
+++ b/tests/generic/238
@@ -108,7 +108,7 @@ runtest() {
 
 	_reflink_range $dir/file1 $blksz $dir/file2 $((blksz * 2)) $blksz >> $seqres.full
 	_pwrite_byte 0x61 $((blksz * 2)) $blksz $dir/file2.chk >> $seqres.full
-	_scratch_remount
+	_scratch_cycle_mount
 
 	echo "Compare files"
 	! cmp -s $dir/file1 $dir/file2 || _fail "file1 and file2 don't match."
@@ -127,7 +127,7 @@ runtest() {
 
 	$XFS_IO_PROG -d -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $dir/file2 >> $seqres.full
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 $blksz $((blksz * 3))" $dir/file2.chk >> $seqres.full
-	_scratch_remount
+	_scratch_cycle_mount
 
 	echo "Compare files"
 	! cmp -s $dir/file1 $dir/file2 || _fail "file1 and file2 don't match."
diff --git a/tests/generic/242 b/tests/generic/242
index 1f174df..93fdc1d 100755
--- a/tests/generic/242
+++ b/tests/generic/242
@@ -74,7 +74,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -84,7 +84,7 @@ md5sum $testdir/file2.chk | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/243 b/tests/generic/243
index e1d698b..ae9caa2 100755
--- a/tests/generic/243
+++ b/tests/generic/243
@@ -75,7 +75,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -85,7 +85,7 @@ md5sum $testdir/file2.chk | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/253 b/tests/generic/253
index bfb91a3..4935f44 100755
--- a/tests/generic/253
+++ b/tests/generic/253
@@ -67,7 +67,7 @@ echo "Create the original files"
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $filesize $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,9 +76,9 @@ md5sum $testdir/file2.chk | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 2)) $blksz $((blksz * 2))" -c "truncate $((blksz * 2))" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 2)) $blksz $((blksz * 2))" -c "truncate $((blksz * 2))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/254 b/tests/generic/254
index f16cdd3..cd015ec 100755
--- a/tests/generic/254
+++ b/tests/generic/254
@@ -67,7 +67,7 @@ echo "Create the original files"
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $filesize $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,9 +76,9 @@ md5sum $testdir/file2.chk | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" -c "fpunch $((blksz * 2)) $blksz" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" -c "pwrite -S 0x00 $((blksz * 2)) $blksz" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/259 b/tests/generic/259
index 6718c50..3765bfd 100755
--- a/tests/generic/259
+++ b/tests/generic/259
@@ -67,7 +67,7 @@ echo "Create the original files"
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $filesize $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,9 +76,9 @@ md5sum $testdir/file2.chk | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" -c "fzero $((blksz * 2)) $blksz" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" -c "pwrite -S 0x00 $((blksz * 2)) $blksz" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/261 b/tests/generic/261
index 28d0e0b..84ebc86 100755
--- a/tests/generic/261
+++ b/tests/generic/261
@@ -67,7 +67,7 @@ echo "Create the original files"
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $filesize $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,9 +76,9 @@ md5sum $testdir/file2.chk | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" -c "fcollapse $((blksz * 2)) $blksz" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 2)) $blksz $((blksz * 2))" -c "truncate $((blksz * (nr - 1)))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/262 b/tests/generic/262
index aaf38cf..366801b 100755
--- a/tests/generic/262
+++ b/tests/generic/262
@@ -67,7 +67,7 @@ echo "Create the original files"
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $filesize $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,12 +76,12 @@ md5sum $testdir/file2.chk | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 2)) $blksz $((blksz * 2))" -c "finsert $((blksz * 2)) $blksz" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 _pwrite_byte 0x62 $blksz $blksz $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz * 2)) $blksz $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x62 $((blksz * 3)) $blksz $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 4)) $blksz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/264 b/tests/generic/264
index d5bcca6..631184c 100755
--- a/tests/generic/264
+++ b/tests/generic/264
@@ -67,7 +67,7 @@ echo "Create the original files"
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $filesize $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -76,9 +76,9 @@ md5sum $testdir/file2.chk | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" -c "falloc $((blksz * 2)) $blksz" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 $XFS_IO_PROG -f -c "pwrite -S 0x62 -b $((blksz * 3)) $blksz $((blksz * 3))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/277 b/tests/generic/277
index 39ebdc3..f92235b 100755
--- a/tests/generic/277
+++ b/tests/generic/277
@@ -50,7 +50,7 @@ _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
 touch $SCRATCH_MNT/tmp
-_scratch_remount
+_scratch_cycle_mount
 ctime1=`stat -c %z $SCRATCH_MNT/tmp`
 
 sleep 1
@@ -58,7 +58,7 @@ chattr +A $SCRATCH_MNT/tmp
 chattr -A $SCRATCH_MNT/tmp
 ctime2=`stat -c %z $SCRATCH_MNT/tmp`
 
-_scratch_remount
+_scratch_cycle_mount
 ctime3=`stat -c %z $SCRATCH_MNT/tmp`
 
 if [ "$ctime1" == "$ctime2" ]; then
diff --git a/tests/generic/284 b/tests/generic/284
index aae4bb0..b3e8f3b 100755
--- a/tests/generic/284
+++ b/tests/generic/284
@@ -65,7 +65,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -77,7 +77,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/287 b/tests/generic/287
index 11e3c9f..7d53883 100755
--- a/tests/generic/287
+++ b/tests/generic/287
@@ -66,7 +66,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -78,7 +78,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/289 b/tests/generic/289
index 31df1b8..62b28dc 100755
--- a/tests/generic/289
+++ b/tests/generic/289
@@ -67,7 +67,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -79,7 +79,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/290 b/tests/generic/290
index 4a576c5..ff3af20 100755
--- a/tests/generic/290
+++ b/tests/generic/290
@@ -68,7 +68,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -80,7 +80,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/291 b/tests/generic/291
index 0f35ee0..1888043 100755
--- a/tests/generic/291
+++ b/tests/generic/291
@@ -67,7 +67,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -79,7 +79,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/292 b/tests/generic/292
index c3d9f11..e71b555 100755
--- a/tests/generic/292
+++ b/tests/generic/292
@@ -68,7 +68,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -80,7 +80,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/293 b/tests/generic/293
index f6579d9..6792f10 100755
--- a/tests/generic/293
+++ b/tests/generic/293
@@ -68,7 +68,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ cowsz=$((filesize / 2))
 _sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/295 b/tests/generic/295
index e7cfaa0..8f7916e 100755
--- a/tests/generic/295
+++ b/tests/generic/295
@@ -69,7 +69,7 @@ blksz=65536
 nr=64
 filesize=$((blksz * nr))
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -82,7 +82,7 @@ cowsz=$((filesize / 2))
 _sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/296 b/tests/generic/296
index 53eceb2..4297088 100755
--- a/tests/generic/296
+++ b/tests/generic/296
@@ -68,7 +68,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -78,7 +78,7 @@ md5sum $testdir/file2.chk | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" -c "fdatasync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" -c "fdatasync" $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/301 b/tests/generic/301
index 0201d0b..a513333 100755
--- a/tests/generic/301
+++ b/tests/generic/301
@@ -71,7 +71,7 @@ internal_blks=$((filesize / real_blksz))
 echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ echo "CoW and unmount"
 for i in `seq 1 8`; do
 	$XFS_IO_PROG -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" -c "fdatasync" $testdir/file2 >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/302 b/tests/generic/302
index c48da0a..1600b5a 100755
--- a/tests/generic/302
+++ b/tests/generic/302
@@ -72,7 +72,7 @@ internal_blks=$((filesize / real_blksz))
 echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -82,7 +82,7 @@ echo "CoW and unmount"
 for i in `seq 1 8`; do
 	$XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" $testdir/file2 >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/305 b/tests/generic/305
index 9356a86..d73d87f 100755
--- a/tests/generic/305
+++ b/tests/generic/305
@@ -75,7 +75,7 @@ chown nobody $testdir/urk
 touch $testdir/erk
 chown fsgqa $testdir/erk
 _repquota
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Change file ownership"
 chown fsgqa $testdir/file1
@@ -88,7 +88,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $((sz/2)) 0 $((sz/2))" -c "fsync" $testdir
 _repquota
 
 echo "Remount the FS to see if accounting changes"
-_scratch_remount
+_scratch_cycle_mount
 _repquota
 
 echo "Chown one of the files"
diff --git a/tests/generic/307 b/tests/generic/307
index 857c196..f5d0680 100755
--- a/tests/generic/307
+++ b/tests/generic/307
@@ -58,14 +58,14 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount >/dev/null 2>&1
 
 touch $testfile
-_scratch_remount
+_scratch_cycle_mount
 ctime1=`stat -c %Z $testfile`
 
 sleep 1
 setfacl -m 'u::x,g::x,o::x' $testfile
 ctime2=`stat -c %Z $testfile`
 
-_scratch_remount
+_scratch_cycle_mount
 ctime3=`stat -c %Z $testfile`
 
 if [ "$ctime1" == "$ctime2" ]; then
diff --git a/tests/generic/326 b/tests/generic/326
index b6c748c..8afc6a2 100755
--- a/tests/generic/326
+++ b/tests/generic/326
@@ -76,7 +76,7 @@ chown nobody $testdir/urk
 touch $testdir/erk
 chown fsgqa $testdir/erk
 _repquota
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Change file ownership"
 chown fsgqa $testdir/file1
@@ -89,7 +89,7 @@ $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $((sz/2)) 0 $((sz/2))" -c "fsync" $test
 _repquota
 
 echo "Remount the FS to see if accounting changes"
-_scratch_remount
+_scratch_cycle_mount
 _repquota
 
 echo "Chown one of the files"
diff --git a/tests/generic/327 b/tests/generic/327
index 90d2aca..c165ad5 100755
--- a/tests/generic/327
+++ b/tests/generic/327
@@ -70,7 +70,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $sz 0 $sz" $testdir/file1 >> $seqres.full
 chown fsgqa $testdir/file1
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _repquota
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Set hard quota to prevent third reflink"
 setquota -u fsgqa 0 1024 0 0 $SCRATCH_MNT
diff --git a/tests/generic/328 b/tests/generic/328
index 46cfa66..e0b0550 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -72,7 +72,7 @@ chown fsgqa $testdir/file1
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file3 >> $seqres.full
 _repquota
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Set hard quota to prevent rewrite"
 setquota -u fsgqa 0 1024 0 0 $SCRATCH_MNT
diff --git a/tests/generic/330 b/tests/generic/330
index 377d822..f9f82a4 100755
--- a/tests/generic/330
+++ b/tests/generic/330
@@ -67,7 +67,7 @@ _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 3 * 5 / 4))
 echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -78,7 +78,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 sync
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 $AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/332 b/tests/generic/332
index f9b5f6f..b805bbd 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -68,7 +68,7 @@ _require_fs_space $SCRATCH_MNT $((filesize / 1024 * 3 * 5 / 4))
 echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -79,7 +79,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 sync
 $AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/generic/333 b/tests/generic/333
index b8a1ea8..61a2d02 100755
--- a/tests/generic/333
+++ b/tests/generic/333
@@ -63,7 +63,7 @@ blksz=65536
 echo "Initialize file"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 # Snapshot creator...
 snappy() {
diff --git a/tests/generic/334 b/tests/generic/334
index 89601be..28c47d6 100755
--- a/tests/generic/334
+++ b/tests/generic/334
@@ -62,7 +62,7 @@ blksz=65536
 echo "Initialize file"
 echo > $seqres.full
 _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 # Snapshot creator...
 snappy() {
diff --git a/tests/xfs/127 b/tests/xfs/127
index 67a8c96..f44daae 100755
--- a/tests/xfs/127
+++ b/tests/xfs/127
@@ -62,7 +62,7 @@ _cp_reflink $testdir/copy1 $testdir/copy2
 
 echo "Grow fs"
 $XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Create more reflink copies"
 _cp_reflink $testdir/original $testdir/copy3
diff --git a/tests/xfs/139 b/tests/xfs/139
index ecd88e6..16193e5 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -61,11 +61,11 @@ sz=$((48 * 1048576))
 nr=$((sz / blksz))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "CoW every other block"
 _pwrite_byte 0x62 0 $sz $testdir/file1 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/140 b/tests/xfs/140
index 6dfe581..052c539 100644
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -62,7 +62,7 @@ nr=$((sz / blksz))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir/file2.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match"
@@ -73,7 +73,7 @@ seq 1 2 $((nr - 1)) | while read f; do
 	_pwrite_byte 0x62 $((f * blksz)) $blksz $testdir/file2 >> $seqres.full
 	_pwrite_byte 0x62 $((f * blksz)) $blksz $testdir/file2.chk >> $seqres.full
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 ! cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 must not match"
diff --git a/tests/xfs/180 b/tests/xfs/180
index fdb24eb..00e91a4 100755
--- a/tests/xfs/180
+++ b/tests/xfs/180
@@ -75,7 +75,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -85,7 +85,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" -c "fdatasync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" -c "fdatasync" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/182 b/tests/xfs/182
index c1bfc02..b7aa5e7 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -76,7 +76,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -86,7 +86,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $((filesize + 1))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/184 b/tests/xfs/184
index 50674ff..6d32e93 100755
--- a/tests/xfs/184
+++ b/tests/xfs/184
@@ -75,7 +75,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -85,7 +85,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $((filesize + 1))" -c "fdatasync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "falloc 0 $((filesize + 1))" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/192 b/tests/xfs/192
index 6429def..8594787 100755
--- a/tests/xfs/192
+++ b/tests/xfs/192
@@ -76,7 +76,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -86,7 +86,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "falloc 0 $filesize" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/193 b/tests/xfs/193
index 974f1eb..f59b3bd 100755
--- a/tests/xfs/193
+++ b/tests/xfs/193
@@ -74,7 +74,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -83,7 +83,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" -c "fdatasync" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/198 b/tests/xfs/198
index 7f3c105..c12d915 100755
--- a/tests/xfs/198
+++ b/tests/xfs/198
@@ -75,7 +75,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -84,7 +84,7 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/200 b/tests/xfs/200
index 99bcf31..a750ef6 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -77,7 +77,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -89,7 +89,7 @@ cat $testdir/file2 > /dev/null
 $XFS_IO_PROG -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" -c "fdatasync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "fadvise -d 0 $filesize" -c "fsync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "falloc 0 $filesize" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/204 b/tests/xfs/204
index 3159849..ae21d6e 100755
--- a/tests/xfs/204
+++ b/tests/xfs/204
@@ -78,7 +78,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -90,7 +90,7 @@ cat $testdir/file2 > /dev/null
 $XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" -c "fdatasync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "fadvise -d 0 $filesize" -c "fsync" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "falloc 0 $filesize" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/207 b/tests/xfs/207
index d416f79..efa283f 100755
--- a/tests/xfs/207
+++ b/tests/xfs/207
@@ -64,7 +64,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 0 0" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 0 1048576" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 0 0" $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Set extsz and cowextsz on zero byte file"
 $XFS_IO_PROG -c "extsize 1048576" $testdir/file1 | _filter_scratch
@@ -73,7 +73,7 @@ $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file1 | _filter_scratch
 echo "Set extsz and cowextsz on 1Mbyte file"
 $XFS_IO_PROG -c "extsize 1048576" $testdir/file2 | _filter_scratch
 $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file2 | _filter_scratch
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Check extsz and cowextsz settings on zero byte file"
 $XFS_IO_PROG -c "extsize" $testdir/file1 | _filter_scratch
@@ -85,14 +85,14 @@ $XFS_IO_PROG -c "cowextsize" $testdir/file2 | _filter_scratch
 
 echo "Set cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
-_scratch_remount
+_scratch_cycle_mount
 
 $XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_scratch
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
 
 echo "Unset cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
-_scratch_remount
+_scratch_cycle_mount
 
 $XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_scratch
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
diff --git a/tests/xfs/208 b/tests/xfs/208
index d876898..4f56884 100755
--- a/tests/xfs/208
+++ b/tests/xfs/208
@@ -85,7 +85,7 @@ _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "extsize $bufsize" $testdir/file3
 $XFS_IO_PROG -f -c "cowextsize $real_blksz" $testdir/file3
 _cp_reflink $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -108,7 +108,7 @@ $XFS_IO_PROG -f -c "cowextsize" $testdir/file3 >> $seqres.full
 
 $XFS_IO_PROG -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $filesize" -c "fdatasync" $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" -c "fdatasync" $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/209 b/tests/xfs/209
index 684187e..cecd9c7 100755
--- a/tests/xfs/209
+++ b/tests/xfs/209
@@ -67,7 +67,7 @@ seq 1 2 | while read nr; do
 		touch "$testdir/dir-$nr/file-$nnr"
 	done
 done
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Check cowextsize settings"
 seq 1 2 | while read nr; do
diff --git a/tests/xfs/211 b/tests/xfs/211
index cb0f17a..9f01d08 100755
--- a/tests/xfs/211
+++ b/tests/xfs/211
@@ -76,7 +76,7 @@ echo "Create the original files"
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $((filesize + 1))" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "cowextsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -86,7 +86,7 @@ echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $((filesize + 1))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b 8388608 0 $filesize" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/212 b/tests/xfs/212
index 4e3bcd4..48235d4 100755
--- a/tests/xfs/212
+++ b/tests/xfs/212
@@ -72,7 +72,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $s
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
 $XFS_IO_PROG -f -c "extsize $bufsize" $testdir/file2
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -87,7 +87,7 @@ sync
 
 echo "Crash and recover"
 $XFS_IO_PROG -x -c "shutdown" $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/213 b/tests/xfs/213
index 2450097..d5cc129 100755
--- a/tests/xfs/213
+++ b/tests/xfs/213
@@ -80,7 +80,7 @@ chown nobody $testdir/urk
 touch $testdir/erk
 chown fsgqa $testdir/erk
 _repquota
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Change file ownership"
 chown fsgqa $testdir/file1
@@ -93,7 +93,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $blksz $((sz - blksz)) $blksz" -c "fsync"
 _repquota
 
 echo "Remount the FS to see if accounting changes"
-_scratch_remount
+_scratch_cycle_mount
 _repquota
 
 echo "Chown one of the files"
diff --git a/tests/xfs/214 b/tests/xfs/214
index 847f489..35972c6 100755
--- a/tests/xfs/214
+++ b/tests/xfs/214
@@ -81,7 +81,7 @@ chown nobody $testdir/urk
 touch $testdir/erk
 chown fsgqa $testdir/erk
 _repquota
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Change file ownership"
 chown fsgqa $testdir/file1
@@ -94,7 +94,7 @@ $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $blksz $((sz - blksz)) $blksz" -c "fsyn
 _repquota
 
 echo "Remount the FS to see if accounting changes"
-_scratch_remount
+_scratch_cycle_mount
 _repquota
 
 echo "Chown one of the files"
diff --git a/tests/xfs/215 b/tests/xfs/215
index 9ed842e..5ae4d85 100755
--- a/tests/xfs/215
+++ b/tests/xfs/215
@@ -69,7 +69,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/218 b/tests/xfs/218
index e98b14e..ea464f2 100755
--- a/tests/xfs/218
+++ b/tests/xfs/218
@@ -68,7 +68,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -80,7 +80,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/219 b/tests/xfs/219
index 25c0bb4..012b07c 100755
--- a/tests/xfs/219
+++ b/tests/xfs/219
@@ -69,7 +69,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/221 b/tests/xfs/221
index dc00331..8b860f2 100755
--- a/tests/xfs/221
+++ b/tests/xfs/221
@@ -68,7 +68,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -80,7 +80,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/223 b/tests/xfs/223
index 2bb1fcb..1e6ba98 100755
--- a/tests/xfs/223
+++ b/tests/xfs/223
@@ -70,7 +70,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -83,7 +83,7 @@ cowsz=$((filesize / 2))
 _weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/224 b/tests/xfs/224
index 92d3b05..3d19f94 100755
--- a/tests/xfs/224
+++ b/tests/xfs/224
@@ -69,7 +69,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -82,7 +82,7 @@ cowsz=$((filesize / 2))
 _weave_reflink_holes_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/225 b/tests/xfs/225
index b8e7712..c2e5b82 100755
--- a/tests/xfs/225
+++ b/tests/xfs/225
@@ -69,7 +69,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/226 b/tests/xfs/226
index ef4226e..3f035b4 100755
--- a/tests/xfs/226
+++ b/tests/xfs/226
@@ -68,7 +68,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -80,7 +80,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/228 b/tests/xfs/228
index ecbe35f..52fbb75 100755
--- a/tests/xfs/228
+++ b/tests/xfs/228
@@ -75,7 +75,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -89,7 +89,7 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 # now cow
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/230 b/tests/xfs/230
index e09b52e..91e4d3f 100755
--- a/tests/xfs/230
+++ b/tests/xfs/230
@@ -75,7 +75,7 @@ real_blksz=$(stat -f -c '%S' $testdir)
 internal_blks=$((filesize / real_blksz))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _weave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -89,7 +89,7 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
 # now cow
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file3.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/231 b/tests/xfs/231
index 3672887..60f59a9 100755
--- a/tests/xfs/231
+++ b/tests/xfs/231
@@ -79,7 +79,7 @@ $XFS_IO_PROG -c "cowextsize $bufsize" $testdir
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/232 b/tests/xfs/232
index 7219a64..9a8403c 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -80,7 +80,7 @@ $XFS_IO_PROG -c "cowextsize $bufsize" $testdir
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file2.chk >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/233 b/tests/xfs/233
index f821004..f10af2b 100755
--- a/tests/xfs/233
+++ b/tests/xfs/233
@@ -61,7 +61,7 @@ cp -p $testdir/copy1 $testdir/copy2
 
 echo "Grow fs"
 $XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Create more copies"
 cp -p $testdir/original $testdir/copy3
diff --git a/tests/xfs/239 b/tests/xfs/239
index 5bab633..c658dda 100755
--- a/tests/xfs/239
+++ b/tests/xfs/239
@@ -72,7 +72,7 @@ echo "Create the original files"
 $XFS_IO_PROG -c "cowextsize $((bufsize * 2))" $testdir
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -83,7 +83,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 sync
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 $AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/241 b/tests/xfs/241
index 090f913..5b29f4d 100755
--- a/tests/xfs/241
+++ b/tests/xfs/241
@@ -74,7 +74,7 @@ echo "Create the original files"
 $XFS_IO_PROG -c "cowextsize $((bufsize * 2))" $testdir
 $XFS_IO_PROG -f -c "pwrite -S 0x61 -b $bufsize 0 $filesize" $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -85,7 +85,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 sync
 $AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/243 b/tests/xfs/243
index 629173e..b616adf 100755
--- a/tests/xfs/243
+++ b/tests/xfs/243
@@ -153,7 +153,7 @@ echo "Regular data extents:"
 test $(_xfs_bmapx_find data $testdir/file3 '000000$') -gt 0 || \
 	echo "Expected to find a regular data extent"
 
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/245 b/tests/xfs/245
index 6da701d..c745592 100755
--- a/tests/xfs/245
+++ b/tests/xfs/245
@@ -62,7 +62,7 @@ mkdir $testdir
 
 echo "Create the original files"
 $XFS_IO_PROG -f -c "falloc 0 256k" -c "pwrite 252k 6k" $testdir/file1 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 
 echo "Compare files"
diff --git a/tests/xfs/248 b/tests/xfs/248
index 50771a1..7e25258 100755
--- a/tests/xfs/248
+++ b/tests/xfs/248
@@ -67,7 +67,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -79,7 +79,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/249 b/tests/xfs/249
index f2088ee..b82d89c 100755
--- a/tests/xfs/249
+++ b/tests/xfs/249
@@ -68,7 +68,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_regular $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -80,7 +80,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/251 b/tests/xfs/251
index a2617bb..4f74772 100755
--- a/tests/xfs/251
+++ b/tests/xfs/251
@@ -69,7 +69,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/254 b/tests/xfs/254
index f5cbbfe..c8ac412 100755
--- a/tests/xfs/254
+++ b/tests/xfs/254
@@ -70,7 +70,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_unwritten $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -82,7 +82,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/255 b/tests/xfs/255
index 7532d68..93ad13e 100755
--- a/tests/xfs/255
+++ b/tests/xfs/255
@@ -69,7 +69,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -81,7 +81,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/256 b/tests/xfs/256
index ea8bd69..d5cf71b 100755
--- a/tests/xfs/256
+++ b/tests/xfs/256
@@ -70,7 +70,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -82,7 +82,7 @@ cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/257 b/tests/xfs/257
index 05a3d25..624f5e3 100755
--- a/tests/xfs/257
+++ b/tests/xfs/257
@@ -70,7 +70,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -83,7 +83,7 @@ cowsz=$((filesize / 2))
 _sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/258 b/tests/xfs/258
index ad7cb83..243e853 100755
--- a/tests/xfs/258
+++ b/tests/xfs/258
@@ -71,7 +71,7 @@ nr=64
 filesize=$((blksz * nr))
 $XFS_IO_PROG -c "cowextsize $((blksz * 16))" $testdir >> $seqres.full
 _sweave_reflink_holes $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
@@ -84,7 +84,7 @@ cowsz=$((filesize / 2))
 _sweave_reflink_holes_delalloc $blksz $nr $testdir/file1 >> $seqres.full
 $XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file1 >> $seqres.full
 _pwrite_byte 0x63 $cowoff $cowsz $testdir/file1.chk >> $seqres.full
-_scratch_remount
+_scratch_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_scratch
-- 
2.5.0

