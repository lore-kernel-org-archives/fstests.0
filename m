Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CD4A263A
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485756; cv=none; b=dXgA2gPxCNfk1qUXI3NGzDtD8Vnj4PzvLDlf1EcDEO2fvA1Cc1c545Nnl4RV4AeipYg3kqd660b9bsJZHntv2RHHj6iyzywIxhz9oD19V01EiUG0v+KAYqy65sLU/egiFXiKwW7fABNnV7VOo5ukAf0q3qcP6RNqLa8thEFbXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485756; c=relaxed/simple;
	bh=u+Ul4rHd6A11EYpEDSt/Kiaj5PMne2PLrXwIpbJiWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjeXaYA0GKs67AS4RfKL3/Or5fidIORLn3zi2GnacSqMSAHBcx4a2nPH23YPU6bIRKhvIZDUujnjTkgfK6mWBB01PmkxHfuMkJt/7zkoXKEsNdXlYccIcijK6UBU2SZGxQXHhVfFlfKkvdCWtV+4SS7hPXQF/OcL/y2WRazBO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Dpb5yQe9; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=GyxRDwDx; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Dpb5yQe9";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="GyxRDwDx"
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1hnT548080
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=n92ZgNPaqmHp
	qIBzwaHbM6DS22O4oYnHfZYTRXw/zMk=; b=Dpb5yQe9qWbYIsrZyknJwjJvccP+
	dATS4qFeIBeM3BHm999o5InxpDjzhgyQ1OjlwlweX3ETakME8EkYC1SnsVXpy014
	NUjI2wSVWToK+YzBD+MB5FqnnOeMGe8CQcLvsQyxm+J9Hj9Z4fuQJVA/tsdLUCEK
	wB+O4Vy0sSMNpV9z+b9uOu7J3tPiWaUkP2yARRVvDiuXILNOPBzwc/zediS9C1pC
	mE3xFhB+ewh00ZYFYqsA5h+h21cTuXtS6x3vkw9voYNQ78o3DbgsMT/+kbS/5gZc
	/u2ervcMuWV88Nok7Ce99bf0fBM23EYclji/L0irgSCz4NcppaeTQ//F/Q==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gn1a13v7y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:58 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FDxS9E3661268
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:58 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gq4m0k5v9-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 10:17:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1789481878; x=1821017878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n92ZgNPaqmHpqIBzwaHbM6DS22O4oYnHfZYTRXw/zMk=;
  b=GyxRDwDxK460pxuA46Pd24lsZG9k4oefph0JkLtR1+aXwtx0D7njfPtL
   NE88aiqh1BXYj2UeZxbcUIomsMw/USn4yB4PFgo6+56I9YpOJ8qh8YzJ3
   YYk2MbKg8TYQegzrmQFB9t6OCjrAok6vZ7EtIS7XnuA5VVgbvKV9a4KU0
   k/pwvMHANJdDHPRMCPeIHLrrHazPUQTWqeZLLQuuzGFwkP8D69/Y4t50t
   z/m2/RW5274GTPHN59XCFU5kPl97F1tssK8I8glhDchNNROcDqrbQY/3/
   pc/wyzXwKkb88eaPLGU8yeBc+/RYBu2fAUt6jsnqLvzwf5R23byXssErC
   Q==;
X-CSE-ConnectionGUID: zYkaOg1/T6+YUm33t1AJFQ==
X-CSE-MsgGUID: +CwMI5eJSQC6g2XQUXSo8Q==
X-LoopCount0: from 10.94.9.174
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.9.174])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2026 14:17:56 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3 2/6] generic/795: add missing _require_scratch check
Date: Tue, 15 Sep 2026 14:17:41 +0000
Message-ID: <20260915141745.4299-3-prabhakar.pujeri@dell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfXyzxwEPFFUTJe
 Vs4qPZuL/2JXJel+Yk6247pemcL0mCZnEwe1Q160fqCGX9t9V1M++uHioSpV2vI3YEXJSacM3D+
 i2PSK7+q6OCTOMArEPUyIn3tQekSxiEOzJQVph5B2z8y3UA4iGTNQQa0ab6l0LJ2ihO95N9BFbb
 Xallfecd1LV7VGSDRlCuAJIxLTVI19BxucAQ63C66YNOBLCH8UsywNNuNApZbzSgtvxGRTL/WtY
 jGVKdesLLSKRcYOB9OzYyQrPMxxteVVNJIosqlcUeytj7jOjPhITAPNLZ2iPVVrEw2RIevZYqM0
 q+7zBd0b+sZE6hE9YMVzln+ls0NbYB6LWXT8zqhAbkTWuN8rifB2qrhug9+n/OV8pydMDL/Ycuj
 ZZz5Zx6qTW4pOKYpPn3gpxOpJ4h0EUj4gdIO8afLMXOfx63OtLmbRKw1WzfOUvFFc0FaCYULXWY
 RcmwW20H1+C4E5xbAJg==
X-Authority-Analysis: v=2.4 cv=Jt1kP84C c=1 sm=1 tr=0 ts=6aa95396 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=gLxAKuEMs0EQMVFiDJnH:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=wPallV7q4Y9WyMEzn_EA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfXzsSuQ50N2kuy
 WW0XROyAGf4JUVy6nS9NIY9jqLj4/uNyOLu3NQJOJ/5DNcK48TeV3fzikRrlfCJJV2OgA15tNFW
 8NIc6Z8/YkpAp06/rw6BttPVRDl2pMY=
X-Proofpoint-ORIG-GUID: nqI1BaZMR58wuGjSFG9lmsAbCpm36gHO
X-Proofpoint-GUID: nqI1BaZMR58wuGjSFG9lmsAbCpm36gHO
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150208

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

