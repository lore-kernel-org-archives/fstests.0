Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560953379
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846990; cv=none; b=gNo1IzOxvaUpqczLPicbsi6o3OYeWvsDxNwgA2CN+bqI09lMJrZASkU/mUozdD9eO842xb9rGB/jMccMuJvn72cmc+Jpq9VQaMg/GUDMsN6Mv3XLEEPAm6dlZ7wmtv0r90JRoZmGwhmSybskYpGvtWIoeNIhP1oygbN5rAQQjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846990; c=relaxed/simple;
	bh=5/VN/K4I7YGKuSbmN0XMRCLL+ElRxEwOk8rOUm8mV2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=igxwTT+w0jKdYwP3wYRykOP20/5/hyBwWvb88ATBZWFFwXHs+OPj1a4GVeruT/esMHYPSGu1+9G0bmD9G0aUq3Nv4sxFeR4bkbX6QzzniCL5/UEDZhSZPDhnmwr0TjA3MZuWX1p+fyLIJHS/aFFUCmgkKsppOqKd4iU0wVp1wL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A1SZgt2T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A1SZgt2T"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAkgCh004608
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 11:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7l/vtGSqqMkY38HmSmnrSPY6/n/JOvoqWnVrqsNBSNU=;
 b=A1SZgt2TqW3jG3gYsxh+T5mAYispFttZsaoTPWDo9/+/6nKqz8Bzt7W1YQseckV/4Iki
 g/+O785DDb+Y+WZ+twW4gWTNOf9OSTIwG/jhWqtx7XC1exFUQ7iw8AgwfgOFIS4sDgsk
 UZ6T+ZbY5kWaYVsybFjhTHerkob0ftoUkwkBJTex2gcdiGF4oyCBtCVYlps1lU8Vywyt
 ZybSlMnOmZ+VXVhVxp7+QJsW36QDxbbsTZUBkRLBWXCDKXUXO7dFz3ehivl7CkIMLD8W
 h8kLEhcA3czF35BMHDY8Lw1m9zuI7/bYp8d4uvEjJWno2kIkj/eO4Coh3D6INUNcYEPi 8Q== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy8trrc2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 11:16:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J8RKZC011594
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 11:16:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kxtpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 11:16:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JBGLoO51773858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 11:16:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 560F62004D;
	Tue, 19 Mar 2024 11:16:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B94320040;
	Tue, 19 Mar 2024 11:16:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.252.32])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 11:16:20 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: ojaswin@linux.ibm.com, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] generic/735: improve test by incorporating extra hints
Date: Tue, 19 Mar 2024 16:46:13 +0530
Message-Id: <20240319111613.11029-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: shFKmmsavW0bajOXD1GTebku0kcZbw2H
X-Proofpoint-ORIG-GUID: shFKmmsavW0bajOXD1GTebku0kcZbw2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=938
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190086

On power systems with 64k block size (where default page size is 64k) we
encountered a kernel oops due to an integer overflow issue when writing
near the last logical block of a file. The allocator could allocate a
range where the end exceeds the maximum supported logical block
(UINT32_MAX), leading to a subsequent BUG_ON. This issue has been
addressed in the upstream kernel with commit 2dcf5fde6dff
("ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS").

	==================================================
	kernel BUG at fs/ext4/mballoc.c:4448!
	Oops: Exception in kernel mode, sig: 5 [#1]
	CPU: 8 PID: 2880554 Comm: xfs_io
	NIP ext4_mb_use_inode_pa+0x110/0x160 [ext4]
	LR ext4_mb_use_inode_pa+0xac/0x160 [ext4]
	Call Trace:
		ext4_mb_new_inode_pa+0x134/0x3a0 [ext4]
		ext4_mb_try_best_found+0x158/0x280 [ext4]
		ext4_mb_regular_allocator+0x16c/0x940 [ext4]
		ext4_mb_new_blocks+0x610/0x960 [ext4]
		ext4_ext_map_blocks+0x858/0xa90 [ext4]
		ext4_map_blocks+0x218/0x800 [ext4]
		ext4_iomap_alloc+0x10c/0x260 [ext4]
		ext4_iomap_begin+0xfc/0x1f0 [ext4]
		iomap_iter+0xf0/0x190
		__iomap_dio_rw+0x208/0x690
		iomap_dio_rw+0x20/0x80
		ext4_dio_write_iter+0x210/0x4d0 [ext4]
		vfs_write+0x364/0x4e0
		sys_pwrite64+0xd4/0x120
		system_call_exception+0x164/0x310
		system_call_vectored_common+0xe8/0x278
	==================================================

This test has been extended to provide a hint about the relevant fix
in case of failure.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 tests/generic/735 | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/generic/735 b/tests/generic/735
index 75b23d5e..0ba111a6 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -6,16 +6,19 @@
 #
 # Append writes to a file with logical block numbers close to 0xffffffff
 # and observe if a kernel crash is caused by ext4_lblk_t overflow triggering
-# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
-# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
-#
+# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for
+# commit bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
+# commit 2dcf5fde6dff ("ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS")
+
 . ./common/preamble
 . ./common/populate
 _begin_fstest auto quick insert prealloc
 
 # real QA test starts here
-[[ "$FSTYP" =~ ext[0-9]+ ]] && _fixed_by_kernel_commit bc056e7163ac \
-	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
+if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
+	_fixed_by_kernel_commit bc056e7163ac "ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
+	_fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS"
+fi
 
 _require_odirect
 _require_xfs_io_command "falloc"
-- 
2.39.1

