Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE231344D8C
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407638; cv=none; b=ckLxJa9sFJzZebqdzxbJFeysotpGcFyzsXNUj/bFyQczJvzJrX59YAwX0czybFFbz+AXJ2OaGQmdvcAmLGzScWG0bR/D+Lkf7xSmFnfUaV9aCvOg9qscAiODG9+3MsrSzgsjBghFKuMU4T0rxpYQaAxlJkcYUJ/ixfUT57ftDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407638; c=relaxed/simple;
	bh=6B6dUGJFduL5KWfyo72aIduXBnfp7jzVT+DkAhsLE/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVxjW4F61MbLC/c2ShWhK8tepzF89FCjcqxqCaQGQ4QVYS6ULAuKb/3/m01hDrcYvzv9pDNKhyQ6Uc+JbgMg1bnn0Eze3V8sO1PCS0tolpJnchdo5j1wLBuLXwH44OwYcw7kLh11yWmm0v+gGRV0MsizBza5gO0gBT3bDtMGw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=bgXTlEmQ; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=bfdIXpdK; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="bgXTlEmQ";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="bfdIXpdK"
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832vXEj2713304
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=f5J0fn45pArx
	q0JfaDQY3sOKocEePmivLTiwXXuaOdU=; b=bgXTlEmQH6MxP8vYCXQiASoB8Zp1
	GaseSgZEuFtFrFKnFg3LeBsxPvkeuUQn2CpQELh1lTqrn9SgGmljWABU7gt/Hef6
	yBGwfPuf1mgNB9xx1dD1UZnoaL/I/5b7QTrpMkmTYsqehXVx6zxrMggND9i4h1ly
	tPbfMAvpkc5cWB40ng7UBFOJ0jiYt2+MOBMfOExvy1AO4SX/0Pl5YCkLc+oiLmaT
	bQnqaB/R9+WF5l3dP5lWjahPV7HHaYhUJxOYXSB8E+l4C6aRJ/Ml5A4B77D1PpPA
	HusJBTq6piQbfSNQPRGqgL3N3mqSkHY119TY8KyCllZdgZdk0QDkoOm7AA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtk7d03b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:56 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832xmQt3359155
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:55 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com [143.166.211.146])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4geuq1kgrb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788407635; x=1819943635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5J0fn45pArxq0JfaDQY3sOKocEePmivLTiwXXuaOdU=;
  b=bfdIXpdK0UgicQY8bMr3oKVUhPDniPiUVMkohrEh+kdkAavEW9PGWbhV
   Zil5p+5/FAnroEnMdMDyu+jBHH6h4qiYk6/w3VdLhGSHN5prXM0rF7nNB
   7MU3DqOnEMAMFnfPfCjfh21mTAvDRz12ijAT3jvEMdSCpkEO4bCVq8RNP
   6Fjy6XTN7YP/9heooWoBD+jtajpTurS/8zyB3bHtyCqrkODl2B9VZC8u2
   fx2IdTpUyIkCTbpQIur4IeFqCLn/9uo9vRL0x2y2cAzpLhzCvC7Y/6BaA
   rV2h9NiZ+HqbxEIgI9FU7ftRaUf5HJAK+Y8U0i/TRzk7V925iVt2ve22/
   g==;
X-CSE-ConnectionGUID: acv4rW54Q9S1IhE3C1pMUA==
X-CSE-MsgGUID: JL7eoqxfShuYZZ36zFPtZQ==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtpat01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Sep 2026 03:53:53 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 3/3] f2fs/015,016: add missing _require_scratch checks
Date: Thu,  3 Sep 2026 03:53:44 +0000
Message-ID: <20260903035344.752-4-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903035344.752-1-prabhakar.pujeri@dell.com>
References: <20260903035344.752-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030032
X-Proofpoint-ORIG-GUID: 9AiOzI1bazMlXmoQSZM7i3ThSMTFCeit
X-Authority-Analysis: v=2.4 cv=PL0/P/qC c=1 sm=1 tr=0 ts=6a98ef54 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=itNknoWdtTBfkXsrupcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX1RHHfon5vl05
 9KswM12aeOjL//6HWtvBF31JjJTZpsiQTvjgvNHArmGyJEwhWdv3LRHdgKKciuIkygb6w5kSiBR
 ZeDanjZF7i9/Rv+7BX9LLmGDqlHNsSo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX2em/NLhY8BDb
 s/qswkL8E5wbg7m5xAYXncMhk5Fhzm9cWCeSP6Y0OjtnjyHqUusQ42EPzQ7atW+R3c3eHPquMoe
 CZZiuTIIj58xjhDGe/bUfv9BEWRH+vQBJ/OSlJDb5BoN8ZG3iQCoANkZu7LtpG7McUEtC+yg2ok
 ewy6lAlmqtwGXn9mmr2n5e9y0M0V2WSQ2mi/v51KAUm2a3DoOt696pFGbeW8bgjke+MJrCYE5fZ
 gMdYahpBe/6dINErzt8t8Uh15ULpQHmhrPVEuk2kiZkJFcsXNJzbdTw4PcmvL6fMtptpw8AL7kZ
 knS0Fm7+7v1JUHXtYBv6xTTwjPbmvjZlxuTUPQkf+iN4qRGXht73k1HOXApKGJdI5J2T3lrY/d2
 kWW5uLzzC77l9q2H3xq6YVd+kOIlSb2GX6jdFYIG//dcadYhL8U6qSl7SSpc142k5bHhhlLVyWn
 U0G1XGi1k9ZooySlTSA==
X-Proofpoint-GUID: 9AiOzI1bazMlXmoQSZM7i3ThSMTFCeit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030031

Both tests run _scratch_mkfs in a loop without first requiring a
scratch device, so they fail messily instead of skipping when no
scratch device is configured.

Reviewed-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/f2fs/015 | 1 +
 tests/f2fs/016 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/f2fs/015 b/tests/f2fs/015
index 54cada4a..75ae91f2 100755
--- a/tests/f2fs/015
+++ b/tests/f2fs/015
@@ -12,6 +12,7 @@ _begin_fstest auto quick mount
 _require_kernel_config CONFIG_F2FS_FS_XATTR
 _require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
 _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
+_require_scratch
 
 options=(
 #	mount_option			mkfs_option
diff --git a/tests/f2fs/016 b/tests/f2fs/016
index a6df827d..e0857e0a 100755
--- a/tests/f2fs/016
+++ b/tests/f2fs/016
@@ -15,6 +15,7 @@ _require_kernel_config CONFIG_F2FS_FS_LZORLE
 _require_kernel_config CONFIG_F2FS_FS_LZ4
 _require_kernel_config CONFIG_F2FS_FS_LZ4HC
 _require_kernel_config CONFIG_F2FS_FS_ZSTD
+_require_scratch
 
 options=(
 #	mount_option			mkfs_option
-- 
2.55.0

