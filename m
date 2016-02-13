Received: from imap.thunk.org ([74.207.234.97]:34539 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 08/16] Rename _test_mount to _test_cycle_mount
Date: Sat, 13 Feb 2016 12:41:01 -0500
Message-Id: <1455385269-26319-9-git-send-email-tytso@mit.edu>
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

Currently _test_mount performs "_test_mount ; _test_umount"
so mechnically rename this function to _test_cycle_mount.  This was
done mechnically using the script fragment:

git grep -E "_test_remount" | \
	awk -F: '{print $1}' | sort -u | grep -v tests/xfs/189 \
	xargs sed -i 's/_test_remount/_test_cycle_mount/g'

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc         |  2 +-
 tests/generic/013 |  2 +-
 tests/generic/116 |  4 ++--
 tests/generic/118 |  4 ++--
 tests/generic/119 |  6 +++---
 tests/generic/121 |  4 ++--
 tests/generic/122 |  4 ++--
 tests/generic/134 |  4 ++--
 tests/generic/136 |  4 ++--
 tests/generic/137 |  2 +-
 tests/generic/138 |  4 ++--
 tests/generic/139 |  4 ++--
 tests/generic/140 |  4 ++--
 tests/generic/142 |  6 +++---
 tests/generic/143 |  6 +++---
 tests/generic/144 |  4 ++--
 tests/generic/145 |  4 ++--
 tests/generic/146 |  4 ++--
 tests/generic/147 |  4 ++--
 tests/generic/148 |  4 ++--
 tests/generic/149 |  4 ++--
 tests/generic/150 |  2 +-
 tests/generic/151 |  6 +++---
 tests/generic/152 |  6 +++---
 tests/generic/153 |  8 ++++----
 tests/generic/154 | 10 +++++-----
 tests/generic/155 | 10 +++++-----
 tests/generic/156 | 12 ++++++------
 tests/generic/178 |  4 ++--
 tests/generic/179 |  4 ++--
 tests/generic/180 |  4 ++--
 tests/generic/181 |  2 +-
 tests/generic/182 |  6 +++---
 tests/generic/303 |  2 +-
 tests/generic/304 |  2 +-
 tests/xfs/128     |  6 +++---
 tests/xfs/132     | 12 ++++++------
 37 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/common/rc b/common/rc
index 509e524..18d1a00 100644
--- a/common/rc
+++ b/common/rc
@@ -354,7 +354,7 @@ _test_unmount()
 	fi
 }
 
-_test_remount()
+_test_cycle_mount()
 {
     _test_unmount
     _test_mount
diff --git a/tests/generic/013 b/tests/generic/013
index 534c9f0..e31fe35 100755
--- a/tests/generic/013
+++ b/tests/generic/013
@@ -35,7 +35,7 @@ _cleanup()
 {
     cd /
     # we might get here with a RO FS
-    _test_remount
+    _test_cycle_mount
     # now remove fsstress directory.
     # N.B. rm(1) on IRIX can find problems when building up a long pathname
     # such that what it has is greater the 1024 chars and will
diff --git a/tests/generic/116 b/tests/generic/116
index 18f8073..620a358 100755
--- a/tests/generic/116
+++ b/tests/generic/116
@@ -56,7 +56,7 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 6)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 6)) $testdir/file2 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -68,7 +68,7 @@ echo "Reflink the middle blocks together"
 free_before=$(stat -f -c '%a' $testdir)
 _reflink_range $testdir/file1 $((blksz * 4)) $testdir/file2 \
 		$((blksz * 4)) $((blksz * 2)) >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_after=$(stat -f -c '%a' $testdir)
 echo "freesp changed by $free_before -> $free_after" >> $seqres.full
 
diff --git a/tests/generic/118 b/tests/generic/118
index 6b6478b..66dbc04 100755
--- a/tests/generic/118
+++ b/tests/generic/118
@@ -57,7 +57,7 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 6)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 $((blksz * 2)) $((blksz * 6)) $testdir/file2 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -69,7 +69,7 @@ echo "Reflink the middle blocks together"
 free_before=$(stat -f -c '%a' $testdir)
 _reflink_range $testdir/file1 $((blksz * 4)) $testdir/file2 \
 		$((blksz * 4)) $((blksz * 2)) >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_after=$(stat -f -c '%a' $testdir)
 echo "freesp changed by $free_before -> $free_after" >> $seqres.full
 
