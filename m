Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE947605E
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348956; cv=none; b=F+6nwvMQ5s4Dj7HfvrnkXebA8V7dLRgX2g8msBBG49mA9IgWGEHa4S2YBi5srPaPT1ZXnCYxAb6B6T4l2p0i2srqZWrMgW3PQ936p2TGNHtF2rOuvNCSrDKszGAwZVtN+o2cvoa4MUA8g93UCSr2DrL9zW3/uBg00Pr+ZA2H4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348956; c=relaxed/simple;
	bh=tcN5xyPkl9fHMSbE4fcb0Dqniq02rkTOnb0Xb/E1Y4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5bG3kWU+d+JjAlfItRnQ+t9h6OhZYGL49CvvT4NdSIh+rpwAyFJsJy9yOt5ZPHSgWbzA5THKYptnzuen1EWRZhW3gHsAXUUmvPRZMT153W1LkoNEmxIijHBKPhswsu8V6kLeCJEDWvi0JLQSDE4Aad+GNBo4uSBWNJOm3jxbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=YF54vBVE; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=VjTIc/6I; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="YF54vBVE";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="VjTIc/6I"
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829LxOL3039446
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 07:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=LBBguPxPWcRw3tK/73kzG4q
	8/LewuLR9811S29vrhko=; b=YF54vBVEQid/Ao7Nj3Q/KOcOmUj1JXIQrUbWhv2
	Ws9kpZK3J0zerxdRDKCGKNec5r8KVRtGSzCJbFnJEot4wY+dSdUXRi7nzkrvZ6NX
	rlJ0lyGkjveBAKM9+NdWaWOMNZ4UgBeAapO8oXxl+E3pH75U8GX9+X1qHI3/cMJt
	nUFN7wLck6G25H0mqJI1TiObnyRwi7R8y3qHOVGa8RWBjC3Wys+vj9r1UBELP0HC
	NQbd9E+aYt7mfbEq5mUnqzdcdi/5PfXPFlY2ubMnJ6Z+WkyDeoF5UqCXKWPZKLC+
	U+UMA9TKvayuXYtSaIbpGLDkuupJwY7Kv7b8v24Q79P8kZw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtfwsakj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 07:35:41 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682BDc6k532299
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 07:35:41 -0400
Received: from esapsmtplv01.us.dell.com (esapsmtplv01.us.dell.com [143.166.203.147])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gejr0g7yx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 07:35:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788348941; x=1819884941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LBBguPxPWcRw3tK/73kzG4q8/LewuLR9811S29vrhko=;
  b=VjTIc/6I3/9DqeGk0NK5vu17wtKwFmelzFy32U1G8JkjdTtZRt89B42D
   pFz/x0f60Wc5WPeCvNNbV+CNC14He2wFT9BhAabfqqOk+3mVbPQloJX6L
   HpFD1PHUh5IwO9Rv/UeysiV3ZgiosNz4hgIzXZ66I5STTLmhz8YseZ9+N
   +EBpVWepvpvJ4sCFaDRoEDrONMEonr84ZelPL0OOByJJwuIoO0Lvybvbr
   15QZ7+lcdC4/Qto9ZbS9KDxojM5KEyy+R5SHX3IhEC5dun5wg/zdlrdrF
   +YGuwqRDpkyP1r/0BUfEy1ZATTbidO7bMezxO08Jw5N8/nmt3z6yExvCJ
   Q==;
X-CSE-ConnectionGUID: unNCwfW3Q1aUrKcWHVRnhg==
X-CSE-MsgGUID: vbyK4UWNTQ2EgKP6hohw9A==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtplv01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2026 11:35:39 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Subject: [RFC] overlay tests: generalize _check_overlay_feature for param-less mount options
Date: Wed,  2 Sep 2026 11:35:36 +0000
Message-ID: <20260902113536.6573-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020102
X-Authority-Analysis: v=2.4 cv=BdToFLt2 c=1 sm=1 tr=0 ts=6a980a0d cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=L/h6WUVEnF1aJ0/14Ndw0A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=fdcs9bMiDrRvo0A8tFcA:9 a=QEXdDO2ut3YA:10
 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMSBTYWx0ZWRfX+JZqiEwfIg3G
 XBI5FoSzF3Kvx2mdWePGhphoENp+6bXwqBEgXyNqbm8pLe/gmGJU2Z8J2kCVpUqXfcuKGNG8h0C
 o7aKUJBsJmXq+SkzvtjHVNuWA5+dTZo5dJf7dO+TX1oRc3mYPFZ1ifVn008cK4jV1b8Ef3Hvnwh
 I2zTX7cXg4cV9s/brg5Rt8bkyCbVOWVW81BVdraegilcGb5dS1qWBxS0fQOi6r9NEjY9hq8e1Po
 F3XUtAIYeVX+5dAkguWTMZqRU2I75B3CS/FLeNq2qrz06ZOJxF4niAOq+bbdeGG1BvJnChE0/oN
 GzwEFFxCvrCZ7LoJXC1K8QJGAzFUgTu841jowxd3n8XmekEcrJDT1mcHIQagbA56aEiNLNjqSkN
 nTFRovr9VNidrwmDa1+zoyvsAkIHZrjyAY+u0s7YFuexeDI8EUEEy89NoY2bVF4E0iPF6tLMM3z
 t9c4jV4Phq9L4AJbgFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMSBTYWx0ZWRfX7Kj1NnfWO/jJ
 Wi5nYBsS5sMavWwZtzFRcTBowK3Bla6CHy/oJnmDst17j7ga4T1Yjfo8JXI3HnEW4+icPGwT9r+
 G7dTPXDYXVYWZruwbyzBeliqbdcvzBc=
X-Proofpoint-GUID: el5efMUIMGByNppSyi-gpU4je04iHxbr
X-Proofpoint-ORIG-GUID: el5efMUIMGByNppSyi-gpU4je04iHxbr
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020101

Hi all,

During the overlay/081 _require_scratch review, Zorro asked whether the
uuid=null/auto/on mount options (kernel v6.6+) warrant a _require_*
helper.  Amir replied that a dedicated helper is not the way; instead he
suggested teaching _require_scratch_overlay_features /
_check_overlay_feature about mount options that have no module parameter
of the same name (uuid, xino, verity, fsync) -- a missing /sys/module/
overlay/parameters/<name> then means "defaults off" rather than
"unsupported" -- and pointed out the xino tests (overlay/041, 043, 044,
067, 070, 071) practically open-code that pattern already.

Before writing the series, one scoping question: would such a refactor
be welcome?

Sketch of the series:

  1. Extend _check_overlay_feature() so element names without a matching
     module parameter fall back to treating the feature as fixed-default
     (per Amir's note), so callers can require "uuid=on" and friends
     uniformly.
  2. Convert overlay/041, 043, 044, 067, 070, 071 to the generalized
     helper, deleting their open-coded variants.
  3. Optionally, switch overlay/081's ad-hoc uuid= probe to the helper
     as well (currently _notrun on mount failure with EINVAL).

(A practical caveat: for the param-less options, presence still needs a
probe either way for kernels predating the feature; the helper
generalization mainly removes six near-identical code blocks and the
shared "not supported vs default-off" semantics.)

The motivation and context are in this thread:
  https://lore.kernel.org/fstests/CAOQ4uxjBc5CfCpjrq8Ut4xHHaenKicTxBCbNuQkBFuu-Mz9=EQ@mail.gmail.com/

Please let me know whether to proceed (or whether you would rather keep
the open-coded xino blocks).

Thanks,
Prabhakar
