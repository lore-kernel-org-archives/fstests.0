Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9084A99AE
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486046; cv=none; b=GLn4NOuFseLmlTkaNYbKy7gLHOV8DoAVGo0MIGmcLHbrirV1vbiaOiEc0EcYWaddU9lKheoPePGm/5qtYYW3enxjCLHuf6yDeLTgM7tECaRGXmzxXcxV4OLJPbYaWXhlgcVF6fUMKNuG5gGlWHPF4KKKUWa8DxJ7b7bu8UAZgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486046; c=relaxed/simple;
	bh=2i24WeWgGvv7g5BUc3Ruu/IH9zlQMA9TaHU9WMKi0wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELyNjifMEdU91HCMz7rQFkKefvTNxlXhv7ax/mtsNkcAyWFiX92r01eUKOonaacxwZsiXt6nVCN0aqeb4tWRCV33N72KMdmYLel+0dRulWQfGnvLAd1pVDQkyrDhkDQoogHfKJ9pOnLxRav9gGGWo6+D8cIWOUH/OjiQwfyC+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Km9poefN; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=dIkBEqpi; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Km9poefN";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="dIkBEqpi"
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1jLP251208
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=M9W/SlQ7ja5m
	PgEMq7pRdcXF2hcFGbtyJi91ryM9DDo=; b=Km9poefNv2X+kcsh5f7JuC/5qWKj
	I/1/OKgPc+PVM4VZFgrNr0qa4GQ8SXiXJu/oOgkt3MeSneVlLTFZB43hwOMGFied
	7NDeFgX6yTDh5EsRh96dgXCpaKeG0Ii2dTFOu8QenG4ig5/YflhzmoC6wgwK7TCG
	XAiodFxfyvHj54E2km6o00VEcs/6T8pmXh00bsGq7haqAl/NhsYNP4JdBhepJvXy
	XPeHAnqjs7cpoXY8bxbHVmIlAqIjQoHikdsQMiZJgOtG9+v5H/pBxNP+K8IlzNOl
	B+kLQOagCRT05VnZHKs9L8TIFH+++4G9F3hKXYUMwPk0xUAldziMYr1Qig==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gn1y4kr4t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:56 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FDxS9D3661268
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:55 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gq4m0k5v9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1789481876; x=1821017876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9W/SlQ7ja5mPgEMq7pRdcXF2hcFGbtyJi91ryM9DDo=;
  b=dIkBEqpiGq9jPBfKar3UgcNLayPUKZK+rmqrB79oufr+ZhXAaVwhagUP
   N3hSdn+ZChDBPb4uC8f8JUfI2fuLxo7eb11i/r/t5fPwOZH3r0l6dm0ED
   6oM0Dj7vUtt/JjWetj5cpu+Wg3CYGJQ7xBK2l7oa0e/2xVjDSSeSegADq
   nZ/4JAktIwQX9UN/Lm5TL4Slvjmcz+QsQkuZfl3TxLJqBX5wYTxV1v7Ll
   vNSnA2EHtJZFa2kinvGNFWqGRs3epjN6Rx6TE5OuIeCAMF2RI+zwhUG0x
   jWgI4qlHwjSXH4KvQQ/KDnMZLByI5Fvo3W/hlVva2bdHXZkh/+iwXeaLv
   w==;
X-CSE-ConnectionGUID: dcz9DbIdTrWeH33/gIpnGw==
X-CSE-MsgGUID: GQF9kMqSTJWVnJhRLj5I5w==
X-LoopCount0: from 10.94.9.174
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.9.174])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2026 14:17:54 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3 1/6] generic/590,735: add missing _require_scratch check
Date: Tue, 15 Sep 2026 14:17:40 +0000
Message-ID: <20260915141745.4299-2-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915141745.4299-1-prabhakar.pujeri@dell.com>
References: <20260915141745.4299-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150207
X-Proofpoint-ORIG-GUID: MrzQVJE46aY_VmAik8bWnoSVtMVorwaX
X-Proofpoint-GUID: MrzQVJE46aY_VmAik8bWnoSVtMVorwaX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfX2TNvBWdtbTKK
 HKuXKdZnjvIvpfBQIGlUoRVPp5fnFQ/gaQn4ClyrlFAmJA/cBcLC2aI7JaGXwcdjWzOitJjNT+z
 WM5loGfZP7vlL51KGhPRoWtZ/rvpIZU=
X-Authority-Analysis: v=2.4 cv=cLN1IVeN c=1 sm=1 tr=0 ts=6aa95394 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=EoK_iTtilsJg0zOig5gA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfX/I+txvY5aWWk
 DzkoGYB0zOqTVJqbwdHERjKTk7D1dwv2QImGnVIf2bskR9ZqsjR8+7OeRIjEFGabt5+LqaB0CRw
 ieUsHi18HSj/g4Y2czbouePOvtS2TQx0HzWfsB9PGAaa487xA0ERzR1g7UAjXmANLbJ95YTruXo
 5pT1mB5VEy0l/CkCIjJPc7XY3V2/O275XbIIlhqOJptwQQiqlyo2G3Eq1ZCmxcvje06/a0S86RW
 K5cPo5jdxIetlDD7xCvXi1barOLsURm4+A4gvjJL376L2MqanFLlrSb0LnZt8BiZ7izh/UTBMDF
 AlpEEynlBF/xiqBCfXOJmNucXP4NEndReLVOeLVZtOtiFOupe6c+P5J0Os6Usq3wev+iuEV4AN6
 ey8Mv8dF90pq34uBtP2vm2ojWHM9L5BKYL38ntbDFYm0Nxj6hzlPQ8vuOVtHF39Au9HGZSvDaab
 u9OIfndPOH7kBPD+4VQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150208

Both tests use the scratch device without first requiring one, so they
fail messily instead of skipping when no scratch device is configured.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/generic/590 | 1 +
 tests/generic/735 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/generic/590 b/tests/generic/590
index 54c26f2a..0775d6ff 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -13,6 +13,7 @@ _begin_fstest auto prealloc preallocrw
 
 . ./common/filter
 
+_require_scratch
 _require_xfs_io_command "falloc"
 
 maxextlen=$((0x1fffff))
diff --git a/tests/generic/735 b/tests/generic/735
index 60fa3dce..d7e732bc 100755
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

