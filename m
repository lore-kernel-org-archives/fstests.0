Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66E277C96
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939174; cv=none; b=GlOs5J9bJCMtlDiMvYWXdw5XA43pgMy+YDPiCFyR7Pi188ZTp/3pKWUjnPtNLCt+1QX30yTrHa9qXrrETKVrnMYE7PWUtHJuqVMrggCKMIcVBc7ayNYwouLWf9874/Jjp25xxc5ix8WfGZ5VkrfZfhsgZak1D22MIdvwk+x6rm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939174; c=relaxed/simple;
	bh=V6mLuj9xjYIWQjZ3JYrYjpS6KgKX0hsE4o6jcC9R4Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojvYIIhPEoHfkkjErrghIAGcBJXpQT4nDcCmCo/mmyz9/a+yEr6h6grMtcpXstp4kHzCO/n/4iyKPT2+WwvY6jZKqudSEhfVpjf12HfG2K1iP03YS6GwE3nOO38jm9O7HxLQpkIKM5dZyxYKCYK5EsWJZsVpsAIzOLGU3KVdNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FnZ+0BjH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FnZ+0BjH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AfRO032174;
	Thu, 26 Jun 2025 11:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BzBDbaQYHvs7Ju528
	Jh5ImDQt1cv3ARJI5h5BycmejE=; b=FnZ+0BjH9SNWG8tryiKvQpRSNsLAt0DIY
	1hMAlTQ+smus+73IVsfupzbJ0NSScvDBejS5XrPvp+IG9oHDqE3ptMsISRYj3jwE
	RdCwbs7vWb/u0faymotICpItjEqqCTUh7FsQN18hieBZeB4O3YTuEiZHA9CzW9uK
	OVpFeRIR9cnNvE3cel1sPEjmkXocxd9SVxHUUuoirwN50idAAkVyH5omtNWvNu32
	t9VWKmtExWrvn5tzaevioUbYXgwTCkFrDoZQT/DA/KpYfTmisYyF65HOWD72fVWP
	dyGoYZ2Fk3XtYMoqAXdE0DticlNy1wzYfFEV6/bZqk2bQySMrlFPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u65ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBuBWt007659;
	Thu, 26 Jun 2025 11:59:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u65m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55QA1e7K003980;
	Thu, 26 Jun 2025 11:59:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kxfqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxGPW46596400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72D6620040;
	Thu, 26 Jun 2025 11:59:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D8D2004B;
	Thu, 26 Jun 2025 11:59:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 05/13] generic/1226: Add atomic write test using fio crc check verifier
Date: Thu, 26 Jun 2025 17:28:56 +0530
Message-ID: <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: RkAvig0mCIXuCPGpN73S0JfPwDcC444M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX3ho0Eu5ObisY bqjgtLt/nL5hYBAEZPg81PkrvEemMM3ad/r03bRPjtxAYgbVeyXASJcqkWpZDogF390IjASb3su t/0OaIHv7XZd+qk7nrKl+7Ctwv5AP7j3nIjHxTD0zVuNOFrzVVEVHu+z//hEECNxJUgESs2gtKT
 7IIJFokjsirE693aqlyLT3Tk+hS8qd8PxiokDDG09JbasXFBorWIyfCo73a2WSuh8nUonA3WAyK W9QQ+AI8O1G6T2NpzXZ3u1CNGmu2V3dUlWS1G7kR5MW6MHFgbGE8IW4qVcMpts3cwarLLw5vjwy FYW0Nl8Gf7lFYmNJoLKFVApRSCmMQLnUwzghc4uHUFtmK/x02KHhC56dErjUqeYR39t+trY+n6H
 pfE/dL9Dy/KAiy8BcUWrzZPI0AnD/WNCgsSdLHfooXWHHbKMAZNnfv6ycNJEj0J5Pwvwb39V
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685d3617 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=O54qzub7SrlYGMPR4oMA:9
X-Proofpoint-GUID: J2ygj2NOT_pxuv9AtmetjYTD5yRSUr9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=958 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This adds atomic write test using fio based on it's crc check verifier.
fio adds a crc for each data block. If the underlying device supports atomic
write then it is guaranteed that we will never have a mix data from two
threads writing on the same physical block.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1226     | 66 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1226.out |  2 ++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out

diff --git a/tests/generic/1226 b/tests/generic/1226
new file mode 100755
index 00000000..a5ce8556
--- /dev/null
+++ b/tests/generic/1226
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1226
+#
+# Validate FS atomic write using fio crc check verifier.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic
+_require_odirect
+_require_aio
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
+
+# XFS can have high awu_max_write due to software fallback. Cap it at 64k
+blocksize=$(_min "$blocksize" "65536")
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100 * 1024 * 1024))
+
+cat >$fio_config <<EOF
+[aio-dio-aw-verify]
+direct=1
+ioengine=libaio
+rw=randwrite
+bs=$blocksize
+fallocate=native
+filename=$SCRATCH_MNT/test-file
+size=$SIZE
+iodepth=$FIO_LOAD
+numjobs=$FIO_LOAD
+group_reporting=1
+verify_state_save=0
+verify=crc32c
+verify_fatal=1
+verify_dump=0
+verify_backlog=1024
+verify_async=4
+verify_write_sequence=0
+atomic=1
+EOF
+
+_require_fio $fio_config
+
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config --output=$fio_out
+cat $fio_out >> $seqres.full
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/1226.out b/tests/generic/1226.out
new file mode 100644
index 00000000..6dce0ea5
--- /dev/null
+++ b/tests/generic/1226.out
@@ -0,0 +1,2 @@
+QA output created by 1226
+Silence is golden
-- 
2.49.0

