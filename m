From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs: Fix the situation that mount operation rejects corrupted XFS
Date: Tue, 20 Nov 2018 19:58:28 +0800
Message-ID: <1542715108-8539-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On upstream kernel, running some tests which corrupt XFS on purpose
got the mismatched output. e.g. running xfs/087:
------------------------------------------------
 + check fs
 + corrupt image
 + mount image
-+ modify files
-broken: 1
 + repair fs
 + mount image (2)
------------------------------------------------

It is reasonable for corrupted XFS to be caught and rejected by mount
or read/write operation.

Fixes: 0828657542ea ("xfs: fix blocktrash fuzzers")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/086     |  3 +--
 tests/xfs/086.out |  3 +--
 tests/xfs/087     |  9 ++++-----
 tests/xfs/087.out |  3 +--
 tests/xfs/088     |  3 +--
 tests/xfs/088.out |  3 +--
 tests/xfs/089     |  3 +--
 tests/xfs/089.out |  3 +--
 tests/xfs/091     |  3 +--
 tests/xfs/091.out |  3 +--
 tests/xfs/093     |  9 ++++-----
 tests/xfs/093.out |  3 +--
 tests/xfs/097     |  8 ++++----
 tests/xfs/097.out |  3 +--
 tests/xfs/099     |  3 +--
 tests/xfs/099.out |  3 +--
 tests/xfs/100     |  3 +--
 tests/xfs/100.out |  3 +--
 tests/xfs/101     |  3 +--
 tests/xfs/101.out |  3 +--
 tests/xfs/102     |  3 +--
 tests/xfs/102.out |  3 +--
 tests/xfs/105     |  3 +--
 tests/xfs/105.out |  3 +--
 tests/xfs/112     |  3 +--
 tests/xfs/112.out |  3 +--
 tests/xfs/113     |  3 +--
 tests/xfs/113.out |  3 +--
 tests/xfs/117     | 11 +++++------
 tests/xfs/117.out |  3 +--
 tests/xfs/120     |  3 +--
 tests/xfs/120.out |  3 +--
 tests/xfs/124     |  3 +--
 tests/xfs/124.out |  3 +--
 tests/xfs/125     |  3 +--
 tests/xfs/125.out |  3 +--
 tests/xfs/126     |  3 +--
 tests/xfs/126.out |  3 +--
 tests/xfs/235     |  3 +--
 tests/xfs/235.out |  3 +--
 tests/xfs/337     |  3 +--
 tests/xfs/337.out |  3 +--
 42 files changed, 55 insertions(+), 96 deletions(-)

diff --git a/tests/xfs/086 b/tests/xfs/086
index 2a8df3a..8602a56 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -77,10 +77,9 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 done
 
 # Try to append to files; this should fail
-echo "+ mount image"
+echo "+ mount image && modify files"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
 	for x in `seq 1 64`; do
 		$XFS_IO_PROG -f -c "pwrite -S 0x62 0 ${blksz}" "${TESTFILE}.${x}" >> $seqres.full
 	done
diff --git a/tests/xfs/086.out b/tests/xfs/086.out
index 6c053f4..261f0c9 100644
--- a/tests/xfs/086.out
+++ b/tests/xfs/086.out
@@ -4,8 +4,7 @@ QA output created by 086
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 + repair fs
 + mount image
 + chattr -R -i
diff --git a/tests/xfs/087 b/tests/xfs/087
index 625ed35..ede8e44 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -75,17 +75,16 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 	_scratch_xfs_db -x -c "agi ${ag}" -c "agi ${ag}" -c "stack" -c "blocktrash -x 32 -o +64 -y 4096 -z ${FUZZ_ARGS}" >> $seqres.full 2>&1
 done
 
-echo "+ mount image"
+echo "+ mount image && modify files"
+broken=1
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
-	broken=0
 	for x in `seq 65 70`; do
-		touch "${TESTFILE}.${x}" 2> /dev/null || broken=1
+		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
 	done
-	echo "broken: ${broken}"
 	umount "${SCRATCH_MNT}"
 fi
+echo "broken: ${broken}"
 
 echo "+ repair fs"
 _scratch_xfs_repair >> $seqres.full 2>&1
