Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B515A4B0
	for <fstests@vger.kernel.org>; Tue, 17 Sep 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726581523; cv=none; b=AtSHN60xzgvajRq4t16Y3btV2FLnM67O8TdlcKmlrDgWHeE1UwnZyHdPOlUbCA39SRLo1olR927GiiGq7PYxujtFGEmS23u1BuJ1Udr9lDTIKVrhiIjMx7wJtzbFku27atPALP6LWhsyWBUkQnsW+7l+36W1X5hUlprndMPRmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726581523; c=relaxed/simple;
	bh=Ioayja6wIGEQU18cjHJ/fRk4y23Pisp/K7om4Xv+m5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehk45rORqzYT10sETzTfwZiPH8Kbjp9wL/p+QXZvqP7rErnZzW4SaHZtsvs4NkGQ/pgs5IUM5XGE6VzyHISkFRe5beQJC3szAkUKUvF813V40sSh/L5Pt2oVoBlPLa4NTQ80iajNaLBR7CY3rDdYSQIOnHU0Wgs45tEkcPlv8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWZsKMZs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWZsKMZs"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HCtX29030847;
	Tue, 17 Sep 2024 13:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=21UaNLH4w3QQXM
	BqfhZKYsf3574Mz2oItvrDnXw/VrQ=; b=eWZsKMZsxYKzOwVo9WSzTMy8oY7cEK
	+D42mmZJg4M4J7DpM1Rzqwnbsag5fiBza3b07C9ZyXkWL4Y/TKjgyPapx/78UNaI
	sdQjtMS5Liw702XAOPWTQQcEPzIZqmXPNvg5yo3Z4kWq4fk5l19cynzAlTK6lMh7
	HKkgSV/zSXbjRFhtxPeK+fBgKmdjzhn5vL0yGL5uG9LXMqOFpAgQR0XYHZGQYJBC
	IR9U0qbRHgG1T8lBpgIZ4rOeH6vP2xXG5leBYCxhkcoy1u8YUjRnM+GlzAJExnkO
	vypyCYfTUZkF+Of3f7w86NQjNebhNarFpt4R1GZjx8CkAbAe7Ecbx6jg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nse8gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 13:58:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48HClgJk000430;
	Tue, 17 Sep 2024 13:58:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nydv6wpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 13:58:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48HDv14E022135;
	Tue, 17 Sep 2024 13:58:31 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41nydv6wp3-1;
	Tue, 17 Sep 2024 13:58:31 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: fstests@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com,
        zlang@redhat.com
Subject: [PATCH v2] ext4: Regression test for corruption during on-line resize
Date: Tue, 17 Sep 2024 13:58:13 +0000
Message-Id: <20240917135813.1375520-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_06,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409170099
X-Proofpoint-GUID: qVa1xmsmjfxY8tPQklq9j0bXZMQCJpbz
X-Proofpoint-ORIG-GUID: qVa1xmsmjfxY8tPQklq9j0bXZMQCJpbz

Regression test for:
	a6b3bfe176e8 ext4: fix corruption during on-line resize

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---

v1->v2:
- Remove default $MKFS_OPTIONS
- Unmount the device before running e2fsck

 tests/ext4/060     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/060.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/ext4/060
 create mode 100644 tests/ext4/060.out

diff --git a/tests/ext4/060 b/tests/ext4/060
new file mode 100755
index 00000000..38d1c8f7
--- /dev/null
+++ b/tests/ext4/060
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 060
+#
+# This test ensures that kernel avoids FS corruption while online
+# resizing an ext4 filesystem with disabled resize_inode feature.
+#
+# The commit a6b3bfe176e8 ("ext4: fix corruption during on-line resize")
+# stops the corruption.
+#
+
+. ./common/preamble
+_begin_fstest auto resize quick
+
+_supported_fs ext4
+_fixed_by_kernel_commit a6b3bfe176e8 \
+	"ext4: fix corruption during on-line resize"
+
+_require_command "$RESIZE2FS_PROG" resize2fs
+_require_command "$E2FSCK_PROG" e2fsck
+_require_scratch_size_nocheck $((9* 1024 * 1024))
+
+# Initialize an EXT4 filesystem with the resize_inode feature disabled,
+# and a size of 128MiB less than 8GiB, i.e., short of 1 block group in
+# an 8GiB filesystem.
+
+dev_size=$((8* 1024 * 1024 * 1024 - 128 * 1024 * 1024))
+MKFS_OPTIONS="-O ^resize_inode" _scratch_mkfs_sized $dev_size \
+	>>$seqres.full 2>&1
+
+_scratch_mount
+
+# Perform online-resize
+$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
+
+_scratch_unmount
+
+$E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "Filesystem corrupted"
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/ext4/060.out b/tests/ext4/060.out
new file mode 100644
index 00000000..8ffce4de
--- /dev/null
+++ b/tests/ext4/060.out
@@ -0,0 +1,2 @@
+QA output created by 060
+Silence is golden
-- 
2.39.3

