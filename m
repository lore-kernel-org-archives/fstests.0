Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6432572F
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802979; cv=none; b=beruuqPh5czdL6SURsfhzXItAFHHWRTwcTcajwweZgppsAJ1H1rrjtfFhfOf4CVArw/PqJWZClaRoXvsHorWjGP4fPYVdJaAh1mIiGmlvUPd2FBhOHupLxfrWlccBhISECjKluGyetiqDFGREREP2HSMCFYSJqd6YqCgibyuNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802979; c=relaxed/simple;
	bh=3MdueRkaA0mwKFjhanmG5XlMk+6mn0lB7GLHFOjnegI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMgELKVw+0z46k38UE1BIC9L4NXhRoKtCxp4+LUlTfk2nCcsXZFKnVRkMIvRc9JErWnbKc4xX3LaKZ0OAi1ozzI+JV0+h3fhg4MOFuaRMKv2mDXZ/eqW2/h7JuTxhCZvbsMf05AROdJswhzQufFuw6aCoKilT4sj7f8aZSPtw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X+ZP92Bq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X+ZP92Bq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639J1pfv2213384;
	Fri, 10 Apr 2026 06:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9oVhScmcotlIFLXHQ53LftfCNulKxeRfrphkq58fq
	1E=; b=X+ZP92BqY16+rG3OziHkJq1TsC7dA0TX11TWLn+xz1ozRTjI0MuytDkCy
	NmKWxPYkrZPhXYw+vz+x0TjTztpZwexIlmUUeOCYgJLcOirIwFZCJXzSciuiw0Bh
	Wd+COaixOn/3eLZ+PSIwUI1JoOTqgcni6EcSCsshe84Q94TmE2J3gpkYBQ4hBJxd
	bGDk3JuSf9wdYL93p64W2RVuBiafdhO1mQ3Xt9CoqTc9Ia3NTIwDlvew/Tj89v3i
	U143qjqG/UYbUqhGrSkYf2FyZ2jWLSwZ0NQYodQAGxS4xUW5iRIpZNSpBJdqza69
	v58bdbQhmhpVaQtPzrhzLLAcgv3iA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hqk4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2Q5w4019008;
	Fri, 10 Apr 2026 06:36:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9pvrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6a9PB6357410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 016CD2004E;
	Fri, 10 Apr 2026 06:36:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 687B720040;
	Fri, 10 Apr 2026 06:36:07 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:07 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
Subject: [PATCH v2 0/6] Atomic write test fixes & refactoring
Date: Fri, 10 Apr 2026 12:06:00 +0530
Message-ID: <cover.1775802601.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX/d4oj/w5jcnS
 jR8Nxsa+iCbWH7nDgrFsu/OMpz+0XYXts2dfQN7tP3+Ey9KVQ1W+TjiU60mr3DrlzHzWCwG3RDt
 gpHZSb0TS6ZHTRgxlnGaHS+SqgKEVazDMm35Q49eaCyvjY8kgrIPbyasyku6bf4X9cNYfiaNde3
 qT/m5R7qcpXMIWgehQ8iX5lCoJJ+OvX+r5uopAxFuRFhcWF3iLf7WuYr4D4/trl3KIF6EmDedsR
 O3dUnL1SkZOU829/VXRE2E2ruCt4VuzqGhX7AefhwxuZuv60MREtZgd8Bf900UXLqbr5RVOqXKr
 QIigyUwB7VHRUS504pHoR+tXzQyAEeR81Bo6Tm1FimHuxTlat/XChEEiVW1DO2LgqWK5a47g7SC
 cIevIF0r1TRAKgStGiWVEdioTNbetSUdXm7KKJku9L+9yIcisPE2z2zBdGFoIDPflnzsrMk6g2/
 ytZHCYPMstLR0UfsurA==
X-Proofpoint-GUID: cV2-BW_Y1Mm1xQrIBgi5xG8SIVz8F5kk
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d89a5d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TudYG4PG8-XSXDfB0qwA:9
X-Proofpoint-ORIG-GUID: ejJsSfLvN52eHGUlZBe4CdW7pWSeJpAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

* Changes since v1 [1] *

 * Add a helper to correctly get sysfs queue path, and 
   use it treewide for consistent handling.
 * Collect RVB from Darrick on patch 1
 * generic/765: Detect if mkfs succeeds
 * generic/775: Make variable local and rename it for clarity

For treewide changes I've tried to CC respective maintainers and
original authors. Please let me know if someone else needs to be looped
in.

[1] https://lore.kernel.org/fstests/726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com/

Ojaswin Mujoo (6):
  ext4/061,062: Minor fixes and refactoring
  common/rc: Add _sysfs_queue_path helper with partition support
  generic/765: Fix sysfs queue path for nvme partitions
  generic/765: Ignore mkfs warning
  generic/775: Fix an infinite loop due to variable name clash
  treewide: Use _sysfs_queue_path helper in all queue access locations

 common/encrypt    |  7 ++-----
 common/rc         | 36 ++++++++++++++++++++++++++++++++----
 common/report     | 20 +++++++++++---------
 common/zoned      |  5 +++--
 tests/btrfs/076   | 11 +++++++----
 tests/btrfs/237   |  5 +++--
 tests/btrfs/273   |  4 +++-
 tests/btrfs/283   |  4 +++-
 tests/ext4/061    | 28 ++++++++++++++++++++--------
 tests/ext4/062    | 26 +++++++++++++++++++-------
 tests/generic/765 | 12 +++++++-----
 tests/generic/775 |  3 ++-
 12 files changed, 112 insertions(+), 49 deletions(-)

-- 
2.53.0

