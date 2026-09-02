Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD804318EFF
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 05:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325310; cv=none; b=CsyoqfVTbs/o0D9XRQzWKWyFmTTRIhdu26VuMn6teikGbpEJjmwTicwrxLjdxGXUVKmhnSyIPcBN+hWZddlaFQLXa4fUzF7X+IHr64JOyu7+qin1ATo33vTNYEPuRoGLogIkPHA45xgAiK/BXt3JaobVeqL+kfNJvYkfy20M0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325310; c=relaxed/simple;
	bh=GNA54eXiGMN8mJ6fm/SJ5s5vswwg8zKdycrFdLtSpyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsALKRvrlPdwJ3q2LpYLpBh13qlZML2kr608GHO4XTMePxDAWo9bDUWRLbNtCqrlfDXvBfke4EWofbBbdKQ9y758IEG/Gh5DHmOUAMt4zW7HMJn6jJIo449fJmYHi/ID3kJWnckAZ3D1n4CInDO7W0p200ludgeYc3sM9xgSVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=QaEnLKz6; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=hjzfm9S8; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="QaEnLKz6";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="hjzfm9S8"
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KSFEW3620936
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 01:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=TnW7ZJo1UuH0SN5ic7v3zIqIYX2TqFRxYdis
	rJbQEUo=; b=QaEnLKz6eVCsHYdomElNQauL9KOf+UyOIhKcD+B8Vc0ZNbqdpQMA
	1+0iXNjiiySRJDzuIg4OYDzG5wEToOehtZWfhyl2tNbkQuItQ2JZ5YvgB8BNOgSm
	JrzaSDoDZcSFOdBkPi6nwOxRgan4oXkjG6rvjXWjaHThJIazucDJE7S8AcLmbymV
	pFrfL7Cat2F6KxFQxB0IwMkEmwXqO6/PXw2I96kfuxlSTsfpjF9kMj37GRMFB4AC
	IZ24wyvIOBQSXRacSdT7Gu3lVXfxPB1Y3axpxaDW0XZAq3fAqE/oK3lNSDCvnGS8
	PZ6/WsxPlDWKKbrz+pZuaPBavpCAPuidtA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbv3gfmdg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 01:01:46 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6823MLpB3107975
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 01:01:45 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com [143.166.203.146])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gebu7ruuk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 01:01:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788325305; x=1819861305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TnW7ZJo1UuH0SN5ic7v3zIqIYX2TqFRxYdisrJbQEUo=;
  b=hjzfm9S8xL81yxBm+J1xugYp+vgx/MtmU/W+skTfpYwck32gY9lq/HhW
   cUTPhKCE4FWsJaELYsP3tL7O6oXU+91M910V+0FbXbfiLOyItESfH5918
   hJvhb3eqDEz28SDqHLi0M749DLrI1ljiJO/vbGmsvEiyVCs3H4iaqiO15
   8PHvXK3AB46ZaiF81iL/DXjy2lgi2pSkqBD02YX3L/pBxiX1fzpKkEzpZ
   qYXFTpztJ7JFzYxGcv52w3UYPZrwWR782pAjofcDNeR9JIfvEx14Uy34x
   hNbqLwEGQEuyEDdGfiUO/Ilf3pv81eQNZE8FIeL9GNaodHU+t6+3wYfzF
   g==;
X-CSE-ConnectionGUID: w7JQjtTJSJWA8CewMA9mLA==
X-CSE-MsgGUID: 27OTEHScSl6iUYLk4ZXr0w==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtplv06.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2026 05:01:43 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>
Subject: [PATCH] generic/795: add missing _require_scratch check
Date: Wed,  2 Sep 2026 05:01:39 +0000
Message-ID: <20260902050139.2426-1-prabhakar.pujeri@dell.com>
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
X-Proofpoint-ORIG-GUID: NXtwD-dNzKiubMODNo-XRf-Tv6v3s9jm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX41PipFhE7qW6
 rQLWHTzVKD8Bl9SR+EPX8lqm8Cu4a9LnVCd3qe8wkPIjZn8JA/NXwlKXdOxSMucb6rqfEZecnFY
 JCNQK4MZgqt/+8rXzMaRJDMNEbjpZOEensWRLOhIO3U2RTPImmjSy0tmL9efeDm9QN+wgSoqLO3
 x1wSZ1B1zAERgF4XF8G0oT39lkhn8zHk9jpnel9y7LjqwXdTW/FJqK6AlwvTp1YVZs4XaRJTWAu
 CArOvKJTrB6txrPi8tNX5fMP+3rziLe1H0fzGPdaCWpv2/1P1zNasiQHtucR7RHScVn8smGI7IL
 ssZl5nu6Hkr6kOe2JuT7RIxG3jWGQOn3+0RdQSlu+2X2WjdboOXiObMZN7yh2AyTCzwtGeM65gh
 GaSQpGpw0hlruFvi4OYteSAmXZBUAG8HaKzR0nxUqHFEi3DWhgaYt6GNfa8jR7MS+/97PclI/85
 gZpd+yfSkZY9YIq6a4g==
X-Proofpoint-GUID: NXtwD-dNzKiubMODNo-XRf-Tv6v3s9jm
X-Authority-Analysis: v=2.4 cv=B7SJFutM c=1 sm=1 tr=0 ts=6a97adba cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=wPallV7q4Y9WyMEzn_EA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX+MxtzRlWyyFp
 RThj+xau8v7p+Y2sZjsUzLlP1Np0aY97pRqh1sQ+Nl9hHbJH0yEcTQfgdPAGT+l6qqfZBpPX0ZX
 OF8W+hDq8iEE3lzyQlCxeXguWBqDBgU=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020043

The test runs _scratch_mkfs and _scratch_mount without first requiring a scratch device, so it fails messily instead of skipping when no scratch device is configured.

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

