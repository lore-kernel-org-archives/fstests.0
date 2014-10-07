Return-Path: <fstests-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31223 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbaJGXNG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 7 Oct 2014 19:13:06 -0400
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s97ND3qi013889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Tue, 7 Oct 2014 23:13:04 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id s97ND37P008390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 7 Oct 2014 23:13:03 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s97ND3EV028692
	for <fstests@vger.kernel.org>; Tue, 7 Oct 2014 23:13:03 GMT
Date: Tue, 7 Oct 2014 19:12:59 -0400
From: Dwight Engen <dwight.engen@oracle.com>
Subject: [PATCH] xfs/242: fix for archs with 8k page size
Message-ID: <20141007191259.7e5b5ee3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test was failing on sparc64 because there is a minimum granularity of
PAGE_CACHE_SIZE in xfs_vnodeops.c:xfs_zero_file_space(). This change follows
the approach taken in xfs/194 to filter the bmap output to be in terms of
"blocksize" which is computed from pagesize.

_test_generic_punch is modified to optionally take multiple as an argument,
so the file under test will be twice the size on an 8k machine as a 4k
machine. Since the files will be different sizes, we can no longer use
md5sum so od -x is used instead with the byte offsets converted to
"blocksize" offsets.

The changes to _test_generic_punch only take effect in the case of the
xfs/242 caller, other callers will have multiple=1 and still use md5sum.

xfs/242 was tested with these changes on both a 4k and 8k machine.

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 common/punch      |   63 +++++++---------
 tests/xfs/242     |   76 +++++++++++++++++++-
 tests/xfs/242.out |  211 ++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 254 insertions(+), 96 deletions(-)

diff --git a/common/punch b/common/punch
index f2d538c..fa1a6e5 100644
--- a/common/punch
+++ b/common/punch
@@ -234,23 +234,6 @@ _filter_hole_fiemap()
 	_coalesce_extents
 }
 
