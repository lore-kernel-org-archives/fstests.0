Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50323A257A
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172918; cv=none; b=kPw8kvSsu8nz84kyQvv+euwecQ6lD0KM7ow/weRpDY0zeesz6QvIvzLTflcmHSPgW5oBG5LfMEEBUPYZJ0mMmXwPHBMH3hjnKTstfm+K3LMj5Ivd03PigKBQ072AAtkYwHGJJepCVwbHr2R76hHdoAs+h+IouEM3zc+DOot5QgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172918; c=relaxed/simple;
	bh=XE5PQnV+6TNeZeq1mQPF9CAHuK7+G+QWiMutuBpmSxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBa0CY3laXkne8GwIaN6/INQTsmppfO7YIF5xmBPX9l6hMzZeGVZ7pre4OlyrZXmbdzOqhyP7rjagF7NlfLt/fExeugSzNilAtVvE+0O+G4znLfFPaKWFJBEjj19UkyfW7HnToBPp6sdahom3+yqrEBuOAJydCFWMwzqV9e2KIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=q/E+o9RP; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=hj4hvxsr; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="q/E+o9RP";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="hj4hvxsr"
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x1dl2499288
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=gv7TWes1y4I+up3eGrXAwjlXoE6Co9YXuRkE
	+EE3hzc=; b=q/E+o9RPi9VesMlcMZLp4NNdTik46MBzQlavfiRDhLBEFrDxb4Cq
	Ku1gp2RNjJt7s7YkxPPOHaruPTTJUEWKRQKQPGCtcdfvQfYLZvEAQHRHqzRornS1
	WWWv99k6dRBn4+7BoROVV8vKTZnM0eOU6reIy1SvfbULaOkELbl/JOhZG2Oiiu2V
	IImqgRxYZSB935CVYAdJ7Vtf0AftFy0YyXAz6zuHGovglOCI9tMufF/snfcFGUwt
	WtC8ptWuqBixL/dNFnIfyAu6ol9pQnoi1MgAzJm+yC5ynC0kIMxnX0pZwjvvc3US
	3+FmCmRRwu8mQyo0rRf/Ej2NMVo/JSjpqw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbtn4wfq7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:55 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V8PdCg2742967
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:55 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com [143.166.203.154])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd63g9dpw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172914; x=1819708914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gv7TWes1y4I+up3eGrXAwjlXoE6Co9YXuRkE+EE3hzc=;
  b=hj4hvxsrDlwsywAxim6tvQererXLiALiCtRZ2AWfa8cxIZMBMS3xcK2k
   9+lDRD+KlQ0lFyi7bSz1nGdiiYTiefyv28f33oU/o8kusu6a9Wq9swpf8
   mYXNxditE/g2R/zgcD6u0DQzHaId3I/1l17mbqIDeEIwhvs9VeDlQEqpl
   33DB0cnWuREKPpcWOZwwBLoRB1zGGAP67ermsQJHd5e55KNjGOs4NBHEp
   i/rY72j75JAr7TcsiLQsxvzAlcj3eSp2p4jbyuZQN0mNB2sqOQdalcEX9
   lCraEt7jYDrxf+HOodwO85nIDEnxQemcbL+2DlevQ28MaiAquU6h3jmWi
   A==;
X-CSE-ConnectionGUID: Gf/NNbzqQp+ywfHmj/ru4w==
X-CSE-MsgGUID: ODbaPQ1yTye3gnRS+IRuSw==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtplv07.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:52 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>
Subject: [PATCH] generic/590,735: add missing _require_scratch check
Date: Mon, 31 Aug 2026 10:41:48 +0000
Message-ID: <20260831104148.2243-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX5QMwrVwabFaT
 68/yrx5cbjWb9flaJrSiZUvEDcFC8jvmDPJuiBbli7ig1a3f6vzzQWsFfcAA4tXf49o/0O/OryP
 lYSF69LtRcHFWtRW8S0cTlIYaVNUo3g=
X-Proofpoint-ORIG-GUID: cCjoCVWZ1JeGXzJZz7oefN-AoSRjbMR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX0dnyAMX0vuir
 F0N8I+MGyGeS2SnulgIV7c41bvK35yzpHsGU/JNbOwSQ9XRwlS6QfcEcaordCrRna58v43tYQNI
 gfaEzwE0deHh1iV/5jcyeEWwE3bx9PutJDEOQkGRkfMj2RNAVbIggV4RXXBNG1Ur97wcRxjf0ee
 MGQAzMD+0pbL1pEdJ38fokN4jw5dcob7XpIDpNgw1XE2xfNMhbH3nJI0CPwbOHAB1JbOomWr3iT
 lAxbhxbUPbrNKSWuPf5RFz31UT+jE1FhSEiJtUcsKsYwtzXjfmt0NVAQng1YljYML63w4FApa+S
 DiJzDr7vLa/XjpbnW4oNXYh5pbdeNJIcC1JTIZxCWu4U1Uir5uM6QuqIew/2QawyK8PA4+3ec0P
 1H/vU/FgpiyMxHLYYA+Xt5GKNnMbBfh75/9iEOrluYYlIS9ytQnul7oUB1qdFdh98k0tZK6adGP
 f1Go/zO+logHcGMdr0g==
X-Authority-Analysis: v=2.4 cv=FMIrAeos c=1 sm=1 tr=0 ts=6a955a73 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=EoK_iTtilsJg0zOig5gA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: cCjoCVWZ1JeGXzJZz7oefN-AoSRjbMR1
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

Both tests use the scratch device without first requiring one, so they
fail messily instead of skipping when no scratch device is configured.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/generic/590 | 1 +
 tests/generic/735 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/generic/590 b/tests/generic/590
index 54c26f2..0775d6f 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -13,6 +13,7 @@ _begin_fstest auto prealloc preallocrw
 
 . ./common/filter
 
+_require_scratch
 _require_xfs_io_command "falloc"
 
 maxextlen=$((0x1fffff))
diff --git a/tests/generic/735 b/tests/generic/735
index 60fa3dc..d7e732b 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -20,6 +20,7 @@ if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
 fi
 
 _require_odirect
+_require_scratch
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
 _require_max_file_range_blocks $(( (1 << 32) - 1 ))
-- 
2.55.0

