Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02378277C87
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939178; cv=none; b=lT2eD493djRzN/W6cmIkE+L3fG6jaiwLk//tVqIvOeJlSeuMMdE4rAHXsoF9Df2+B0aEvzkQl32JB75xLP7T0jzetwJJsDWFcGUK6sOLi1Z6EpKhsPzAt0wgFinIfW01oe/USwFg8fk5r3rLxZCRbzO4+0VRnQ8D2cTPDtIrPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939178; c=relaxed/simple;
	bh=W7g9L2Z2eL405O4pG8wBlacU7+UEZFGyzFfeSPU6I68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYGgcf84n8ne0X7k5YeM8xM71F2dMIjlUkLlaZ3c9ZOqZmUSTSiG9rPWO76XGRt2LNH1fGV04BqD69UYmek9EFQjUbZGhu9cl3B38C16I6a4W4HRfO8NHvhcn/rxPLK8+UK4Iv7ZxX5kebqauR7llXSVfpB7+47iGw8/f6LR+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dfOriG/+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dfOriG/+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4B3VB030913;
	Thu, 26 Jun 2025 11:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XqIrCugnZ7P4P8PAj
	4Kniw0blWcZmHoOVve0IATKERs=; b=dfOriG/+SxzcB/6rCCGN33bMzRIeWjD/v
	otPbYpo3fG5m73WgeyP3WtnvbORIm4ZuU4j3n6S8KhwYukHfMP0OVJgCv6qOgCp8
	Ok+IQ6Vva+xN4X8b8I9tmMt8uK7Nbsrh99IyBpxRgJYuCf9SvfcLtcAj7zZMOe4k
	sM3Ck+dBGIdoRBv+2NrPxpCFhRVru0xWgMSAlkd4zwQ7yyxiWMmOUme43i1iT8gr
	6Na8CyvqyQFurBNsqZQ+OJk5bgOsvrhrqHC+q8WrQ3l/j4W+6LPqvDAjKy8sj3R6
	z/9kRzE4KUGmPb63OOBzOLB1yLu29Wcl/WfvKvGyupgPEl9516i7Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk645vpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBgcFj013588;
	Thu, 26 Jun 2025 11:59:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk645vph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8XDFe006513;
	Thu, 26 Jun 2025 11:59:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pes43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxQoZ30212368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48D9B2004E;
	Thu, 26 Jun 2025 11:59:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D221420040;
	Thu, 26 Jun 2025 11:59:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:24 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 10/13] ext4/061: Atomic writes stress test for bigalloc using fio crc verifier
Date: Thu, 26 Jun 2025 17:29:01 +0530
Message-ID: <9885a5585d44fa6e018423c711d78015f04d3020.1750924903.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX6AlOhwalujEx ZISPmiUKurhsZfP+SUSX8q2oXJjmgs+vygxTuDPAANZa/sIfjyAKwUU6+s7oEdgkRVqTmCzBbIe 36mSljqaugQb8lhI5leHzOP+wrqzc5jbhtJlqVekeZraRAMZysA4e/sEXNYtqLKwFAhyIA9zqRn
 5ShdQPw81BwvD/jWyqFQD86c5WKGqHYU4PcHh+UYeBplzPar5x42k2D7zPf2iAhEeIWL73ZVRk3 JwoudHdYmqsdh+llO9ob6Pq7xcOKi9j7gQtua1QE4mrwxRFUEQFjWaE1ngX+lbi3Jwyd9EyjVi8 eDfehp4r9SEkPukkXKbliNmd1Ar8IU5VFH58ZgBZRUdrFkLYwmODz2jRWyIXIMCajiqwcSbjKgM
 7fCSIJ6tHXZcmoJXAyO4Kparw/gT/GXhwlTgiSXobtBOK8SN33aLp/SLmzghU6V7gubxQJRi
X-Proofpoint-ORIG-GUID: 4hJQqer-iI_8B04RhyokkRw1p2XMwlco
X-Proofpoint-GUID: Be1neWqDCUVj54YmNzIEJa6Rq4LSM31K
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685d3621 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=IXpTdg1pUaTNVRSqEnEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=946 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

We brute force all possible blocksize & clustersize combinations on
a bigalloc filesystem for stressing atomic write using fio data crc
verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
that we never see the mix of data contents from different threads on
a given bsrange.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/061     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |  2 +
 2 files changed, 99 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..1c600c70
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Brute force all possible blocksize clustersize combination on a bigalloc
+# filesystem for stressing atomic write using fio data crc verifier. We run
+# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
+# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
+# we should never see the mix of data contents from different threads for any
+# given fio blocksize.
+#
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
+_require_aiodio
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100*1024*1024))
+fiobsize=4096
+
+# Calculate fsblocksize as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+fsblocksize=$(_max 4096 "$bdev_awu_min")
+
+function create_fio_config()
+{
+cat >$fio_config <<EOF
+	[aio-dio-aw-verify]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=native
+	filename=$SCRATCH_MNT/test-file
+	size=$SIZE
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
+EOF
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+create_fio_config
+_require_fio $fio_config
+
+for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
+	# cluster sizes above 16 x blocksize are experimental so avoid them
+	# Also, cap cluster size at 128kb to keep it reasonable for large
+	# blocks size
+	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
+
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
+			if _try_scratch_mount >> $seqres.full 2>&1; then
+				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
+
+				touch $SCRATCH_MNT/f1
+				create_fio_config
+
+				cat $fio_config >> $seqres.full
+
+				$FIO_PROG $fio_config --output=$fio_out
+				ret=$?
+				cat $fio_out >> $seqres.full
+
+				_scratch_unmount
+
+				[[ $ret -eq 0 ]] || _fail "fio with atomic write failed"
+			fi
+		done
+	done
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/061.out b/tests/ext4/061.out
new file mode 100644
index 00000000..273be9e0
--- /dev/null
+++ b/tests/ext4/061.out
@@ -0,0 +1,2 @@
+QA output created by 061
+Silence is golden
-- 
2.49.0

