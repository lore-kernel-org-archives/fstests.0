Received: from aserp1040.oracle.com ([141.146.126.69]:18772 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbcAWAg6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 22 Jan 2016 19:36:58 -0500
Subject: [PATCH 2/5] reflink: fix off-by-one errors when iterating file
 blocks in a loop
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Fri, 22 Jan 2016 16:36:54 -0800
Message-ID: <20160123003654.2666.17112.stgit@birch.djwong.org>
In-Reply-To: <20160123003648.2666.37062.stgit@birch.djwong.org>
References: <20160123003648.2666.37062.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, darrick.wong@oracle.com
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

When we're iterating file blocks in a loop (via seq), we have to
end at $nr-1, not $nr.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/183 |    2 +-
 tests/generic/185 |    2 +-
 tests/generic/186 |    2 +-
 tests/generic/187 |    2 +-
 tests/generic/194 |    2 +-
 tests/generic/195 |    2 +-
 tests/xfs/129     |    6 +++---
 tests/xfs/140     |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)


diff --git a/tests/generic/183 b/tests/generic/183
index 5c65e9a..2cf9ce4 100755
--- a/tests/generic/183
+++ b/tests/generic/183
@@ -69,7 +69,7 @@ seq 0 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
diff --git a/tests/generic/185 b/tests/generic/185
index 384c9aa..55c54ac 100755
--- a/tests/generic/185
+++ b/tests/generic/185
@@ -69,7 +69,7 @@ seq 0 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
diff --git a/tests/generic/186 b/tests/generic/186
index d84166d..f1c0e6b 100755
--- a/tests/generic/186
+++ b/tests/generic/186
@@ -112,7 +112,7 @@ seq 0 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
diff --git a/tests/generic/187 b/tests/generic/187
index c85a0a9..ce35ec0 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -112,7 +112,7 @@ seq 0 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR-1)) | while read f; do
 	_reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
diff --git a/tests/generic/194 b/tests/generic/194
index a441aee..b88297e 100755
--- a/tests/generic/194
+++ b/tests/generic/194
@@ -79,7 +79,7 @@ md5sum "$TESTDIR/file3" | _filter_scratch
 md5sum "$TESTDIR/file3.chk" | _filter_scratch
 
 echo "directio CoW across the transition"
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR-1)) | while read f; do
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3" >> "$seqres.full"
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
diff --git a/tests/generic/195 b/tests/generic/195
index 83e7b23..464a4d4 100755
--- a/tests/generic/195
+++ b/tests/generic/195
@@ -79,7 +79,7 @@ md5sum "$TESTDIR/file3" | _filter_scratch
 md5sum "$TESTDIR/file3.chk" | _filter_scratch
 
 echo "CoW across the transition"
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR-1)) | while read f; do
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3" >> "$seqres.full"
 	_pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
 done
diff --git a/tests/xfs/129 b/tests/xfs/129
index c8c47a2..3b7c59c 100755
--- a/tests/xfs/129
+++ b/tests/xfs/129
@@ -65,9 +65,9 @@ NR_BLKS=$((4 * BLKSZ / 12))
 _pwrite_byte 0x61 0 $((BLKSZ * NR_BLKS)) "$TESTDIR/file1" >> "$seqres.full"
 
 echo "Reflink every other block"
-seq 1 $((NR_BLKS / 2)) | while read nr; do
-	_reflink_range  "$TESTDIR/file1" $((nr * 2 * BLKSZ)) \
-			"$TESTDIR/file2" $((nr * 2 * BLKSZ)) $BLKSZ >> "$seqres.full"
+seq 1 2 $((NR_BLKS - 1)) | while read nr; do
+	_reflink_range  "$TESTDIR/file1" $((nr * BLKSZ)) \
+			"$TESTDIR/file2" $((nr * BLKSZ)) $BLKSZ >> "$seqres.full"
 done
 
 echo "Create metadump file"
diff --git a/tests/xfs/140 b/tests/xfs/140
index e20cd3f..45be9f4 100644
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -70,7 +70,7 @@ cmp -s "$TESTDIR/file1" "$TESTDIR/file2" || echo "file1 and file2 do not match"
 cmp -s "$TESTDIR/file2" "$TESTDIR/file2.chk" || echo "file2 and file2.chk do not match"
 
 echo "CoW every other block"
-seq 1 2 $NR | while read f; do
+seq 1 2 $((NR - 1)) | while read f; do
 	_pwrite_byte 0x62 $((f * BLKSZ)) $BLKSZ "$TESTDIR/file2" >> "$seqres.full"
 	_pwrite_byte 0x62 $((f * BLKSZ)) $BLKSZ "$TESTDIR/file2.chk" >> "$seqres.full"
 done

