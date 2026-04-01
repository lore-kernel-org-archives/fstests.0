Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948523BBA15
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040066; cv=none; b=UBfw3v5KpCevt+xaB4ARqSCi00BLD2zAwPTbJMpOxvkALQBNp6XIRvP2TFBbTUfDWk5NpP4RbIBToUvM3b1WBcOwyax6zSwM2jClFx+0Ppmg/0E37dlaWhXzG7I25WKF3lFHXaCc++O08jq0SVSeuECO7gR2VVxb4GvII/aw0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040066; c=relaxed/simple;
	bh=sS0qu9jNSipr0NFfVuhgpfIt2hJ1txkzS59JH8HcQXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH/egsRsPhz3ccpBDJR4PfuJQh9jZpRcyLx5Ldajeq0sZWVpu42Liy7ONdHVgDsj/JjUDGEgml/ev6G/yekbnGK5/8BLt/YbJ24BIswL4W2RZp23arBcIdD5dDIXrU6b70Dfq8xjIQ56NrTWBP5CggaFrfBwuxRASBLiXFvPa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rLg+ZAoz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rLg+ZAoz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIa5n9442944;
	Wed, 1 Apr 2026 10:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LAZCOavDIym4W7X0b
	C50gHC6zrxfBc8uTtigWG3AKLw=; b=rLg+ZAozlA6tUyOk+UyHuJ/z6rz+E0xOK
	pmVg4c9HSqd3v84c9zZxrFxeFK+6+ydsDHs5VKTwm39G0PP4mInsayX9MHVzeufl
	MvmVtmxVKVoNAFQ4IanMCNEvSu7HtZL0EtGChgBlX2iCdNgQDLD+48w4MgEWCnix
	WgB2pazi9IvKCiB0vBz/oSQBC1J0mIPkNsN4VyU/szgQ+tMJq64QbrtXGpnLjyZ0
	Q4Mt4vFhS7el+BO/gKasuyopExNdHpSj5ooetyAYQYimtrIR+qIxL7yl+i8EbW1L
	Lr9WnR1LLVDcTSDNBh3D85wpVnpMAQABFknA4duZ/52Wv8OUDsvcA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1ypj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:41:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63184PGl008685;
	Wed, 1 Apr 2026 10:41:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11mx82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:41:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Aew1c34079122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:40:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A14D20043;
	Wed,  1 Apr 2026 10:40:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E190320040;
	Wed,  1 Apr 2026 10:40:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:40:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 4/4] generic/775: Fix an infinite loop due to variable name clash
Date: Wed,  1 Apr 2026 16:10:50 +0530
Message-ID: <d1a7045002ded5d9e68347ff0fec41a86ff3877e.1775039135.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ccf63f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Etsdx-XbT5tXqzfHL0gA:9
X-Proofpoint-ORIG-GUID: GDyP-hbWQeN1Lwi8r_7M0tiuvZ2zJh5Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfX5jyVm+un1Uys
 tXm0fpdKxqhWTJ+3KDsG88SbPJSP+4ZjzWsws/f8EbctzCLEJgLT+rsGSZrnJI0dmLPLdYs/bsx
 SVMqjVH9+T2ncrfLInG2vdkVbVlY7BCjs1h8taxDKBR276bLVFWWEqpu2jZn5DfEcImNFHW3yJZ
 lceKZRei1YmhRLePy54X4Zivk1/dcTeO6Nl5thyTw4aRh81Eh0BZboADH5Vh98sIFupzYEsORY1
 KuCjJsG/ZVnqVChlVXC1T5h3KdgBDJ4y+MNmGRtWvbvDawKcTI5EyWEFhE0OzIuX3DG12UsJoKQ
 gAuTQnBYZv9WV8ub3437cBjUwTIqdUc6H+GFQqt+czR/OaaKqj9fUIOWhzlEWsVGZL5F0gUzVmG
 vPVZeQwyl2l+p9vlzZeWT7JwH04vSp6ZfHEbgL0NRQddDSHN4RyyBDe1l82sQ4Wd9/b0oYMPPGZ
 xXYR/bmvpA75IpPxCeQ==
X-Proofpoint-GUID: GDyP-hbWQeN1Lwi8r_7M0tiuvZ2zJh5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010094

We use i as the iteration variable in the main test loop as well as some
internal loops. Due to this clash, $i variable of main test loops was
getting modified by the following loop in prep_mixed_mapping().

	for ((i=0; i<num_blocks; i++)); do

If num_blocks is less than 10 (example ext4 with blocksize 4k and
cluster size 8k) i would always be set as 3 and the main loop would
never exit. Take the simplest approach of just renaming the variable.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/775 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/775 b/tests/generic/775
index 2a4287bb..19ae95e2 100755
--- a/tests/generic/775
+++ b/tests/generic/775
@@ -41,7 +41,7 @@ prep_mixed_mapping() {
 
 	local operations=("W" "H" "U")
 	local num_blocks=$((awu_max / blksz))
-	for ((i=0; i<num_blocks; i++)); do
+	for ((j=0; j<num_blocks; j++)); do
 		local index=$((RANDOM % ${#operations[@]}))
 		local map="${operations[$index]}"
 		local mapping="${mapping}${map}"
-- 
2.53.0

