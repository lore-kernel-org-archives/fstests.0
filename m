Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC7277037
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939175; cv=none; b=DOeOJfD8yog00UA+w8jV99/43XCjut/GosBlX3GtmjTsyv8h8QjVemOsNiFooNkAouxeYgQ6tC1sDuqYVRnC7cqPIDWXACDQEafFroLdexY7jnaywq54glck4E8DGjyzdD5xQoqsq2Z/EKBhsUYL67P6NhBXiar/XeozofcsMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939175; c=relaxed/simple;
	bh=qfTNrVszUJrJ9X5OWWdIiNeQVrPCrDeBfKMcJnCHPrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG5hQTY3JNuSCAlowwBe4Akb1vc2M2XIjrXfLtF7gCTO8HL9i5ZXUP23NrDUOl4OvAjclaJC9nzGnIR4huuHBTKaAoDdmNiCrNGPir3rGb/R1JQNjEHC8V6+0Otlt+3MYaKsfAUt1H+K9/iAxlyPB47DWROyAsRLdsfxx2rWG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLG086Iv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLG086Iv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZw6015789;
	Thu, 26 Jun 2025 11:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jnPUZ5Gvv3upS+qTq
	KyPnVTG8IdhzTg0fV6sfLAbL/4=; b=oLG086Iv+U1b8yoUEN8M4vwJYIYLqkE9v
	jzzgVmfuM0ml5cBGCBfbB56uaDE59++x3u6maE4y5IX299GfQe83XcPN+91E0Mv+
	OycdYGchXdH4AQSdI5EbWR7dC46q2nmgt0Kbxbpu45OrA32O1/CboEd1zYoKtS57
	uzvQfClAPNd1owhDBdkXSOaj2Jc6dbyC323WezO2zTlViMviDSoteQFmglK/xQeW
	vnob+PwsYI0pOLVaFOote0wdwVbYpFehYZmo4maR0GbRsUHHmSPsUV2u3TvFpbKs
	YVtdF7qlen16eci9PTcVJbT7eHEGzZoaZEhSa8zJlkf6pM8F1FRkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBmORa010330;
	Thu, 26 Jun 2025 11:59:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8WP8l006414;
	Thu, 26 Jun 2025 11:59:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxKiC33161936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70A6520040;
	Thu, 26 Jun 2025 11:59:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D319F2004B;
	Thu, 26 Jun 2025 11:59:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:18 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 07/13] generic/1228: Add atomic write multi-fsblock O_[D]SYNC tests
Date: Thu, 26 Jun 2025 17:28:58 +0530
Message-ID: <ebfae5c51171ed1a8685309d11f1f9783a53c653.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX0AIAYLFBM6Fn eYW6Qwr/ImotaHYk6/s7xx9gCNkJceCpibgAx4CUIA+UvDHjizkfb8aBKuzAGbHi2dnQnd2K1oV 96nRuIdn3omY9dHefXfPlNERqthbz4X8zg5MhBXpfIFUlxv53utNyRign9pqqAtOlWZiQRo8FK2
 /z8/G1k5qSUCsqZwVCcsiGvKXqPDCC0Y1fgy2+RqQ+5ODrdB09Uq4/WAuOnMxMkpyUcz1FHcj5B u1o/ZWG1Y/NsaC00ho7VRo8FVX53tqzSlTcAsTsMx+gEbVLibj7wsZNFblgbig/zNjaZJAMh0Lx NqZzqPTgbt4OSmROxcZpN/yIlF3KBHC6LvKHYCmqsVP9ID894zgt8KZEJNONQYD5yJ8B7GJsGQc
 eItDnX5glN6hOLZyjopodkrBYWp6jSgzf9BXpGuRISRBpnDgG219sf6HmP1IBRdkdvLEBoj0
X-Proofpoint-GUID: w6Ia0qGmhs85-oFAjyXLoIdDXipEm4HZ
X-Proofpoint-ORIG-GUID: 2gG0YoMr7-AcJngWR7zlvo59OrlxSxHR
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d361c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=gLbHiHCgn5DP7liA1jIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

This adds various atomic write multi-fsblock stresst tests
with mixed mappings and O_SYNC, to ensure the data and metadata
is atomically persisted even if there is a shutdown.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1228     | 139 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1228.out |   2 +
 2 files changed, 141 insertions(+)
 create mode 100755 tests/generic/1228
 create mode 100644 tests/generic/1228.out

diff --git a/tests/generic/1228 b/tests/generic/1228
new file mode 100755
index 00000000..3f9a6af1
--- /dev/null
+++ b/tests/generic/1228
@@ -0,0 +1,139 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1228
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
+_require_scratch_shutdown
+_require_xfs_io_command "truncate"
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
+
+		_fail "Data integrity check failed. The atomic write was torn."
+	fi
+}
+
+prep_mixed_mapping() {
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+	local off=0
+	local mapping=""
+
+	local operations=("W" "H" "U")
+	local num_blocks=$((awu_max / blksz))
+	for ((i=0; i<num_blocks; i++)); do
+		local index=$((RANDOM % ${#operations[@]}))
+		local map="${operations[$index]}"
+		local mapping="${mapping}${map}"
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
+	echo "+ + Mixed mapping prep done. Full mapping pattern: $mapping" >> $seqres.full
+
+	sync $testfile
+}
+
+verify_atomic_write() {
+	if [[ "$1" == "shutdown" ]]
+	then
+		local do_shutdown=1
+	fi
+
+	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
+
+	if [[ $do_shutdown -eq "1" ]]
+	then
+		echo "Shutting down filesystem" >> $seqres.full
+		_scratch_shutdown >> $seqres.full
+		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
+	fi
+
+	check_data_integrity
+}
+
+mixed_mapping_test() {
+	prep_mixed_mapping
+
+	echo "+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
+	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
+		        grep wrote | awk -F'[/ ]' '{print $2}')
+
+	verify_atomic_write $1
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
+echo >> $seqres.full
+
+echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping:" >> $seqres.full
+echo >> $seqres.full
+for ((iteration=1; iteration<=10; iteration++)); do
+	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
+
+	echo "+ Testing without shutdown..." >> $seqres.full
+	mixed_mapping_test
+	echo "Passed!" >> $seqres.full
+
+	echo "+ Testing with sudden shutdown..." >> $seqres.full
+	mixed_mapping_test "shutdown"
+	echo "Passed!" >> $seqres.full
+
+	echo "Iteration $iteration completed: OK" >> $seqres.full
+	echo >> $seqres.full
+done
+echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
+
+
+echo >> $seqres.full
+echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
+bytes_written=$($XFS_IO_PROG -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" $testfile | \
+                grep wrote | awk -F'[/ ]' '{print $2}')
+verify_atomic_write "shutdown"
+echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
+
diff --git a/tests/generic/1228.out b/tests/generic/1228.out
new file mode 100644
index 00000000..1baffa91
--- /dev/null
+++ b/tests/generic/1228.out
@@ -0,0 +1,2 @@
+QA output created by 1228
+Silence is golden
-- 
2.49.0

