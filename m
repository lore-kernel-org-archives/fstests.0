Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AB39EF01
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172911; cv=none; b=aM6zEgDJ0HqtLRXM2KfzgKU6DLlBlcaPg4PG+4DoYFBs5EkFveucJRQsZ0PxeuvQdMwFvT01lUA7qw/psWm+yHSw0ApQof1YGd6DhdwLb2Sy+UQ4OzR2e6xp18zeOVjojGIG/LObkeQZ6tVt40WxzA2EhHOIL1/Gj67ELox1dnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172911; c=relaxed/simple;
	bh=WBzRrUw6Ep/kY/rYKdwUcwxa6hPnbl0N25b39KcLRG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBwrhqhhK9x22Elu4zEILQToK8kIbtP9DXZKbXB2W0yBydzSDuKnnkZNNHTL96FDkHFZjhwg6AolH4OPpgXbXeauQw2Uv7S3eWiV/BauepRt/wBt5B0XWqxCAjN5+QJy1oe+MFKy98qUAN80fxrdU1DI0JyLfsL1ZtkT0U64+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Zuo6oZDb; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=d9EZJC/S; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Zuo6oZDb";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="d9EZJC/S"
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xHG62780970
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=x6knYLxBGqt2H4ZybVlyxcPpLJoFsdskIEri
	IIXWLDo=; b=Zuo6oZDbg4COcsEBoBPwsEUUR6t3S50E2ix/4/BIVRGzrSTYqRlK
	fCYaGBrecGqKX9bjQEGRxGfgDiIriauU73QVThT7hnbRPUobZsWYYptLzNbaakIj
	k7HZeBbq+fuVueTFaOP8Mn5LV2ypmQY6ZBTKr1t+EgQlSXfMmUE/DTtZVe9gER++
	1SKlMjMGQlDUUYY7gV3IUQE5DqLtHzzqZ8b+T9jVZxS3xmo5hAsXz9bXNHg2EKEs
	nYq/Dp8tqLddLTHOUX+SDNXUFkF96r+h20MLnO6T4ufqcQDVW78tuDBwiO5XZJAl
	kIZk9neqCmgw+DTRnL5hUMzOd/kIj6jFjg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtk6wev1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:49 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7weCN3771633
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:48 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com [143.166.203.154])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd4wejbwk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172908; x=1819708908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x6knYLxBGqt2H4ZybVlyxcPpLJoFsdskIEriIIXWLDo=;
  b=d9EZJC/SFOb6ofsu7kXhEB3xrk3IBVkLnHEDWBIz86A5S7AeuS7qV0Ch
   pWvaG++Pewmvgd+0MOxdfYCb9wKkwpBSpngGCmAo6LOSHj84UayybWHFY
   WPmJXA8AINykzJhwXDixNqqArVyZ1VvA3S5r0tVaQl5roE3CjjBksoFmr
   K7lOi3afX5+9PmNGEvFG35z27EA9pTEk2yCNENacl4ykJTc0bf51AMLII
   wrDlyUAsx7M8oOXzufItTdbGiR0q5zo3pw6guaUYJeRCVuiRb85U5JgA5
   VhwVeGRLDSc+N3F5Xrncr8j6DGNTgPbH6aTP/w/I2wXRBs0tx7xP96jPi
   w==;
X-CSE-ConnectionGUID: 2fc6uPgOSra3dZg08u0HDA==
X-CSE-MsgGUID: IdHSqLpiRlmjLaMwJOutzA==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtplv07.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:46 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] f2fs/024: add missing execute permission
Date: Mon, 31 Aug 2026 10:41:42 +0000
Message-ID: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
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
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-ORIG-GUID: V6kRLpruQAhXp3GKhNonq0DTlEdzTnHI
X-Authority-Analysis: v=2.4 cv=PL0/P/qC c=1 sm=1 tr=0 ts=6a955a6d cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=iLNU1ar6AAAA:8
 a=ZFVciXT5ayevmQCRhY8A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX+9NQ4E392SCZ
 1BKjmEkwtLcwoR+j/CVhBpkX0ZLWwB3H886X9vrxg1HVaYZhtsZ7jbyuhrH55KA6ozefLpnv0p3
 ZAnbVSvurII9wBAC13xFx/QsF51QoF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX2BA9KTOvQV00
 +mQn/ycEOy4Wk1y0jTOcKoWyQbXzFXWSTRKcAJINHhwxE9XddaTMP5LUcJFL8McFgp+rz171pgO
 aEEXebXwhZC4CTyexbTu7nRAUzogME1cHB07kN24RmXw2/+qWidUny6pMFLa4sQ5WCxfw9H8xZY
 T7YtiHpaTj+gN8v/g+PXmF086V3jLAvwuaoB5sv0v/Acl/Wr2t9lx4WyDP8LzsIOqNt3ojqvF2b
 pZLDhw7bBMedu2FTGO0kQoRZn5/1wWcqa5FrsreHHCwrJdWL0kqNTpgAujzWZ0cMNUI6HuD/+2Q
 XpfwfvUHZBOf5pJ/8BpktaW0xF4EHAmY4FvkK8SV55st/n0SXYfzwxBTHvmdLEs2WOzEs/uPuwg
 /FAud1MflBrhdOaI1roLQV/cvQZ1rJ4Wl59QamGubKwEzRl+MkMay292npu74JXRMPBkC50w1Wv
 UJLuq5mWaXgXXwms2GA==
X-Proofpoint-GUID: V6kRLpruQAhXp3GKhNonq0DTlEdzTnHI
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

The test script was committed with mode 100644 while all other test
scripts are 100755, so check fails to execute it directly with
"Permission denied".  Fix the file mode.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/f2fs/024 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/f2fs/024

diff --git a/tests/f2fs/024 b/tests/f2fs/024
old mode 100644
new mode 100755
-- 
2.55.0

