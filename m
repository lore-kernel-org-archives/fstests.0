Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067A3B27CA
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758840; cv=none; b=Rw15JQ9LqZbsUgtv6PziE1RNs6mSvRXmYd6SWOC3BzzzQg8aD1ytc95CuTqSMeVx2b014S3zAig/1i8KE162yhxbkThIOGeMPtM8Wc0rphtGLsm8kXd4Jbj0iYWq4G71M5p2o/XeTxpV/tZbdBQjfY5/XYHm8Hu9bHVSbbJshbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758840; c=relaxed/simple;
	bh=vPK0/sACSLestpaGh7VHnIPW9CSnfWjiYEw06uu06N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2p9t8DqL4SDTKm4Xk2VyqO9RtkJQftx+syYu/K7XxWsHtYC9cpN4skYjHKa2q2QJBjkIPDCcrfMU9L+yx9hW5rmdiuY+k94P0rXFVY1g6ulyHjES1oEst5YT1YXOqrG0H90a/jNMNxlUzvxL0wyE/+D7MwK8sZZPQNNidu4QjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 3B255180F2E7;
	Thu, 14 May 2026 13:40:34 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id uaW8NIm0BWoNiioAKEJqOA:T4
	(envelope-from <lukas@herbolt.com>); Thu, 14 May 2026 13:40:34 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	xfs-linux@kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH v2 3/4] generic/{102,172,347}: Adapt test for XFS on systems with 128+CPUs + SSDs
Date: Thu, 14 May 2026 13:39:13 +0200
Message-ID: <20260514113910.866888-8-lukas@herbolt.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514113910.866888-2-lukas@herbolt.com>
References: <20260514113910.866888-2-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFS will now scale by default its log size according the amount of CPUs. This
can significantly increase the log area and using hard-coded size of file size
will make the test file. Using the X percent of the free space to create the
file will let the test proceed.

For generic/102 we also have to change the 102.out as we cannot know the
amount written data and it has to be filtered out.

For generic/172 we just use the new function to calculate file big enough
to consume most of the available space.

The generic/347 will use -l concurrency=0 in case it is being run on the
XFS filesystem and mkfs.xfs already supports this option.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 changes v2:
	test: generic/102 change the file size to 80% as it's closer to 
	      original size of 800MB
 tests/generic/102     |  5 +++--
 tests/generic/102.out | 20 ++++++++++----------
 tests/generic/172     |  8 ++++----
 tests/generic/347     |  9 ++++++++-
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tests/generic/102 b/tests/generic/102
index daa5061bd3fe..be9ddda30a1d 100755
--- a/tests/generic/102
+++ b/tests/generic/102
@@ -23,12 +23,13 @@ _require_scratch
 dev_size=$((1024 * 1024 * 1024))     # 1GB filesystem
 _scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
 _scratch_mount
+file_size=`_mb_pct_of_available_space $SCRATCH_DEV 80`
 
 for ((i = 0; i < 10; i++)); do
 	echo "loop $i" >>$seqres.full
 
-	$XFS_IO_PROG -f -c "pwrite -b 1m 0 800m" "$SCRATCH_MNT"/file | \
-_filter_xfs_io | _filter_scratch
+	$XFS_IO_PROG -f -c "pwrite -b 1m 0 ${file_size}m" "$SCRATCH_MNT"/file | \
+_filter_xfs_io_numbers | _filter_scratch
 
 	rm -f "$SCRATCH_MNT"/file
 done
diff --git a/tests/generic/102.out b/tests/generic/102.out
index b58aa5ccc68b..647bb23abec1 100644
--- a/tests/generic/102.out
+++ b/tests/generic/102.out
@@ -1,21 +1,21 @@
 QA output created by 102
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 838860800/838860800 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/172 b/tests/generic/172
index b67e817b667b..06f9370f065d 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -37,15 +37,15 @@ echo "Reformat with appropriate size"
 blksz="$(_get_block_size $testdir)"
 _scratch_unmount
 
-file_size=$((768 * 1024 * 1024))
 fs_size=$((1024 * 1024 * 1024))
 _scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
+file_size=`_mb_pct_of_available_space $SCRATCH_DEV 70`
 
 echo "Create a big file and reflink it"
-_pwrite_byte 0x61 0 $file_size $testdir/bigfile >> $seqres.full 2>&1
+_pwrite_byte 0x61 0 ${file_size}m $testdir/bigfile >> $seqres.full 2>&1
 _cp_reflink $testdir/bigfile $testdir/clonefile
 _scratch_sync
 
@@ -54,7 +54,7 @@ _fill_fs $fs_size  $testdir/space $blksz 0 >> $seqres.full 2>&1
 _scratch_sync
 
 echo "CoW the big file"
-out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
+out="$(_pwrite_byte 0x62 0 ${file_size}m $testdir/bigfile 2>&1 | \
 	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
@@ -63,7 +63,7 @@ echo ${out}
 echo "Remount and try CoW again"
 _scratch_cycle_mount
 
-out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
+out="$(_pwrite_byte 0x62 0 ${file_size}m $testdir/bigfile 2>&1 | \
 	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
diff --git a/tests/generic/347 b/tests/generic/347
index 5c0e3f949585..06df0cf9eddc 100755
--- a/tests/generic/347
+++ b/tests/generic/347
@@ -14,6 +14,13 @@ BACKING_SIZE=$((500 * 1024 * 1024 / 512))	# 500M
 VIRTUAL_SIZE=$((10 * $BACKING_SIZE))		# 5000M
 GROW_SIZE=$((100 * 1024 * 1024 / 512))		# 100M
 
+dmthin_mkfs_opts=""
+if [ $FSTYP == "xfs" ]; then
+	if _scratch_mkfs_xfs_supports_concurrency -l >> $seqres.full 2>&1; then
+		dmthin_mkfs_opts="-l concurrency=0"
+	fi
+fi
+
 # Override the default cleanup function.
 _cleanup()
 {
@@ -25,7 +32,7 @@ _setup_thin()
 {
 	_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
 	_dmthin_set_queue
-	_dmthin_mkfs
+	_dmthin_mkfs $dmthin_mkfs_opts
 	_dmthin_mount
 }
 
-- 
2.54.0

