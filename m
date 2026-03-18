Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9436C0AC
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821922; cv=none; b=sBBRlxo9/kCM2xDI1jACT40xtdEjkcqO+NW7FoAVQz4afT1YH/aZbohExn+fja1/KvAI1yix68kLWENmvBjTQEHJf2O9H5T9aEOq6tDHNQD8lIbxGodyBvZdn4mh4T6g3/P8JItp4A0NctuwpVHiiRAllPVAB5ze+WocPgx5ZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821922; c=relaxed/simple;
	bh=wGssAIL5e1agTOKp0ygES085MHtvcc3iOu1PzD9qCZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNsFcrhIK2hatqDZ1qIAUBssmIOJ2wPfCdt2GfLJBYxnzbhXJ0vyancZZ7M9pk8TYCts/uu+vz6aScAsCCMK9lQbjPQivI7t6YRKSpvPUC0aD0OscmQKyJKE2WEC1dChB6+L+OCGWcwR67LTyr8HKNIdMoxq/+mwwVIxCpsWVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AiTYZ3KA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AiTYZ3KA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I59cDs3931551;
	Wed, 18 Mar 2026 08:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/DzbrIzTYzCKe2IwH+GKRXL4wThDETVlsrARBM99O
	Pw=; b=AiTYZ3KA3wrDkJ64oTSNJbTOI0geEzMWg/knxGdC3gq53rpNyiJ44/ENZ
	qUttbSbpNlIVGcBrx/RBR0Sx0U9nQxb/qi4Gcaokxh2EFctUeDvlYSub604STowV
	VkuDBmRIC0OH3MQczDgJXFyNrQ75YP2O4YmL+qmaQtAjlxYMM6aTVe48AMmYYtEC
	x60Xz/N6uzpFdvE5UByJDSIptw4TnPhKxVN30Yt5SGHcPfP0Iv4SXDmGxGjH01WH
	YRcyOLyGvoWBwlS6cYCdKzXCirUFzQnJRcMuStaaLaXJrDsvvge8T7anploVMVCI
	2TXGSkeI+g0xm4J+5AiccZyycQrAQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaug87t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:18:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4hqas015746;
	Wed, 18 Mar 2026 08:18:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nd2vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:18:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I8IXJh15925596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:18:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D2C2004B;
	Wed, 18 Mar 2026 08:18:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA57820043;
	Wed, 18 Mar 2026 08:18:32 +0000 (GMT)
Received: from macbookpro.bl1-in.ibm.com (unknown [9.123.4.214])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:18:32 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org, disgoel@linux.ibm.com
Subject: [PATCH] generic/730: skip on ext4 when dax is enabled
Date: Wed, 18 Mar 2026 13:48:12 +0530
Message-ID: <20260318081812.47870-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2OSBTYWx0ZWRfXy64oW/tDpiUR
 Vsd9i1f7tGvhg5P3wVhzq/PTdSrxRbeapquT2IXQcjPF6+7dy9Y1VKLzLzV5qjhnk2h7LYZr4qh
 r5Rk8f4uF4CYA9DWM5SSl/nylxytyoNIIBu9N5YE+Q7Fzrt3pZLKIiorfkKJNnIOqwwmpbu58xY
 h/PKLCFi64TyXTpvbVkWlzlG0pOrRUKTSIfBFO37Pew32xvM/pM5B1KRTEIJUP5uvQ0rzgm+8gT
 yl9y98rEPX95PlMFWzjLasd+YLXCgG2r/lLijbd9Y8A8xKmZoF1LO6M/uNup91V9A4xX6/c2icb
 Lh0W3rVOIg3QYWQXcrqZK7B8f7Jg5z+uAj5JQLZSvDzHbfbUGYBW8Dx70RpXL+pCDaSo6ipseor
 YTGagH3tvK+a83+4dN8P1Snb6gf/YyblRQozuF8igag4XkQhRLFsbluPkhEQ1mDFV2xyY9UrgOX
 cbWCHTP+/mvhkAaWI1Q==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69ba5fde cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2J2l3PWtKg4SYkkgj40A:9
X-Proofpoint-ORIG-GUID: _QAgeoqh0Lhp3sG9WrwQ9SdzxrAvdMgo
X-Proofpoint-GUID: _QAgeoqh0Lhp3sG9WrwQ9SdzxrAvdMgo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180069

The generic/730 test utilizes the scsi_debug driver to create a
synthetic SCSI block device for testing. However, scsi_debug does
not support DAX capabilities.

When xfstests is configured with DAX mount options, ext4 strictly
validates the block device during the mount phase. This results
in a mount failure:
  EXT4-fs (sdc): DAX unsupported by block device.

Skip this test for ext4 when the 'dax' mount option is present to
avoid false failures.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 tests/generic/730 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/730 b/tests/generic/730
index 6b5d3196..b42f5f63 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -20,6 +20,9 @@ _cleanup()
 . ./common/filter
 . ./common/scsi_debug
 
+if [ "$FSTYP" == "ext4" ] && echo "$MOUNT_OPTIONS" | grep -q "dax"; then
+	_notrun "ext4 does not support dax mounts on scsi_debug"
+fi
 
 # We don't actually use the test device, but we need a block based fs
 _require_test
-- 
2.45.1