diff --git a/tests/xfs/087.out b/tests/xfs/087.out
index 1f6e0b5..d64754f 100644
--- a/tests/xfs/087.out
+++ b/tests/xfs/087.out
@@ -4,8 +4,7 @@ QA output created by 087
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 broken: 1
 + repair fs
 + mount image (2)
diff --git a/tests/xfs/088 b/tests/xfs/088
index df5b051..6f36efa 100755
--- a/tests/xfs/088
+++ b/tests/xfs/088
@@ -76,10 +76,9 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 done
 
 # Try to append to files; this should fail
-echo "+ mount image"
+echo "+ mount image && modify files"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
 	for x in `seq 1 64`; do
 		$XFS_IO_PROG -f -c "pwrite -S 0x62 0 ${blksz}" "${TESTFILE}.${x}" >> $seqres.full
 	done
diff --git a/tests/xfs/088.out b/tests/xfs/088.out
index f083d3a..cba64af 100644
--- a/tests/xfs/088.out
+++ b/tests/xfs/088.out
@@ -4,8 +4,7 @@ QA output created by 088
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 + repair fs
 + mount image
 + chattr -R -i
diff --git a/tests/xfs/089 b/tests/xfs/089
index e905e21..5c39829 100755
--- a/tests/xfs/089
+++ b/tests/xfs/089
@@ -76,10 +76,9 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 done
 
 # Try to append to files; this should fail
-echo "+ mount image"
+echo "+ mount image && modify files"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
 	for x in `seq 1 64`; do
 		$XFS_IO_PROG -f -c "pwrite -S 0x62 0 ${blksz}" "${TESTFILE}.${x}" >> $seqres.full
 	done
diff --git a/tests/xfs/089.out b/tests/xfs/089.out
index 722bcdf..f35cc5a 100644
--- a/tests/xfs/089.out
+++ b/tests/xfs/089.out
@@ -4,8 +4,7 @@ QA output created by 089
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 + repair fs
 + mount image
 + chattr -R -i
diff --git a/tests/xfs/091 b/tests/xfs/091
index 22c8779..5d6cd36 100755
--- a/tests/xfs/091
+++ b/tests/xfs/091
@@ -76,10 +76,9 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 done
 
 # Try to append to files; this should fail
-echo "+ mount image"
+echo "+ mount image && modify files"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
 	for x in `seq 1 64`; do
 		$XFS_IO_PROG -f -c "pwrite -S 0x62 0 ${blksz}" "${TESTFILE}.${x}" >> $seqres.full
 	done
diff --git a/tests/xfs/091.out b/tests/xfs/091.out
index d557023..a61a57b 100644
--- a/tests/xfs/091.out
+++ b/tests/xfs/091.out
@@ -4,8 +4,7 @@ QA output created by 091
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 + repair fs
 + mount image
 + chattr -R -i
diff --git a/tests/xfs/093 b/tests/xfs/093
index 3e1821a..2b16020 100755
--- a/tests/xfs/093
+++ b/tests/xfs/093
@@ -75,17 +75,16 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 	_scratch_xfs_db -x -c "agi ${ag}" -c "agi ${ag}" -c "addr root" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full 2>&1
 done
 
-echo "+ mount image"
+echo "+ mount image && modify files"
+broken=1
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
-	broken=0
 	for x in `seq 65 70`; do
-		touch "${TESTFILE}.${x}" 2> /dev/null || broken=1
+		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
 	done
-	echo "broken: ${broken}"
 	umount "${SCRATCH_MNT}"
 fi
+echo "broken: ${broken}"
 
 echo "+ repair fs"
 _scratch_xfs_repair >> $seqres.full 2>&1
diff --git a/tests/xfs/093.out b/tests/xfs/093.out
index 74b773c..4b59e3b 100644
--- a/tests/xfs/093.out
+++ b/tests/xfs/093.out
@@ -4,8 +4,7 @@ QA output created by 093
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 broken: 1
 + repair fs
 + mount image (2)
diff --git a/tests/xfs/097 b/tests/xfs/097
index 174aee0..db355de 100755
--- a/tests/xfs/097
+++ b/tests/xfs/097
@@ -78,17 +78,17 @@ for ag in $(seq 1 $((agcount - 1))) 0; do
 	_scratch_xfs_db -x -c "agi ${ag}" -c "agi ${ag}" -c "addr free_root" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full 2>&1
 done
 
