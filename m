Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B928D831
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407643; cv=none; b=Ox/80YvaO0qdpJz4CYRT0DVMqP0/jbg5ebTBDb5Kw1x3AIvJsnNAlY0wTxpJMwvU65/Rke3sqbRhhOXBGZUIe9gHKBxSpLS1dMHU5YvP5Zd532Em/ohJYDjrY8pu02LxHepQ+aqbzAGCy5zfqDRsiN3aJG01b0j0lsHsr5PO5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407643; c=relaxed/simple;
	bh=u+Ul4rHd6A11EYpEDSt/Kiaj5PMne2PLrXwIpbJiWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftsxJ/cV4ZzWDnkcuEGQGmrf0b1crLCZDFL/RBVtkey0ZonfgitTBgXczcRnrZw/IGQVPoa0vx9obxIH2yLo6DVxKXJokQF3Oj7d9M5tSyKRq8E2hUdJ1yDvrtQkf4xDLjKwiBRwOzrTHbn9qufyg38BPCrlAe868cDZThXOFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=L6jQLRFJ; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=IZgC4nFR; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="L6jQLRFJ";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="IZgC4nFR"
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832w3jG2727034
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=n92ZgNPaqmHp
	qIBzwaHbM6DS22O4oYnHfZYTRXw/zMk=; b=L6jQLRFJKUpakbymTkr388C9BxnB
	y1u9tYmAJmDRhyYxhdqmM+qCI3mDPVmPvf2RejQYdNDcBkKOxHvregKvKPSAJIIR
	ODSYuhc4uvGK7tcf0qMJXEAAH4iFaCU+Q51jhbiVSrX0SJ9xpGLDB6Dh/d7GW2cd
	sj2by48YLOb7DyU2K/J4VgGljWSj70rktY5MZBBVn+YvcSe5OkRX9UijeTwR9A0k
	/y0RfKwDQ6OCBTAapWEKgeIdYQNcxybJxvj/4mwRIWtj/840lS0gacn1gaHpBfsm
	WOPjaDAUhvtFpyQhyKzxqzluN3pzhoDlo5OpaEWtfqyQAN9fU5hP3Q+kNg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbt01w2v9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:54 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6833MJCB1439916
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:53 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com [143.166.211.146])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4geu2qbxxg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788407634; x=1819943634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n92ZgNPaqmHpqIBzwaHbM6DS22O4oYnHfZYTRXw/zMk=;
  b=IZgC4nFRaOXtDV8ZvbRRRaoZn75UHheUXX2IJX5C7oK9A4qXdS4by6xJ
   Fr5SMLreBDfriU7+plefgxzwbRABzGvDsZcx9h/YQ40yzIPzWB9ZVFUlE
   Khg2WyaXNiFc50I/mgvpejw5nDe08b1///pg2mBIC6T/uIE9/i/Jg+SnG
   mTKGlltsWFAJdZMu2FdgpqjMY2PCT5ovB08ZBA6b6FERh6ut81ZEynzsN
   yrekzKcfAg/VWNEQGr3Z1XFs2IEvYv8hz8VTXrpnZnHAW+WPH0vg2hUxN
   rD+gfmsL1wcat5rqyIqyueniNsAAFAlmFVGARZDx4b9q05UHCjx6BOGAp
   g==;
X-CSE-ConnectionGUID: zpcT+CYFREONHYsv3KK56w==
X-CSE-MsgGUID: NbwTKMuMRyaGpwCB+trAzA==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtpat01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Sep 2026 03:53:51 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 2/3] generic/795: add missing _require_scratch check
Date: Thu,  3 Sep 2026 03:53:43 +0000
Message-ID: <20260903035344.752-3-prabhakar.pujeri@dell.com>
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
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030032
X-Proofpoint-ORIG-GUID: mc1_UGht8v9iWouo5O4MYkvcTrzkNotE
X-Proofpoint-GUID: mc1_UGht8v9iWouo5O4MYkvcTrzkNotE
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=6a98ef52 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=gLxAKuEMs0EQMVFiDJnH:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=wPallV7q4Y9WyMEzn_EA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX+KDG1V0uCo5c
 CJWZG9xqsrxkKvsY4wGdmJXl9N2B8wD6Ie8AwEsC839mWhJfx1Qs8dfRhOLqQISuWnFvv+IrMZK
 FQflPq7aflOX3kYh35tgGPQD6hbtHZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfXw1iqVYRno7NA
 BTrc8DNTPWoRINPN/bzNt+dhEGsN2Oo+PbOHPfg9ERRUmnZxCb9cuHto5TJX5OtlmbiTnDQkRve
 nIlnqi4IQoWPo3T7jwS/Vi5Vk7W5icigA0BGhxLQa8QpHIx4qZzPNjnVLXvKcjo60zE3B/7tPYG
 dH56JhsYnrVrv+k7dBXgGGhm5bGl4W9wxnXDmwqVCsujqZbLW6cNpYfWc3mIDgpJVXVlK+yq45x
 mjJ+QFVhc65AqROGVkRSdJvmDjO3rSO8ZDqeZYIe4K9j99cxq2YZLt+wafRwj9SzyeO6m3cmZ9b
 So1RqrnaeploLCa4R/ICUNbuUyVnYzPMwg97s9eTISGYuu4e3kMSpgPP2NidFwRfyi2cdIIGv7n
 qUv38fA6CPZWBYNxMQZbRnP2meb3hGEc2HQynGz1HS85o8PuQCQZzM+T5fqY6bvuHfc7AiUf9W0
 d8jY5jUm46ptuohKybA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030031

The test runs _scratch_mkfs and _scratch_mount without first requiring
a scratch device, so it fails messily instead of skipping when no
scratch device is configured.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/generic/795 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/795 b/tests/generic/795
index fa5474c5..4c0e7bdb 100755
--- a/tests/generic/795
+++ b/tests/generic/795
@@ -27,6 +27,8 @@ _cleanup()
 
 . ./common/filter
 
+_require_scratch
+
 fsv_file_size=10000000
 nproc_enabler=$((4 * LOAD_FACTOR))
 nproc_reader=$((6 * LOAD_FACTOR))
-- 
2.55.0

