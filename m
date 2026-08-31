Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50DE2D781B
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172935; cv=none; b=V6eG9caZKObbQ6eTw91nT6kWIhopdiblJ3i22CPLuesnba0YLAjWgHfY4iRqr1tC6sYIUUbD1/UPA4qvFLgFPjWhw1kU1UhBKHBmqWsdZ+UOxVrdRSykr9NSWMVL6E4HIdg/qblRq7x/CohVt3rBuijFiFnmdflYq8yd4xtAzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172935; c=relaxed/simple;
	bh=Ox8cAtAXLisyzdMsnNdhPcpuJBxUWK7s29kb6GdIzbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCR86pyema1SyYe+LJeJ05rkqSkqInYv+Um6r2l0oS8CxfeexqloZPQVWBAjM3qdWBdHBT03mPBhqTedDR46K5NJYInPE6uPtHSq2sJTazh3H1rE5wgVjmTj0qOACbw0WCh9is/DQseAJ4y6I7qG98nlk92smvDkaWCWmn4AgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=jB/plHuW; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=aqjBbIUB; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="jB/plHuW";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aqjBbIUB"
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7wtiB2640991
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=2qZXT8mndfwdcY2px8gsrAuGDjiYUcbWLJ7h
	uJpcEoM=; b=jB/plHuWAxtFPps6O6f6KNpuK0v5UB3SHxKUvgRCtDB7vKCQK6Bq
	DYTavxCLDn03wT0fsnSK2gXxfFDItsUzAs+yN1w783Y5z0gzrRbCsuld9ZyOWoxv
	iIopVzcVyKCIPM5JZqUSP/AQWZOOCNIlATeL26Vt1tTbyNdR/eok1Y/HBqqG0skx
	21wdUzje5qX0g6V20ZO3RogTIJl6ejFO9U9XXIKaXWK2h2IffKXKQGd5ceX+Cy9Q
	QGiezuErdy2AiRlgW9eLrHlaKoiCQVQg12DQUc0w98wbzqtRpKIAH9o7H9svgasP
	XrQV+mctKfYLW3clkpcf+d1i3Hh04NVB0g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbuedwa8v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:42:13 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V8PegP2742973
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:42:12 -0400
Received: from esapsmtplv04.us.dell.com (esapsmtplv04.us.dell.com [143.166.203.152])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd63g9dsf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:42:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172932; x=1819708932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2qZXT8mndfwdcY2px8gsrAuGDjiYUcbWLJ7huJpcEoM=;
  b=aqjBbIUBOTTPkqtpGIeOluOvX18UtIxkf9yjPL+b0+KGefVnu36IfLHY
   7go0GXiE1Wb7iTZdZpuTJUn48rHbm+9BtNEkVp8YYKv4+TY4Z45UMrdQK
   DzVdL++4QRGm/bqFnNI6QbCiNnLoWpXD9W56eoH7SinJwn+aMB2A6mLvK
   6q3/QrgChDhYKnw3Hx7+Of0waavdHj9SXplBUS415OnShyFuXaq1lR/OA
   L6gwrnXwv6t3W77V+6oBUvX1FJzuND1ahZyS62NvDKv0SfuKq6c7E7D1H
   tkOHYEmfrD3IPsh2ED/lUE/tUY1uwsf5/IsKxtqNNJjs4IsF9H8/UPVRd
   Q==;
X-CSE-ConnectionGUID: EO9UdqSMQ+ixuOMMzI0E+w==
X-CSE-MsgGUID: 2Mar/OnLRaWAEhyfPsBkaw==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtplv04.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:42:10 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: fstests@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Zorro Lang <zlang@kernel.org>
Subject: [PATCH] common/rc: remove trailing space from _mread() default map_len
Date: Mon, 31 Aug 2026 10:42:05 +0000
Message-ID: <20260831104206.2284-1-prabhakar.pujeri@dell.com>
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
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX9kkrQXTwZhud
 /Ohf9YCRyEtDVOQlLyrVno8I5SuUV4AYIlk94kU1tSxmhRGjAfJc+qICGAPvY8LaecGazntnFr5
 LseL9lwdAwUySCkOxyDKwXlqFV669eI=
X-Authority-Analysis: v=2.4 cv=FbUHAp+6 c=1 sm=1 tr=0 ts=6a955a85 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=XtseytAk/c9oG0Kwoj6KRQ==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=IzVYPfmjs6CrMQxx0tAA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: 6wzpZEJA1R8YCpVXNV-h21Ve_Jk5bGKx
X-Proofpoint-ORIG-GUID: 6wzpZEJA1R8YCpVXNV-h21Ve_Jk5bGKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX/8bQwVwhsGka
 S7rWqx7j1jM5btZFKSKvJoPP3sdzl5p9EJj7m9zVhifv7/3T1f+TpwJnSLWlAGSXUlMlnCKwpbW
 +ckHz4MZc9eo9pgW6DJZA6aRolpyjFJQlf7ZnTgeGgFNMCTAdalj5dtjRhNDVxN2GamAYiwuvMa
 MNjVBjPh4XgR1v1XQ52uDSAeb3+OFb3Z+GdvUerkwMzIQlPlsARlg3NE4NmzY58NLKag11cMNpv
 XINRwq4PmizjIPgJes8HGm9q70EQTND5989oNbUPYn5/CWhnnbc6j0DEHjPsKFN+2OxEkhtStYg
 E9xvFHJe7TJ7sEWFc0Z2WgY07qJqQy4SsAeBfuVzHAT+Zt4RfRoD213k4PwBMuLzqlx1b17VOl7
 n+U8ihWvdu9hdM2foRFW9GTREwWT7PaCnySlf4YgsROu9cUsw97OP0LjgII9O2AEplTGMXjIZ5D
 PBoMipM/HeGLwwUZtXQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

The default map_len expansion contains a space before its closing brace,
so the variable includes trailing whitespace.  Its current unquoted use
tolerates that whitespace, but the value should contain only the computed
length and may be used differently in the future.

Remove the stray space and leave the surrounding expansion unchanged.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 02bdb31..2db85e5 100644
--- a/common/rc
+++ b/common/rc
@@ -176,7 +176,7 @@ _mread()
 	local file=$1
 	local offset=$2
 	local length=$3
-	local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file)) }
+	local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file))}
 
 	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
 	# causing the shell to print "Bus error" to stderr.  To allow this
-- 
2.55.0

