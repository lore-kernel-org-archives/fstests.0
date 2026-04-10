Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5033F399
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802990; cv=none; b=FqnSi9ysZR6en8He7Wz8Yg/iN6aZqxQWT9icSBsNZc+7KoJ1aTgdYCQzwpJUlVqSsR2U8UdIpiTZCTkWL2iCUx42ckHngmeoczBOF6uOy3AqrcoYpnQWuGrJiiiEGlMqoUJVQlkipzy818ndWfm/Pj8jUkwIecrGv0U57zYU5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802990; c=relaxed/simple;
	bh=uZQltI3XRjOsoDcDvvLQYtoutMs8cDui1C5AIDvKRzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkBA3AFYCtNO4MdgpvBbou/8gdf2IY9Y2/H3UQQFj+c8uA/GCcNu0pjVfYgFqozE19NWHghWCNX06gCe3pLkQ1N0/OVpoFaWTpopWH0+QTPlLettag/N6dVl+0hc6pAXtO2ebCz+hQIa8Q3aztg2XDQovuhK2cvrhcsoFQs9psU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4iggkE9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4iggkE9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639LDaTV2326338;
	Fri, 10 Apr 2026 06:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dONpeduRHR0yPUVXb
	KO9m3SALxko2B2R2fg5gRNCZ2w=; b=e4iggkE9bxgEOMGna2zkGd/1IwoXrs3S6
	ERxqzlaHOR9/ZAR+V6hECqZcQUMwvCOuYuaabRXNQB7SVDu1oSbpSCJcKIisU6pC
	cMw83VoF1GVUsxOf2uH3iB8U7hZUSM2Y2D8NG5WwYjBGhOwfB0uq+E+A1MuR+AyD
	/yaRtCwERlzld9GZ+mKBwAjPar1gToUAfgcWtLN0JPI1gxosPx1L76bd+14FQtLo
	b3v6891kOiQIJKei23vxpglD0bUzqOh7lKOTRSv+S69TDbTCOX4Jt7F7gLUov71h
	kQ0eS89ms2EY5kaUwKZHlPgpnK1oW5pwvXyK5s/VT0iHFlQ0xf0Kw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kqkk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A3CXs6007951;
	Fri, 10 Apr 2026 06:36:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2pvjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6aLQJ16974104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA5920043;
	Fri, 10 Apr 2026 06:36:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9F320040;
	Fri, 10 Apr 2026 06:36:19 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:19 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 5/6] generic/775: Fix an infinite loop due to variable name clash
Date: Fri, 10 Apr 2026 12:06:05 +0530
Message-ID: <9c8783dc648ef861f81cba8d5d692932b795e262.1775802601.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX10oRVzTi6MFs
 km3wWNj9xTFQ87WYmUE1zvceYvBCwwVdQbyhj4vjHDvodCtH1+IIV9MXEUggYcEVjw4LHyDFqoM
 g+Rbj3Xqfiq2zgO4/Kj+2RcDxvE/uOLZx8N+pQlupJoxf7PnqVJNeL1CkmTtINlLWPLW+5EikTp
 Tinhsjbo1xszDevKC0qTGJgrj8Rotxv7Nx1qsXHtTx0Gh/rkPy+NSQxrd5+6zeXnDrzykHiA9qg
 k9Ro6AbSQA6fCD9cdAATAmrGTL1VRANuG3K7xbTZQZsM4pBYoG4+0h+JkeSREvujSQ7eSF53Gyq
 jm5nlapUqkdpWiGFWWVk1dEaLWqkVprJzVQHDe7xwqO1PD07owPHOCvqiad11i5BbYeLk6FePdD
 sdwyj4/+gr5D6nbIjgZHyoyI5WP5YMlysSrhyZY3giTBGFI3AdepusoBEfRdK5+lJqO1ESEPuZD
 yfLvh2nPvg+2v1B3lDQ==
X-Proofpoint-ORIG-GUID: EOzcVuXGaFsbG1WqhxrqxrVUvkjOyX6h
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d89a68 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=a1dcs3mMzdOfK9T3pMkA:9
X-Proofpoint-GUID: kUTjMojX5eLVGmCKho-9RCoHkuZcj2q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

We use i as the iteration variable in the main test loop as well as some
internal loops. Due to this clash, $i variable of main test loops was
getting modified by the following loop in prep_mixed_mapping().

	for ((i=0; i<num_blocks; i++)); do

If num_blocks is less than 10 (example ext4 with blocksize 4k and
cluster size 8k) i would always be set as 3 and the main loop would
never exit. Use local variable to fix this and while we are at it,
rename it for clarity.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/775 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/775 b/tests/generic/775
index 2a4287bb..6dc005a0 100755
--- a/tests/generic/775
+++ b/tests/generic/775
@@ -41,7 +41,8 @@ prep_mixed_mapping() {
 
 	local operations=("W" "H" "U")
 	local num_blocks=$((awu_max / blksz))
-	for ((i=0; i<num_blocks; i++)); do
+	local blkno
+	for ((blkno=0; blkno<num_blocks; blkno++)); do
 		local index=$((RANDOM % ${#operations[@]}))
 		local map="${operations[$index]}"
 		local mapping="${mapping}${map}"
-- 
2.53.0

