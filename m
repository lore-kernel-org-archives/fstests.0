Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D352CCA9
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939170; cv=none; b=f08RyHfDfzPOfWbRcp/Jkiu0h4rOTmwRDhFX0iu7jvFu/MKQASZInlue+K+SneEpOYuHqzi5VnFytOt+++b9FM9veASA2Uda7fsjpQ9MlgfQ+yW2WoQJZ8d7ewQ4rR4tMgV/BxEkrQpAvtonZVPlMqv9NX2mWcafQ3/igaGhFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939170; c=relaxed/simple;
	bh=+PmUcpWvjWDfrcHSbDlBioRDY42ylDZyDwdKgI7J454=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3zIbEgNwuuTEQ0DFNVTYfZnVAPNDhRd1yq2P8DZ+YN64XsaGcEfeHV4YyPccrZrC+SE+1rUE+HKBO1ufLAC74tEPli7ypoNT6jK9IqM56yiQC90D6gUoqo3ozNyZRpRBF9ay0oELWgIiiC0uS8lq5Xb8apXVqyCdF9J1NxhmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mpqQv67P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mpqQv67P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZTo015816;
	Thu, 26 Jun 2025 11:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0tswQM7DXEqGAdP0u
	cRSQSNHbayLtpjKumtwv5FPJqI=; b=mpqQv67PLG9QUyWV5b21Fut/K042lQkLN
	Evfu7XsM3bGs6LJmbk621I6EB16mKuH/CRWNfYv1MStufVHL9QwWTy/8r8JZRhTI
	a6+ftIZWEEhJZUqcP4VOfgAR8SbBHC8nJEq7kIpi+M8IUn8PNw9BGYMjWn4lHrVF
	KsKLDOf7grOC48aYF0DfMNdf19IKmiT2G1vM+EZ/6zfFxXQCvrqwXGYgGsJWMGJ9
	QTzLYLgnq5Wkf24nrl4ftS1FxOUTktTSu7QOZXfV3zxgn9VubWDAgK7OXr/RIjyX
	nK9qYXEgh9Iom/5ZDn/ADIyzeGloMkA51X/D1LNhJ9FR5sB+Pn32g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBxLNa004263;
	Thu, 26 Jun 2025 11:59:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55QAR4hC014775;
	Thu, 26 Jun 2025 11:59:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2pd3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxI9d53477686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80F0E2004B;
	Thu, 26 Jun 2025 11:59:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D561B20040;
	Thu, 26 Jun 2025 11:59:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:16 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 06/13] generic/1227: Add atomic write test using fio verify on file mixed mappings
Date: Thu, 26 Jun 2025 17:28:57 +0530
Message-ID: <7aa00f0480eef14f269ad28e5e3003e7c32590ee.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX3dvL8UhmBvQT amZ6b0uX4IM+XoYS/3QEqq7IKDLC34i9+TBOvA+1bOTI48G0jbWnko+K5ZXibP37/8GNjAayFjQ ylk9eiB0clgprxIw/jLC+E0cYvX+kcjas0+hHBudUHzMRK8+NI5M8ZKIOk9Q4sreuKqhUu194VX
 1DagY3cVyL2Dvq6JF+/3dGkhil1yhp0jsH/bgPnGMBhh/SGVDthDiNV0R6VK9JzumibmTWvrZtX YD+rzos/Bv07jmWZy2jcSVAKih1sBVxcvPC1GH0xhCDFJsTHH6fx+uPZojkkScIOf9tTx822ghC McDNF2BOwrv9GZo7AIEZqER6rgY7hSX96qk85jk8BxZfhRnbaQ6G6ucWCRev3tSwQsMyxfMuZJv
 GSoA1Ls4rD9ShRQy7ntoaYHJTJQM0BaWZTe5YeHxU8GN6RqZtsesHEIekGSIwpSEyhw3UGWC
X-Proofpoint-GUID: GdDv9ICv0gXmkIbZr6vwHXs4NifroL5w
X-Proofpoint-ORIG-GUID: aW52oAuseQroj1EAJ04KpUMQ7I_89g3M
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d3619 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=Ahe27PiC6ptxRdsnh7AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This tests uses fio to first create a file with mixed mappings. Then it
does atomic writes using aio dio with parallel jobs to the same file
with mixed mappings. This forces the filesystem allocator to allocate
extents over mixed mapping regions to stress FS block allocators.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1227     | 92 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1227.out |  2 +
 2 files changed, 94 insertions(+)
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out

diff --git a/tests/generic/1227 b/tests/generic/1227
new file mode 100755
index 00000000..e2668758
--- /dev/null
+++ b/tests/generic/1227
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1227
+#
+# Validate FS atomic write using fio crc check verifier on mixed mappings
+# of a file.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_odirect
+_require_aio
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
+
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((128 * 1024 * 1024))
+
+cat >$fio_config <<EOF
+[global]
+ioengine=libaio
+fallocate=none
+filename=$SCRATCH_MNT/test-file
+filesize=$SIZE
+bs=$fsbsize
+direct=1
+verify=0
+group_reporting=1
+
+# Create written extents
+[written_blocks]
+stonewall
+ioengine=libaio
+rw=randwrite
+io_size=$((SIZE/3))
+random_generator=lfsr
+
+# Create unwritten extents
+[unwritten_blocks]
+stonewall
+ioengine=falloc
+rw=randwrite
+io_size=$((SIZE/3))
+random_generator=lfsr
+
+# atomic write to mixed mappings of written/unwritten/holes
+[atomic_write_aio_dio_job]
+stonewall
+direct=1
+ioengine=libaio
+rw=randwrite
+bs=$aw_bsize
+iodepth=$FIO_LOAD
+numjobs=$FIO_LOAD
+size=$SIZE
+random_generator=lfsr
+verify_state_save=0
+verify=crc32c
+verify_fatal=1
+verify_dump=0
+verify_backlog=1024
+verify_async=4
+verify_write_sequence=0
+atomic=1
+EOF
+
+_require_fio $fio_config
+
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config --output=$fio_out
+cat $fio_out >> $seqres.full
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/1227.out b/tests/generic/1227.out
new file mode 100644
index 00000000..2605d062
--- /dev/null
+++ b/tests/generic/1227.out
@@ -0,0 +1,2 @@
+QA output created by 1227
+Silence is golden
-- 
2.49.0

