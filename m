Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A21EB2F
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939161; cv=none; b=mutPdyTPYamFZZb9C/T1SAbukkxi/Tx/mI2hDDVW1n0J8L3b6zT6iI4tuXXm/VDXFSqHuWcve6nVIl0pD4n3eP5dE8VOBn/8VEH4e1gtjR9Ktrmsb5YO6qMKlKSKpi/s86YpwTGzQnzByl6e6awJuMXneDpge7qIC9VRdSy8pCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939161; c=relaxed/simple;
	bh=SlqoMeHxI/B3wQJkL1wW4j3lBrhsyHFXZtkze0gwIRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCkMVES3XkyE4l4H9mrDQQz7ErO8izRH2J0qagS+OZoPoeqKBKf/FSGBeUZAVWj8iJVPXnPIBiPzVfR82uwJsig46sZ50pc0pHakyrlpS/1Mok3bwM0TqSRdveMNWcyXbCHWpfZUngxT5RV0pAuektsXI6FQ06OYzey2vo1Wa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CpCflh+u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CpCflh+u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4ASJB018285;
	Thu, 26 Jun 2025 11:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jD1wBLNMjFnXK/8n9U8/2k34TbJLHsI3bG+wvNLoi
	Zs=; b=CpCflh+uG0i6PWlFVM3FE9RYCWRI4/8wpU3Y2cTCjESQTWoNrll7lAekL
	hSLl3Oz3HKMJxkYmzbbT2I/CNpBojCb8OhzRuhT+TcS/aoOSthhJSGe7S5Ga6TyW
	ewz5C511wcrgoHJ/oJM+b7Cp+eqxgrlINtM/ITmekFzaCu9RZBxVB83wSdG13GF5
	4fBXh+G5LxCJI6Pi/iS55Qyjq0klJPP/SSBNm2wqR8WfViHsGzD87EqCIbpm02Rl
	FYkacdDbbhhfeK1Z6QuSiVNkoQgjvQJRze4XfbdPHZxJ79Z/moCxYcWeA/0IHYbI
	T2ntobFZbXVSa2JtiHLtHTQkxvEIQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme1p573-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBiKkD000965;
	Thu, 26 Jun 2025 11:59:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme1p56u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8iBEr006403;
	Thu, 26 Jun 2025 11:59:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBx6Mb35127996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEEA2004E;
	Thu, 26 Jun 2025 11:59:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6869D2004B;
	Thu, 26 Jun 2025 11:59:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:05 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 00/13] Add more tests for multi fs block atomic writes
Date: Thu, 26 Jun 2025 17:28:51 +0530
Message-ID: <cover.1750924903.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685d360e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=AJ12i1JoEAX1BBJSESIA:9
X-Proofpoint-GUID: TTPd79KqSVbsqHJdHZRUoRlnHAO11UcC
X-Proofpoint-ORIG-GUID: R7mZvOi-Sy4TAfSgv4yU_ziNC6gKythH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX8YHDIZkJZr3/ diRVqzn/edQCIWgO9TIiDcqVOlsdoOy6UXwtgRhwpgaBS5ZiC0rVGXXUBr2W+ZB3/ro8KR5LSXC lsC4HQyDOeGvpL6gxbU86KqgR4U/lvXxz3hAXsB79dXQSu2PKMKFE1wglQeQt0IdPhi7NRKcqwp
 8Z6drWVZm7Kn2WOx/RWyRgKIZJO5eq8xoPR0KBGlYs32vSG5dh3/tzXYdJVdjRrsE/ygbrEDXH3 jO49+amXik2RbdmykTpR2m2QG8UJW6wzyO8DERcvQNJzBbdt8kNRKezzBWoIbWhT/rngpZcoXBk Xb72iUbCyXFLxNuYKpA8ltZrFevC7jSGSf6C7Y/T9blPPtO+9Wv+v+gxcZE4J6dU2gwWMZXEmdJ
 bSIUWVkKOL8gtMEx2MusG5a/VEDvDvUQUOk9rmIcxPQRULt9pDiQazeDv08X99muVh6WLyUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Changes:

- (1/13) new patch with _min and _max helpers
- (2/13) remove setup_fs_options and add fsx specifc helper 
- (4/13) skip atomic write instead of falling back to normal write (fsx)
- (4/13) make atomic write default on instead of default off (fsx)
- (5,6/13) refactor and cleanup fio tests
- (7/13) refactored common code
- (8/13) dont ignore mmap writes for fsx with atomic writes
- (9/13) use od instead of xxd. handle cleanup of bg threads in _cleanup()
- (10-13/13) minor refactors
- change all tests use _fail for better consistency
- use higher tests numbers for easier merging 

Link to rfc: https://lore.kernel.org/fstests/cover.1749629233.git.ojaswin@linux.ibm.com/

PS: I'm on vacation till next week so there might be a delay in response

Ojaswin Mujoo (9):
  common/rc: Add _min() and _max() helpers
  common/rc: Fix fsx for ext4 with bigalloc
  common/rc: Add a helper to run fsx on a given file
  ltp/fsx.c: Add atomic writes support to fsx
  generic/1228: Add atomic write multi-fsblock O_[D]SYNC tests
  generic/1229: Stress fsx with atomic writes enabled
  generic/1230: Add sudden shutdown tests for multi block atomic writes
  ext4/063: Atomic write test for extent split across leaf nodes
  ext4/064: Add atomic write tests for journal credit calculation

Ritesh Harjani (IBM) (4):
  generic/1226: Add atomic write test using fio crc check verifier
  generic/1227: Add atomic write test using fio verify on file mixed
    mappings
  ext4/061: Atomic writes stress test for bigalloc using fio crc
    verifier
  ext4/062: Atomic writes test for bigalloc using fio crc verifier on
    multiple files

 common/rc              |  62 +++++++-
 ltp/fsx.c              | 109 +++++++++++++-
 tests/ext4/061         |  97 +++++++++++++
 tests/ext4/061.out     |   2 +
 tests/ext4/062         | 121 ++++++++++++++++
 tests/ext4/062.out     |   2 +
 tests/ext4/063         | 125 ++++++++++++++++
 tests/ext4/063.out     |   2 +
 tests/ext4/064         |  75 ++++++++++
 tests/ext4/064.out     |   2 +
 tests/generic/1226     |  66 +++++++++
 tests/generic/1226.out |   2 +
 tests/generic/1227     |  92 ++++++++++++
 tests/generic/1227.out |   2 +
 tests/generic/1228     | 139 ++++++++++++++++++
 tests/generic/1228.out |   2 +
 tests/generic/1229     |  41 ++++++
 tests/generic/1229.out |   2 +
 tests/generic/1230     | 321 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 20 files changed, 1257 insertions(+), 9 deletions(-)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out
 create mode 100755 tests/generic/1228
 create mode 100644 tests/generic/1228.out
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out
 create mode 100755 tests/generic/1230
 create mode 100644 tests/generic/1230.out

-- 
2.49.0

