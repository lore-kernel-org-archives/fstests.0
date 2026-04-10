Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA85359A8E
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802988; cv=none; b=AsD3e+E2x9TK7FabwIDkDeuIkZXZSFAcsmjyk+A3VgdtPmUKPYF1XmD7ReUDhxtncAzEz53LpSXXUcnVPYe2YmiaU0NROq7HCn5Q5FDSHRRlVt0OVUq97qIOjGffKaScfKAdbVeLV3Wy/1bpIGPp3UiMrpTdoaXR7k2PjrBcDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802988; c=relaxed/simple;
	bh=qUGBzwfd3wngUyAHfC9K7wcV25vmwhhnHi72FtibwV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7R2maQlev6lx+DdR7DSKiolDyo3+ZqztalgxM1U0xPjC0u5h9uLV1GHtlMramWnef7OTSEu3OCv0LAhXfVOKP2Cvw+5Ddw6pqWB3MUk4TTC3CIpryjFwX7VoLxFzYD5W/Cg5EBya4PIjn1/YiuIRlb6R4m62f/86zcitICiqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1j0VyuD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1j0VyuD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Ntt7A2590966;
	Fri, 10 Apr 2026 06:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FtGzZX7OQlikMhFQ/
	wWZKweCAFLuq/mLaSJ5P2M4uX4=; b=W1j0VyuDHzOLbJsypXcnTlQo6myUTaO/v
	fo+ps9yUOiEY6XL/+9jbTaoLvim/ZN0nM7+Kvk0lpBOC3QVnRde/ltIAvvs57e2R
	1foRZiSF9rovKHPfDt2qbRk/vB5PRPm5fZBlhqc6OH2G0Rs0Z6+FQBNwy5AfXu88
	LUhnppwvMcqjT+N9diZwt3tuF/8PcHo1jxq/d9MOf0CDCHRr1AialgroZg0eOU20
	eStZqZp2oSQWRO2z2lJDIUhpIuJlyrnnrKu3k4r+lwqZcz1xu+HSrWyJnbc/zOGx
	z6QiJE6HinsPhFHtHv8ySBxd2ogt5B41jAZnTHliCMTCqID3KlZmw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2egp9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2UXji030062;
	Fri, 10 Apr 2026 06:36:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7pv5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6aJtS48103730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B74420040;
	Fri, 10 Apr 2026 06:36:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CFB720043;
	Fri, 10 Apr 2026 06:36:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:16 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 4/6] generic/765: Ignore mkfs warning
Date: Fri, 10 Apr 2026 12:06:04 +0530
Message-ID: <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: v_hsuM3a8P8j6HnEc1J6TWmYM2RXmTV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX+G9CoGNrAkI8
 8pn5PrsWXdympCkFEa0/GXlIZvUso5TyuqbPBDgaP150BeYF7nH6qf951ZbCDLWF74XN/1uBB5b
 BVUWkF7dD6CybNsV5Nh7zOIZtNj34ENdIaiZ3kYZRbiPxvZIT4V3TDKyCd2JsrTUuOfi2TNL2Ef
 5DH9hl3bifYCVms8dCWyUKn4wmE6lt7zBf8LTEFzYoLguSxGx/r8K85+Yvm2h2NvO3bnELvCazK
 51vwbTsmAnNG8i5FCUBjGn6JSaCIEFI/lxniDKeID5RpwjnpKOhoZGrklrC4T9SfMV4oDQ/Ul5h
 PamtzA/J8jkBz/7724rHaedJlBcgpMW5hgUagdsgE1RHMhshxa9C2fbrLn/FL2iU3Npzvt4wUAv
 vx0jw/aNxqu0PGrzYwWmDRJsIi2HQ2mR+C7ZOdYw6fqs3BBPcBbGXoProJwx36tNb2xViNpdzBN
 7Bdhwsst0bSeat9geUg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d89a66 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VeLAhyBOSRJBHbqfvowA:9
X-Proofpoint-GUID: Z56HjAthPsIrYYUS_lZzWCpfAlDYQ3AV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

This test validates atomic writes for all possible block sizes. In ext4, for
smaller block sizes with configurations like:

export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"

The output can get corrupted with warnings like below because clustersize
more than 16xbs is experimental:

+ 16 times the block size is considered experimental

Hence pipe these to seqres.full to avoid false negatives.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/765 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/765 b/tests/generic/765
index 09be53db..b7cc70f1 100755
--- a/tests/generic/765
+++ b/tests/generic/765
@@ -64,7 +64,8 @@ test_atomic_writes()
     local bsize=$1
 
     get_mkfs_opts $bsize
-    _scratch_mkfs $mkfs_opts >> $seqres.full
+    _scratch_mkfs $mkfs_opts &>> $seqres.full || \
+        echo "mkfs $mkfs_opts failed"
     _scratch_mount
 
     test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
-- 
2.53.0

