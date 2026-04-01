Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E23DEFF4
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040139; cv=none; b=EwrhXuM0OLqruypWNZ1/D9MpylY7Lra7tFJ5sinSZyydCwWZwVDoJ+TUzlEzfZ0K+JMTHDXrigDprT3LN0ZzuqiaCtjg50GqYyGIZOp509L//Pic91tQz/+mA4xkwJkR7bov4xYtx9dMH2Cp0Y6cI+3lnfB5fyLtg5NW3y+GqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040139; c=relaxed/simple;
	bh=yXC4AIgYBEn+DwLt+qG97ICiIrMR9tC9meL1Ey4xKdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGSin79LQPVKq+R6acIFq6BDrDpt0yjLAr2snkvZoqIPCjPFTbbBgSIIMZiFVgPBXpb4jn5lj3z1ViV2KLXgZjGOX1gFpMuYA4QX989fSsxGR5KIS0sKmOukmoPWD/tn2MbhShVOT01h5OWu88hM+efJjLyQ16sw7TiahiPs9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k6VBkQKB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k6VBkQKB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63163lVc3226794;
	Wed, 1 Apr 2026 10:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sS02cYBTuAdu5LNPH
	O3NseIwkDKNCMnjkhBDi3LOjBE=; b=k6VBkQKBHk7FSn6qyNZtvDKPX27I4l0NE
	v9GbmXVmpaC/tCp6qLkt0Hhzn266ZWRmB9bjSBPo1ZZoSMmBo745PW2iTVEXul7/
	EUVUUxzgweECQHskvrONDCKP8g59/bfLcb7/7Wh9G8Ctuik2E/MALDGELGd1emYe
	gDTlBiYCqKWDYqyVc7qMypeKwBLYxfKUIy+tyuNcl1e1Ah2KRnCT+IXTk90hrWnO
	MvpkOuxkxGQ9hL2t6uBHQLJsDAivT7/chLRTDkj1K1VY0ibqsBSWc1QIqsIFDygN
	RYAt5tZCj2R04XbmWr8U7RJG0qUwpKJriXI+FvsMVVcrSAUMc8cFw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcf05r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:42:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6315sQsX021651;
	Wed, 1 Apr 2026 10:42:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasnb0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:42:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631AeuXW38666504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:40:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A97D20043;
	Wed,  1 Apr 2026 10:40:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D1A720040;
	Wed,  1 Apr 2026 10:40:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:40:54 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Super User <root@ltcrain119-lp6.ltc.tadn.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 3/4] generic/765: Ignore mkfs warning
Date: Wed,  1 Apr 2026 16:10:49 +0530
Message-ID: <1418f57e6115c93278a3891f075338163e2ec667.1775039135.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ccf688 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VeLAhyBOSRJBHbqfvowA:9
X-Proofpoint-GUID: SzXq-5OwCjGgCZ1dZi0QQUgW-tOhWTh0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfX6KfW3nVJGSOH
 CxByQmRPncV4pP2W93mKSci8fyJ6t9f9EVFGsRJ7Qmftmz4b3OaR8aEuzBdhwtiQuudCZWRYsSL
 YyFTQED6VcAhq+3NngyMnXOySuPyj9fqD50Uwi3GBTHyjQ2T4+b9w9dUoy4zjfOlnrSw//QKlxW
 iYnR6ZS2b9xXwSsIhM2SBAw0GD5rq51hYzRceCCMi9WkEkNydE+/jvw1MTMXdwpEUmHblUY8UTX
 JpiG2GEpJkkjPKtZGp5QIeIgW1POkFLMHRkqdgQ8xH37PmgidoqrOq+aHxFht5eYpekIrIBiWHA
 bruyJQfaYTHPgL7B1yT/8GqECaMS/xIYJgEMSrwfoCWfQ52PjkFw712kFGj1X0X6rRD6z+p6CdG
 XlpANL5AD1pynBbEq/B/Z1TOzoOOHdP1BFP++oQgxHLE+u4qsUx+GUhPugUBZg9ZzGz8REtWzI4
 LlWqFKNW3VeR1vCU+TA==
X-Proofpoint-ORIG-GUID: SzXq-5OwCjGgCZ1dZi0QQUgW-tOhWTh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010094

From: Super User <root@ltcrain119-lp6.ltc.tadn.ibm.com>

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
 tests/generic/765 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/765 b/tests/generic/765
index 4c768783..6794eb72 100755
--- a/tests/generic/765
+++ b/tests/generic/765
@@ -64,7 +64,7 @@ test_atomic_writes()
     local bsize=$1
 
     get_mkfs_opts $bsize
-    _scratch_mkfs $mkfs_opts >> $seqres.full
+    _scratch_mkfs $mkfs_opts >> $seqres.full 2>&1
     _scratch_mount
 
     test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
-- 
2.53.0

