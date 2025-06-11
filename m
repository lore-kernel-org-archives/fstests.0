Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4E264A88
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634526; cv=none; b=UOi0nyT7Ip6OEOhyJCR4W3kmm4NSxfXZLv410V5EdpBC8+eVYPUcbYOd9ifzyg4gF85FoLbrjWLY+sO62dL0k04gtm3iPvJjJyXZSp43vEbChSguPF40fGyNoXHPZVY99D5OIUaHfSHiWNdDs+BDIx6YR74qZodSvlR6NWY7EgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634526; c=relaxed/simple;
	bh=HRgr9TkVA5yEmATEPHAiGIf1osThJgnOr8fUah5qrgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNXocbDJN+Rng6zUUC5AxqD925BfeRgDWxC4aDVq+GQPUOL716ReJnFTibL6vm78n6c+jza2CttFk7mMatY9K2AI/KXeRhBL/TXetBWld5bH5qCUWpm7TXKiVVP8Z+x9wI5kF3Po4QEZfX0baq/kFJxD7lNwYJPhar8BUkBSFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WhF7iOD7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WhF7iOD7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B0wO2n005022;
	Wed, 11 Jun 2025 09:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XnQNxJIUY3zwJF497
	7t/bXfkD6TxY1VpSvdyg6HAn5k=; b=WhF7iOD7O//I37WYKkEDVbkw508AM333O
	3VRudzWlBjS8l4Reirrpve+WKGIvkceSCLwx/8aZv9iNDlXPj353qjEyV6vPFVOr
	FlbRZWB/Ssyq8awva+apaauPFi7CVw3sDF1H/l48J4UzqxrnRe4uGhpL8wWgMPIQ
	7xr7fxB+LTnDZTgdK0dUinqd5qOypIO3pFbXBPVjguFvcaZsgqQklsmhtmoRxqWe
	CXjHKSwCXqA8gktMdWyltt2npIX0pHjzFRopcx58T4sUW6Xr8ze5JaLr+eLqO7RB
	ZtD3fy/TvI3kEDxA4Et0zK2sSAG7NhYn53IMcXISXbF0Yzr7Phpow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8qbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B98MkG028705;
	Wed, 11 Jun 2025 09:35:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8qbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8NLBj015186;
	Wed, 11 Jun 2025 09:35:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtf8g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9ZFtG57934266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ADE52004B;
	Wed, 11 Jun 2025 09:35:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6394120043;
	Wed, 11 Jun 2025 09:35:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 10/12] ext4/062: Atomic writes test for bigalloc using fio crc verifier on multiple files
Date: Wed, 11 Jun 2025 15:04:53 +0530
Message-ID: <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68494dd6 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=TkcjpYBco3HGeQvuunIA:9
X-Proofpoint-GUID: fDGL9uSSxawZGb5zJ_csGCNgWIdd3Nqt
X-Proofpoint-ORIG-GUID: Lunc98RgAJWLhuVeeHFZ1GO4f3o3S60f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX5i3dJDJbsPJ/ SEVgAeLql3FJurqU0tn5VHHALU9U/PNtTKVPpf670hZW6ACwV0VK3M8blHZQbp9jMoNqGEUVLAX mrENx59NzqfZs14yIszhAM66wp9qkb9Tjaz4TtsM0gw5sKOEC6g9CGN9zrwnHV+t2m2j3I7HLc8
 gQF2K5t6TB/y2UOdZl0tDj8oS3v3NtA74PbqPYdfEBxmWDasNYEmX71p6UKALZur6I9Cq0/SY2F b6SKRmSCkFOpj/TjwDpxm8H7MYl7oeBw0pqoiDR8vlO3CNV4H71MdOxFsMY0paA4o1fS6OdChrU hweApX/jP1rHgHS3Ivll1mac78q/RCg8Jn+uUnfgKb6mYiGM8QH0UfF5Uh6eCk44wn4rnUYT5ls
 a7d5uOGh5Xa9nDJ2oBHhaLrwGEN0Ae67ib7wQRog3thQfEfsKnjwEB+OJDn1MfF4C9fo2xld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=929 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Brute force all possible blocksize clustersize combination on a bigalloc
filesystem for stressing atomic write using fio data crc verifier. We run
multiple threads in parallel with each job writing to its own file. The
parallel jobs running on a constrained filesystem size ensure that we stress
the ext4 allocator to allocate contiguous extents.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/062     | 131 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |   2 +
 2 files changed, 133 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..50803b97
--- /dev/null
+++ b/tests/ext4/062
@@ -0,0 +1,131 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Brute force all possible blocksize clustersize combination on a bigalloc
+# filesystem for stressing atomic write using fio data crc verifier. We run
+# nproc * $LOAD_FACTOR threads in parallel writing to a single
+# $SCRATCH_MNT/test-file. We also create 8 such parallel jobs to run on
+# a constrained filesystem size to stress the ext4 allocator to allocate
+# contiguous extents.
+#
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
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
+	if (( $1 < $2 )); then
+		echo "$1"
+	else
+		echo "$2"
+	fi
+}
+
+FSSIZE=$((360*1024*1024))
+FS_MAX_CLUSTER_SIZE=$((128*1024))
+FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
+fiobsize=4096
+
+# Calculate fsblocksize and FS_MAX_CLUSTER_SIZE as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+fsblocksize=$(max 4096 "$bdev_awu_min")
+FS_MAX_CLUSTER_SIZE=$(min "$FS_MAX_CLUSTER_SIZE" "$bdev_awu_max")
+
+function create_fio_config()
+{
+cat >$fio_config <<EOF
+	[global]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=truncate
+	size=$((FSSIZE / 12))
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	verify_state_save=0
+	verify=crc32c
+	verify_fatal=1
+	verify_dump=0
+	verify_backlog=1024
+	verify_async=4
+	verify_write_sequence=0
+	atomic=1
+
+	[job1]
+	filename=$SCRATCH_MNT/testfile-job1
+
+	[job2]
+	filename=$SCRATCH_MNT/testfile-job2
+
+	[job3]
+	filename=$SCRATCH_MNT/testfile-job3
+
+	[job4]
+	filename=$SCRATCH_MNT/testfile-job4
+
+	[job5]
+	filename=$SCRATCH_MNT/testfile-job5
+
+	[job6]
+	filename=$SCRATCH_MNT/testfile-job6
+
+	[job7]
+	filename=$SCRATCH_MNT/testfile-job7
+
+	[job8]
+	filename=$SCRATCH_MNT/testfile-job8
+
+EOF
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_config=$tmp.fio
+create_fio_config
+_require_fio $fio_config
+
+for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $FS_MAX_CLUSTER_SIZE; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || continue
+			if _try_scratch_mount >> $seqres.full 2>&1; then
+				touch $SCRATCH_MNT/f1
+				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
+				fio_config=$tmp.fio
+				fio_out=$tmp.fio.out
+				create_fio_config
+				_require_fio $fio_config
+				cat $fio_config >> $seqres.full
+				$FIO_PROG $fio_config --output=$fio_out
+				ret=$?
+				cat $fio_out >> $seqres.full
+				_scratch_unmount
+				[[ $ret -eq 0 ]] || break;
+			fi
+		done
+	done
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/062.out b/tests/ext4/062.out
new file mode 100644
index 00000000..a1578f48
--- /dev/null
+++ b/tests/ext4/062.out
@@ -0,0 +1,2 @@
+QA output created by 062
+Silence is golden
-- 
2.49.0

