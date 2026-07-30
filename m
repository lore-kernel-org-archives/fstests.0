Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1792442B1A
	for <fstests@vger.kernel.org>; Thu, 30 Jul 2026 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432137; cv=none; b=Fs1q/fkfUuU2HxkZTcVhB5qA1XsJpwE6JFp1R5V6hVdhnwDBlfrpVq9rjOGprGfjpAWe5/Po54lSjRF7XeD23px29L4PtPeDypm8ekgznsK6TR/kWYzcwHOBIYO4zhykZ1K/mFvPqo6ZOBUTkhYJMyR0X+uFcN6oMz3hnvZKhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432137; c=relaxed/simple;
	bh=M6BZx1YxcFhe2zDgOp87LxGOPfuYB/P1/u/4kRmSOwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bITEoKIBLcoAA9i4tjioGFeNMAl1KmTPofEGvjJHiJYUoDaI1BS9pcqlDCIS+TkuGl0qV1oPdgtSHrhXhuai7Ldk7Im3ZOmpzIp/rkZqxjZRpeU/5ivFZU1lZ/qkiq1BLEBkOF+9Kku2zJc64ypQaGdZJYyikXP5RAiYbACrFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CB3qosFE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CB3qosFE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGmMJw3487681;
	Thu, 30 Jul 2026 17:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=quti2JBsVDuhOf9qHYZ/usRcLaaMDsLD2AiZ3SxEk
	EE=; b=CB3qosFEktidtI1hBEm24OZ5FwK85l1lkdEoh0Ofh03TSwVvYJv+mBWyP
	VhY6cWM0NQ8MJpzKsdSSQaC/Lv+Eg1257bakV1z/aKMqhDxsKI5hMF/ux6R9kwab
	GAXio15cJK2ntYAlBsINTTp4iD3n+BtO2mHNh0T5dffTkjDFY/0+t5P4ciUMbt8/
	STHNFq8LTyZixvuJNDmfLeG9iOCjvmRsnoTfxlqRWl7yQ5m6VmCmGkpXUDrWBJ+Y
	qBjIhHThX77KRXKIfVHabo7JcaAG9MIWqyghkS5FJfzZ6yFwIFmxbdK1zMV8wKj1
	6tRncz8fa/TML+fEHqUeI7EsNTunQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p03dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 17:22:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UHBFkV004941;
	Thu, 30 Jul 2026 17:22:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqmgqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 17:22:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UHM9Qj22151930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 17:22:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C711420043;
	Thu, 30 Jul 2026 17:22:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2D020040;
	Thu, 30 Jul 2026 17:22:08 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.25.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 17:22:08 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v2] generic/645: notrun if FS doesn't have enough free inodes/blocks
Date: Thu, 30 Jul 2026 22:52:07 +0530
Message-ID: <20260730172207.1937537-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyOSBTYWx0ZWRfX9DqoaBQMnRfJ
 kdW991mA/3sNc9Q7+wj/t2JjCUv9v+PlQ1R5uFYF+Z+Ws9VZ2QpGlFIC3VXhQuFDRrGrbatwhpw
 LUCo2RPNj09tD0wPgXFhBjPjV4Vcn9Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyOSBTYWx0ZWRfX0myQpVOwZDTG
 D9EzVjkfc00ykmduOU725w3mJ5uMzVDk63LQxTjXt/GzxkaXf2TwDaBPJdBvvLhHXnKi3GVYG0w
 Gw9tC4T+6BjqEH3AjGbZAGdiyzny+CAqwJnbnMB5D+Z7xXcCCsHVCiQbraCGtqcNvFn3WsfsFMv
 ZIcfIy85EjceynFIdjb1gOxF9KZELyJaf/Oauhhe6LwV6uvcJXlWijAlbjyEkPF+L9hbysm2jSx
 b5b7T1VBXoWkf0kFCURHiIfcxKsHnSWpreRxoP3hVrUiWuPEMqnwpRsvjSouaDggUCI8bp8SJZA
 8ZUPCJAIx4SNz9XkMiG5z23wooWpHznscvpWRf2Ok2omskvyBolC9D8U8s1hqMThg3sHs310mMn
 /ZTltkFoTVG29Ix1uoxg4gBjQhB+Tyu/6DuKFQFJFBfNv+FEM7VcAH36n1//hwYO1x7/5ImDMuo
 C5MxywHcque1K05vA8A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b8844 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NyWC17klOB7_xQ97rUoA:9
X-Proofpoint-GUID: zWe5-A0I3u1pyLscNdsJTQcTkid-g2mH
X-Proofpoint-ORIG-GUID: zWe5-A0I3u1pyLscNdsJTQcTkid-g2mH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300129

When running generic/645 with ext4 using 64k block size + bigalloc, the
test fails with ENOSPC because the filesystem runs out of inodes before
the test completes.

The test creates approximately 10,001 files, however, in this particular
configuration a standard 5G FS only has around ~5100 inodes resulting in
the ENOSPC failure.

Parse vfstest output to notrun the test incase we encounter this ENOSPC
instead of reporting it as a failure.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---

* Changes since v1 [1] *

- Instead of using a helper, check for ENOSPC in vfstest output
  (Thanks for Darrick for suggestion)


[1] https://lore.kernel.org/fstests/20260617054216.3186441-1-ojaswin@linux.ibm.com/
 tests/generic/645 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/generic/645 b/tests/generic/645
index d6eb75e6..6498efe1 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -22,7 +22,13 @@ _wants_kernel_commit dacfd001eaf2 \
 echo "Silence is golden"
 
 $here/src/vfs/vfstest --test-nested-userns \
-	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP" \
+	> $tmp.vfstest 2>&1
 
+if grep -q "No space left on device" $tmp.vfstest; then
+	_notrun "$TEST_DEV ran out of free blocks/inodes"
+fi
+
+cat $tmp.vfstest
 status=$?
 exit
-- 
2.55.0

