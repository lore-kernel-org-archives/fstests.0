Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782834750B
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407636; cv=none; b=eEbZzcBZ5vDrdQgZllsDDOCxICB0UA4lWBr+cff+TRWPyT5AYtPJHRXh4L1fbhBjEELzZdz4TzFq93N88pLQMxREauY0/9GfIui2TBbBMeY/D4P1NqFwacTAJzpWnu0jvmuqnGWu7kdpcGC47sqc2WB4uGS6YUMoJz8ZQy1hBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407636; c=relaxed/simple;
	bh=2i24WeWgGvv7g5BUc3Ruu/IH9zlQMA9TaHU9WMKi0wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtu2XwPIEjYCPLl7UHnPeEjlKuZqhNOy9ntFCV0d4aCD0HBErzXrEZ3NUoYaLqHkXOeFQPyZQu650Ir5Afy0eag7JFpBDQ/evs/Dq9ErixYmGiS0dZH5ySOmgVZ9+uySFzppYcWemXLwCxAyb/Pv2OR4joNOoOLQCB+4SXqDL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=dYEFuz+z; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=l/xgW64D; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="dYEFuz+z";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="l/xgW64D"
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832vdnX2564456
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=M9W/SlQ7ja5m
	PgEMq7pRdcXF2hcFGbtyJi91ryM9DDo=; b=dYEFuz+zA8LAF7pJMCefrGzgUcJ1
	VXqsHCvmGoGjbnoUfj3Pj04jsDu2jM56AmpiBNNreWnfcapvfTFzutIpxlvaAtwM
	46gj0bo4EnmnvoLDeHDGUY5VhfCKvWrHXcsbk2xvYaAffmnMr9SlxE9uUJEWtRqi
	ahu4I+pUg/EUYwFaSgFCABWOtJgL6cEPTikoWx8r/x+5lskVZs4V2OAO5aEktWBz
	cnPJvk5ZXM/JwAnK1T5c7BVzi9xccvxqXmHx1COXf3wsFuB8S0tRavT5DIz6ums8
	aSgBKfphxbAMCEysq4MrGJ6C/E+BbsY2lgYLtjClkc51rCZwrgvL5ZteHQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbueecr04-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:54 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68338bD01209912
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:53 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com [143.166.211.146])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4geu9akrwm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788407631; x=1819943631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9W/SlQ7ja5mPgEMq7pRdcXF2hcFGbtyJi91ryM9DDo=;
  b=l/xgW64DKXScD59pRv0sqcF+GPTSjBIAKKPpkRxsFC77eeXVPR67pWB8
   ToV/OJR9bsd4xcFA1LqzN8jyYxMOMtvp9QgyWsdi9duh8+7fkmfXbANT7
   dF2gv6BxSmV7LtlegsvKu63LRL9/VjEWWlYvi+ZIgULuUa1UU8+lFr6f7
   58n0BihMD0CtmsRpxY+84EpyB7jTz//Ch8nB5EW6nPWbwxa6qsXJ5FvZs
   DiRr2cK99HQQfAdY+Ce93PJWbqTeT4O9eCNS3Sgc5QBD8DWkPCaN3o6ln
   epBUWO7NnNNluDfFgFHdStOaRBOwKVBd8ifFaSQqRxmMvR+/oo5JISVFz
   g==;
X-CSE-ConnectionGUID: 7eaLrtzWSTKaayd8ADMiIw==
X-CSE-MsgGUID: mI2sLJSDQfiK7AumeFf++w==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtpat01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Sep 2026 03:53:50 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 1/3] generic/590,735: add missing _require_scratch check
Date: Thu,  3 Sep 2026 03:53:42 +0000
Message-ID: <20260903035344.752-2-prabhakar.pujeri@dell.com>
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
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030032
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX3tgiyrlkQhJT
 lmsuiNr5yqgJPSmIhS/u1zOL/WSxisQZu6q4MceXcirTsI7CT61VsoFB7fJ2zhTAI5b/WH6LTwP
 gj866ZfKcxq8y6HfgU0Q2sNiUXZJY3w=
X-Authority-Analysis: v=2.4 cv=FbUHAp+6 c=1 sm=1 tr=0 ts=6a98ef52 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=EoK_iTtilsJg0zOig5gA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: oS1AEYWDU5thRjpNPKP5GuQb9TvlJSp_
X-Proofpoint-ORIG-GUID: oS1AEYWDU5thRjpNPKP5GuQb9TvlJSp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX3+Tfn7yn+TFa
 aUeg4cnwRCQHSkuILoGeMWq66UkSE47YIDo2h6WfjtF1gAm+Y6FsV03gg6XxHjvYXtm2/7o1K4V
 dD8ZvOkz8AU4rM7s3xBtScZCGBMjTiTyAvDK+SURDBuPXrMFUIZOX/IoDklbRZc49vOn5MZQt/E
 vZP6F11TzTyoHnDtbsJiDbBm1+bMRrzSwAhsQh6CN2ulrP/zPWM86qnuiuy0RGcCBocEFdgiCEp
 Ihg9lWMMYgMOumHqFmWUFs4bSPv+UvqmCWchIw0zZnc9KJMaasRqlIN7tgSivy0gRDD7GInoZFI
 y+laohzDLAfpbmExZArMKHgQx8POUo8e7sf8Fb6mbED/qwSJ/kDzOv1xe1Sf3ENY/55zVgFH4SZ
 K44Ncv70bAJ6LMXfjcVOoFf6F8cu0LAiUfrqHu5bIfy+svfuwoD+/4XlKejVAjgAwL/wT7f2hZ6
 xAk0e0nFN8JY/Y/FZSg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030031

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

