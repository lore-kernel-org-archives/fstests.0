Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4215687D;
	Fri, 11 Jul 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258473; cv=none; b=L2+wpDdRVVXSQbrZ1FLo/gyQ2060XbggDEHZSe6/vBbqGpAGeESChMUcJVJJ2rku7b/M3EH1zlookUPNm1U/WNsiTonKuBUqeWlTbHqY7FwtiB1feHHU1qNCnOfxixXZK6YFf+3GUa2pt16cytB1/GHNNh2TuKSK0it333xGWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258473; c=relaxed/simple;
	bh=qOLPZ71Lm/7F76AExwLyjfM41Zkdfj7uJlrjF73dAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmK1xViR+0E1PE2dQFy9LadUJO4q/UjcuXexIm/HVQEj5/0rf/hwpppLB7pL4E2zKnj/UZ25ax9WveALwftOsl7JdOpqlVn0gKvd/R0yY0O4vSjaVhlBpERgYBDJzxLMVHz/i5vA1ZcmECk4RywXQeXLrz5r8XiWxx/CSzmrQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oiZricBA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oiZricBA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHYOOH013127;
	Fri, 11 Jul 2025 18:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rVYv5IVbqdmmXwCCt/Al5LtTMojWYhlIX684JpVlE
	YU=; b=oiZricBA6dQSQ7XVWQyoDqpAQvnVdcai5rPwu9D0P5i+myXSM7NPPVpxQ
	d3r1q992QXMIlfZN8eznRjgioEC4yUCRpWd88pmiCCebP7bcvSR1P7JfwJBmYR10
	75garoTokwjbWtLHJCs+m1DmjnzgYobdrppYiKTkM2Z4guET1q+CwM9tbb70HkEI
	5Cs+hlbu9eaHrvBVPalYxtn3BiR8UUjLbXTkayQBVUWjdFX8hnqMhhpistjbMbI7
	j3QXjBvL+mqYoEl/u8d0ZrPGSZus9IX40m0JgwieipEtO2CZ+tqMqFen/jp7A3ZR
	i6t+5/quYpMSOc1nszWcTLZvA7Vcg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdjk2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:27:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEgKpS010826;
	Fri, 11 Jul 2025 18:27:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0m59s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:27:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56BIRk8w30343892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 18:27:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ED3020043;
	Fri, 11 Jul 2025 18:27:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE2620040;
	Fri, 11 Jul 2025 18:27:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.137])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Jul 2025 18:27:44 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] generic/365: Add fix hint for ext4
Date: Fri, 11 Jul 2025 23:57:44 +0530
Message-ID: <20250711182744.1512486-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J5IkJqEsK9mk9iUyTxJGqNIm8M37k6Rk
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=687157a5 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=GFQTgSnAqz6jy6FBlawA:9
X-Proofpoint-GUID: J5IkJqEsK9mk9iUyTxJGqNIm8M37k6Rk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzNSBTYWx0ZWRfX8r+98wmpiShP YexsiF71zL/b88KQaQ6WZCP0csjlb7JD+AnbbMWIE7M0+KN1yYEiWEr7LA0hHGG/lygp6DeI0ZL gE7uA6OYPHG2bm+cq1dJDIXRbCt7d/8uhQi6huSgHipmHtv38gstYW9NOqeeYm8LAHxY52lOrYX
 qR4u/Y6yZgUkwb3yRU/bncHSFlM9Bl+bLWyH40afFWfXrst8V0ejfQAYqxM9oz5PoVOdYX8kmTI 2AgYUd0imV5KegxpuJ+Q2IqRmS01ZxsiaZkLVkef8zXVw/GKP1OPu14z5WriOVlDuXu76eU5WgS fAhENY3HJUb9MzH79yXq5xT31cEkloa3X1NXpi6N/jrY5FAc+/2ijDtWWW67bDItL81xyymhkOC
 c7gciOfHP7SvZ0q+jJ6/MySLj5DjKo/Vu1vEWl2n/EJdhwSWWs9zOtJ/Pe/O1AAZzrtEYil5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110135

This test fails on ext4 if the commit 4a622e4d477b
is missing in the kernel. Add this hint.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/365 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/365 b/tests/generic/365
index 1bca848a..36cb2530 100755
--- a/tests/generic/365
+++ b/tests/generic/365
@@ -14,6 +14,9 @@ if [ "$FSTYP" = "xfs" ]; then
 		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
 	_fixed_by_kernel_commit ca6448aed4f1 \
 		"xfs: Fix missing interval for missing_owner in xfs fsmap"
+elif [ "$FSTYP" = "ext4" ]; then
+	_fixed_by_kernel_commit 4a622e4d477b \
+		"ext4: fix FS_IOC_GETFSMAP handling"
 fi
 
 . ./common/filter
-- 
2.49.0