-echo "+ mount image"
+echo "+ mount image && modify files"
+broken=1
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
 	broken=0
 	for x in `seq 65 70`; do
-		touch "${TESTFILE}.${x}" 2> /dev/null || broken=1
+		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
 	done
-	echo "broken: ${broken}"
 	umount "${SCRATCH_MNT}"
 fi
+echo "broken: ${broken}"
 
 echo "+ repair fs"
 _scratch_xfs_repair >> $seqres.full 2>&1
diff --git a/tests/xfs/097.out b/tests/xfs/097.out
index 84f6a70..7d2b486 100644
--- a/tests/xfs/097.out
+++ b/tests/xfs/097.out
@@ -4,8 +4,7 @@ QA output created by 097
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 broken: 1
 + repair fs
 + mount image (2)
diff --git a/tests/xfs/099 b/tests/xfs/099
index f5750be..a806444 100755
--- a/tests/xfs/099
+++ b/tests/xfs/099
@@ -66,10 +66,9 @@ __populate_check_xfs_dir "${inode}" block
 echo "+ corrupt dir"
 _scratch_xfs_db -x -c "inode ${inode}" -c 'dblock 0' -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/099.out b/tests/xfs/099.out
index 773200b..38d6773 100644
--- a/tests/xfs/099.out
+++ b/tests/xfs/099.out
@@ -5,8 +5,7 @@ QA output created by 099
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/100 b/tests/xfs/100
index 6b9ca53..b75e0bd 100755
--- a/tests/xfs/100
+++ b/tests/xfs/100
@@ -71,10 +71,9 @@ while true; do
 	loff="$((loff + 1))"
 done
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/100.out b/tests/xfs/100.out
index 97dba7c..488338d 100644
--- a/tests/xfs/100.out
+++ b/tests/xfs/100.out
@@ -5,8 +5,7 @@ QA output created by 100
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/101 b/tests/xfs/101
index 57983a8..069a248 100755
--- a/tests/xfs/101
+++ b/tests/xfs/101
@@ -66,10 +66,9 @@ __populate_check_xfs_dir "${inode}" leaf
 echo "+ corrupt dir"
 _scratch_xfs_db -x -c "inode ${inode}" -c "dblock ${leaf_lblk}" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/101.out b/tests/xfs/101.out
index 22ca620..df60f0a 100644
--- a/tests/xfs/101.out
+++ b/tests/xfs/101.out
@@ -5,8 +5,7 @@ QA output created by 101
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/102 b/tests/xfs/102
index 9920bad..aafe626 100755
--- a/tests/xfs/102
+++ b/tests/xfs/102
@@ -71,10 +71,9 @@ while true; do
 	loff="$((loff + 1))"
 done
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/102.out b/tests/xfs/102.out
index d8a8fa1..476ca0e 100644
--- a/tests/xfs/102.out
+++ b/tests/xfs/102.out
@@ -5,8 +5,7 @@ QA output created by 102
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/105 b/tests/xfs/105
index fe45134..8c2cf3b 100755
--- a/tests/xfs/105
+++ b/tests/xfs/105
@@ -71,10 +71,9 @@ while true; do
 	loff="$((loff + 1))"
 done
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/105.out b/tests/xfs/105.out
index d8510a0..f2969f4 100644
--- a/tests/xfs/105.out
+++ b/tests/xfs/105.out
@@ -5,8 +5,7 @@ QA output created by 105
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/112 b/tests/xfs/112
index 0bd6850..a69e915 100755
--- a/tests/xfs/112
+++ b/tests/xfs/112
@@ -71,10 +71,9 @@ while true; do
 	loff="$((loff + 1))"
 done
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/112.out b/tests/xfs/112.out
index be0e61f..07b7611 100644
--- a/tests/xfs/112.out
+++ b/tests/xfs/112.out
@@ -5,8 +5,7 @@ QA output created by 112
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/113 b/tests/xfs/113
index 9394a25..ff3beec 100755
--- a/tests/xfs/113
+++ b/tests/xfs/113
@@ -71,10 +71,9 @@ while true; do
 	loff="$((loff + 1))"
 done
 