-_filter_bmap()
-{
-	awk '
-		$3 ~ /hole/ {
-			print $1, $2, $3;
-			next;
-		}
-		$7 ~ /10000/ {
-			print $1, $2, "unwritten";
-			next;
-		}
-		$7 ~ /00000/ {
-			print $1, $2, "data"
-		}' |
-	_coalesce_extents
-}
-
 die_now()
 {
 	status=1
@@ -317,10 +300,18 @@ _test_generic_punch()
 	map_cmd=$4
 	filter_cmd=$5
 	testfile=$6
-	multiple=1
+	md5_cmd=$7
+	multiple=$8
+
+	if [ -z "$md5_cmd" ]; then
+		md5_cmd=_md5_checksum
+	fi
+	if [ -z "$multiple" ]; then
+		multiple=1
+	fi
 
 	#
-	# If we are testing collapse range, we increare all the offsets of this
+	# If we are testing collapse range, we increase all the offsets of this
 	# test by a factor of 4. We do this because unlike punch, collapse
 	# range also decreases the size of file hence require bigger offsets.
 	#
@@ -342,7 +333,7 @@ _test_generic_punch()
 		-c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	echo "	2. into allocated space"
 	if [ "$remove_testfile" ]; then
@@ -353,7 +344,7 @@ _test_generic_punch()
 		-c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	if [ "$unwritten_tests" ]; then
 		echo "	3. into unwritten space"
@@ -365,7 +356,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 	fi
 
 	echo "	4. hole -> data"
@@ -377,7 +368,7 @@ _test_generic_punch()
 		-c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	if [ "$unwritten_tests" ]; then
 		echo "	5. hole -> unwritten"
@@ -389,7 +380,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 	fi
 
 	echo "	6. data -> hole"
@@ -401,7 +392,7 @@ _test_generic_punch()
 		 -c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	if [ "$unwritten_tests" ]; then
 		echo "	7. data -> unwritten"
@@ -414,7 +405,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 
 		echo "	8. unwritten -> hole"
 		if [ "$remove_testfile" ]; then
@@ -425,7 +416,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 
 		echo "	9. unwritten -> data"
 		if [ "$remove_testfile" ]; then
@@ -437,7 +428,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 	fi
 
 	echo "	10. hole -> data -> hole"
@@ -449,7 +440,7 @@ _test_generic_punch()
 		-c "$zero_cmd $_4k $_12k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	echo "	11. data -> hole -> data"
 	if [ "$remove_testfile" ]; then
@@ -463,7 +454,7 @@ _test_generic_punch()
 		-c "$zero_cmd $_4k $_12k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	if [ "$unwritten_tests" ]; then
 		echo "	12. unwritten -> data -> unwritten"
@@ -476,7 +467,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_12k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 
 		echo "	13. data -> unwritten -> data"
 		if [ "$remove_testfile" ]; then
@@ -489,7 +480,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_4k $_12k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 	fi
 
 	# Don't need to check EOF case for collapse range.
@@ -503,7 +494,7 @@ _test_generic_punch()
 			-c "$zero_cmd $_12k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
 		[ $? -ne 0 ] && die_now
-		_md5_checksum $testfile
+		$md5_cmd $testfile
 	fi
 
 	if [ "$zero_cmd" == "fcollapse" ]; then
@@ -520,7 +511,7 @@ _test_generic_punch()
 		-c "$zero_cmd 0 $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	[ $? -ne 0 ] && die_now
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	# If zero_cmd is fcollpase, don't check unaligned offsets
 	if [ "$zero_cmd" == "fcollapse" ]; then
@@ -545,7 +536,7 @@ _test_generic_punch()
 	diff $testfile $testfile.2
 	[ $? -ne 0 ] && die_now
 	rm -f $testfile.2
-	_md5_checksum $testfile
+	$md5_cmd $testfile
 
 	# different file sizes mean we can't use md5sum to check the hole is
 	# valid. Hence use hexdump to dump the contents and chop off the last
@@ -561,7 +552,7 @@ _test_generic_punch()
 	$XFS_IO_PROG -f -c "truncate $block_size" \
 		-c "pwrite 0 $block_size" $sync_cmd \
 		-c "$zero_cmd 128 128" \
-		-c "$map_cmd -v" $testfile | $filter_cmd | \
+		-c "$map_cmd -v" $testfile | $filter_cmd $block_size | \
 			 sed -e "s/\.\.[0-9]*\]/..7\]/"
 	[ $? -ne 0 ] && die_now
 	od -x $testfile | head -n -1
diff --git a/tests/xfs/242 b/tests/xfs/242
index 304e69f..0daee38 100755
--- a/tests/xfs/242
+++ b/tests/xfs/242
@@ -39,7 +39,6 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common/rc
-. ./common/filter
 . ./common/punch
 
 # real QA test starts here
@@ -47,6 +46,63 @@ _supported_fs xfs
 _supported_os Linux
 _require_test
 
+# For this test we use block size = 1/8 page size
+pgsize=`$here/src/feature -s`
+blksize=`expr $pgsize / 8`
+
+# Some architectures (sparc64) have 8k pages, so we pass multiple into
+# _test_generic_punch and use the filter to report things in terms of
+# "blksize" (similar to test 194) as computed above so the output is
+# consistent across 4k/8k archs.
+multiple=`expr $pgsize / 4096`
+
+# Filter out offsets and physical location info which vary by blocksize
+# Input:
+#  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
+#  0: [0..15]:         hole                                    16
+#  1: [16..47]:        66..97            0 (66..97)            32 10000
+#  2: [48..79]:        hole                                    32
+# Output:
+#  0:	1	blocks
+#  1:	1	hole
+
+_coalesce_extents()
+{
+	awk '
+	{
+		blks = $2;
+		type = $3;
+
+		if (type != prev_type) {
+			if (prev_type != "")
+				printf("%u:\t%u\t%s\n", ext_count++, blks_tot, prev_type);
+			prev_type = type;
+			blks_tot = 0;
+		}
+		blks_tot = blks_tot + blks;
+	}
+	END {
+		if (prev_type != "")
+			printf("%u:\t%u\t%s\n", ext_count++, blks_tot, prev_type);
+	}'
+}
+
+_filter_bmap()
+{
+	if [ -n "$1" ]; then
+		# Special case for Test 17. Single block file
+		blksz=`expr $1 / 8`
+	else
+		blksz=$blksize
+	fi
+	echo -e "EXT:\tBlks\tTYPE"
+	awk \
+	'$3 ~ /hole/     { print $1 "\t" ($4 * 512) / blksize "\t" $3 ; next }
+	 $7 ~ /10000/    { print $1 "\t" ($6 * 512) / blksize "\tunwritten" ; next }
+	 $7 ~ /00000/    { print $1 "\t" ($6 * 512) / blksize "\tdata" ; next }' \
+	 blksize=$blksz | _coalesce_extents
+}
+
 _test_io_zero()
 {
 	$XFS_IO_PROG -c "zero help" 2>&1 | \
@@ -54,10 +110,26 @@ _test_io_zero()
 	echo $?
 }
 
+# Dump file, converting bytes offsets to block offsets
+_od_file()
+{
+	echo "BLK  Data"
+	od -x $1 | \
+	awk '
+	$1 ~ /*/	{ print $1; next }
+			{
+				offset = strtonum($1);
+				printf("%-04u %s %s %s %s %s %s %s %s\n",
+					offset / blksize,
+					$2, $3, $4, $5,
+					$6, $7, $8, $9);
+			}' blksize=$blksize
+}
+
 [ $(_test_io_zero) -eq 0 ] && _notrun "zero command not supported"
 
 testfile=$TEST_DIR/242.$$
 
-_test_generic_punch resvsp unresvsp zero 'bmap -p' _filter_bmap $testfile
+_test_generic_punch resvsp unresvsp zero 'bmap -p' _filter_bmap $testfile _od_file $multiple
 
 status=0 ; exit
diff --git a/tests/xfs/242.out b/tests/xfs/242.out
index a516c23..de7ed08 100644
--- a/tests/xfs/242.out
+++ b/tests/xfs/242.out
@@ -1,79 +1,174 @@
 QA output created by 242
 	1. into a hole
-0: [0..7]: hole
-1: [8..23]: unwritten
-2: [24..39]: hole
-daa100df6e6711906b61c9ab5aa16032
+EXT:	Blks	TYPE
+0:	8	hole
+1:	16	unwritten
+2:	16	hole
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	2. into allocated space
-0: [0..7]: data
-1: [8..23]: unwritten
-2: [24..39]: data
-cc58a7417c2d7763adc45b6fcd3fa024
+EXT:	Blks	TYPE
+0:	8	data
+1:	16	unwritten
+2:	16	data
+BLK  Data
+0    cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+8    0000 0000 0000 0000 0000 0000 0000 0000
+*
+24   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+40          
 	3. into unwritten space
-0: [0..39]: unwritten
-daa100df6e6711906b61c9ab5aa16032
+EXT:	Blks	TYPE
+0:	40	unwritten
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	4. hole -> data
-0: [0..7]: hole
-1: [8..23]: unwritten
-2: [24..31]: data
-3: [32..39]: hole
-cc63069677939f69a6e8f68cae6a6dac
+EXT:	Blks	TYPE
+0:	8	hole
+1:	16	unwritten
+2:	8	data
+3:	8	hole
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+24   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+32   0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	5. hole -> unwritten
-0: [0..7]: hole
-1: [8..31]: unwritten
-2: [32..39]: hole
-daa100df6e6711906b61c9ab5aa16032
+EXT:	Blks	TYPE
+0:	8	hole
+1:	24	unwritten
+2:	8	hole
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	6. data -> hole
-0: [0..7]: data
-1: [8..23]: unwritten
-2: [24..39]: hole
-1b3779878366498b28c702ef88c4a773
+EXT:	Blks	TYPE
+0:	8	data
+1:	16	unwritten
+2:	16	hole
+BLK  Data
+0    cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+8    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	7. data -> unwritten
-0: [0..7]: data
-1: [8..31]: unwritten
-2: [32..39]: hole
-1b3779878366498b28c702ef88c4a773
+EXT:	Blks	TYPE
+0:	8	data
+1:	24	unwritten
+2:	8	hole
+BLK  Data
+0    cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+8    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	8. unwritten -> hole
-0: [0..23]: unwritten
-1: [24..39]: hole
-daa100df6e6711906b61c9ab5aa16032
+EXT:	Blks	TYPE
+0:	24	unwritten
+1:	16	hole
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	9. unwritten -> data
-0: [0..23]: unwritten
-1: [24..31]: data
-2: [32..39]: hole
-cc63069677939f69a6e8f68cae6a6dac
+EXT:	Blks	TYPE
+0:	24	unwritten
+1:	8	data
+2:	8	hole
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+24   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+32   0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	10. hole -> data -> hole
-0: [0..7]: hole
-1: [8..31]: unwritten
-2: [32..39]: hole
-daa100df6e6711906b61c9ab5aa16032
+EXT:	Blks	TYPE
+0:	8	hole
+1:	24	unwritten
+2:	8	hole
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	11. data -> hole -> data
-0: [0..7]: data
-1: [8..31]: unwritten
-2: [32..39]: data
-f6aeca13ec49e5b266cd1c913cd726e3
+EXT:	Blks	TYPE
+0:	8	data
+1:	24	unwritten
+2:	8	data
+BLK  Data
+0    cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+8    0000 0000 0000 0000 0000 0000 0000 0000
+*
+32   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+40          
 	12. unwritten -> data -> unwritten
-0: [0..39]: unwritten
-daa100df6e6711906b61c9ab5aa16032
+EXT:	Blks	TYPE
+0:	40	unwritten
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	13. data -> unwritten -> data
-0: [0..7]: data
-1: [8..31]: unwritten
-2: [32..39]: data
-f6aeca13ec49e5b266cd1c913cd726e3
+EXT:	Blks	TYPE
+0:	8	data
+1:	24	unwritten
+2:	8	data
+BLK  Data
+0    cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+8    0000 0000 0000 0000 0000 0000 0000 0000
+*
+32   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+40          
 	14. data -> hole @ EOF
-0: [0..23]: data
-1: [24..39]: unwritten
-e1f024eedd27ea6b1c3e9b841c850404
+EXT:	Blks	TYPE
+0:	24	data
+1:	16	unwritten
+BLK  Data
+0    cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+24   0000 0000 0000 0000 0000 0000 0000 0000
+*
+40          
 	15. data -> hole @ 0
-0: [0..15]: unwritten
-1: [16..39]: data
-eecb7aa303d121835de05028751d301c
+EXT:	Blks	TYPE
+0:	16	unwritten
+1:	24	data
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+16   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+40          
 	16. data -> cache cold ->hole
-0: [0..15]: unwritten
-1: [16..39]: data
-eecb7aa303d121835de05028751d301c
+EXT:	Blks	TYPE
+0:	16	unwritten
+1:	24	data
+BLK  Data
+0    0000 0000 0000 0000 0000 0000 0000 0000
+*
+16   cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+40          
 	17. data -> hole in single block file
-0: [0..7]: data
+EXT:	Blks	TYPE
+0:	8	data
 0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
 *
 0000200 0000 0000 0000 0000 0000 0000 0000 0000
-- 
1.7.1

