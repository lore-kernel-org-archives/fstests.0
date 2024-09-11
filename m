Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085A165EFC
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050141; cv=none; b=oHVnIMFszJmpzVgQ1MUE8CyNUf1uJawrX36xCcOdrQpfaZre/z6kn6sWNBK69j6d2ljSdErFyHqxImfxMrsJuAo75r3j3hZHlKJ03IRMeQnX9+Fqhre15uDdhLPLx2j2yBZ+TMugCSt9wBvaTCS/eplLaxIIyw+jECPjkWohXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050141; c=relaxed/simple;
	bh=S7sGarAjhBy0iDEKTRneCgbkp/NiEnehoFXMrH8C7qY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQLNTueibgGBB9NNPaxvkQa3JD3gdsYsnBJAn0QHbA6Jem6cH+2gjvQ9k7n72sIPIMfnjiuv5z4DAJyYP8fNhSzeJAHHiPuXlwvzN2+L+nVny5N408Q9dsaLQiv5ldG4twfeam+sojFuxpG0ccKYlou5ENPZkOjXwe/uQZvaciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XPWSLnPm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPWSLnPm"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B4GQfW010390
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=lyDbT+k4LfOe1n
	cy7vlNbKKMQo13Ui+3nf/yMamPpd8=; b=XPWSLnPmrK9lseOjVHQBRifqbaTzOQ
	DscfRfbKpSD7XD7jZnuF/gPsinqkNEbJipF69pqglw/yY2KfD4jP4H+pfexh4tZX
	/+9mBrFpYahS11d9DBC+DJjQVDT/wt6ihdJGxHrALr2gAvz6GrFpzuoLbwfF/1bW
	MWYmRjOmD4BFkTzxfohLFUN/gEJW6YvmlJRfaiqGPxdG9z7a+RCoA/RPQg4a4a47
	DbhDvhwgBOoky6kpdNYkN3IJW2HzMiAexsz+1VtD0HSoAO9TNo7iyJ7TSO7dEx+O
	gegkduU+ZuZOTljs0PK9NTMgyAtJr5KtDqJsf2xgTHLfl8EMl6syoRlg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcqv5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:22:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAKatt040804
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:22:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9b8cr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:22:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48BAMGxe022064
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 10:22:16 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41gd9b8cqp-1;
	Wed, 11 Sep 2024 10:22:16 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: fstests@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH] ext4: Regression test for corruption during on-line resize
Date: Wed, 11 Sep 2024 10:20:45 +0000
Message-Id: <20240911102045.71870-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110076
X-Proofpoint-ORIG-GUID: trA9Tyz9vI6OyuEBP5eX2YavbtgfApE0
X-Proofpoint-GUID: trA9Tyz9vI6OyuEBP5eX2YavbtgfApE0

Regression test for:
	a6b3bfe176e8 ext4: fix corruption during on-line resize

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 tests/ext4/060     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/060.out |  2 ++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/ext4/060
 create mode 100644 tests/ext4/060.out

diff --git a/tests/ext4/060 b/tests/ext4/060
new file mode 100755
index 00000000..440748ea
--- /dev/null
+++ b/tests/ext4/060
@@ -0,0 +1,43 @@
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
+MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
+	>>$seqres.full 2>&1
+
+_scratch_mount
+
+# Perform online-resize
+$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
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

