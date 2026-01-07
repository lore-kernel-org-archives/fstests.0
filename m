Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75451328623
	for <fstests@vger.kernel.org>; Wed,  7 Jan 2026 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782276; cv=none; b=mpeuuM0xR5+2YQveJrCb+Mo1iZCXxbjIttgty2IaPci5KMs8LgpTHXy3dj4UHiJa7+mue5+zcRYrV2K/nld4cb6whtogfihZiIvaf/OCjYnrQsoanvszb3BvoOgL9dBCYlznpUVtYJFRFFk2tt5xtOMzqMIelgJsCRtC4ZOAvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782276; c=relaxed/simple;
	bh=Um25oj7nki0zFSgy1PTq+dKr8xv6jDz8qrGIRulaGmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJbm3BV3tvpYBHkbNQahc6wtQoNhUbQay+UnEkOtqc4pjHLYIwNh7JH/U87qb7eHZroStn8DRSnDhLIvv/xxmLzWOIEFubp3GeOvdOffCK0oVIVx2q13AOZdn7exu8stkl3pq78Qov1gGJ6TeUvX7iSeQt5FwAkJtPnmVHR6bTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ls+Inz1Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ls+Inz1Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607AX8xD009924;
	Wed, 7 Jan 2026 10:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fa6VW2JSjZ6g9mioA+BrUQS/iWRKnsv+qhjUiaqia
	xE=; b=Ls+Inz1ZXmmpCnsC06Muccsa8kKBo8s9uD+0fNyXR6JDJ+GyerMjDxBy2
	7noj3LCEMV3/jfyvXxZ94ClBtPy6XwHYjesxS7JoYCrEovOBm8tx5F+8jwjlM0MK
	+V/JNqH4BezU1zw4M5ki6izcWZEoshxCRmIcpG3jSG21ZvbgGvj8iabx/s4vH8ia
	ZFrSidkWC3R860hpMOoGkAEys2Cl5pzB0EVhdwoBTjcWGI4PHn7/vGZSkCaU9uUv
	0Yy+jtstmU5moIROfGEBss5NQY2+tHsxA43DkwpU31OJXZrg/M16YLzdCW7t/Rzc
	oR12d+3rsF1juEDMe7zpvgOYxMSow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq8bfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 10:37:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60797jvY019177;
	Wed, 7 Jan 2026 10:37:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51860g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 10:37:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607AbkDQ44630498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 10:37:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE0C20043;
	Wed,  7 Jan 2026 10:37:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B626120040;
	Wed,  7 Jan 2026 10:37:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.31.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 10:37:45 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v2] generic/108: fix test hand upon failure to create LV
Date: Wed,  7 Jan 2026 16:07:44 +0530
Message-ID: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HGIGH1NbBthG0r622ky8b0GChPiGIT2p
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695e377f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=0fFrJNyYT6Ehky_TIyQA:9
X-Proofpoint-ORIG-GUID: HGIGH1NbBthG0r622ky8b0GChPiGIT2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA4MyBTYWx0ZWRfX7rI1J07mkpBX
 yIO6OagIiJhNL6OIcCq85p9eGS8SV9drdKL4PUhDsd5pOxeEM2DBlRAdt2I0S7mpRWvc71rayja
 x/eVh72gPCsucP+jtayQlV8J9LGryNr9wPxcGTcgpIYMh7IBzEk0qcy6jRxcUEEfAOOLaA+hflz
 jxou2cuk/QKNvQuv7YgCIuuR4USzV4hBdLWC/+BOOpXVZrY7zJjW7I+X/LpQ7ieykvpsMmfU+3V
 BatB27Jd1eBvbtYB2a1Y6lK+fc67equ+Pc2GlWOzcKMYfi3cHhlAL7jofE5+h7UsYqdPOt1H3d9
 GO/TDMA7+n9RDVNhDt5DwK5MeXkvwTpfIeyPyGJSu55JBa+lG8LTXs02usIrUlCSZL7CsgVuGKz
 yn7LovVmNAR6NkCQmayhbinfMbmbwdsCb3cUydwcuLs74YnwTzPE5ZZJS2PBhfJEaURRNxDbg01
 3nmlcPAlnckoWIbkXOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070083

In case the lvcreate operation fails, we don't catch the error and
proceed as usual. The test then tries to wait for the LV to come up
but it never does, causing a hang.

To fix this:
1. Add a check to ensure SCSI_DEBUG dev is of required size
2. Additionally, fail if there are errors while creating the LV.

Context for completeness:

This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
of =m, causing it to create an 8MB SCSI debug device. This led to the
lvcreate operation to fail with:

  Insufficient suitable allocatable extents for logical volume lv_108: 68 more required

However the test never caught this resulting in a hang.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
---
 tests/generic/108 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/108 b/tests/generic/108
index 4f86ec94..05d743a9 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -50,6 +50,11 @@ SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 $size`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 
+got_size_kb=$(_get_device_size $SCSI_DEBUG_DEV)
+
+[[ $got_size_kb -lt $((size * 1024)) ]] &&
+	_notrun "Need SCSI debug device of size $(( size * 1024 )) KB. Got $got_size_kb KB"
+
 # create striped volume with 4MB stripe size
 #
 # lvm has a hardcoded list of valid devices and fails with
@@ -60,7 +65,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
 yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
-	>>$seqres.full 2>&1
+	>>$seqres.full 2>&1 || _fail "Failed to create LVM lv"
 _udev_wait /dev/mapper/$vgname-$lvname
 
 # _mkfs_dev exits the test on failure, this makes sure test lv is created by
-- 
2.51.0

