Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9B1EB2F
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939164; cv=none; b=pQ9h2T5MSzAdeOOEm8oVwUViVEAuvuXTHkmu/sjQWtvs/O6V/xDOxHulrxnDLcW1+CMbnKpYISS5n4+XWepkv4HDn5wCOD/2f4VMzSYR7Rw/VtGEJEKtJGvHNaXNRh3Wfu7oAzLXDakysyWnP2tbgAC2xrB4hPynUSCdsHiFPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939164; c=relaxed/simple;
	bh=TcJWlwXVIKfrFbGKAg0vrTpU4jWPZiB2rqDTJQktqWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3OiyQpgRvL7Ior7QNO+oSdXtLiA/0d8O0DG+75aia75CF8idk1Vzpau+dSGCelt2QiNANcZv/SHAATfNc76eZqpz/ZYRISJeCRLHn1ReDwyGDNf1QuY/YXnMwWGM7AW/wPuXX70xe1ZvII9BVUfLB0R4s4Gm3uieXzigJwkSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aR0tQEQ9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aR0tQEQ9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4Abex015932;
	Thu, 26 Jun 2025 11:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o5cZa9TfvPPU6Pbcg
	/Y2H9FzVqIkhCCRWJAPN9Q+KNw=; b=aR0tQEQ9v/IkDGKgKq6aXlOKX4HYCJzgs
	uGi69R0uf8VJFaqe+4Lid3waabblUiqJZbxpYGv2Afbvt/Ebfo6iWcup19pBzsJe
	HLU09FRMhQudKFQHNXzMK11OTMXMoffdd61Rkqq4mqpqI8WKyeywyP1h8qg0CgGK
	O4MVzBLn02g1z8KMBBmEMzk/ZDGCWcNSSUATmSY8P2kgpPd83XMp4HbDz9AYMhHj
	/C8ZjfNkhfnPXZl255hqGNQUcG8qhDdJPAkVO31gIFvw6dK2EmsjYkYRoIXem9SE
	PvdsqQhGaG/5gqwW1kMEMfGCUpRzziCYaUJXj2BpncHR+sWvMBuYA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBxFv0004078;
	Thu, 26 Jun 2025 11:59:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jp9mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55QAX9HZ014748;
	Thu, 26 Jun 2025 11:59:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2pd36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxCQP56099108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5DFE2004B;
	Thu, 26 Jun 2025 11:59:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093432004F;
	Thu, 26 Jun 2025 11:59:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 03/13] common/rc: Add a helper to run fsx on a given file
Date: Thu, 26 Jun 2025 17:28:54 +0530
Message-ID: <d529378d23079005c1f6ae84d089f5d28c8029b8.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfXxs48LXhv4G5e EncdpHxBToOpdZiY/jkDV5Z+KsULNBrsaTZUZvnmR00LheDnHl7l6imLXn1lyitFKZqSZByHjIu tSI0TJAmbnIeM+DkEMlDV1JDLL4wVHnKms3jB4GsuwP5o7Mf7YLBX1/T/R+nBYmUnJg3X3wc01p
 Kvsamy5tDkWToEQbrEfGV9otXVQ7kYUslQQStLhdxHLcfTh8SEmcz3NspesA2anbAkME/pUOmPx 2oF+219th2rvocsC8vGda42XM/M4DOSS4x8AhNzG6iaZ4L1X6nIEfHAfx2JHUMQ3nVMCM01BzhC GP5get4r7qLLgX9zxM+pKVLFo9U6lP6b2eCEAYZX77eK5zWgKvV5QRjZ1C6vEFp+e+gnZSXg/tg
 xym6n57h7/vp+NQLYreg9gdfWlKncE/OR3djh4AybRGdnO1AhoDnCcqwDv25GqXM9aihX5AZ
X-Proofpoint-GUID: jAWuQQ2oGEdWdvOLzPqgtC5GVdbXX-o_
X-Proofpoint-ORIG-GUID: q3taW5EI76t3-K9wnzdv6FJhLK-9tB9k
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d3614 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=u_VYNAqGXo6OSSAA:21 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EfcJlRrZmV05EoLhlkQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=943 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
Add a helper _run_fsx_on_file so that we can run fsx on any
given file including in $SCRATCH_MNT. Also, refactor _run_fsx
to use this helper.

No functional change is intended in this patch.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 3cfa432d..3ac9a4e5 100644
--- a/common/rc
+++ b/common/rc
@@ -5126,16 +5126,26 @@ _set_default_fsx_avoid() {
        esac
 }
 
-_run_fsx()
+_run_fsx_on_file()
 {
+	local testfile=$1
+	shift
+
+	if ! [ -f $testfile ]
+	then
+		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
+		touch $testfile
+	fi
+
 	echo "fsx $*"
 	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
 
 	_set_default_fsx_avoid
 
-	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
+	set -- $FSX_PROG $args $FSX_AVOID $testfile
+
 	echo "$@" >>$seqres.full
-	rm -f $TEST_DIR/junk
+	rm -f $testfile
 	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
 	local res=${PIPESTATUS[0]}
 	if [ $res -ne 0 ]; then
@@ -5147,6 +5157,12 @@ _run_fsx()
 	return 0
 }
 
+_run_fsx()
+{
+	_run_fsx_on_file $TEST_DIR/junk $@
+	return $?
+}
+
 # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
 # the test, but if any other error occurs then exit the test.
 _run_hugepage_fsx() {
-- 
2.49.0