diff --git a/tests/generic/119 b/tests/generic/119
index 1a7d26e..e6a6f59 100755
--- a/tests/generic/119
+++ b/tests/generic/119
@@ -60,7 +60,7 @@ _pwrite_byte 0x61 0 $((blksz * 8)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz * 8)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x63 0 $((blksz * 8)) $testdir/file3 >> $seqres.full
 _pwrite_byte 0x64 0 $((blksz * 8)) $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -80,7 +80,7 @@ echo "Reflink the first four blocks together, 1-2 3-4"
 free_before=$(stat -f -c '%a' $testdir)
 _reflink_range $testdir/file1 0 $testdir/file2 0 $((blksz * 4)) >> $seqres.full
 _reflink_range $testdir/file3 0 $testdir/file4 0 $((blksz * 4)) >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_after=$(stat -f -c '%a' $testdir)
 echo "freesp changed by $free_before -> $free_after" >> $seqres.full
 
@@ -112,7 +112,7 @@ echo "Reflink the first two blocks together, 1-3 1-4"
 free_before=$(stat -f -c '%a' $testdir)
 _reflink_range $testdir/file1 0 $testdir/file3 0 $((blksz * 2)) >> $seqres.full
 _reflink_range $testdir/file1 0 $testdir/file4 0 $((blksz * 2)) >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_after=$(stat -f -c '%a' $testdir)
 echo "freesp changed by $free_before -> $free_after" >> $seqres.full
 
diff --git a/tests/generic/121 b/tests/generic/121
index 7d6f982..d17f047 100755
--- a/tests/generic/121
+++ b/tests/generic/121
@@ -56,7 +56,7 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 6)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 6)) $testdir/file2 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -68,7 +68,7 @@ echo "Dedupe the middle blocks together"
 free_before=$(stat -f -c '%a' $testdir)
 _dedupe_range $testdir/file1 $((blksz * 4)) $testdir/file2 \
 		$((blksz * 4)) $((blksz * 2)) >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_after=$(stat -f -c '%a' $testdir)
 echo "freesp changed by $free_before -> $free_after" >> $seqres.full
 
diff --git a/tests/generic/122 b/tests/generic/122
index d5cc3a2..9dcfa9a 100755
--- a/tests/generic/122
+++ b/tests/generic/122
@@ -56,7 +56,7 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 6)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 $((blksz * 2)) $((blksz * 6)) $testdir/file2 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -68,7 +68,7 @@ echo "(Fail to) dedupe the middle blocks together"
 free_before=$(stat -f -c '%a' $testdir)
 _dedupe_range $testdir/file1 $((blksz * 4)) $testdir/file2 \
 		$((blksz * 4)) $((blksz * 2)) >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_after=$(stat -f -c '%a' $testdir)
 echo "freesp changed by $free_before -> $free_after" >> $seqres.full
 
diff --git a/tests/generic/134 b/tests/generic/134
index b1b1fa7..8dc9988 100755
--- a/tests/generic/134
+++ b/tests/generic/134
@@ -62,7 +62,7 @@ _pwrite_byte 0x61 0 $((blksz + 37)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz + 37)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz + 37)) $testdir/file3 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz + 37)) $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -84,7 +84,7 @@ test ${c3} = ${c4} || echo "file3 and file4 should match"
 echo "Reflink the last blocks together, 1-2 1-3"
 _reflink_range $testdir/file1 $blksz $testdir/file2 $blksz 37 >> $seqres.full
 _reflink_range $testdir/file1 $blksz $testdir/file3 $blksz 37 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
