Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71E37C934
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486534; cv=none; b=OBQ+roWks582TfQjPVYJBhn0dGCT52SZqwTXnXB0zFlOce1icFaFfXeTpwaD+QNueK3CKmxg1hmd0/uI+iwucMEVI3FGBMtd0yLchQrycK9zzTfEiKGOOkwoK9Ae/1KkYjda+eq1ycgcDsUK5oEm0CX+cQkPjEAYii4Ess4jx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486534; c=relaxed/simple;
	bh=y034vEy4OAXk2eyXeVxM1GMhIL2c8cnPN5lZWqJXuTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipB3I03nWDp1l7viUlKwhfiTxTycboSA+lb7MCbP94JneSzn9o7RR3vYYux1sbmdZN/wTisxoZBvXH+OwT31bBvU5LPlwU0RDUgSuCYlIaE6W+HybsYd8GmTqQmRz3FWIbHKIan2Fj0sTIKRo6P0QfO44HmvTQAP4PGE9/hjJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=zEQW4V5q; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=cFGWrC+X; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="zEQW4V5q";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="cFGWrC+X"
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1h5k652883
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=i0ql3NkidXtk
	aKoJVbDJSny1HBM1HO1hMPEuXNyrd+M=; b=zEQW4V5q4yWgrgth9Rh2e4TeWPcT
	J0anyuYenSNU6tQk8qHZPDn16uLVd0RItmfq0RO2l6Am8gl/cbDhZ8GqpW3RxDz9
	6He6GpoMQc32aOYGPYP6uw942XbHJnvQzgnepHHW89uPdDsujs3D+LPDDDFxYnhr
	TT1IA1nfGf8IHpmnjIYr9UY8cmYM+fd75qj8KNGR8q6ZqlJteA8r2TpHPa/oaHxF
	SUQNjeJmofnrxD3QDGQImk1daWoh+yhYMRSCjon7iJmtkb7os5wcUlAd/TtYchdG
	dsuGlF16mtOPMr/NxR5Xpc44WudjHlkuTryN01CwMJ87dBk0aZ68AeYluw==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gn2jt3msx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:18:00 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FDxS9G3661268
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:18:00 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gq4m0k5v9-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:18:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1789481881; x=1821017881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0ql3NkidXtkaKoJVbDJSny1HBM1HO1hMPEuXNyrd+M=;
  b=cFGWrC+XF7RcuuPC9z+wVVqdOC9t7xVu+5f0YF3Wk97ypde00sTpOKW3
   nQlaz6YNFBLiyjTn0Lbujb9rsJXTGebsEoHUQYma46+M8BiV5seDRoUiH
   7jmpE4zwQljoHxj3IrXwxmvSDHJoNQN+DL5DOGHvZWOieE/LV5muaV4K3
   DilsB3w59HAfAb8p9RtjR8zJsPbo0SjoonkmISx4KCsYJqe+LFXP5Baxu
   Xl+IomAjwXOPnMyyuWeAjcwOFR+0rg3KPOF5TGFofv5+PuUPXMEm7YQFX
   6WKM77yuh4EY9spfB55pW+0e9SHbDMVkcHW8BC1z1G4adG/VviO7VPmud
   A==;
X-CSE-ConnectionGUID: fCOpgZVrTiqRoE2b+NAeOw==
X-CSE-MsgGUID: kWkOdiIlRMqFoelc5ykeMA==
X-LoopCount0: from 10.94.9.174
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.9.174])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2026 14:17:58 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v3 3/6] f2fs/015,016: add missing _require_scratch checks
Date: Tue, 15 Sep 2026 14:17:42 +0000
Message-ID: <20260915141745.4299-4-prabhakar.pujeri@dell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfXw6Ghv+ueNn3Y
 B4qnxSxfeST+D++gh4bM+fUDNcumoRAFU1xJijhRPcjqzhLm1oQHfsoCec08PYQ8kG5/eA7TPX8
 0qAiufDaxBYktqBS4V+DDfVJRSvBVXFmKBJujAb73JxHrkOe1HbrDOxI1awCR3uzYxpdTaBX/j4
 7HMF2fSg5fRKAugjDm77G2Uklc0Fo600mOO68zbYX24BGnEgKZHcMaqvLvJkxnZlxGa9nGgbLqJ
 qYbZFL+NO80U/XbDvUg4dzNxYK0qzaAl+0qg14ESoP16WwLsfZrdJE+tdEcC3GGYI6rPP2J/j63
 4sDQyzX52zX2IJfX+T4I90gCQnyT8ysNcCZJBbf0/lcy/AYQq2qUdiO/9XTFJj8OX+QbKF7EQ4Y
 Bx/9N7AJu757OHkLRGr5JmM85u+wIHrbzi3qzDsMSCYMfI8c1YCULEt9k/t0ap5XOfVdNVwu+LJ
 eADTk4qT23/9cM45SZQ==
X-Proofpoint-GUID: Wgs3I4AxIM7SSuBz7xne6-h8m8OFczqR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfX4vh0Q3ubSImT
 1M3ZTK1I+diHRXKI2WqO36mchdbpyUylt3x3+m4QqZYa3R2DNiSgkSHJkmPT3Q3PthfHd9s/Iy6
 OJ1j4Tbs9rFR93pRM998zcoAXGhZBwo=
X-Authority-Analysis: v=2.4 cv=b/AncdGx c=1 sm=1 tr=0 ts=6aa95398 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=itNknoWdtTBfkXsrupcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: Wgs3I4AxIM7SSuBz7xne6-h8m8OFczqR
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150208

Both tests run _scratch_mkfs in a loop without first requiring a
scratch device, so they fail messily instead of skipping when no
scratch device is configured.

Reviewed-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
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

