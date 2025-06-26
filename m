Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28517BA1
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939161; cv=none; b=Jog/5z4yr1bw67mFJ017q2/dqegV4ySlQF63jGM44DuPzziEhy8Xq/l8cItyJRx/ZoD1Bicu84ctUG0evYujhm4CIZR/4wkxrcSc3ztehlZ1zkmRewf/IIM+XIz6SjvlZdCKUe9+bPe3Kyz4s2KTbdEoMhSPdW1W9+5IfaHUQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939161; c=relaxed/simple;
	bh=EKt3LaRTQhTqOQVciT3J8A3LWitv17pEkQe717TNThQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3rB0yPsyosgN/IIGOutoIrOMhQ0y+QDMcw4SdKqtWs9qeqEaWmePNaN0cbdx2Rs2QBft7BofnLJQiLNrhaT8UnrziUa1hKy13rSVWhVyGRnbvBal77jGwcj8nKEIV1AoPmT9gE2kcAvYoyc9dJZLanqWeJiXw6V7fOoV1CACMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b/NATWhM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b/NATWhM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZt9015782;
	Thu, 26 Jun 2025 11:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CUzTD0wkfC3sB9Zp3
	VoJZOPXyQVt6/7WO9TezYZB1Is=; b=b/NATWhMMhsf8bhgSiXWtIxBPj/vl6ZUG
	3Xb1/YPU7doYRJiH1UcuN7ovVeMPWeaI/SrJydu88gXkYSbXOXw7P1V9fSUkwNZ6
	1jkr/A6OExTNK2WymPSF28E1lvBSSKkd6J35LQaLiL699jPbSC0nEiLpKDY/Mnm1
	8WbUWCF8w13e3z+7YGNFOEDIZhan7Gmpw74rAkOh6RAhGRn7z1KwkM7BR08zwLbS
	nRBKZvHxx0dwBMY9hUsRN2ov0o9hXmh2HcYoNK2asEB4xjPTl8hEk24Eyjhctjoc
	JWyO2m+R+qRLOjvqGsR14BJLIfDGEx7YPxd/loo78bh4XYXxOkMwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBvhxQ032376;
	Thu, 26 Jun 2025 11:59:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q82wrm015033;
	Thu, 26 Jun 2025 11:59:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72txwtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBx8ju53281060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B632004F;
	Thu, 26 Jun 2025 11:59:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F3852004E;
	Thu, 26 Jun 2025 11:59:07 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:06 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 01/13] common/rc: Add _min() and _max() helpers
Date: Thu, 26 Jun 2025 17:28:52 +0530
Message-ID: <a115244a49b728c1f48b5780c3b6c737621c467e.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX7DDm93SG7m86 zGSyoV4NYWYttMgtHdaV6BM/Xxx6XnFGA8+wEr6S8cDM+yHmhmaNBLAm+nNxD8YK4Mmpn5urXmw TLQ9JaUFBT0GIY1ljMCKXAOYZgvSjekMNZlQvKwcjhrS783Nr5TltOprSnUQ5G5DOA4HlFW6pd9
 /o92SQR7OUMohbU6rUufuzZ5aFNo+jo2Ju4qDuYm8O+7RaZJHlyiExp/kIZbCKONGhYYbt1qlwi BG2UQmPsfqziK5CBtURBQJEK5KNvKnmziv/rlaAm0GfG1MnJfaq2K1uFp1I6LFZUyKshVHd1fvh 9anUxCAdihjiLf5KDgTS8fgVdWxxBbG2FNRY1cm3PsERp6NHtjp92GNzgi7ixg6p0NJA0Tvzcom
 XKLmleoCdLoHsj3ZuplVIZUr9Ne+LPC6p1IcQ39JekPaWmH6XovoX6Jaw6VrYfgdwoR0mLVL
X-Proofpoint-GUID: Knhmg-XXJuG99kTQikBue075fx5bhpOc
X-Proofpoint-ORIG-GUID: m2RVOmyV1wgyTJCMVroBczP_30MlCaRF
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d360f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=wDx1mg2EYdB0JXDzLs4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=910 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Many programs open code these functionalities so add it as a generic helper
in common/rc

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index 94ae3d8c..2f94a4f9 100644
--- a/common/rc
+++ b/common/rc
@@ -5817,6 +5817,28 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
+_min() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg < $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
+
+_max() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg > $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.49.0

