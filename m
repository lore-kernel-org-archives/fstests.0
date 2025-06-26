Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF93274FFD
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939178; cv=none; b=HjH6F2ZNS0fCBtCm6/gX/YNa8bNrSLMqAz17ACBXZUQZzvlSOlCeeLvtT5E+kxE6tKf0IiB6g+eB1hs1dQcblvD6qTs+PfgtlhJqbYVyoqMboMJaFZ9RyyygWZqQovFQuumvbkv4ngnsqGvXOCGCKlhSVZfE0ZhnAS2r7x/pfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939178; c=relaxed/simple;
	bh=WanGwxHlBHd/+1ooGk/OJ6/nLWjp8/ahCzh2gOmWpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkeXSaqx7SErxfIADGLxEJpB2lTr5l4wLHBDgXes3gCJXYCI4xyEcxHaWNY2Nnt/TExkUBtBEAq+TlHRWqQRuAC/MnxO/qy1Cx+UtOFCXWtMVK3iVd0pCdvsuB28STMRuiog0SgsVCWHpCo/D6lYNwBHNsKoRv0z2bfbfVGrtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3AdOoiv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3AdOoiv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZw7015789;
	Thu, 26 Jun 2025 11:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QfO5LbuVEdFD6MYBG
	+KY8MBTI7LF3bPGUyNsn/KAUzs=; b=E3AdOoivJiR6Rs3x+3BLTI0YftDUJBGk3
	WIE6CLnDYjrQ9ZOKeEmVbOm4fwr8AYHgyAJQvCFXAAbrpzi8DP4Ul8n1ApdfcHRU
	UjNqilBC9m57fQ/DoHtqjvPWbxtzgDiQ3xhUsMl0jwNyIEPwuLdaj6chZc80kLWc
	LnX6gk3OxCeeMenzH69Cy6d66NVHs84pLNEsMIDwe+WpZZAlfvjG/pFMJhWdqYuz
	8EF9OUy7uO8OA4uBbzhl1lTSPfDj9C3xmb8gipfLgjwGG1AIQY4srd8HGYI6RBEf
	d5y5v7RJ/U6ITemJvlei21Bp5/94CMQ/WZgb1xyOUYpFIfeNwCE4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBhUqs031745;
	Thu, 26 Jun 2025 11:59:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q95alR006397;
	Thu, 26 Jun 2025 11:59:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxM9257671970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A4732005A;
	Thu, 26 Jun 2025 11:59:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D438E2004B;
	Thu, 26 Jun 2025 11:59:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:20 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 08/13] generic/1229: Stress fsx with atomic writes enabled
Date: Thu, 26 Jun 2025 17:28:59 +0530
Message-ID: <53a8d709e20f53e73cc8cd846cfbcf0fb60a432c.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX0tVukT+HcD/L +v+gWIBS2R0KUERxEQ0agln+ep337JZR8jfiLcPoxVNqRV3CBWFtoIEe7KSPBbAtY2p9dgV+/3J /F3xkAIgIAf8HfWZyt+Z5N5rB8nhuRhf8/0MaNLdojhzW8aaW9pFb/irvyZxT5DZpSnO8xoXH73
 Xon1LDgbJQIfN+RiqVbDGuU7yyyEz6CzmZhqShGvV34qb48DHECjQXn9pF3BeUtNJqaQFRCEH97 B+4zK/V9eyyroY6oxWMNzu+nWhevOMZAX895rYx7tOcsJD0bWh9zvu20+2dRLfc1p+RvPj3SWtD gsQlKvLpUlRNP/WYs4Ybh426dh0MrEnXyRG8wFlwKo46YKF0zP/+JELDOPcdVNhTPdijY3r/8S8
 tjgL8PuIJ1KyF0a9G/nK9Hq0q/KwQxH8lFau9jih8gZduJeV2Yl7d4TuTFuGph9ei/RJHO5k
X-Proofpoint-GUID: dahhY1JFel1MK8Ue8oj-2PTZu0_7dncw
X-Proofpoint-ORIG-GUID: XykLUp6vdTvC9iNSZQQGv1cxf9xGugWi
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d361e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=JyoSrJM7ovCTkwbihYMA:9 a=U1FKsahkfWQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=784 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Stress file with atomic writes to ensure we excercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1229     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1229.out |  2 ++
 2 files changed, 43 insertions(+)
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out

diff --git a/tests/generic/1229 b/tests/generic/1229
new file mode 100755
index 00000000..98e9b50c
--- /dev/null
+++ b/tests/generic/1229
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1229
+#
+# fuzz fsx with atomic writes
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest rw auto quick atomicwrites
+
+_require_odirect
+_require_scratch_write_atomic
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount  >> $seqres.full 2>&1
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+
+# fsx usage:
+#
+# -N numops: total # operations to do
+# -l flen: the upper bound on file size
+# -o oplen: the upper bound on operation size (64k default)
+# -Z: O_DIRECT ()
+
+_run_fsx_on_file $testfile -N 10000 -o $awu_max -A -l 500000 -r $bsize -w $bsize -Z $FSX_AVOID  >> $seqres.full
+if [[ "$?" != "0" ]]
+then
+	_fail "fsx returned error: $?"
+fi
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/1229.out b/tests/generic/1229.out
new file mode 100644
index 00000000..737d61c6
--- /dev/null
+++ b/tests/generic/1229.out
@@ -0,0 +1,2 @@
+QA output created by 1229
+Silence is golden
-- 
2.49.0

