Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058A264630
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634519; cv=none; b=tokebBNSkVc7rKbY6+xfxcnYDEpduCtxViIgLFIEYbXWcZ3Qn+dXHlwjoNzURIGHgFiTAsWtzeYXdPqVrx+kZM0FTE48OCjThBo9V/6J6KfI4vQq4y27++CLF9xET6bkQPuWRxKAmd4hcNLmnpcTQswhGPX2VXNrGevNhABbiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634519; c=relaxed/simple;
	bh=Y74Ghx7rrvayyKKctGbDQvVR1bY7V9LfZI2JdOLP58Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc7bR3Q0AvQigZTyGO1tF/FvQsTO4bzxfycAqib2mL/RSj0dxsu96N5T3rAf1zYwJJ2McCwSKiOtSlpvHjI8ypPjJ9V5g7ekWRotQA/UVM2dNm30ftEj6TVsW0wuzzEHHOeuEmkjkVyIGOHOErFl2iWY66hUTHrABBTuN0XoVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p3ysU4A3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3ysU4A3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B6UHFa021238;
	Wed, 11 Jun 2025 09:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eao6kEhG7BEWFivlc
	eQfeCde+CCg417esiQv/9hOpr4=; b=p3ysU4A3XHKPdXlqX1qLMnGaALo/tn6Pi
	XuYeWGyAKGdk0sC4zzov/ePnDJLeVuW3rmF1khYHJfXRxDjfkAbq823ofuJRmILl
	mJSrFRoM8/lqzXxggoKW6eh6HNrG+0uLecil228/3yhyZaVI5RyjGZXlIHizhQED
	DkD9t3DlcedvuHho2LeiAekbi2gzBKWyG3ROhN6Lj/QiEduM23i4xMI/u8Y11ucy
	WpUOeIZ+UYfqnM/4SxIAkX/EKTr8sOKVZH+bTreEvesATPZoVbwvkXdB3hI8YVDv
	6HuqOZSHgZu3ErqKiXuew26VcRgMrXI5hxFgNFVAt9xSJGjpIP2bQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8qb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9ZBqc017712;
	Wed, 11 Jun 2025 09:35:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8qav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9NQJx015369;
	Wed, 11 Jun 2025 09:35:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp703h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9Z8kW30671236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE84B2004B;
	Wed, 11 Jun 2025 09:35:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5745B20043;
	Wed, 11 Jun 2025 09:35:07 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:07 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 06/12] generic/770: Add atomic write multi-fsblock O_[D]SYNC tests
Date: Wed, 11 Jun 2025 15:04:49 +0530
Message-ID: <5503061a800eaff9fc182e68c3030c1ef07410f3.1749629233.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68494dd0 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=L2jkS5k7augT6nwTTI4A:9
X-Proofpoint-GUID: MQG_m5Hfey3C_jeqXmqGxzNgw2pf2qn0
X-Proofpoint-ORIG-GUID: iVRuIxEbCQ8c9iAgHS1GJLu3K8rBOy3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfXyMBQku8uRrzd woJgiBN322ezmvjomy0pSgsKci7A5zf5wEU5iSVrZDFhXU5XwuPX+drITpEQETswocM20LX/F7D rz7L7RVtQyke+FEsxuaoWIVJX3brA613l/rJ3p9/2jZ1dLP+kRODwBpFIIiHybFihPuxgPRIYL2
 hkEmYYkouwT18t2M2uWAJwLxjrgLEtplRlnt9x1IiuEm+Smwrh4dDhe08yBLiZOatn4kqMQvu+i xpMU9/fc0q9XQF4qLCHX6I/wUed6uYtkUMfqqpmosIkSKc8wJbMmZeHUdn4ztCBmD6kfzAf0fwY o2ZrmYFVKn7EL0X6TLbls5fSS2XT0guM/LAlDSQ6TzmNlLs4Q6IiGwTShAxdTkqSL6vrHSMrAZc
 dGLTGGdq712Qn5LGrroR0uMKA1TzOk9KJlxCab38BKUuRJcww0/bt7oaXNG64vhNX1NR4KRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

This adds various atomic write multi-fsblock stresst tests
with mixed mappings and O_SYNC, to ensure the data and metadata
is atomically persisted even if there is a shutdown.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/770     | 161 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/770.out |   2 +
 2 files changed, 163 insertions(+)
 create mode 100755 tests/generic/770
 create mode 100644 tests/generic/770.out

