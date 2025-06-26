Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8E277CB6
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939179; cv=none; b=CY2ZuPO/nw8IWVTEURpo4UUn7YeuAng3iq5m+SFW78jLaRj9ApeZ5pNNiyI0N4OO1i7lA5R60MZfMaf8b7mfcJ99F7zPCiDpLRsmHXIpGDlByWs7S9MjTc+uPx709Y2wV063Ktm/l88nnIfWPme68lpfwdoaW46UrXiuQxcQ6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939179; c=relaxed/simple;
	bh=CXkM+A+jKT1Jb2LpQZ4NatquiQIyv+X5cbqloFqh05Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py1T08k2Ny1KV+wjMAi4kL41dwY+TUjY0NYezkCXMmnBXE5CDIes0bolJVuT95xorKQ6P3jtEm8hQqbagfzkTYSzjkAVO0kHJto/rtBriiHFh6GE1Qj3WxoyJMMMBfaE1gUQKrRiPdZPjOuFm6cf87HmFA/rZFF7GzjP1UFXjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JHcH3v4m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JHcH3v4m"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZbi031744;
	Thu, 26 Jun 2025 11:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y+HSYll3R/gdFHwzH
	YkfGbQPrBOj1UsZMtP8BLefhY4=; b=JHcH3v4mBUIblWDUIVF9WxA2YmCImRQfe
	ICAbGIBJQA1Hxdyd2PP0LkuG4ZHUlG3Ky3tQK8Di31nhVdfo0xiUMRedtftclL3e
	IaFC0qKtDVFaGfuVDseetG5yqdBdOeDKf7dCxP5crzbg8XJDtqnvgR/PI33qv0Nr
	kyPvH2JiQYnX5ixANiP7wauHSNTj/60XgmGpCSgj3VlYexqKGpXNx3ALOEz73DLb
	Fv2RtcWpME9Ipw7o+JEEq6oiM0Q4YR3ZVzHPx5fbvfBWL4AOSorTv8AsUQsPIxg5
	0HoOmkzJzwOROCR5t4cZ6Fv1xYklCgP6hQbTfvsywRAW0IuR3s7GA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u65nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBuNLW008056;
	Thu, 26 Jun 2025 11:59:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u65nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8AqVN006400;
	Thu, 26 Jun 2025 11:59:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxSAx31850810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126C22004E;
	Thu, 26 Jun 2025 11:59:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9321C2004B;
	Thu, 26 Jun 2025 11:59:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:26 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 11/13] ext4/062: Atomic writes test for bigalloc using fio crc verifier on multiple files
Date: Thu, 26 Jun 2025 17:29:02 +0530
Message-ID: <8867b7c43cd0e0d430b8479a5fe8148a1c53906b.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 68Z1rKV51Zn89JYOGGKXCctE4QPAixj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX+RLgDDcdJDaE r0GTcAvhzQONwsHF7ypUoLrznfaHAQK0IPYhTsY7/uN/LWJQglRdovHFHfyWaKs0bUIvqwMuZsI KEukt5Pm5HLz55dpQiw2dbNta0qRJ84RMB1WDg/SVqQZEGwTzbUkYACZRzrW4buwJfxtoxZDr/o
 AuMgb5CJV3FPwbC+hNlkMCQi9dRLFRwHkIoWX5NrBemvLPBbwhU7kR2GIBDXKbszyKtEh/SgLmU dbf2dVFKNrka8cCuzBbkeU5whieBUIkNWMUkD5dpk3bl7ZdZAm06Z9ZOSAQErXn8S+kgJBpHk6j AmwPhXwXVAJIvtnDMG2/Dkta36w+2Hf+ne3g2GplwZE0wP8Pz3cLqMUrjFEWAWSPpZSmtZYx+Sz
 OnxFAPPIBbpFtQi9l6q3tmN0n0hyh2XByjvs+B5wrf9WftjTaIqeobzkvyjFgPGzr+wwxv7g
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685d3623 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=TkcjpYBco3HGeQvuunIA:9
X-Proofpoint-GUID: csIrK6ORAGWEjDyYUQDg4C-Xezgc5zQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Brute force all possible blocksize clustersize combination on a bigalloc
filesystem for stressing atomic write using fio data crc verifier. We run
multiple threads in parallel with each job writing to its own file. The
parallel jobs running on a constrained filesystem size ensure that we stress
the ext4 allocator to allocate contiguous extents.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/062     | 121 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |   2 +
 2 files changed, 123 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..d59701c8
--- /dev/null
+++ b/tests/ext4/062
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Brute force all possible blocksize clustersize combination on a bigalloc
+# filesystem for stressing atomic write using fio data crc verifier. We run
+# nproc * $LOAD_FACTOR threads in parallel writing to a single
+# $SCRATCH_MNT/test-file. We also create 8 such parallel jobs to run on
+# a constrained filesystem size to stress the ext4 allocator to allocate
+# contiguous extents.
+#
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
+_require_aiodio
+
+FSSIZE=$((360*1024*1024))
+FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
+fiobsize=4096
+
+# Calculate fsblocksize as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+fsblocksize=$(_max 4096 "$bdev_awu_min")
+
+function create_fio_config()
+{
+cat >$fio_config <<EOF
+	[global]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=truncate
+	size=$((FSSIZE / 12))
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	verify_state_save=0
+	verify=crc32c
+	verify_fatal=1
+	verify_dump=0
+	verify_backlog=1024
+	verify_async=4
+	verify_write_sequence=0
+	atomic=1
+
+	[job1]
+	filename=$SCRATCH_MNT/testfile-job1
+
+	[job2]
+	filename=$SCRATCH_MNT/testfile-job2
+
+	[job3]
+	filename=$SCRATCH_MNT/testfile-job3
+
+	[job4]
+	filename=$SCRATCH_MNT/testfile-job4
+
+	[job5]
+	filename=$SCRATCH_MNT/testfile-job5
+
+	[job6]
+	filename=$SCRATCH_MNT/testfile-job6
+
+	[job7]
+	filename=$SCRATCH_MNT/testfile-job7
+
+	[job8]
+	filename=$SCRATCH_MNT/testfile-job8
+
+EOF
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+create_fio_config
+_require_fio $fio_config
+
+for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
+	# cluster sizes above 16 x blocksize are experimental so avoid them
+	# Also, cap cluster size at 128kb to keep it reasonable for large
+	# blocks size cases.
+	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
+
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || continue
+			if _try_scratch_mount >> $seqres.full 2>&1; then
+				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
+
+				touch $SCRATCH_MNT/f1
+				create_fio_config
+
+				cat $fio_config >> $seqres.full
+
+				$FIO_PROG $fio_config --output=$fio_out
+				ret=$?
+				cat $fio_out >> $seqres.full
+
+				_scratch_unmount
+
+				[[ $ret -eq 0 ]] || _fail "fio with atomic write failed"
+			fi
+		done
+	done
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/062.out b/tests/ext4/062.out
new file mode 100644
index 00000000..a1578f48
--- /dev/null
+++ b/tests/ext4/062.out
@@ -0,0 +1,2 @@
+QA output created by 062
+Silence is golden
-- 
2.49.0

