Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4025D209;
	Tue,  5 Aug 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385968; cv=none; b=FwgkyedMDA/PKCtEjUmcfR+3fQjMYQahlo1NIPpGaVZX2jwRLmGbmTKgJKxyE/mhHTn6JzUn0F0i5f+0QW6yjthdBqY7H/MPuD+4cRw6TgCs3piDMkIxGoNypKtgsWKdxoeW1PUwkceg35+ewe0VvU8MD4XGXGa3nZNJbmjAGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385968; c=relaxed/simple;
	bh=SC7kBJKgGGpXyIjZc97jxuiKeFp4ze/eQl6HVrX/jwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHi+9GJ2JDiyo7ODAzrSDO2jj5hJ6cDzCvYJ9c0ojihp8BjY5QLdw9CkjcJ1NDI20H1h9Oa0wmtblS0NTKk87mZO87baen6d10jijM5F85mN1MOSg651fi8GVh+NNTmG0hdmAt3BM4/gVo4R4RdZRRVoERF1ebIMXoOECHSDzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZDUDuFJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZDUDuFJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754t2HG031981;
	Tue, 5 Aug 2025 09:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WW9xICsrfqoVJzFaZpY6jTtLHaZI6sQdYK4gr259q
	q4=; b=PZDUDuFJW9i7sPgs768cuZm1oGHTG/rlyAX7r/RNfmY0OttHAd58jDe8c
	sk0UIvkVCni33aJqXbJM38eVDtrh+81OzZiYKtrbTwKL2KcO1AdnR/CoxvgnXtvk
	GJFURrrZCGAMC2iiLeTnyQiTY6zIUaaP9yfy4ZLEY9COFEPicnN3JgAfw9+lIlYX
	axRAnykOFeDM5O9e0Ek/UGqiHAFOp4tOHzbJVSgZNVchCM0Qk4/ZQzW9XQa06RD4
	KYVx8pJ4FORnNNce6+Qrd3t/t0ulBfevfJCbdPCfj2xUbpRMeEcaLPD4lF2nKPT5
	1nPC4DQZ3azW8NWlqgoNQdH2+UzNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq1380-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:26:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5759Q0u9004614;
	Tue, 5 Aug 2025 09:26:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq137w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:26:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5757qfj3009449;
	Tue, 5 Aug 2025 09:25:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0thx4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:25:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5759PwZj58720674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 09:25:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014302005A;
	Tue,  5 Aug 2025 09:25:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D677620043;
	Tue,  5 Aug 2025 09:25:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 09:25:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] generic/365: Fix false failure when mapping ends with free space
Date: Tue,  5 Aug 2025 14:55:56 +0530
Message-ID: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Exrh5Cltwx0qwNHbchGNTJqEizp7W3XT
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891ce28 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=L-JcgC3ReIh2akJ2wxQA:9
X-Proofpoint-ORIG-GUID: 3ZJytAWtBMSaFd7-gO5V9GlqJuyIK2mD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA2OCBTYWx0ZWRfX/OnzmAn/XSM5
 O833NdEsL6QfghVCUn+9itxn0y351XgSbSR3skZd5VY506A++jXXHGV89W/tVHHusnxXMzbapGQ
 ce/RRiK+AXYTB3izf2xRefE1ZgREF1E7lPWNDGdO7lMBgNKrR9PKgsmhRsNERt8zRYiaWaJRxGI
 mqjAbt81cXYpw39eAx9do1qfAlBVnrb63O9ozDPtdgQPMaFfi4LlEkLO8A1WQaQ/0B+RKLNvpwq
 STWVc8Y9oIivKLfnb3IINTHRxWDfyYcHQ6fSg8my2X7teda5CBo94TuV+Cd8RES9q6sd64KuN4/
 Gj3VGyqoqZ0pfH+aSdunRtRaJsDlUB/HKe+6hAMwaPKWtkFvpUVLnGc8HBjF8jYq4Hb/vuUlS/t
 YwsH/ea06esumq+GSMJZI4pVkUbcA9IsDr0pPbXF7KGf9DLOdu6MKM33EXsnMIwstZrS720a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=871 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050068

If we have a small FS where the first free space mapping is also the
last mapping of the FS, then the following sub-test fails:

  echo "test whatever came after freesp"
  $XFS_IO_PROG -c "fsmap -d $((freesp_end + 2)) $((freesp_end + 3))" $SCRATCH_MNT

since there is nothing after the freespace. Fix this by punching a 1M
hole in a 3M file to ensure that the first free space is always
surrounded by allocated blocks.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/365 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/365 b/tests/generic/365
index 36cb2530..bbadae71 100755
--- a/tests/generic/365
+++ b/tests/generic/365
@@ -32,6 +32,10 @@ if ((blksz < 2048)); then
 	_notrun "test requires at least 4 bblocks per fsblock"
 fi
 
+# This makes sure there is free space surrounded by allocated blocks, which
+# is needed for some sub tests.
+$XFS_IO_PROG -fc 'falloc 0 3M' -c 'fpunch 1M 1M' -c 'fsync' $SCRATCH_MNT/f
+
 $XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT >> $seqres.full
 
 find_freesp() {
-- 
2.49.0