diff --git a/tests/generic/770 b/tests/generic/770
new file mode 100755
index 00000000..2b98b3b3
--- /dev/null
+++ b/tests/generic/770
@@ -0,0 +1,161 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 770
+#
+# Atomic write multi-fsblock data integrity tests with mixed mappings
+# and O_SYNC
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto quick rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+check_data_integrity() {
+	actual=$(_hexdump $testfile)
+	if [[ "$expected" != "$actual" ]]
+	then
+		echo "Integrity check failed"
+		echo "Integrity check failed" >> $seqres.full
+		echo "# Expected file contents:" >> $seqres.full
+		echo "$expected" >> $seqres.full
+		echo "# Actual file contents:" >> $seqres.full
+		echo "$actual" >> $seqres.full
+	fi
+}
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+
+# Create an expected pattern to compare with
+$XFS_IO_PROG -tc "pwrite -b $awu_max 0 $awu_max" $testfile >> $seqres.full
+expected=$(_hexdump $testfile)
+echo "# Expected file contents:" >> $seqres.full
+echo "$expected" >> $seqres.full
+
+echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping (10 iterations):" >> $seqres.full
+# Calculate how many blocks (e.g. 4K) fit in awu_max (e.g. 64K)
+num_blocks=$((awu_max / blksz))
+echo "Testing $num_blocks blocks of $blksz size within $awu_max region" >> $seqres.full
+
+operations=("W" "H" "U")
+
+# Run 10 iterations of the test
+for ((iteration=1; iteration<=10; iteration++)); do
+	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
+
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+	off=0
+	mapping=""
+
+	for ((i=0; i<num_blocks; i++)); do
+		index=$((RANDOM % ${#operations[@]}))
+		map="${operations[$index]}"
+		mapping="${mapping}${map}"
+
+		case "$map" in
+			"W")
+				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
+				;;
+			"H")
+				# No operation needed for hole
+				;;
+			"U")
+				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
+				;;
+		esac
+		off=$((off + blksz))
+	done
+
+	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
+
+	sync $testfile
+
+	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
+	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
+				  grep wrote | awk -F'[/ ]' '{print $2}')
+
+	test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
+	check_data_integrity
+	echo "Iteration $iteration completed: OK" >> $seqres.full
+	echo >> $seqres.full
+done
+echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
+
+echo >> $seqres.full
+echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
+bytes_written=$($XFS_IO_PROG -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" $testfile | \
+                grep wrote | awk -F'[/ ]' '{print $2}')
+test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
+_scratch_shutdown -v >> $seqres.full
+_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-2"
+check_data_integrity
+echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
+
+echo >> $seqres.full
+echo "# Test 3: Do O_DSYNC atomic write on random mixed mapping with sudden fs shutdown (10 iterations):" >> $seqres.full
+num_blocks=$((awu_max / blksz))
+echo "Testing $num_blocks blocks of $blksz size within $awu_max region" >> $seqres.full
+
+operations=("W" "H" "U")
+
+for ((iteration=1; iteration<=10; iteration++)); do
+	echo "=== Mixed Mapping Shutdown Test Iteration $iteration ===" >> $seqres.full
+
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+
+	off=0
+	mapping=""
+
+	for ((i=0; i<num_blocks; i++)); do
+		index=$((RANDOM % ${#operations[@]}))
+		map="${operations[$index]}"
+		mapping="${mapping}${map}"
+
+		case "$map" in
+			"W")
+				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
+				;;
+			"H")
+				# No operation needed for hole
+				;;
+			"U")
+				$XFS_IO_PROG -c "falloc $off $blksz" $testfile > /dev/null
+				;;
+		esac
+		off=$((off + blksz))
+	done
+
+	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
+
+	sync $testfile
+
+	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
+	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
+				  grep wrote | awk -F'[/ ]' '{print $2}')
+
+	test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
+
+	echo "Shutting down filesystem" >> $seqres.full
+	_scratch_shutdown -v >> $seqres.full
+	_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
+	check_data_integrity
+	echo "Iteration $iteration completed: OK" >> $seqres.full
+	echo >> $seqres.full
+done
+echo "# Test 3: Do O_SYNC atomic write on random mixed mapping with sudden fs shutdown (10 iterations): OK" >> $seqres.full
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
+
diff --git a/tests/generic/770.out b/tests/generic/770.out
new file mode 100644
index 00000000..17994ed5
--- /dev/null
+++ b/tests/generic/770.out
@@ -0,0 +1,2 @@
+QA output created by 770
+Silence is golden
-- 
2.49.0

