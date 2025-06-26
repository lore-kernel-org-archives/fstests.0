Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4B277CAD
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939184; cv=none; b=WAxmYR00ZislwxaSm4uHgd0D/bFe1U7d3b/DyOA4TioWnUzKvZmQgTvIZAjF4rzvkPci9iY0JDObW8NvrbGlUlQYglaIx7shMJCOGSWhiTKzwVO0hzlZ/OPxFBNF6oBnfEIvXHhzXL/aYebE4dxZd2+US5iyO2nT0AqtPw7NwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939184; c=relaxed/simple;
	bh=EWZ5P3hK76Z6OvtYAHftlDXYHxIiGpzvT+Filq2kvaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQrpjrcpmdmtfrjpR/qbyFnslSP2t6GZjAPT4Y/s9IGiQTGbnc8U56mTnc8F18Uzt6B3t8DW+RJnL0BBp8BEl1frJgfU+FnF6cjtqYg5traQfi0w9rbZqMh8Hui9IHGdCOWH+DExtICmUxd7rtcpKIMOvqX84F1XfOwKcDa4eTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xupe33MD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xupe33MD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AU97010678;
	Thu, 26 Jun 2025 11:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Qp+LtOx7GmPwaZCz
	tYC+3HTAkC8Ob0pTvDIkziBgsk=; b=Xupe33MDiPQA+VRHQNUOOw61DtQgVuqSv
	Wqa4FzJaYJOS7BMj96cIJp816BqLE8bToD4Qv+WqAAD12KAyQIjtvUb8/QcFbHXA
	8CuFrvV1GW+2kXctesBk3jRMyQKJ+xwMZGuTauPy2yrWJQjd7cmlPF1Hv5Vx7D6j
	+Xw1MOzRhfBrVDhi+QbvJ7bQDGhLGDdgSetDbHSuigw6Cm+aL3bg0LV1EF/d0a2E
	c1/FgDQXV3FGoevitHDQDISzSux7i26SbKsXuTlwsJKx5OTHHoZadHpuHzDJuwAn
	eqexr6jrmJ51sCKeVueIw49NBA3WGmhAP6yTO3HBr4MT6JwaGkaHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphm0r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBwbx5023376;
	Thu, 26 Jun 2025 11:59:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphm0qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8XDFi006513;
	Thu, 26 Jun 2025 11:59:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxW0O53477696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBAF82004F;
	Thu, 26 Jun 2025 11:59:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FDEA2004E;
	Thu, 26 Jun 2025 11:59:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:30 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 13/13] ext4/064: Add atomic write tests for journal credit calculation
Date: Thu, 26 Jun 2025 17:29:04 +0530
Message-ID: <9765ff8c08f177bad0fce6391d849031d6b69973.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: fir3synBVUmUXzUaIagh5yZjPccj3nB3
X-Proofpoint-ORIG-GUID: eO-r3FAFNim89-F9iSZ_Z6jgjQrsaF6G
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685d3628 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=s1tx9Ns7CSuJm8OCEucA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfXwMCReI1ppn76 IA3aBYHOY4brmDrRraVyiPbYGFd+L3pC5haA00pETupZVbCnk751QWh2trqRmWKr62/IajgNLro EpWk1myDJ3PUfbR4TFaPGFRDBKdDDIyoiZISHBIIn3THEQcNQh46OdK1duK8t0sNBRODepb6UJZ
 o1eAygNWG6jZptEz4DoIPenPOreDtZDMPq9TwX6NZyXm2L5p/uqOtDbES2PmtFvuAg1CfnTpC5r cRXgUT+Hrmd/s3SSTw83RwJQosxejKxzU45POdeIpKnPTtOAfDLi6oReyYThyKm2TpzZeIpa+Xy DTQlA1TAwrBnmkG947Ek5EpWmSWaFpogQCCHak1AGrvjYQ48HvDbbGBOsvKw43V8g3QCto7wWCc
 ZlqBRDjnH1pHVD73NbnK5ITWBPSKTpAScXWKWi5iN53aWl0gRj/vXa/YSjmH96k0gvxz39Cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Test atomic writes with journal credit calculation. We take 2 cases
here:

1. Atomic writes on single mapping causing tree to collapse into
   the inode
2. Atomic writes on mixed mapping causing tree to collapse into the
   inode

This test is inspired by ext4/034.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/064     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/064.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out

diff --git a/tests/ext4/064 b/tests/ext4/064
new file mode 100755
index 00000000..ec31f983
--- /dev/null
+++ b/tests/ext4/064
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 034
+#
+# Test proper credit reservation is done when performing
+# tree collapse during an aotmic write based allocation
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto quick quota fiemap prealloc atomicwrites
+
+# Import common functions.
+
+
+# Modify as appropriate.
+_exclude_fs ext2
+_exclude_fs ext3
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fiemap"
+_require_xfs_io_command "syncfs"
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+
+echo "----- Testing with atomic write on non-mixed mapping -----" >> $seqres.full
+
+echo "Format and mount" >> $seqres.full
+_scratch_mkfs  > $seqres.full 2>&1
+_scratch_mount > $seqres.full 2>&1
+
+echo "Create the original file" >> $seqres.full
+touch $SCRATCH_MNT/foobar >> $seqres.full
+
+echo "Create 2 level extent tree (btree) for foobar with a unwritten extent" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
+	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
+	     -c "fsync" $SCRATCH_MNT/foobar >> $seqres.full
+
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar >> $seqres.full
+
+echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
+$XFS_IO_PROG -dc "pwrite -A -V1 4k 4k" $SCRATCH_MNT/foobar >> $seqres.full
+
+echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy >> $seqres.full
+
+echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
+$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
+
+echo "----- Testing with atomi write on mixed mapping -----" >> $seqres.full
+
+echo "Create the original file" >> $seqres.full
+touch $SCRATCH_MNT/foobar2 >> $seqres.full
+
+echo "Create 2 level extent tree (btree) for foobar2 with a unwritten extent" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
+	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
+	     -c "fsync" $SCRATCH_MNT/foobar2 >> $seqres.full
+
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar2 >> $seqres.full
+
+echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
+$XFS_IO_PROG -dc "pwrite -A -V1 0k 12k" $SCRATCH_MNT/foobar2 >> $seqres.full
+
+echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy2 >> $seqres.full
+
+echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
+$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/064.out b/tests/ext4/064.out
new file mode 100644
index 00000000..d9076546
--- /dev/null
+++ b/tests/ext4/064.out
@@ -0,0 +1,2 @@
+QA output created by 064
+Silence is golden
-- 
2.49.0

