Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5E33939D
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407632; cv=none; b=hJuvHvCuHIA2fV+2/Gz2Q4kqgVF474lDdXaHq+PDlk17xpzT03YxmyTsAuph1oRdbpx3c0x4vuyvyxL6DsZuBB3C4BS2mAk2KUeabo/OCPAmNOOnx3yCNizv6smNAVgOp/PqyLQiQJwT3/kcOHGdb4v/CfHbPauzDd1K4mQEvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407632; c=relaxed/simple;
	bh=VcLmt6CkUVFjDuzI5CRTo06zIqS46WVgXNUn3oCyNU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaCFKSrh3fQPDGxKx+7dlMMBEyq84sx7xylQ2emQiF4df6fPmSA+u6dJ3mX242NKyIe5iaChwsGv6/pwC2mH8DAFzl2u5kwkwPXxpDD3cz6yQ8kEpLKshJA+I0xudRk0wl9ZUgpAYVTlkmRYjW7b4OpWcHRJjiomnFf+afy0yTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=WlBJIqkD; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=q1seDzZf; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="WlBJIqkD";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="q1seDzZf"
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832vfeb2569447
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=LVjRlh92iwUTPX/Bqaa3XzE4Fg6lj/f19hRB
	1vQeFm4=; b=WlBJIqkDwc25qhzm93FqYbeJ27jYgPveLi9qc08gRAzh5Yu/D9p4
	fF8wB8D77xZ6A2RPRruRHHJ7lejb7DdCDisPwu2wymVfPSXya0146fEyz3F6XoDL
	CDePVUiZqaAmDxnddPXBfFGnNCz/PsuGSxNh4xEG1Eu8W9wuwnSYjBZ00VZV9w9o
	wmNoCtAb3ji4UDwWnfdFuAec4x1IWE4/L47ZBCUIMRSYJ73cVGS9mrDd7AHae5HK
	JXovb8ce+X93TLxreCvnJGQJga2d/BPFC3KWf98p3/3vG/sipf3eHg8cu6ieNF32
	UoJeJFwm47uFWVQ7dBn0PB+GPMdQbUbJmA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtrgctyf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:50 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68338bCx1209912
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 23:53:49 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com [143.166.211.146])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4geu9akrwm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 23:53:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788407629; x=1819943629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LVjRlh92iwUTPX/Bqaa3XzE4Fg6lj/f19hRB1vQeFm4=;
  b=q1seDzZfWtKO4Tx+y9fLAqAR94FFu+XJJSKt12WiVn1vwrT/L+VjzUQp
   mfdvz7h851Odrf64IFqkjTWgUe7uslvt2uV3SCj8x1Vm9TGRdf5phoSdg
   MucDrQP9lIBKdde1eYdHlQpd6QRQIY09XV5auOxhUKwOnXEwQr5HgnUB/
   AGQtzcJeXyYPP1e43laRIIOixJA0h5Gf8/nbra2a7jM6u6s3TDsPAS/Kn
   JzTWJTSHoGaYvbJPi4d8lGNjQ4TS8wwFsOEZxMRV0UrFfGIRWzV3EwKFW
   Vd5hzBNNNoCJhE+3St+sHbK5wB++2HXGvJFK4XR4H0Vjthu4A1qjKNW5i
   A==;
X-CSE-ConnectionGUID: mXIxyWaDTU+rZ5ltztFjYQ==
X-CSE-MsgGUID: rXAwdWPKQJ6SvJtdvhiS/w==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtpat01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Sep 2026 03:53:48 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 0/3] xfstests: add missing _require_scratch checks
Date: Thu,  3 Sep 2026 03:53:41 +0000
Message-ID: <20260903035344.752-1-prabhakar.pujeri@dell.com>
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
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030032
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfXxoAgh0qagWFI
 Abjpv3cu6FfFwEYmduUP/iy/owLvlyLAkrUv4z/Wa+QnDqJ88M3JF59lWRh/qo0A3B5dj8VeidB
 jNETTmYv9+W++wfdSXbqycmD0pUtrzaOrmgCx0cCZtw3UEdXcVR2doekIMUVmMhC4OYzoBrPnXJ
 wNAjFCGAjVlCUMrq1QHGHDm0rodGevgC0aVuaVaq98TWSL9p4fPu91L2o0j67eQU08EduV7QI5y
 nToDpk04oIzN54jc1OIJ/9n2dq5RHhpvIaxSweKc1PqDTQhgkoi0EVv1k+IFqtAMOQLVewcVQne
 XghoSJTrQPbg0Nf23BpYnCMk4/Whyb3SE8l0ueYrV12uddTHcVCNmBdiQviCfi2jiPCzDsBGlyR
 fGoHP0P97Z7VCWwS52rR8UV6WXXD+5R0B8vZw1D7Yb5GnlHXGL0qxHdOxNrIkNaTtkC+2UihA4I
 J+1a0a4AgwpV/liiVgw==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a98ef4e cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=XsqfU6m5DJ0zkSNgDAkA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: l-jXxwNz7SJL52L-kF3EtI3cfJ1RX9JA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfXw+aJXtcUtTL4
 o8ErYgSzC2IFl2dT+ipitA9KZIIckxvTGrUUWqrBWAQQjLjy716JILH/9VOGX6fbUf83JybNxFz
 SrcD3GSSlnfKSHcUgsaFppDekXkYk0I=
X-Proofpoint-ORIG-GUID: l-jXxwNz7SJL52L-kF3EtI3cfJ1RX9JA
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030031

Consolidated resend of the remaining _require_scratch fixes, as
requested by Zorro.  The first three of this batch (btrfs/333 v3,
overlay/081 v2, btrfs/273 v2) are already in his local tree.

v2:
- Resent as a single series, per Zorro's request.
- Carry Darrick J. Wong's Reviewed-by (generic/590,735 and generic/795)
  and Zorro Lang's Reviewed-by (f2fs/015,016); besides message
  re-formatting there is no code change.

v1 pieces for reference:
- generic/590,735: https://lore.kernel.org/fstests/20260831104148.2243-1-prabhakar.pujeri@dell.com/
- generic/795:     https://lore.kernel.org/fstests/20260902050139.2426-1-prabhakar.pujeri@dell.com/
- f2fs/015,016:    https://lore.kernel.org/fstests/20260902050133.2413-1-prabhakar.pujeri@dell.com/


Prabhakar Pujeri (3):
  generic/590,735: add missing _require_scratch check
  generic/795: add missing _require_scratch check
  f2fs/015,016: add missing _require_scratch checks

 tests/f2fs/015    | 1 +
 tests/f2fs/016    | 1 +
 tests/generic/590 | 1 +
 tests/generic/735 | 1 +
 tests/generic/795 | 2 ++
 5 files changed, 6 insertions(+)

-- 
2.55.0

