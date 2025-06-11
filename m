Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234E264A70
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634520; cv=none; b=imGkKtDT8M3804RhpPlZV6fhrG+LaMAlGTqmP+YF8hy4GAOMdDAD0QH3meWRi6zPShXq2NJEG8/+V977/2iIKNcQILQsKc2+wWXS/EZINv+RwnaoY8T2LmbtPIvX9BnX5r3eaf/srz5fTFg6aAaBq25UNhOb9ZIDXS2+dTNgJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634520; c=relaxed/simple;
	bh=VeUJZ4eCD4N/5zUZos4W5VlMRZcofm2RXgmeKcBvfZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dspA6SnFXHVoD1J4jwaM7/Xp50xTNcTdNDe8CNPMQ48Pm2QsyyHAyPEvAm7Fa477XsGCFqCaV76LTT2JGOUnt45AM0If04nn9ugnNSOSOX3n9KC1zq6sbsThEy8P4EPcT5i5mi/GOVbdDhUqyzybH42XRAqKGuBBVExBwAsoHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyFtIkXL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyFtIkXL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7aa0w007588;
	Wed, 11 Jun 2025 09:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BI1ceOIPTnthe15A1
	Y6BlT1N4/U1WJ3FDI9jVc/Stic=; b=LyFtIkXLjH3Vi3x7yNQKV/iEb2MOVSt0u
	LNwMcpN66Kd8jtI7szcFIQjzFQrapFP6yAoufH5MvdtgqPZGrdEXuFiFROdQcGJz
	tmKQZo0tnD2G3l9h8kUPPrhUGVN1noB7okWPwFVC8p2r7kwQb/itYo0X8ZDC6h5E
	WuoYm+u6ZxURvZCV+b8PHbYuCtqlmXf0t38jS0PEs2zaSa3u+WnyfXNrkWRVWFW1
	Nu9j6Hv7vSWv4Yz25b9Q8vruM/kSPRqxumXc4t/GJeES5vuxGmRxw676jpj+6CBP
	zzD081xbMx+XLzde8xolkleW+TEQV8mCU4FWs6cDtjPn14aH0LciA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3je1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9ZCAM020947;
	Wed, 11 Jun 2025 09:35:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3jdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8Plv4015180;
	Wed, 11 Jun 2025 09:35:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtf8fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9ZAMk41419254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 977642004B;
	Wed, 11 Jun 2025 09:35:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E55F20043;
	Wed, 11 Jun 2025 09:35:09 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:08 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Date: Wed, 11 Jun 2025 15:04:50 +0530
Message-ID: <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68494dd1 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=TvWH76wYgg8AaOexQP8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX8VfdkvXiDUEq Nlap78q6f01yNUXpFGayo+chnkI9oTKdWkRb0pxGTXwzHrVHqFFgUt6KdU2j3ajFmTm/JyP51s1 rFlZIkNlJwmCm+2reB6LIjZFFgD85Z43avmAhku89smI2D9c7dbdRraen0TyUl5X2g/95uNVoAP
 e+w7qS/akOfq8N/mnyoV4nCjDSEHATSPVvPuHfJVe9fKjgSnL5mOAtekUXpdCiTkPEIyWZkRUoN qhrR21sDUKqutd/gyqlwuLEvUlaO1JLL9ff2IYGo+w+UENHhuYLg2R8Fdz6Me78pBfu8uZ3PrgJ Yy0hg6EFfgvTFChpcHOU/Wqa5iXfBjCbiTHshxCsHU2Jhmp3KdIKOZjuegfMP5IZ+lWgfH57mYQ
 cpTGIl6LTBxofsdevaOlVqY84nnX6BVFvKLyMh9qFfKJuOLotpzaOlba9dkmJVDT9Ct6EPX1
X-Proofpoint-GUID: y7cakSD04G_DdrVJAkG5Bn49WgyYw57s
X-Proofpoint-ORIG-GUID: eA4BxQzryHfNr3EXBO_7pQvFb9KSLuW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=744 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

Stress file with atomic writes to ensure we excercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/771     | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/771.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/generic/771
 create mode 100644 tests/generic/771.out

diff --git a/tests/generic/771 b/tests/generic/771
new file mode 100755
index 00000000..690dfa0a
--- /dev/null
+++ b/tests/generic/771
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 771
+#
+# fuzz fsx with atomic writes
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest rw auto quick atomicwrites
+
+# Import common functions.
+. ./common/filter
+
+_require_test
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
+# -w writebdy: $psize would make writes page aligned (on i386)
+# -Z: O_DIRECT (use -R, -W, -r and -w too)
+# -W: mapped write operations DISabled
+
+_run_fsx_on_file $testfile -N 10000 -a -o $awu_max  -l 500000 -r $bsize -w $bsize -Z -W $FSX_AVOID >> $seqres.full
+status=$?
+
+if [[ "$status" != "0" ]]
+then
+	echo "Somthing went wrong, check $seqres.full"
+fi
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/771.out b/tests/generic/771.out
new file mode 100644
index 00000000..c2345c7b
--- /dev/null
+++ b/tests/generic/771.out
@@ -0,0 +1,2 @@
+QA output created by 771
+Silence is golden
-- 
2.49.0

