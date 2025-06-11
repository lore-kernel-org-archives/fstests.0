Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D622641E3
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634515; cv=none; b=LzbhliRxZy8DlsqoZe2Q4jMb/ZJtDFzLzk4Q8c2dhCYonodd7ll56sgjViQQ+GgFyHQ4/zQaZk4o/nBjXcGjRjmfKZ0gXBY/VljL61xZfLHAJ83ELTa2iunGnkfOEd9fEg6FF+4qHkAW/wK6ncetwSfc5+514cafsOfHr0ZEuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634515; c=relaxed/simple;
	bh=izM6pcrXEMuVsvhLKgK6u2MsTS70egm/zQ97pO7uAsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5M8pO2pRkIYDYUod0LQ6Naoof2fLeSmg23uibuDRKWsz4C5dRUqsz1VHhnCoNQkF0cy9leiFUBAHNAVfncSw7eGdVhs918WLxYs4yqmYe4QGKyxFhSHrci0YqCjGlL6x1vjlw+pevgO9PsL8lcCApgR9vXwp4cEDAZr/aHGp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RN2CvbSJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RN2CvbSJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B898UD001515;
	Wed, 11 Jun 2025 09:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wk9SNRLyGpiLigDq+
	qShGv89xUAxxinZ/ZxMN2u/Wv0=; b=RN2CvbSJaWPymj/z/NyDBNQ0hU9AHC8g+
	Nt1Mr0pZUssAMIRavq9zrMe/FsdVoR4rEm/l5utH6H7j4hZUEPp2yR4Rvr6tO8w7
	m7vgJkJwvfag9G8gQz1EBRxbvms2545bQsKUKpWqlsmZce96ISdxv7WywxsHIgeS
	aKlp/7WIARsr5uRd6paYL1jiaK8x49Kvx36t4B2/7+xpE5uvE3uW/atB492ZI1Ed
	lzqGoBLSp3dkw/skXARru7Wco6bSnXGFNqJkbImzrlXXnu0MwZkZJcZSPJm6BC2K
	sWLBMKqw1wu3ZM6b7K8beDlAJViLId7gBYqBtEs8ww4xWq9JPDUUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgujpyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9XhCm004220;
	Wed, 11 Jun 2025 09:35:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgujpyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B86VsR015210;
	Wed, 11 Jun 2025 09:35:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtf8fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9Z5lM41222482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08F02004B;
	Wed, 11 Jun 2025 09:35:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5E2F20043;
	Wed, 11 Jun 2025 09:35:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:03 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 04/12] generic/767: Add atomic write test using fio crc check verifier
Date: Wed, 11 Jun 2025 15:04:47 +0530
Message-ID: <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749629233.git.ojaswin@linux.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=68494dcb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=COyG4TZmnK-FvjRuIuoA:9
X-Proofpoint-GUID: XU62BNV5cb2ZGanxE6X4dXskucHijxDw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX5TLY5sjRohzD Vznjj22m+TYnNo77DItT7JojOO+4UPrP9YfVjPYtbclbrh7FQ2lwz6eMz1SSgurfDqsXUGo3tAl eIM8hDz1A6MhWMvYjFp5/9LhpqbRVbEZE/S3NGt+IiqkSd2fSgTC43gqzKSF9wJlVhtOEYHsaYp
 8e0HUC4s0vEprMt5YbOIpqE5V3esEZ3XlQnS26YfVPumiR11+sdPMZlspwIpLYZIw/ryn9TVbNT muGlMmLzqzseQOthSHVIKFXSfWZv26W04RheiP1UuntGrDytX9SlvgLhmANHh8XZyIPrOq/1VzP NjMrvbkIuMzCi4mAqdKx2Qe0tjyJBOoBAFHF9qoxPrbvPSJtqez535T3CWrwDN0d6qTI1ofwLcm
 5QuTEOT8sjE+Pcm6XUS6C9hnsiHxkrT+IqiOATLn34xiOafv4JO4m4Q7R3KVv1CdiA70rNeo
X-Proofpoint-ORIG-GUID: ZJcz2AtV1fnfO4qNxwj-1ZJYxrtgdGZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=816
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110079

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This adds atomic write test using fio based on it's crc check verifier.
fio adds a crc for each data block. If the underlying device supports atomic
write then it is guaranteed that we will never have a mix data from two
threads writing on the same physical block.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/767     | 84 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/767.out |  2 ++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/generic/767
 create mode 100644 tests/generic/767.out

diff --git a/tests/generic/767 b/tests/generic/767
new file mode 100755
index 00000000..4f80e7b6
--- /dev/null
+++ b/tests/generic/767
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 767
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
+function max()
+{
+	if (( $1 > $2 )); then
+		echo "$1"
+	else
+		echo "$2"
+	fi
+}
+
+function min()
+{
+	if (( $1 > $2 )); then
+		echo "$2"
+	else
+		echo "$1"
+	fi
+}
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+blocksize=$(max "$awu_min_write" "$((awu_max_write/2))")
+
+# XFS can have high awu_max_write due to software fallback. Cap it at 64k
+blocksize=$(min "$blocksize" "65536")
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
diff --git a/tests/generic/767.out b/tests/generic/767.out
new file mode 100644
index 00000000..2bf7f989
--- /dev/null
+++ b/tests/generic/767.out
@@ -0,0 +1,2 @@
+QA output created by 767
+Silence is golden
-- 
2.49.0

