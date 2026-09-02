Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13B1FC110
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325302; cv=none; b=S9ix6EsLeCyiUamVGijNN7Bos2xj14oGW/muidukWc7+dZq47olPtFY34rjyu4z4Ge9lMANUn7gv5mXWOSNnYKa4Pj1cMEuoEst5wcswgbmwppw+ldOfPKhU1Jc1AB2Q8YTc04V9RSZaS6YAyeZPeBKZhggLS8iUqedD5D9WTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325302; c=relaxed/simple;
	bh=cOk2Oou3fw/X3G51OGWSZm7lzF+CW/SLeCTHA48LYyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APeZqNigX6pWEgo8xefk+UKSj+AuI0f4lEYBwcvqU1eMkyzRFiASeVIcpGWLBh/u3YTnbsZhzmxTr34kfXX8km1cLxC21smwji8eNwUVK3Qj1GCWn2713bZPWYQum2lelOFTWnl39vC+u0N4+sSj1/Zq8QJLi2XIcODK1u8w1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=sR5hM8S9; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=PMRScVaA; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="sR5hM8S9";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="PMRScVaA"
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KS2Xm1481598
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 01:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=1/KLKRiVPfcZsBxemYIk6m3oWKrc/kl7djnj
	ssGxzRU=; b=sR5hM8S9Ix7cZFD6eh5diGTiFJ4Q6yPwLmreUj7PsQw7pntMMvbU
	/HOr8A/ME1FCudz/OFjU4d3Lyxr0ZMfopEgKeMK+MJgAzFCpC0vfa+s6jC+Mt5Z/
	sfsrJGAngze3OIv3rahXuGhBe+66Rn4Y4l3ns97x1vMr8mBq/4vxB+0e6JEsJZNG
	pTnSra0D1TL07eA/zav44L2FqPa+uuVf0hZKAKxFxjUzaqKeBrlLkW7B8cl02uUi
	OOazCbDN0sHL0R6/Ie48QblLU5n3417cYbHBQsZMhDtCaKddykI5LmDDNbgDQWT2
	FIMqkV18gSP4cKpxCACgIExrbhs7VRQ7Kw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtfwqtkk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 01:01:40 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6823MBPt3107613
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 01:01:40 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com [143.166.203.146])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gebu7rutr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 01:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788325299; x=1819861299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/KLKRiVPfcZsBxemYIk6m3oWKrc/kl7djnjssGxzRU=;
  b=PMRScVaAsxnX6FQJXmNEroSVEH+M8QMpwTs6XntNLzUN1EnGPDbbX049
   e3vMaTgJnTTcJUGR5r3e/oNJKU0MdtN3f7II4XxJL1fz4F+RLfOF7dD6v
   YlCl2LV+rWTat/WuBpgtXHEX82uKqYWTzl6v32foo99t+SceDq241NYtu
   k766otfKMIx8VA/dctEc1yz8qXujiWUZRdk2xxk9nruWOsLvK5gTtsj1r
   Iu+hRvXw+wK9Blg4whJWIpx9salKtLg3SXqVva5jN1taAZXy4yiCWY7B4
   f4qTtQnFWHffVxj2UOF7divQE8R7q5YI2NYp7jfOEdAIz4T8vLBAYiSaZ
   Q==;
X-CSE-ConnectionGUID: xmtYXp9vS+ifyVFkURmwYg==
X-CSE-MsgGUID: 6PYL9kzaTbmITLdTWme2FQ==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtplv06.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2026 05:01:37 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs/015,016: add missing _require_scratch checks
Date: Wed,  2 Sep 2026 05:01:33 +0000
Message-ID: <20260902050133.2413-1-prabhakar.pujeri@dell.com>
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
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020042
X-Authority-Analysis: v=2.4 cv=BdToFLt2 c=1 sm=1 tr=0 ts=6a97adb4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8
 a=mO6Rr1tav0zkpb9LypEA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX5piOM2QGYgSl
 8XJk/jr91Ub6XxF5sczb3D0FsfvCDbSdiJGNAfED9jVr1oLHsfICDr6DnxmK6khS+kWGK0+yM/8
 Y/6Delapz0FKxHxXWoUboTwGQ3Hi/OdjeHaUeUXQgfeF7K36Q8EEqkHK6J1CrxoGa4kv0D4v0lQ
 JJ2b031aRP6SQAwpIzmKoFcMVEzLt2fKpGLpdO/VAhtCk7A7b95S0ttIXCEGg3by/VDOJYEVGvS
 bWzOT14toclxAIg4gSAP1WtgWURx/V0QHApcVpRgfUBk/NgWHAu0F9cW55rwKaLSTEmrx7UulCK
 7t1vsiXskfQdHo9JQVElEboUHPFK5GIBezbiHfvH3ynW6F8mKvWJkkp/pPr7C/xB3uKbUp2MU5j
 La95GjT9OzIzMss9tgwgScqz48C7+FDR624EAxHfIKb+1q1b8cJQfnMBI0Ypick9zZEbyENJdnf
 N69xBYgv/uvsz/Xz72A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX9w9vM8ksvPtp
 9+/w81CMLbRWwuDMp2CwOEf9/wNks41iYFb0n/xCmiuMk2KolM94nsoMOcIUWlvKjVP+NDwf2KT
 PxeheChUnih+hhV9odeE9DE7TW3Iv2Y=
X-Proofpoint-GUID: wwSmtbYqYoBIkG4bQHqnQexd7fQEsHgO
X-Proofpoint-ORIG-GUID: wwSmtbYqYoBIkG4bQHqnQexd7fQEsHgO
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020043

Both tests run _scratch_mkfs in a loop without first requiring a scratch device, so they fail messily instead of skipping when no scratch device is configured.

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

