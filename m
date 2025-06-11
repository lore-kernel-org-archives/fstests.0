Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5668264A97
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634528; cv=none; b=A2bC9u4MVyDM9Xc4zckn8QO6GG2Pmbc7zuP70gYkOk20nbwW61coyURpLflgrStC0oAuWkChSt2VjgkSymz0yd+DaSGudUnb3nNEtxO1Uab3bMvLtDXOswspVeSxTSnnNEfQ7PPvoB4tnQQN2zanLfnywW8TFGrdzxAuq4slhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634528; c=relaxed/simple;
	bh=hqKghHuTSoGtPSpZf4BgRY2u8nrGiWzGndGQ1Emv9uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAc5BuxEPZQZyAL8MctTNMqtsDbELLZQa2Yidunnd4rcuETYh4it59NMp11kbTcNNyHZCZqjjYEXWj2z8bdJBtNXvpn7SVy0AIxWFeGXJKBziP9Lkc4RG5/c1GyMND3gXozgJFShUEGKusb0ufxTxZwzfaf/kXg6Gefno3IdcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sfU3ZN2j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sfU3ZN2j"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B5cR1d003604;
	Wed, 11 Jun 2025 09:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mLHA90HwbE73CBto5
	wRi6zI7QgvaKFytuq8fOMagFCs=; b=sfU3ZN2jPq+mK1cRyB/dXa1ffxQkjVKue
	sHRFmyPQey5eHm0tnyLzqtQjObNIefH1SJnforgVPtDM10invHlPhFDagRack9d+
	a5v9ZylREYytG4lDjSs4UMrr700XQA0Xj9+iF+NRSSvFPaQy2ryWvETm+RE31Qro
	jnlWdKFG/HbCPCXIEnV9BKOeHW5xWtuy1d67N2nr8zOLN+/csVnpQqQt6zdsxj0S
	qALuuYv7aebbXM072jDwUHazZkt9uaP5+xoBZys+Dln+qDR/gZ3L1IDFctKCr8c8
	iJoBXabhDJUzmN2xwbK/GbXGr1szcrUZ6ONPkkHFmi3cYszIcRH5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjbnvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9U3Xw018189;
	Wed, 11 Jun 2025 09:35:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjbnvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B92dOH014908;
	Wed, 11 Jun 2025 09:35:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp7046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9ZJcO56557926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35DA2004E;
	Wed, 11 Jun 2025 09:35:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F4732004B;
	Wed, 11 Jun 2025 09:35:17 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:17 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 12/12] ext4/064: Add atomic write tests for journal credit calculation
Date: Wed, 11 Jun 2025 15:04:55 +0530
Message-ID: <62f2d373b7ac8f1a5f49013ff64ca3051f7f803c.1749629233.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ddHpIBp7MjIq77PUR0ihm5JA_JNeRsCk
X-Proofpoint-GUID: wD11KjkPQ4V8R3uiuryM5zCgbnrC_-lS
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=68494dda cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=s1tx9Ns7CSuJm8OCEucA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX3F720xSsdDkz /GFChDRYK6BTtsoz1YCEhdlzjCfJae/Lw4U0UI+d/PaiWbSqB85eqE/oK+dP/Mfb7X89qKPhYXn kk6xAJSEBbzwbUwLHAoTU3ymrhEb//Tx6nYlBEaJ8D0FaWQhbb1veam9qhHlOcZeXQ00lRAqFG2
 yU0Wu1Y/Bb/oHmmZrK8t/zHhbVrIcoyffonqq8FMbhw+f6k4PBaEo1f6HzLeHRaHLLsFYxFRjNq vVruDHsPB+FosBCNvWPJ3fkqBv0578qgNWKPGM84tfwmqJQ4AJsbScjxTuPGUp7YwAoq9f6ZLSY gTVkgNA11Nj+/JAmPYXd1gWOQOna//DSPiyBwRX3x7LkF4K0fOhDOLfQ/3VVuX2+PsTBmig8llv
 GZgAEVhK+biMEwWpfcRFtfkWKcb9uSk3bvsGddNiDMK/EXUf8LPbwns5lV231f0Jf3ZfGjPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

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
index 00000000..12e48ae3
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
+echo "----- Testing with atomi write on non-mixed mapping -----" >> $seqres.full
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

