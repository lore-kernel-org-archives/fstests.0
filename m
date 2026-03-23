Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8783A3E70
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269628; cv=none; b=q91c8jlEwbJ4IPMrKTf4RRy9N5qAwr2+DBEurJIqxtLXXzPSNZ/TXBL0XCwmaFvelzXVXv7Lq185g8Z6G9W7mnUZrGPKZgx+Yh/ZF8bAplikJCcOzapFUPAWJEYXy3CMOXfpKnIOug+6YW91cNuF/lSbZw8rOjFJX+dpuEPNIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269628; c=relaxed/simple;
	bh=sQgsqyYZt7/GD33yXJpv5GtPjSXYiIZgPc5huc+mO2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJb0MIfFHn2Ey3qN0+Rl9RdQfXZ8QRDadYYEe1aV/j0i/sHkMTyBjKGp3+AqhZQC0BKIodbNnaRM+Rdj7Lba+sEB/TrlbQLsKYSnRRlPJWjGKPDF22UBug83vFOvoHYKh9FdKQYOCSiPSf/oWhiyBk3MkNXkbaoMWo/vzMdzTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aSgHGWIF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aSgHGWIF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBxGxp3835046;
	Mon, 23 Mar 2026 12:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nYeWxDbZ6eyRSDDOtPoiMHpBN60FDWtiI9Ni0ADtJ
	xs=; b=aSgHGWIF/ZWh8NEhxoqtNZEhCokophan35j5d39/6ISmi2tjFLPWDbDnq
	AOdpu7LzSQJq6TXVeicqe5Swlpqg1tvpPK+SZ3nlpsRq775Qv8yKRW9LVjsYUst2
	fcEPlZzCQyY0/bvaCrFbOpUic/M93O/+IegJsLIQ+zTb0g4125nzzUwvAIZ9T7Sy
	cRe/98/lQlPoTJy4oe4hpaMDfvlC6ZeX+nNq4NwSJXgr7O0eFlZ8s1VOUGbsA+5U
	TrWC+5fMMsZKh0pKswXymkIy1RZSLHX8FLW/qm/u4ObCd6Y5StfNe3UuIfnoRoew
	3lJfC0t64Mga5vgSyrTppr2TltaTQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuphtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:40:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBBLNB031592;
	Mon, 23 Mar 2026 12:40:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsng5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:40:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NCeJMb30605616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 12:40:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30FC52004E;
	Mon, 23 Mar 2026 12:40:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 542EA20043;
	Mon, 23 Mar 2026 12:40:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.186])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 12:40:18 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org, disgoel@linux.ibm.com
Subject: [PATCH v2] generic/730: skip test if DAX mount option is enabled
Date: Mon, 23 Mar 2026 18:10:05 +0530
Message-ID: <20260323124006.85176-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oQnQyqrlLzzHB59ChL1SRAwZctx9F0jH
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c134b7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=YfVSlezPLpw5I0x9RAwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NSBTYWx0ZWRfX1ed88lQGyKK1
 /iGwgf3rbbn8wcvTE2QLDHVghshXDSx+CvQ3k2sB4Ml7/YPeGstjLmm8PCpbKpjmz1Wlp0Ul1Bv
 7PgoejFGHAqH0dqIQPXzaQvZIaG1w/oNwLTKqA1Ikz7zixPX9/t715BhwIxg/OTUKFgSoYnTkhW
 +khulWrUi9Pu+o91ij0QL3aYycET3YrhChZnbV5oXYYFdhTCnyihIpMY9fz5YOjcZ5W/Pfv1sM8
 bt6VO1s+12fDpG4mIqYB9C4RxKBvJ4qTIxuE5ICIXnUnU9s3hVZwu9g2iXJpLTF1veVL0/A+8gn
 DTK7sVDQudHZJprf21oDi6Qab1ZEzXPgz/i81H7RnTO3BKzIgfL7oHp6DzdG8L85Be4glWl1RlN
 Ufqzegru8uubA/20+F6k5Ieur7tilWfe0v3ZufIPMi4Wa89RZALDh40EwS4AIST7eG8/glEh/gY
 GnLMaacxgETiOMYVKqw==
X-Proofpoint-GUID: oQnQyqrlLzzHB59ChL1SRAwZctx9F0jH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230095

The generic/730 test utilizes the scsi_debug driver to create a
synthetic SCSI block device. Since scsi_debug does not support
DAX capabilities, attempting to mount it with "-o dax" results
in failures (specifically on ext4).

Since this test is not DAX-related, exclude it when DAX is
specified in MOUNT_OPTIONS to avoid compatibility issues with
scsi_debug.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
Changelog v1 -> v2:
Use _exclude_scratch_mount_option instead of an ext4-specific check.

Link to v1:
https://lore.kernel.org/all/20260318081812.47870-1-disgoel@linux.ibm.com/
---
 tests/generic/730 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/730 b/tests/generic/730
index 6b5d3196..47073f42 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -19,7 +19,7 @@ _cleanup()
 
 . ./common/filter
 . ./common/scsi_debug
-
+_exclude_scratch_mount_option "dax"
 
 # We don't actually use the test device, but we need a block based fs
 _require_test
-- 
2.45.1