diff --git a/tests/generic/136 b/tests/generic/136
index bc69fa7..c72d11f 100755
--- a/tests/generic/136
+++ b/tests/generic/136
@@ -62,7 +62,7 @@ _pwrite_byte 0x61 0 $((blksz + 37)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz + 37)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz + 37)) $testdir/file3 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz + 37)) $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -86,7 +86,7 @@ echo "1->2"
 _dedupe_range $testdir/file1 $blksz $testdir/file2 $blksz 37 >> $seqres.full
 echo "1->3"
 _dedupe_range $testdir/file1 $blksz $testdir/file3 $blksz 37 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
diff --git a/tests/generic/137 b/tests/generic/137
index 19a7ab4..a813036 100755
--- a/tests/generic/137
+++ b/tests/generic/137
@@ -86,7 +86,7 @@ seq 1 $((nr_blks / 7)) | while read nr; do
 			$((nr * 7 * blksz)) $blksz >> $seqres.full 2>&1
 done
 
-_test_remount
+_test_cycle_mount
 
 echo "Check block mappings"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/138 b/tests/generic/138
index c8b4255..f8a3197 100755
--- a/tests/generic/138
+++ b/tests/generic/138
@@ -59,7 +59,7 @@ blksz=65536
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
@@ -79,7 +79,7 @@ _pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file3 >> $seqres.full
 
 _pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file3 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/139 b/tests/generic/139
index 989b054..ef66034 100755
--- a/tests/generic/139
+++ b/tests/generic/139
@@ -60,7 +60,7 @@ blksz=65536
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
@@ -80,7 +80,7 @@ _pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file3 -d >> $seqres.full
 
 _pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file2 -d >> $seqres.full
 _pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file3 -d >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/140 b/tests/generic/140
index 5bcd4ef..bf95ec1 100755
--- a/tests/generic/140
+++ b/tests/generic/140
@@ -59,7 +59,7 @@ blksz=65536
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
@@ -79,7 +79,7 @@ _mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file3 >>
 
 _mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
 _mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/142 b/tests/generic/142
index e9a2d5e..d19725f 100755
--- a/tests/generic/142
+++ b/tests/generic/142
@@ -61,7 +61,7 @@ blksz=65536
 nr=9
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 csum=$(_md5_checksum $testdir/file1)
@@ -70,13 +70,13 @@ echo "Create the reflink copies"
 seq 2 $nr | while read i; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 
 echo "Rewrite the copies"
 seq 2 $nr | while read i; do
 	_pwrite_byte 0x62 0 $((blksz * 256)) $testdir/file$i >> $seqres.full
 done
-_test_remount
+_test_cycle_mount
 
 echo "Examine original file"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/143 b/tests/generic/143
index 703b585..8c4f9ce 100755
--- a/tests/generic/143
+++ b/tests/generic/143
@@ -62,7 +62,7 @@ blksz=65536
 nr=9
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 csum=$(_md5_checksum $testdir/file1)
@@ -71,13 +71,13 @@ echo "Create the reflink copies"
 seq 2 $nr | while read i; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 
 echo "Rewrite the copies"
 seq 2 $nr | while read i; do
 	_pwrite_byte 0x62 0 $((blksz * 256)) $testdir/file$i -d >> $seqres.full
 done
-_test_remount
+_test_cycle_mount
 
 echo "Examine original file"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/144 b/tests/generic/144
index 71020ab..dbbe169 100755
--- a/tests/generic/144
+++ b/tests/generic/144
@@ -72,7 +72,7 @@ _reflink_range $testdir/file1 $((blksz * 3)) $testdir/file4 $((blksz * 3)) \
 		$blksz >> $seqres.full
 
 _cp_reflink $testdir/file1 $testdir/file5
-_test_remount
+_test_cycle_mount
 
 echo "Compare sections"
 md5sum $testdir/file1 | _filter_test_dir
@@ -116,7 +116,7 @@ echo "falloc everything"
 $XFS_IO_PROG -f -c "falloc 0 $((blksz * 5))" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "falloc 0 $((blksz * 5))" $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -f -c "falloc 0 $((blksz * 5))" $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/145 b/tests/generic/145