-echo "+ mount image"
+echo "+ mount image && modify dir"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify dir"
 	rm -rf "${SCRATCH_MNT}/blockdir/00000000" 2> /dev/null && _fail "modified corrupt directory"
 	mkdir "${SCRATCH_MNT}/blockdir/xxxxxxxx" 2> /dev/null && _fail "add to corrupt directory"
 	umount "${SCRATCH_MNT}"
diff --git a/tests/xfs/113.out b/tests/xfs/113.out
index 0b59fe8..54422e7 100644
--- a/tests/xfs/113.out
+++ b/tests/xfs/113.out
@@ -5,8 +5,7 @@ QA output created by 113
 + check fs
 + check dir
 + corrupt dir
-+ mount image
-+ modify dir
++ mount image && modify dir
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/117 b/tests/xfs/117
index 8c1ab63..0a7831d 100755
--- a/tests/xfs/117
+++ b/tests/xfs/117
@@ -74,20 +74,19 @@ seq "${inode}" "$((inode + 64))" | while read ino; do
 	_scratch_xfs_db -x -c "inode ${ino}" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full 2>&1
 done
 
-echo "+ mount image"
+echo "+ mount image && modify files"
+broken=1
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
-	broken=0
 	for x in `seq 1 64`; do
 		stat "${TESTFILE}.${x}" >> $seqres.full 2>&1
-		test $? -ne 0 && broken=1
+		test $? -eq 0 && broken=0
 		touch "${TESTFILE}.${x}" >> $seqres.full 2>&1
-		test $? -ne 0 && broken=1
+		test $? -eq 0 && broken=0
 	done
-	echo "broken: ${broken}"
 	umount "${SCRATCH_MNT}"
 fi
+echo "broken: ${broken}"
 
 echo "+ repair fs"
 _scratch_xfs_repair >> $seqres.full 2>&1
diff --git a/tests/xfs/117.out b/tests/xfs/117.out
index c8be150..b6b114e 100644
--- a/tests/xfs/117.out
+++ b/tests/xfs/117.out
@@ -4,8 +4,7 @@ QA output created by 117
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 broken: 1
 + repair fs
 + mount image (2)
diff --git a/tests/xfs/120 b/tests/xfs/120
index 9bdcc7b..8965ca0 100755
--- a/tests/xfs/120
+++ b/tests/xfs/120
@@ -63,10 +63,9 @@ _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail
 echo "+ corrupt image"
 _scratch_xfs_db -x -c "inode ${inode}" -c "addr u.bmbt.ptrs[1]" -c "addr u3.bmbt.ptrs[1]" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
 
-echo "+ mount image"
+echo "+ mount image && modify files"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify files"
 	before="$(stat -c '%b' "${SCRATCH_MNT}/bigfile")"
 	$XFS_IO_PROG -f -c "pwrite -S 0x62 ${blksz} ${blksz}" -c 'fsync' "${SCRATCH_MNT}/bigfile" >> $seqres.full 2> /dev/null
 	after="$(stat -c '%b' "${SCRATCH_MNT}/bigfile")"
diff --git a/tests/xfs/120.out b/tests/xfs/120.out
index 18e2329..7191a68 100644
--- a/tests/xfs/120.out
+++ b/tests/xfs/120.out
@@ -4,8 +4,7 @@ QA output created by 120
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ modify files
++ mount image && modify files
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/124 b/tests/xfs/124
index 41f9827..e605d30 100755
--- a/tests/xfs/124
+++ b/tests/xfs/124
@@ -71,10 +71,9 @@ _scratch_xfs_db -x -c "inode ${inode}" -c "ablock ${node_lblk}" -c "stack" | gre
 echo "+ corrupt xattr"
 _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
 
-echo "+ mount image"
+echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
diff --git a/tests/xfs/124.out b/tests/xfs/124.out
index c11f7dd..81a1192 100644
--- a/tests/xfs/124.out
+++ b/tests/xfs/124.out
@@ -5,8 +5,7 @@ QA output created by 124
 + check fs
 + check xattr
 + corrupt xattr
