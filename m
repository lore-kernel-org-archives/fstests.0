Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF07081E
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939177; cv=none; b=jSyvjX8y1vWcIf7hFsgilF0bQEAtnS7lORh59wk4uJ8PP/Y3gcVZgXBclB+/lF55WrANxPFybEJ7ayHOr5e4IzdxE2gNyZJbuix2l8K3zC8pUptMkqzLoi4aYPzpX8cV99tc9DawxzflERXQwd2WrmOd/gyaWFOcBgJpSR1EKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939177; c=relaxed/simple;
	bh=A5AvMVa8UO8iywTpFpPSlM2vhvaR7C4OGUbleuL7AhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8npOrWZiU+/w2WAVo/8NzRcOAvML0XgZ9C/o/MRTMEPd8cy8pagnL2MUQAzNUKKHQhhpkKlP6RXPBZ0ydGsA1NCQmZdIG13YOxRIDcSwSz3VBCAMqcGK96P+4kPN9QbpBnlluiepsCW+S+AUF2dHGj/APTr+FShvH2U3XCBtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZY/Iktm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZY/Iktm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AQJ4010344;
	Thu, 26 Jun 2025 11:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v6P+wNirYYOQZrDI2
	+9l6B+r2GF58JDQJBUiRr6meeg=; b=QZY/IktmZ35UEwPSbw9BjwrVJtGhEtgCT
	SBwgMSWgMgVpwvUlEyQyEWILuNDCTZyaD5zKFXBc+oD4zkdFBnkiHd2W8CrK/oXG
	sjmERb603QfJMV70PRk2bbRSRH9MpMTwiePPCxI3HvOwFKGd9gB7fMx9302bg5rx
	85d9//g5YjCR394pau07497zYbikAgJuc/8p1IGHOcjdWXMMgi3CfOx/fW95J9QB
	SfCvOHoexUGBoBWdeH/U3W26j/tQfM/ChLGOrAOlBPrL3YnBqWSsjk+18CVfh1Dw
	F5n4ShXNMtDNclLXBFTtbrpwSMb3nT1bvHpLbbOj1DBBb6O3FEotA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphm0ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBa1Ng012694;
	Thu, 26 Jun 2025 11:59:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphm0nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8d2ue006329;
	Thu, 26 Jun 2025 11:59:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxAod26804930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99E6A2004B;
	Thu, 26 Jun 2025 11:59:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16EEA2004E;
	Thu, 26 Jun 2025 11:59:09 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:08 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 02/13] common/rc: Fix fsx for ext4 with bigalloc
Date: Thu, 26 Jun 2025 17:28:53 +0530
Message-ID: <4f09b788f506223c9631479d0318be1e1ba5883c.1750924903.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750924903.git.ojaswin@linux.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vJr_8GRbOMQ8nv6jezu0VwLurJg9dhvO
X-Proofpoint-ORIG-GUID: wilBDkmGGVduxY0evFYb4oJQokbLsroG
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685d3612 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=OVCkQZq2it11Q8GQKHUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX/IzREGSMduzZ Y2V4Pzv2yjQZapuh71igTSlKFL52AHiBa91fnzk5fKH6sT5Q9HZF1fZg0GYSAqjKMriJPQiu/nz KHUyjUssHy50w1AHbehBkp6pr+2TG3s00sNUBZKlryV3hsvu5zr0FaCoi+m99a+VAwEDJ5b8mVm
 zevBWP5+xWBr3+ixNLUbf3C51l9Lpbj8oxq4xeuQ3mC4W9wfjnD0E86bnsSSfoPYY5/aIKZgm2Z UvYony3m/MDiHWo5jfOBWSQSyNZLjlXpN2s5YsuVNNR4tcVtOmbpQBUuPYiL4SbrDOAal5+Dglo AnCHAcbSBMbS4oT5iuwTtExhAIIgRJRz5HrW5kDvNGEHiw2yGSBJM+n1qXdPIOycwF/JiQIuB62
 vzlMdK5o/qXQ0kAYuyXtM/iaPhdVuQFlMo3BymDQfSl3jlez274L+jG10d6k9N9R4g8pWdys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Insert range and collapse range only works with bigalloc in case
the range is cluster size aligned, which fsx doesnt take care. To
work past this, disable insert range and collapse range on ext4, if
bigalloc is enabled.

This is achieved by defining a new function _set_default_fsx_avoid
called via run_fsx helper. This can be used to selectively disable
fsx options based on the configuration.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/rc b/common/rc
index 2f94a4f9..3cfa432d 100644
--- a/common/rc
+++ b/common/rc
@@ -5113,10 +5113,26 @@ _require_hugepage_fsx()
 		_notrun "fsx binary does not support MADV_COLLAPSE"
 }
 
+_set_default_fsx_avoid() {
+       case "$FSTYP" in
+       "ext4")
+               if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
+                       export FSX_AVOID+=" -I -C"
+               fi
+               ;;
+       # Add other filesystem types here as needed
+       *)
+               ;;
+       esac
+}
+
 _run_fsx()
 {
 	echo "fsx $*"
 	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
+
+	_set_default_fsx_avoid
+
 	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
 	echo "$@" >>$seqres.full
 	rm -f $TEST_DIR/junk
-- 
2.49.0

