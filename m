Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95D2CCA9
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939179; cv=none; b=nptSgBRvRGKXa08KLvvA/UniWB8fFtB2dNbuFkl4I1jUP1wv10sry7zJBy2S27ib+mr4aD7SqQV8FhE/ShgvmVIPvdutFZz7HUi+E5PnlI4AxJ5GdK5+qi0Zg3MsvCSCxeHh6isQMrqK2eY5Cew4FM7Uv7yfd53CVYUswd/r9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939179; c=relaxed/simple;
	bh=q8AW5AWj3838lJZyBnQbH+yX9p5wSWWfez9/RID2z1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3MUe7v7jE1hGPAuH0oG+ebqwtifxHlkM0nzHRpKYU1C+iH/dQak38jHcp0FrBaWgQyPcLP+5SV5D8NrRO1ado2eaQeHPvyuHq/co5HBKg7yL/HuGhNZoXsq2KnAwDCbc3GDaRg+m82m7YE80bJ2DUmbqeuudmQ4137vwXGjI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZGHTMvCg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZGHTMvCg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AYPO015738;
	Thu, 26 Jun 2025 11:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yNvNmpK5fig8HPlZw
	IgZGawIFwrkuEnz5MrIh/Q1xTg=; b=ZGHTMvCgFkRtJasNACQKc1skyIJyZ7Fw5
	rHEwY3wqrD60elvq61iQ2d7PoolGlVKdV5m7MZNeNNTj7urMseblg/BJ/P65ky/5
	j/1aGXgUVKzDT+dcXVJ38QpWceGMpSxLUB+xUYSr7gTmDNCB9y2+ltlshZux71u9
	MTtuwulLDcCpLkDyJ0OQ3mwtS9d1tx1Xwzmt58+a9k66h8kAm08AF0jHlc/u3ss9
	BLCutOWc0B4mxsaHpjKXrE7GpOUFEi4PURW5wyGjseJa0ToIvsvsSMQq9iTOxXIg
	7Jbp6uiCpyrpC08Y5IboqJGLhyNvi+JCcBQCsAQwAcI0UWU0raY5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBxR9o005572;
	Thu, 26 Jun 2025 11:59:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9Xig0002568;
	Thu, 26 Jun 2025 11:59:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmekpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxOj523265882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 719F62004F;
	Thu, 26 Jun 2025 11:59:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFDAE20040;
	Thu, 26 Jun 2025 11:59:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:22 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 09/13] generic/1230: Add sudden shutdown tests for multi block atomic writes
Date: Thu, 26 Jun 2025 17:29:00 +0530
Message-ID: <eabfa4691ac822af276c900f0cc7502ad62ea768.1750924903.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750924903.git.ojaswin@linux.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfXxUfhZs2mWWon tMcIQLMhPg0unYB5mYq6rIGzRxVVI+MdBr7i6T+tv8NDLCV/s8WExHokQDJK62p5CclVLO88gPb y0KYPq0OgQ2n/zjKKjJuKIu0WVlw5x0NZraP0pqDyJz25ZWZEUoyDElafxeEj1o9dDOeDpdgCz4
 xwRCbFLG25u6tFFaIku4QDZk1fGz+ZgrjjcHxtG+wUikht4fkcTlCiaAFOd4AFDBrVkHYVzLDwc Jxv00QKTNO6oRCIEldsOe6oXmF8MiCOb3waBC3qiduSY/1G7/8KqMhnp0y43cMd91zMRtQtF4SK I6iAKIW+n0HkJZQv41Pn8p0zzJTd43qkLP33iMwvLob2nK/Ua02KdlKh4soiDWyWvRSpwo50g2r
 ohhfaZ/dKG5rema+POc7W+/20zpISv4UrwMPLZGDhRH9bDbOgL7medKvZ7RR81UaFntXChQY
X-Proofpoint-GUID: v59O6O6tKuae-N7kuC7NceXiM0fuWW-E
X-Proofpoint-ORIG-GUID: 10cAf8coqiRdP4f5A3PdQaVl50SN67-z
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d3620 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=482t30lc8_2jWWLQ6-wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

This test is intended to ensure that multi blocks atomic writes
maintain atomic guarantees across sudden FS shutdowns.