index dac2b27..93d3839 100755
--- a/tests/generic/145
+++ b/tests/generic/145
@@ -83,7 +83,7 @@ _pwrite_byte 0x00 $((blksz * 2)) $blksz $testdir/file3.chk >> $seqres.full
 _pwrite_byte 0x61 0 $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x62 $blksz $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz * 2)) $blksz $testdir/file4.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -109,7 +109,7 @@ echo "fcollapse files"
 $XFS_IO_PROG -f -c "fcollapse 0 $blksz" $testdir/file2
 $XFS_IO_PROG -f -c "fcollapse $blksz $blksz" $testdir/file3
 $XFS_IO_PROG -f -c "fcollapse $((blksz * 2)) $blksz" $testdir/file4
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/146 b/tests/generic/146
index 98f0621..b1013f8 100755
--- a/tests/generic/146
+++ b/tests/generic/146
@@ -77,7 +77,7 @@ _pwrite_byte 0x63 $((blksz * 2)) $blksz $testdir/file3.chk >> $seqres.full
 _pwrite_byte 0x61 0 $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x62 $blksz $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz * 2)) $blksz $testdir/file4.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -103,7 +103,7 @@ echo "fpunch files"
 $XFS_IO_PROG -f -c "fpunch 0 $blksz" $testdir/file2
 $XFS_IO_PROG -f -c "fpunch $blksz $blksz" $testdir/file3
 $XFS_IO_PROG -f -c "fpunch $((blksz * 2)) $blksz" $testdir/file4
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/147 b/tests/generic/147
index 8706f83..a1f59a0 100755
--- a/tests/generic/147
+++ b/tests/generic/147
@@ -80,7 +80,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x62 $blksz $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz * 2)) $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x63 $((blksz * 3)) $blksz $testdir/file4.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -106,7 +106,7 @@ echo "finsert files"
 $XFS_IO_PROG -f -c "finsert 0 $blksz" $testdir/file2
 $XFS_IO_PROG -f -c "finsert $blksz $blksz" $testdir/file3
 $XFS_IO_PROG -f -c "finsert $((blksz * 2)) $blksz" $testdir/file4
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/148 b/tests/generic/148
index af60ab8..31e7ebe 100755
--- a/tests/generic/148
+++ b/tests/generic/148
@@ -71,7 +71,7 @@ _pwrite_byte 0x62 $blksz 34 $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x61 0 $blksz $testdir/file3.chk >> $seqres.full
 _pwrite_byte 0x62 $blksz 37 $testdir/file3.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz + 37)) 3 $testdir/file3.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -90,7 +90,7 @@ test ${c2} = ${c3} || echo "file2 and file3 should match"
 echo "truncate files"
 $XFS_IO_PROG -f -c "truncate $((blksz + 34))" $testdir/file2
 $XFS_IO_PROG -f -c "truncate $((blksz + 40))" $testdir/file3
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/149 b/tests/generic/149
index b5f9f4a..0f13b79 100755
--- a/tests/generic/149
+++ b/tests/generic/149
@@ -77,7 +77,7 @@ _pwrite_byte 0x63 $((blksz * 2)) $blksz $testdir/file3.chk >> $seqres.full
 _pwrite_byte 0x61 0 $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x62 $blksz $blksz $testdir/file4.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz * 2)) $blksz $testdir/file4.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -103,7 +103,7 @@ echo "fzero files"
 $XFS_IO_PROG -f -c "fzero 0 $blksz" $testdir/file2
 $XFS_IO_PROG -f -c "fzero $blksz $blksz" $testdir/file3
 $XFS_IO_PROG -f -c "fzero $((blksz * 2)) $blksz" $testdir/file4
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/150 b/tests/generic/150
index 88814b1..2e21d37 100755
--- a/tests/generic/150
+++ b/tests/generic/150
@@ -69,7 +69,7 @@ echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file.$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 _within_tolerance "free blocks after reflink" $free_blocks1 $free_blocks0 $margin -v
diff --git a/tests/generic/151 b/tests/generic/151
index 207378c..55e0e02 100755
--- a/tests/generic/151
+++ b/tests/generic/151
@@ -74,17 +74,17 @@ for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file.$i
 done
 _cp_reflink $testdir/file1 $testdir/survivor
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 echo "Delete most of the files"
 rm -rf $testdir/file*
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 echo "Delete all the files"
 rm -rf $testdir/*
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3
 
diff --git a/tests/generic/152 b/tests/generic/152
index b221f8f..9fe4d32 100755
--- a/tests/generic/152
+++ b/tests/generic/152
@@ -74,14 +74,14 @@ echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 echo "Punch most of the blocks"
 $XFS_IO_PROG -f -c "fpunch 0 $sz" $testdir/file2
 $XFS_IO_PROG -f -c "fpunch 0 $((sz / 2))" $testdir/file3
 $XFS_IO_PROG -f -c "fpunch $((sz / 2)) $((sz / 2))" $testdir/file4
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 echo "Punch all the files"
@@ -89,7 +89,7 @@ for i in `seq 2 $nr`; do
 	$XFS_IO_PROG -f -c "fpunch 0 $sz" $testdir/file$i
 done
 $XFS_IO_PROG -f -c "fpunch 0 $sz" $testdir/file1
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3
 
diff --git a/tests/generic/153 b/tests/generic/153
index 550aa95..5d22153 100755
--- a/tests/generic/153
+++ b/tests/generic/153
@@ -68,27 +68,27 @@ free_blocks0=$(stat -f $testdir -c '%f')
 nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 echo "Collapse most of the blocks"
 $XFS_IO_PROG -f -c "fcollapse 0 $(((blks - 1) * blksz))" $testdir/file2
 $XFS_IO_PROG -f -c "fcollapse 0 $((sz / 2))" $testdir/file3
 $XFS_IO_PROG -f -c "fcollapse $((sz / 2)) $(( ((blks / 2) - 1) * blksz))" $testdir/file4
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 echo "Collpase nearly all the files"
 $XFS_IO_PROG -f -c "fcollapse 0 $(( ((blks / 2) - 1) * blksz))" $testdir/file3
 $XFS_IO_PROG -f -c "fcollapse 0 $((sz / 2))" $testdir/file4
 $XFS_IO_PROG -f -c "fcollapse 0 $(( (blks - 1) * blksz))" $testdir/file1
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3
 
diff --git a/tests/generic/154 b/tests/generic/154
index c0c3142..23b626b 100755
--- a/tests/generic/154
+++ b/tests/generic/154
@@ -67,32 +67,32 @@ nr=4
 filesize=$((blksz * nr))
 sz=$((blks * blksz))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 echo "Rewrite some of the blocks"
 _pwrite_byte 0x62 0 $sz $testdir/file2 >> $seqres.full
 _pwrite_byte 0x63 0 $((sz / 2)) $testdir/file3 >> $seqres.full
 _pwrite_byte 0x64 $((sz / 2)) $((sz / 2)) $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 echo "Rewrite all the files"
 _pwrite_byte 0x62 0 $sz $testdir/file2 >> $seqres.full
 _pwrite_byte 0x63 0 $sz $testdir/file3 >> $seqres.full
 _pwrite_byte 0x64 0 $sz $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 
 echo "Rewrite the original file"
 _pwrite_byte 0x65 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks4=$(stat -f $testdir -c '%f')
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3 $free_blocks4
 
diff --git a/tests/generic/155 b/tests/generic/155
index e96bda7..50083e7 100755
--- a/tests/generic/155
+++ b/tests/generic/155
@@ -72,32 +72,32 @@ free_blocks0=$(stat -f $testdir -c '%f')
 nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 echo "Rewrite some of the blocks"
 $XFS_IO_PROG -f -c "fzero 0 $sz" $testdir/file2 >> $seqres.full
 _pwrite_byte 0x63 0 $((sz / 2)) $testdir/file3 -d >> $seqres.full
 _mwrite_byte 0x64 $((sz / 2)) $((sz / 2)) $sz $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 echo "Rewrite all the files"
 _pwrite_byte 0x62 0 $sz $testdir/file2 -d >> $seqres.full
 _mwrite_byte 0x63 0 $sz $sz $testdir/file3 >> $seqres.full
 $XFS_IO_PROG -f -c "fzero 0 $sz" $testdir/file4 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 
 echo "Rewrite the original file"
 _pwrite_byte 0x65 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks4=$(stat -f $testdir -c '%f')
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3 $free_blocks4
 
diff --git a/tests/generic/156 b/tests/generic/156
index de2d9b1..52ac11f 100755
--- a/tests/generic/156
+++ b/tests/generic/156
@@ -79,34 +79,34 @@ free_blocks0=$(stat -f $testdir -c '%f')
 nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 echo "funshare part of a file"
 $XFS_IO_PROG -f -c "falloc 0 $((sz / 2))" $testdir/file2
-_test_remount
+_test_cycle_mount
 
 echo "funshare some of the copies"
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file2
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file3
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 echo "funshare the rest of the files"
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file4
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file1
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 
 echo "Rewrite the original file"
 _pwrite_byte 0x65 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks4=$(stat -f $testdir -c '%f')
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3 $free_blocks4
 
diff --git a/tests/generic/178 b/tests/generic/178
index 68432e7..7540802 100755
--- a/tests/generic/178
+++ b/tests/generic/178
@@ -59,7 +59,7 @@ filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $filesize $testdir/file1 >> $seqres.full
 
 _cp_reflink $testdir/file1 $testdir/file2
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -67,7 +67,7 @@ md5sum $testdir/file2 | _filter_test_dir
 echo "Write and punch"
 _pwrite_byte 0x62 0 $((blksz * 256)) $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "fpunch $blksz $((blksz * 254))" $testdir/file2
-_test_remount
+_test_cycle_mount
 
 echo "Compare results"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/179 b/tests/generic/179
index 27c25e7..c0ea70f 100755
--- a/tests/generic/179
+++ b/tests/generic/179
@@ -63,7 +63,7 @@ _cp_reflink $testdir/file1 $testdir/file2
 
 _pwrite_byte 0x61 0 $((blksz * 3)) $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz - 17)) $((blksz + 17)) $testdir/file2.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -76,7 +76,7 @@ test ${c1} = ${c2} || echo "file1 and file2 should match"
 
 echo "fpunch files"
 $XFS_IO_PROG -f -c "fpunch $((blksz - 17)) $((blksz + 17))" $testdir/file2
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/180 b/tests/generic/180
index a0f30a2..af2abf9 100755
--- a/tests/generic/180
+++ b/tests/generic/180
@@ -63,7 +63,7 @@ _cp_reflink $testdir/file1 $testdir/file2
 
 _pwrite_byte 0x61 0 $((blksz * 3)) $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x00 $((blksz - 17)) $((blksz + 17)) $testdir/file2.chk >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -76,7 +76,7 @@ test ${c1} = ${c2} || echo "file1 and file2 should match"
 
 echo "fzero files"
 $XFS_IO_PROG -f -c "fzero $((blksz - 17)) $((blksz + 17))" $testdir/file2
-_test_remount
+_test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
diff --git a/tests/generic/181 b/tests/generic/181
index 9c640e4..bd884df 100755
--- a/tests/generic/181
+++ b/tests/generic/181
@@ -61,7 +61,7 @@ _pwrite_byte 0x62 0 $((blksz * 256)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz * 2)) $testdir/file2.chk >> $seqres.full
 _pwrite_byte 0x61 $((blksz * 2)) $((blksz * 255)) $testdir/file2.chk >> $seqres.full
 _reflink_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) 0 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
diff --git a/tests/generic/182 b/tests/generic/182
index fddacc4..f484399 100755
--- a/tests/generic/182
+++ b/tests/generic/182
@@ -59,7 +59,7 @@ _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz * 257)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x62 0 $((blksz * 257)) $testdir/file2.chk >> $seqres.full
 _dedupe_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) 0 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -78,7 +78,7 @@ _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file2.chk >> $seqres.full
 _dedupe_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) 0 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
@@ -97,7 +97,7 @@ _pwrite_byte 0x61 0 $((blksz * 256)) $testdir/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 257)) $testdir/file2 >> $seqres.full
 _pwrite_byte 0x61 0 $((blksz * 257)) $testdir/file2.chk >> $seqres.full
 _dedupe_range $testdir/file1 $blksz $testdir/file2 $((blksz * 2)) 0 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
diff --git a/tests/generic/303 b/tests/generic/303
index 2283b5e..3c84008 100755
--- a/tests/generic/303
+++ b/tests/generic/303
@@ -83,7 +83,7 @@ echo "Reflink with huge off/len (should fail)"
 _reflink_range $testdir/file2 $bigoff_64k $testdir/file9 0 $bigoff_64k >> $seqres.full
 
 echo "Check file creation"
-_test_remount
+_test_cycle_mount
 echo "file3"
 $XFS_IO_PROG -c "pread -v -q $bigoff 1" $testdir/file3
 echo "file4"
diff --git a/tests/generic/304 b/tests/generic/304
index e50fc2a..b7ee7b9 100755
--- a/tests/generic/304
+++ b/tests/generic/304
@@ -84,7 +84,7 @@ echo "Dedupe with huge off/len (should fail)"
 _dedupe_range $testdir/file2 $bigoff_64k $testdir/file9 0 $bigoff_64k >> $seqres.full
 
 echo "Check file creation"
-_test_remount
+_test_cycle_mount
 echo "file3"
 $XFS_IO_PROG -c "pread -v -q $bigoff 1" $testdir/file3
 echo "file4"
diff --git a/tests/xfs/128 b/tests/xfs/128
index 56778fc..68f6f94 100755
--- a/tests/xfs/128
+++ b/tests/xfs/128
@@ -66,7 +66,7 @@ _pwrite_byte 0x61 0 $((blks * blksz)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2
 _cp_reflink $testdir/file2 $testdir/file3
 _cp_reflink $testdir/file3 $testdir/file4
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 
 md5sum $testdir/file1 | _filter_scratch
@@ -82,7 +82,7 @@ c04=$(_md5_checksum $testdir/file4)
 echo "CoW the reflink copies"
 _pwrite_byte 0x62 $blksz $blksz $testdir/file2 >> $seqres.full
 _pwrite_byte 0x63 $(( blksz * (blks - 1) )) $blksz $testdir/file3 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 
 md5sum $testdir/file1 | _filter_scratch
@@ -101,7 +101,7 @@ xfs_fsr -v -d $testdir/file1 >> $seqres.full
 xfs_fsr -v -d $testdir/file2 >> $seqres.full # fsr probably breaks the link
 xfs_fsr -v -d $testdir/file3 >> $seqres.full # fsr probably breaks the link
 xfs_fsr -v -d $testdir/file4 >> $seqres.full # fsr probably ignores this file
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 
 md5sum $testdir/file1 | _filter_scratch
diff --git a/tests/xfs/132 b/tests/xfs/132
index cf3d645..f174b3f 100755
--- a/tests/xfs/132
+++ b/tests/xfs/132
@@ -80,38 +80,38 @@ free_blocks0=$(stat -f $testdir -c '%f')
 nr=4
 filesize=$((blksz * nr))
 _pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 
 echo "Create the reflink copies"
 for i in `seq 2 $nr`; do
 	_cp_reflink $testdir/file1 $testdir/file$i
 done
-_test_remount
+_test_cycle_mount
 free_blocks1=$(stat -f $testdir -c '%f')
 lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
 
 echo "funshare part of a file"
 $XFS_IO_PROG -f -c "falloc 0 $((sz / 2))" $testdir/file2
-_test_remount
+_test_cycle_mount
 lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
 
 echo "funshare some of the copies"
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file2
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file3
-_test_remount
+_test_cycle_mount
 free_blocks2=$(stat -f $testdir -c '%f')
 lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
 
 echo "funshare the rest of the files"
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file4
 $XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file1
-_test_remount
+_test_cycle_mount
 free_blocks3=$(stat -f $testdir -c '%f')
 lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
 
 echo "Rewrite the original file"
 _pwrite_byte 0x65 0 $sz $testdir/file1 >> $seqres.full
-_test_remount
+_test_cycle_mount
 free_blocks4=$(stat -f $testdir -c '%f')
 lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
 #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3 $free_blocks4
-- 
2.5.0

