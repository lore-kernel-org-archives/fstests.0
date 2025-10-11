Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C966238159;
	Sat, 11 Oct 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190448; cv=none; b=pvFSRYILSRCa+CVd/6rprnk2LNtDRMfhe0UC32R1CZa8sxjg/efDNNs5IYwSSsVB9HM/5/lZozwKgFd1eS3Dcl+XLLjunyMyXkOZ8+ACFB8RX+MUso2LorJklQVmLduYMoBKIskfgraV34OiUkIPf3ka6kcCbW3/u+LHtHcQz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190448; c=relaxed/simple;
	bh=670+SLhGJSa0RHHnsaPGdt71nMJ5tF9DQXOGLrslfKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFgPtbo6dcGsNwEwHFgUMl7C52f5v6VKHhlGCI8c4sr1QOblSWKw1AEzKxOoA556ck2HkTf0xp0JTpHhVDX1hyMkR+0VVvZWAOm7anM6w9M2JY18ta2PpbBvYStTFGJXb4OJ49mGW18w4EMobx84z5BE2lkPFBxU7uWPR9HEEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GGH4s4vS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GGH4s4vS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BAT3GB026248;
	Sat, 11 Oct 2025 13:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sh3QqBiUmrHdaX7NpL0vaWXjTrLKYoraAAmGhb4iP
	Uo=; b=GGH4s4vSvSDDlqOuyAnkCB5NtDlNgO2aRxepBYtJ4ZdIO1OZIMZzoFvXJ
	1doGqo9FWXW7DJgZLSAaOdY/rVs8Jp2PPb1N6sqv6Xu5JlIffvaPJkDTa+lhrT09
	NRbUdyIYS0BaNSmQBiMJ04tUz16juXfNsdqo8Vm3Zpvlfhbg30kTfZfx8B8a46f7
	lDvmbNyE3PqrMoEvrRu0Hwl9ZLGYenU//8TE3y1N2QZEXX0l6nHFQ/K+XEr+x3T2
	JD0+aQ9nCtlIbaexTHoYEUOTS9ow8bOnLQbmFGmpIJwiI9XW2XNMwTeY96x5t+Gz
	h1Uisicpmg3Btdd4zs//YGjPY3pTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnp1q3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Oct 2025 13:47:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59BCFB2P026038;
	Sat, 11 Oct 2025 13:47:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamxdqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Oct 2025 13:47:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59BDlCVL52953492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 13:47:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FAD3200D0;
	Sat, 11 Oct 2025 13:47:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0F5F200CF;
	Sat, 11 Oct 2025 13:47:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.19])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Oct 2025 13:47:09 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: srivathsa.d.dara@oracle.com, linux-kernel@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] ext4/060: Skip for dax devices on non-4k page sizes
Date: Sat, 11 Oct 2025 19:17:08 +0530
Message-ID: <20251011134708.2426769-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX5cCO3cla4EWp
 VKnZpxvV2iWKTq0CClppl0aBdjrqF7w5P5bVmKI8hBM/c0bVO4v2YWVu1YhO1+tElElus7WosGu
 CKCQ1tN9c301N2G2FBq7byUigs+xc6h0L2KZmKfvQflMagQzj40pjHcD3hcmPGcP+Zo/P/zsHLS
 1pizjzvSCtysK9JrmPndUKrG1zSoKzIVN1Xt6/kZqqoKRvrlSI/j1oqjye7t2DagD3vPNtnaGWA
 WISpwZWwY466mfsDlLr0BQR1zfSGC4KS3jm01sMYFnmyg4HnpndqD1RM3A/SV7Xk1YD/2jGa4jW
 89YRxXhMcMy1M/OY4mClXW8G4hn3m4kMVKu3IfOYk1Jb+CfP40VrypWTh5lKhHa+usHWzNLoE9h
 0oey3X3kI1IfMv+3YjWpvyP978pbvg==
X-Proofpoint-ORIG-GUID: v__kscBe4EpHszsgWnkpb-er6mb-V7RE
X-Proofpoint-GUID: v__kscBe4EpHszsgWnkpb-er6mb-V7RE
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ea5feb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=r4p1LJxbrcFJ-OCt0_UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005

This test tries to trigger an ext4 corruption by resizing past the
meta_bg size (8GB on 4k blocksize) in ext4. Since the test is sensistive
to the size and FS layout it hardcodes the 4kb blocksize ignoring user's
$MKFS_OPTIONS. While this is okay for most cases it fails for dax based
filesystems where system pagesize is non-4k.

One way to work past this is to make the test blocksize agnostic, but
since we still need the disk to be as big as the meta_bg size, this
means for blocksize=64kb filesystems we need a scratch disk of ~4TB
which is not feasible.

Hence, just skip the test if fsdax is used in a non-4k page size system.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/060 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ext4/060 b/tests/ext4/060
index b8cc542f..565f8601 100755
--- a/tests/ext4/060
+++ b/tests/ext4/060
@@ -17,6 +17,10 @@ _begin_fstest auto resize quick
 _exclude_fs ext2
 _exclude_fs ext3
 
+if __scratch_uses_fsdax && [[ $(_get_page_size) -ne 4096 ]]; then
+    _notrun "Test does not support dax on non-4k pagesize systems"
+fi
+
 _fixed_by_kernel_commit a6b3bfe176e8 \
 	"ext4: fix corruption during on-line resize"
 
-- 
2.49.0

