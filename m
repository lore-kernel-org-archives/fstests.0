Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA4264A70
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634523; cv=none; b=lQj7jIRRUok6xEKzF6jTEElsiVvkFGkkoKFixQe6x55vf9k7Ia4MerLtLzTMpGvudUwGQWTpbCnFM5zNveeOLGV3mDlTQBqp2ronpMaGfL4j7EB5+47ljuETHgGpSk6b8qu466fUPPIopurBcYBmfPtn21g1BqW7j+I21dzr84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634523; c=relaxed/simple;
	bh=ZDR9Qp9uHf5Kp5995ZpVtcm0HPM7+0QMWX/TeDH0xK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7wR8yD6gQwzFmkBfiaAt8DPYVw+7Qh9MvgzrBnbZJxjSNizygXwREcSs0IMougX27UISnBHWhAytnahqBoWNWsg800Uh+ZiRNu3lyCGATlOr51Ris1MvcucvfwBHQ55k5srO1ixzo8cC/4SBG1L00IR0Dw1yrjrPzPZmLJ5pq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oASxGK7o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oASxGK7o"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7nTpM021947;
	Wed, 11 Jun 2025 09:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SMNjEbVUDEpxRxGJm
	YbF/UPnkiW5lBFRefATFZQMw6w=; b=oASxGK7oJ1XOOJ4+FBkJVTC6du7D6cErP
	J/tXrMAYZRHDKFcU1fwyXBeapTiAO0AtaXlncczVSi6xx0QZmibUpXBnhUnBOOW3
	j/Uv/4mfJOXz+D3E1FJMzmTz1ZddRU68Q/LSNEPNWlsrPj/d5ICqSgSyQgr9sUFp
	4TD5EQ0WUxoUJmLphAb2O/KT5NyoRMpA2ZeuLFOW+RrBLcfAnlBz8349kJ2/PUbR
	pZBXtVq6RxzkEZ3GX4mcdKAycyowVXRRnEtqm3AqRMuCVvaetM93FMqkYooqtFKq
	nrrCNpKsVZA8A4rD5yjPKHlWKaFdozTjJyQGV1RmFEtC3w6YGRZDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3jea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9Oeck032539;
	Wed, 11 Jun 2025 09:35:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3je8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B5bEPj028575;
	Wed, 11 Jun 2025 09:35:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mewup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9ZCNV44761552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 593D12004B;
	Wed, 11 Jun 2025 09:35:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093C420043;
	Wed, 11 Jun 2025 09:35:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 08/12] generic/772: Add sudden shutdown tests for multi block atomic writes
Date: Wed, 11 Jun 2025 15:04:51 +0530
Message-ID: <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749629233.git.ojaswin@linux.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68494dd3 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=uK8xSeSKhPSojuM-M5MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX26yjjMfPtgTJ 5krWlCH8rEe32elXOtaYqOH4Oyr8YwfBenapBThVeHLBcVGtLM6ifLiqbPr6Du6vkpL0ZdKO2kV q4AVmQ/YbNS+FzGO3pKjfDdMdj70/bvV81ME/9wM1F0jGD9mJLhvfvh7rPbJNKHClNOLjiir6GE
 1O9hhaLInG0FVTY3jtxJraKoR1ejQJKERu2Oo55Xq6J+XS9AdSEl9cPATqafR/FfV1ht6W2mVMz Tkd3RB/pXVyX9e2HAUjk7HzwoNE/dCYAmSf2RaeIhm5fFDE416ExdYz8TyiLZadn7GjF/ZrVnh8 lp/yeOoy4LLHJYiHzSjJ6vkO/jDdXj2UIxCY7v4Ork5PBeOUHb8XSh3aiLY1J5rpVZZtCYiYjyo
 aa22ZqKu1aiK5cu8fybZkAIUJl0lscIb64MWxxNV3YXjkxTUJokJ60rTqgm0oSJzGdW+nz5j
X-Proofpoint-GUID: C63Gfbw_q6Pm5tIASg15rtvvTyLvBvD-
X-Proofpoint-ORIG-GUID: Ruzkpo1ijDDpwZ2m4ikgjVTskDBbhIYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

This test is intended to ensure that multi blocks atomic writes
maintain atomic guarantees across sudden FS shutdowns.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/772     | 360 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |   2 +
 2 files changed, 362 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..6af7e74c
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,360 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 0772
+#
+# Test multi block atomic writes with sudden FS shutdowns to ensure
+# the FS is not tearing the write operation
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
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
+	expected_data_old_mixed=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_mixed)
+
+	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
+	expected_data_old_zeroes=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_zeroes)
+
+	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
+	expected_data_old_mapped=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_mapped)
+
+	# create a dummy file with expected new data
+	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
+	expected_data_new=$(xxd -s 0 -l $awu_max -p $testfile.exp_new)
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
+		actual_data=$(xxd -s $off -l $awu_max -p $testfile)
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
+			return 1
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
+
+	return 0
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
+
+	if [[ "$?" == "1" ]]
+	then
+		return 1
+	fi
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
+
+	if [[ "$?" == "1" ]]
+	then
+		return 1
+	fi
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
+
+	if [[ "$?" == "1" ]]
+	then
+		return 1
+	fi
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
+
+	if [[ "$?" == "1" ]]
+	then
+		return 1
+	fi
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
+
+	return $?
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
+	if [[ "$?" == "1" ]]
+	then
+		status=1
+		break
+	fi
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
+	test_data_integrity_writ
+	if [[ "$?" == "1" ]]
+	then
+		status=1
+		break
+	fi
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
+	test_data_integrity_unwrit
+	if [[ "$?" == "1" ]]
+	then
+		status=1
+		break
+	fi
+
+	echo >> $seqres.full
+	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
+	test_data_integrity_hole
+	if [[ "$?" == "1" ]]
+	then
+		status=1
+		break
+	fi
+
+	echo >> $seqres.full
+	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
+	test_filesize_integrity
+	if [[ "$?" == "1" ]]
+	then
+		status=1
+		break
+	fi
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/772.out b/tests/generic/772.out
new file mode 100644
index 00000000..98c13968
--- /dev/null
+++ b/tests/generic/772.out
@@ -0,0 +1,2 @@
+QA output created by 772
+Silence is golden
-- 
2.49.0

