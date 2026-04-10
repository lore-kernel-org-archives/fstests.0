Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BA33F399
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802985; cv=none; b=ez/C1C9sdR0h75cstbGIK6JlqIy45int13V8R0iEwgvgSP5ERdh3zLpGvdT+dK2p6GUbB1thhS6QwUY+Fe4L1bGsG9bWv+Sl18fb4TeW1aJJJMdvHTypm2loZ68y3W+cS8QPaVZlnf14dDrz1OLz5DK0BAeUH7sGbWg8llhb7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802985; c=relaxed/simple;
	bh=Xjqhthgl8p0Llt0pxsY4eSP2sdxk7+ilwxcUYXWkfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqi8M+xRB1r/RQRv/qyYBmw26Apex9iHZTbS+oE+zrPO+JqOwgibp6OGAx/P1mxmSy8EEBqcTDFp+s3mm2kEH5nn7+iOfQ+Uks8ESLygK/RLoX8BLm/Kw0j4e6vvsW34q4C3iQnLwTJY18D0ycabYnvpuRJ4dBH9nefu2TARpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IsRnKwOp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IsRnKwOp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639N9mLO2302373;
	Fri, 10 Apr 2026 06:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=18DEjaFeir2F8t/o+
	zv3KHu1giQR36DOLMe4DL+OpQM=; b=IsRnKwOptnwvOxusjlQ7KZEa/y9XVzDox
	texdpL+9IsxCjv/qU6Su0NmQ104zhPZ6AKBFWkarUpTo8sAXRQx4pLI9NP/yrHUp
	2fOQ2uM2ODFe1iJyjvS5+4EX7C2g8j8CVRRaKzkUqfTVB7Y6Vim2vhms+riUm0yw
	4wBChn3n1y0XDcCtk58jbbxiUK0sPMGUGyL88+VYepTaJElf2D1fiU7dtLdWRmvy
	aN7miccgabpRy/AzVw6QLymf/nfhnnvhHH/x8hxW10V2qjXfqx0ZYS43zoT1W5PO
	mKLlppAZqXlDK232/fXUJwhgaJZl+6gaZprvnbmRb6VFR2HSsJGKg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2frn6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2Y12x007881;
	Fri, 10 Apr 2026 06:36:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2pvjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6aGXU27918834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258BE2004E;
	Fri, 10 Apr 2026 06:36:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1409E20040;
	Fri, 10 Apr 2026 06:36:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:13 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 3/6] generic/765: Fix sysfs queue path for nvme partitions
Date: Fri, 10 Apr 2026 12:06:03 +0530
Message-ID: <43211d99fd66d3e8a956e1336b800962392c1df5.1775802601.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775802601.git.ojaswin@linux.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfXx0ArQZVCSsvS
 lE6pO7FAMryaqd300dULxRfjfzbjv4yIBipuiIqXMZBVZM2KDJW4ob1KaBnlCHhzEn6P7GuZBjF
 fFZXChmqVsrM9dlzt3GN+yyxoWNkjZ9Ao1sartrEwkd1bKeuO3MBrhJdIGLminEJIpbdLkffUbQ
 3+x3wwJB45QdytQYOFI3Q70ihO/lHU18t8mrlvFwX5ztOABHBwNWH8yp0rvuaBFiGyo3qnXBNgq
 5gFmrc039o3a2E0G9GJZHFREupVfCB4Bg3sRmaQR8XNYBH3efttXrpa6JVio0JI84wdPYJAx99d
 fuKvdx2qTzyJk496R9hy90EZRuVzAiEX7nkvybtujFhq/k3gaTamLAIcTgTorEwoxaitaNGpEWW
 ewmJ8C0bisOlJkjS6RoMbB1K/klvAvvpk8Q/xNT4GUbcaiBMdCvuRpopaoq6ZeD2zUZNbtA0Prq
 W4Yo2ankGT50ENftUAw==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d89a63 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qTSab3RMbMuvg6nAiKUA:9
X-Proofpoint-ORIG-GUID: nglkl5XcKsA46_evK67_tp80Cav7AEyj
X-Proofpoint-GUID: fQIKmW2RUCj-sZVJg6fRGLNNIN-3whzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

This tests checks atomic write limits reported by statx() are same as
the ones reported by sysfs, however nvme partitions don't have the
/sys/block/nvme0n1p1 style entry and also use the namespace's queue
limits for atomic writes. This causes the test to fail because it
expects /sys/block/nvme0n*p* to be present.

Hence, use the new _sysfs_queue_path() helper to get the correct
atomic write limits

Also, fix a small typo (s/awu_min/awu_max) when printing awu limits to
seqres.full

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/765 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/generic/765 b/tests/generic/765
index 8c4e0bd0..09be53db 100755
--- a/tests/generic/765
+++ b/tests/generic/765
@@ -94,16 +94,17 @@ test_atomic_writes()
     _scratch_unmount
 }
 
-sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
-sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
+queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
+sys_min_write=$(cat "$queue_path/atomic_write_unit_min_bytes")
+sys_max_write=$(cat "$queue_path/atomic_write_unit_max_bytes")
 
 bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
 bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
 
 echo "sysfs awu_min $sys_min_write" >> $seqres.full
-echo "sysfs awu_min $sys_max_write" >> $seqres.full
+echo "sysfs awu_max $sys_max_write" >> $seqres.full
 echo "bdev awu_min $bdev_min_write" >> $seqres.full
-echo "bdev awu_min $bdev_max_write" >> $seqres.full
+echo "bdev awu_max $bdev_max_write" >> $seqres.full
 
 # Test that statx atomic values are the same as sysfs values
 if [ "$sys_min_write" -ne "$bdev_min_write" ]; then
-- 
2.53.0