The way we work is that we lay out a file with random mix of written,
unwritten and hole extents. Then we start performing atomic writes
sequentially on the file while we parallely shutdown the FS. Then we
note the last offset where the atomic write happened just before shut
down and then make sure blocks around it either have completely old
data or completely new data, ie the write was not torn during shutdown.

We repeat the same with completely written, completely unwritten and completely
empty file to ensure these cases are not torn either.  Finally, we have a
similar test for append atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1230     | 321 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 2 files changed, 323 insertions(+)
 create mode 100755 tests/generic/1230
 create mode 100644 tests/generic/1230.out

diff --git a/tests/generic/1230 b/tests/generic/1230
new file mode 100755
index 00000000..c65ad55f
--- /dev/null
+++ b/tests/generic/1230
@@ -0,0 +1,321 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test No. 1230
+#
+# Test multi block atomic writes with sudden FS shutdowns to ensure
+# the FS is not tearing the write operation
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+_require_scratch_shutdown
+_require_xfs_io_command "truncate"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+echo "Awu max: $awu_max" >> $seqres.full
+
+num_blocks=$((awu_max / blksz))
+filesize=$(($blksz * 12 * 1024 ))
+
+_cleanup() {
+	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
+	wait
+}
+
+atomic_write_loop() {
+	local off=0
+	local size=$awu_max
+	for ((i=0; i<$((filesize / $size )); i++)); do
+		# Due to sudden shutdown this can produce errors so just redirect them
+		# to seqres.full
+		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
+		echo "Written to offset: $off" >> $tmp.aw
+		off=$((off + $size))
+	done
+}
+
+create_mixed_mappings() {
+	local file=$1
+	local size_bytes=$2
+
+	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
+	#Fill the file with alternate written and unwritten blocks
+	local off=0
+	local operations=("W" "U")
+
+	for ((i=0; i<$((size_bytes / blksz )); i++)); do
+		index=$(($i % ${#operations[@]}))
+		map="${operations[$index]}"
+
+		case "$map" in
+		    "W")
+			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
+			;;
+		    "U")
+			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
+			;;
+		esac
+		off=$((off + blksz))
+	done
+
+	sync $file
+}
+
+populate_expected_data() {
+	# create a dummy file with expected old data for different cases
+	create_mixed_mappings $testfile.exp_old_mixed $awu_max
+	expected_data_old_mixed=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mixed)
+
+	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
+	expected_data_old_zeroes=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_zeroes)
+
+	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
+	expected_data_old_mapped=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mapped)
+
+	# create a dummy file with expected new data
+	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
+	expected_data_new=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_new)
+}
+
+verify_data_blocks() {
+	local verify_start=$1
+	local verify_end=$2
+	local expected_data_old="$3"
+	local expected_data_new="$4"
+
+	echo >> $seqres.full
+	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
+
+	# After an atomic write, for every chunk we ensure that the underlying
+	# data is either the old data or new data as writes shouldn't get torn.
+	local off=$verify_start
+	while [[ "$off" -lt "$verify_end" ]]
+	do
+		#actual_data=$(xxd -s $off -l $awu_max -p $testfile)
+		actual_data=$(od -An -t x1 -j $off -N $awu_max $testfile)
+		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
+		then
+			echo "Checksum match failed at off: $off size: $awu_max"
+			echo "Expected contents: (Either of the 2 below):"
+			echo
+			echo "Expected old: "
+			echo "$expected_data_old"
+			echo
+			echo "Expected new: "
+			echo "$expected_data_new"
+			echo
+			echo "Actual contents: "
+			echo "$actual_data"
+
+			_fail
+		fi
+		echo -n "Check at offset $off suceeded! " >> $seqres.full
+		if [[ "$actual_data" == "$expected_data_new" ]]
+		then
+			echo "matched new" >> $seqres.full
+		elif [[ "$actual_data" == "$expected_data_old" ]]
+		then
+			echo "matched old" >> $seqres.full
+		fi
+		off=$(( off + awu_max ))
+	done
+}
+
+# test data integrity for file by shutting down in between atomic writes
+test_data_integrity() {
+	echo >> $seqres.full
+	echo "# Writing atomically to file in background" >> $seqres.full
+	atomic_write_loop &
+	awloop_pid=$!
+
+	# Wait for atleast first write to be recorded
+	while [ ! -f "$tmp.aw" ]; do sleep 0.2; done
+
+	echo >> $seqres.full
+	echo "# Shutting down filesystem while write is running" >> $seqres.full
+	_scratch_shutdown
+
+	kill $awloop_pid
+	wait $awloop_pid
+	unset $awloop_pid
+
+	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
+	cat $tmp.aw >> $seqres.full
+	echo >> $seqres.full
+	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
+
+	rm $tmp.aw
+	sleep 0.5
+
+	_scratch_cycle_mount
+
+	# we want to verify all blocks around which the shutdown happended
+	verify_start=$(( last_offset - (awu_max * 5)))
+	if [[ $verify_start < 0 ]]
+	then
+		verify_start=0
+	fi
+
+	verify_end=$(( last_offset + (awu_max * 5)))
+	if [[ "$verify_end" -gt "$filesize" ]]
+	then
+		verify_end=$filesize
+	fi
+}
+
+# test data integrity for file wiht written and unwritten mappings
+test_data_integrity_mixed() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with mixed mappings" >> $seqres.full
+	create_mixed_mappings $testfile $filesize
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
+}
+
+# test data integrity for file with completely written mappings
+test_data_integrity_writ() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with fully written mapping" >> $seqres.full
+	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
+}
+
+# test data integrity for file with completely unwritten mappings
+test_data_integrity_unwrit() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
+	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
+}
+
+# test data integrity for file with no mappings
+test_data_integrity_hole() {
+	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Creating testfile with no mappings" >> $seqres.full
+	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
+	sync $testfile
+
+	test_data_integrity
+
+	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
+}
+
+test_filesize_integrity() {
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Performing extending atomic writes over file in background" >> $seqres.full
+	atomic_write_loop &
+	awloop_pid=$!
+
+	# Wait for atleast first write to be recorded
+	while [ ! -f "$tmp.aw" ]; do sleep 0.2; done
+
+	echo >> $seqres.full
+	echo "# Shutting down filesystem while write is running" >> $seqres.full
+	_scratch_shutdown
+
+	kill $awloop_pid
+	wait $awloop_pid
+	unset $awloop_pid
+
+	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
+	cat $tmp.aw >> $seqres.full
+	echo >> $seqres.full
+	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
+	rm $tmp.aw
+	sleep 0.5
+
+	_scratch_cycle_mount
+	local filesize=$(_get_filesize $testfile)
+	echo >> $seqres.full
+	echo "# Filesize after shutdown: $filesize" >> $seqres.full
+
+	# To confirm that the write went atomically, we check:
+	# 1. The last block should be a multiple of awu_max
+	# 2. The last block should be the completely new data
+
+	if (( $filesize % $awu_max ))
+	then
+		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
+	fi
+
+	verify_start=$(( filesize - (awu_max * 5)))
+	if [[ $verify_start < 0 ]]
+	then
+		verify_start=0
+	fi
+
+	local verify_end=$filesize
+
+	# Here the blocks should always match new data hence, for simplicity of
+	# code, just corrupt the $expected_data_old buffer so it never matches
+	local expected_data_old="POISON"
+	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
+}
+
+$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
+
+echo >> $seqres.full
+echo "# Populating expected data buffers" >> $seqres.full
+populate_expected_data
+
+# Loop 20 times to shake out any races due to shutdown
+for ((iter=0; iter<20; iter++))
+do
+	echo >> $seqres.full
+	echo "------ Iteration $iter ------" >> $seqres.full
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
+	test_data_integrity_mixed
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
+	test_data_integrity_writ
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
+	test_data_integrity_unwrit
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
+	test_data_integrity_hole
+
+	echo >> $seqres.full
+	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
+	test_filesize_integrity
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/1230.out b/tests/generic/1230.out
new file mode 100644
index 00000000..d01f54ea
--- /dev/null
+++ b/tests/generic/1230.out
@@ -0,0 +1,2 @@
+QA output created by 1230
+Silence is golden
-- 
2.49.0

