Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE4306B3D
	for <fstests@vger.kernel.org>; Mon, 22 Dec 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387658; cv=none; b=SIQkU9ZyULAQhK+cVty6GNC2nVFqkvldAZlAcAfYK+WlpzITORCP0xDEZ8oxIqyk8tThPc0iS6u6fbhkm7kUoqt2+EV7eW4j7y/Epy1vcAdb1csW2VeoJjDfgUHP57Cfp8IEoC+MI3etWjYlz8z6DMINkyB5zhwrmBs1pkX1xNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387658; c=relaxed/simple;
	bh=xR7UC2Vt9HgRXmQ2T0tjf/4Db37+vTcOZXuWv5885iw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fyKLJuzArIwrLOtxJVchjV17jdUFZaTaDmtKWmQd+9I3Wi0BoROYEAt1TIOLSJSOkH2NBQEFGt0RGynclMLFA1L5aTfnJWwInxiOXZGqAl+y+doIkRV+667dKa32peO08F62U7t79iqVu42WBWhMyaR+2P5m2gbT9TDgU4l102w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tb1byhfP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tb1byhfP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLMmBod009176;
	Mon, 22 Dec 2025 07:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uaSz1MkRQ2TJfbVC7sHbLZCHeUdA/h16YvVNXbWjG
	AM=; b=Tb1byhfPi2b1bvNpsD/z9STnvdOEMsiigu2Wo5mpe/AnvHf5yFx9JwgE8
	V86oAf7Fz3SWX3U/Co7Kcvu8CFnrcVjobYuXZZ2q8S5rqLLOIeygLsOPAc3fn29g
	5rX/S0WJSsRYDfiH1aTCzSGLwMSPRAhQ5nimh7Z6Z0c1tvEwyAU33B5XS54J6Oox
	dPdt7R6ZRQ4qQlGzT9llEmhnr/Dc8OQBaUWmrTPbxWWRiZ52zEcp/CLU4jqPsgCP
	bhZ9l+6UUfHWF7RazmbxRNKa4GgcRvlrdy31kcod1L8fFFRv0iBatDDPcvf1opIf
	Xy80XcIt2PmzBOeISjHhhN2u1wwVQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketpe4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 07:14:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM6qKVI032274;
	Mon, 22 Dec 2025 07:14:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u0vfp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 07:14:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BM7EBRe44957992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 07:14:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9277520040;
	Mon, 22 Dec 2025 07:14:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A48CE20043;
	Mon, 22 Dec 2025 07:14:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.61])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Dec 2025 07:14:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: [PATCH] generic/108: fix test hand upon failure to create LV
Date: Mon, 22 Dec 2025 12:44:09 +0530
Message-ID: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YdaKCdOsU8McRmmsWRGzd3ac9oPb8kxW
X-Authority-Analysis: v=2.4 cv=Qdxrf8bv c=1 sm=1 tr=0 ts=6948efc6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=BTIiT2-IFIdrPUWDWFgA:9
X-Proofpoint-ORIG-GUID: YdaKCdOsU8McRmmsWRGzd3ac9oPb8kxW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA2MCBTYWx0ZWRfX2918N+s7tL5z
 GzLlaGHAL5q+qt7/xSEQgv79kwPP0JpCX0wEW1pbDem1yhDSxkVnUnVsDKtsrDc1ArT0PDeLFZw
 EQ1e4EWIq7NZdmszkFwY/Kb5Jqv3AFe0D438kpI9I3AiwAWf8Z73Wrqg2zuwZbtKLpdkRpDZyOD
 txU1DqMd2UdK/kkZW3q//gFi/xm+DpruSOsQ6pYvJmTpW2/HYGEKubYjmHO0/1RAhVP/ppLNbM8
 0Q3BIHmtRfr3KCxPdzxBc3RcU3TYNX28W/VzXGGpNYnttVtKfFf7WCJHeG9qo30awPuGTKZwtCx
 O03iaXKHY1GejRLuNwfXILJiQ2zOUMJrNAZYZ3QQbOyPGG3PH5y0mGdcPHwFdCQQTK39RfxNrZu
 C4ac4Xkjx6aUP5vnxwySi2ML0s/B/o5MKmhJHsDy5R1o/zfxCzw8opF1T+Qch/1U1bQE+2lljaR
 xNixSUjCxCH5mo6+k5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220060

In case the lvcreate operation fails, we don't catch the error and
proceed as usual. The test then tries to wait for the LV to come up
but it never does, causing a hang.

Fix this by catching any errors while creating the LV.

Context for completeness:

This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
of =m, causing it to create an 8MB SCSI debug device. This led to the
lvcreate operation to fail with:

  Insufficient suitable allocatable extents for logical volume lv_108: 68 more required

However the test never caught this resulting in a hang.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/108 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/108 b/tests/generic/108
index 4f86ec94..308afe20 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -60,7 +60,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
 yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
-	>>$seqres.full 2>&1
+	>>$seqres.full 2>&1 || _notrun "Failed to create LVM lv"
 _udev_wait /dev/mapper/$vgname-$lvname
 
 # _mkfs_dev exits the test on failure, this makes sure test lv is created by
-- 
2.51.0