-+ mount image
-+ modify xattr
++ mount image && modify xattr
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/125 b/tests/xfs/125
index 1dbe966..bda8bc3 100755
--- a/tests/xfs/125
+++ b/tests/xfs/125
@@ -71,10 +71,9 @@ _scratch_xfs_db -x -c "inode ${inode}" -c "ablock 1" -c "stack" | grep -q 'file
 echo "+ corrupt xattr"
 _scratch_xfs_db -x -c "inode ${inode}" -c 'ablock 0' -c "stack" -c "blocktrash -x 32 -o +32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
 
-echo "+ mount image"
+echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
diff --git a/tests/xfs/125.out b/tests/xfs/125.out
index 88e5a3e..085625b 100644
--- a/tests/xfs/125.out
+++ b/tests/xfs/125.out
@@ -5,8 +5,7 @@ QA output created by 125
 + check fs
 + check xattr
 + corrupt xattr
-+ mount image
-+ modify xattr
++ mount image && modify xattr
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/126 b/tests/xfs/126
index e5a2d9e..4f9f8cf 100755
--- a/tests/xfs/126
+++ b/tests/xfs/126
@@ -76,10 +76,9 @@ while true; do
 	loff="$((loff + 1))"
 done
 
-echo "+ mount image"
+echo "+ mount image && modify xattr"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ modify xattr"
 	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
 	umount "${SCRATCH_MNT}"
 fi
diff --git a/tests/xfs/126.out b/tests/xfs/126.out
index 278cc97..5a5bc0a 100644
--- a/tests/xfs/126.out
+++ b/tests/xfs/126.out
@@ -5,8 +5,7 @@ QA output created by 126
 + check fs
 + check xattr
 + corrupt xattr
-+ mount image
-+ modify xattr
++ mount image && modify xattr
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/235 b/tests/xfs/235
index 97db55c..669f58b 100755
--- a/tests/xfs/235
+++ b/tests/xfs/235
@@ -61,10 +61,9 @@ seq 0 $((agcount - 1)) | while read ag; do
 		>> $seqres.full 2>&1
 done
 
-echo "+ mount image"
+echo "+ mount image && copy more"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ copy more"
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 0 $((blksz * 64))" -c "fsync" ${SCRATCH_MNT}/file4 >> $seqres.full 2>&1
 	test -s ${SCRATCH_MNT}/file4 && _fail "should not be able to copy with busted rmap btree"
 	umount ${SCRATCH_MNT}
diff --git a/tests/xfs/235.out b/tests/xfs/235.out
index 7640224..7d402fe 100644
--- a/tests/xfs/235.out
+++ b/tests/xfs/235.out
@@ -4,8 +4,7 @@ QA output created by 235
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ copy more
++ mount image && copy more
 + repair fs
 + mount image (2)
 + chattr -R -i
diff --git a/tests/xfs/337 b/tests/xfs/337
index 37898ad..db1b4a2 100755
--- a/tests/xfs/337
+++ b/tests/xfs/337
@@ -70,10 +70,9 @@ _scratch_xfs_db -x -c "sb" -c "addr rrmapino" -c "addr u3.rtrmapbt.ptrs[1]" \
 	-c "stack" -c "blocktrash -x 4096 -y 4096 -n 8 -3 -z" \
 	>> $seqres.full 2>&1
 
-echo "+ mount image"
+echo "+ mount image && copy more"
 if _try_scratch_mount >> $seqres.full 2>&1; then
 
-	echo "+ copy more"
 	$XFS_IO_PROG -f -R -c "pwrite -S 0x68 0 1" $SCRATCH_MNT/e3 >> $seqres.full 2>&1
 	test -s ${SCRATCH_MNT}/f3 && echo "should not be able to copy with busted rtrmap btree"
 	_scratch_unmount
diff --git a/tests/xfs/337.out b/tests/xfs/337.out
index 1ee2db7..e3b0ba4 100644
--- a/tests/xfs/337.out
+++ b/tests/xfs/337.out
@@ -4,8 +4,7 @@ QA output created by 337
 + make some files
 + check fs
 + corrupt image
-+ mount image
-+ copy more
++ mount image && copy more
 + repair fs
 + mount image (2)
 + copy more (2)
-- 
1.8.3.1
