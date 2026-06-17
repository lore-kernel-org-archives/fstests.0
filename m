Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1E39FCAE
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674948; cv=none; b=evx2yxtmiNAcfWpomHlREAaCHez3b0RFiUyO0mfEIkU3PEk9RCW7kTgPLk53piBYzSj33AaG+cYFZpmMQNAxawHItspTW6BX1WCo6v1oe92UqnqNZ6PSrz2gqPlyDStLMa52BPLvVgUzYjlIHmfV18IjmT55UACmGtawO22enkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674948; c=relaxed/simple;
	bh=4ofbag1TIhCjlsD4hePlh4ydNN0PgNcPZTYiTUDO+WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqHJXMQ5IiOuMpFe7MRg5DYuotw7cfFXzVY1T2m4D9WYbTa4mNF2wylkT5nxXCEOqYNRy7Ijp8+TNZUValcZIJM0LA9RXtPiBy1vm3STuWWlrLhseJQz+TxQkXG1WhG1Hx/Sy9jm1iqr4uuK5DwkmtP07o0bpCY2uFajeU8m9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RRwnwD0M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RRwnwD0M"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLnHv82895756;
	Wed, 17 Jun 2026 05:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0I+hqHY5/s6z8yIIo7jhdMHPmFyUiK+bP1GkTtnPL
	3s=; b=RRwnwD0Mc7ctQekud8n3QyL9AwgsrOsme9u1gGGDcIpFWbZech9zoFZU+
	PPG5luIhZnFBXs1+v5Yoyl3N/ZM+URRTBWqZ+Ttlq3ZKHeZO+es2CdSWjFZM1wR8
	tUA42qOyICX9ib8x+14c8b4WvLVcT7bFIjrOq1JROHWs0/uRbEy5RE3lNFR+MhF8
	Mmts1OGIgAclqrBTM/ZEa74sWBOqpFwzKgbiMALhDLoRSemwMMqNh3M/0zKno87b
	0C/1E+vcX1UUxRQysEQTQmH/vb0ut2TMC/p3EQtDYn+3LFPmIIyvsgHQJdl0ylC1
	XlgLNAueU9LYhDGBacKfDMoxf1ckw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ1cn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 05:42:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H5Yupj015296;
	Wed, 17 Jun 2026 05:42:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudva9p57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 05:42:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H5gJ5Q46661974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 05:42:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA90920043;
	Wed, 17 Jun 2026 05:42:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71C7220040;
	Wed, 17 Jun 2026 05:42:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.216])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 05:42:18 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] generic/645: Confirm availability of free inodes
Date: Wed, 17 Jun 2026 11:12:16 +0530
Message-ID: <20260617054216.3186441-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0NiBTYWx0ZWRfX2zmaCnJzb0ly
 0SOjKbVEDUMrA7bM2IDwDXDnoPRntEfKbZZON1zYi+pGDGBoXxbztRl+6cTD3m2FSXkMam3DVex
 OCVCyLgEQFxVp/7CD+xF5yFTxDcE+TI=
X-Proofpoint-ORIG-GUID: k61M510nET1bcg23ecw65yQdZ17dLiIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0NiBTYWx0ZWRfXz0BIuCBErWKq
 7C+0P/051hshcGZ3zXxMfHy1vVpwTtS3hd+my1ICDz4cL5GLDK1cFKySpWoNVdhVcylQFqoEld+
 mzxWcNAbRyYzeXuXWtbVid5s/Dd+wZgI1Pz0tGXMYVMw7OGP4LxEWZM9MnWxmHkhSLmCwRNsMPc
 wEccIR5m6PG9HOWBb2YRmLqqn8IBY7jBfALKBdvdk72nKaTJQvYW2xIf/+FdtQOwKagPdb7xFrM
 RYy3Z65rVw3ytXiAT4HTpB4GQp7GzzHuriH6wLMmSJfS/loOlSq2q9Q1rtyxghN+MapoHyVGenk
 Ahk2loXVfrYqsmQ3QlMAWaJU6Q34Y0nJBhBPWNxhZAbDwQHlzW99uRJbN/XTXlktVzfCaOukiFZ
 Bfiir8xMsKOMRkJ+VgLYglZw2KTNrUnso2fTRLZW86I0GgUn41g49neP1psYfgsZCCN6uk1emgw
 reNtc9Of++YEGTV+zWA==
X-Proofpoint-GUID: k61M510nET1bcg23ecw65yQdZ17dLiIk
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3233c0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=NyWC17klOB7_xQ97rUoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170046

When running generic/645 with ext4 using 64k block size + bigalloc, the
test fails with ENOSPC because the filesystem runs out of inodes before
the test completes.

The test creates approximately 10,001 files, however, in this particular
configuration a standard 5G FS only has around ~5100 inodes resulting in
the ENOSPC failure.

Add a check using _get_free_inode() to verify sufficient inodes are
available before running the test, else skip it.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/645 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/645 b/tests/generic/645
index d6eb75e6..944b33db 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -19,6 +19,12 @@ _require_chown
 _wants_kernel_commit dacfd001eaf2 \
 	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
 
+_free_inodes=$(_get_free_inode $TEST_DIR)
+if [ $_free_inodes -ne 0 ] && [ $_free_inodes -lt 10001 ]; then
+	_notrun "Insufficient free inodes ($_free_inodes), need at least 10001"
+fi
+
 echo "Silence is golden"
 
 $here/src/vfs/vfstest --test-nested-userns \
-- 
2.53.0

