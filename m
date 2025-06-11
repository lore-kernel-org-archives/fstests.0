Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0F264630
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634524; cv=none; b=mIgLBJ4cTdRLt66LpnRxIGaDqFBrwt28XGdWSBzX028KLf88vVmtikFCXtX1iBJZb+HZ+fWgLH7ScKD2WfsN+fkYyNiovsgJ69jkRrg7Js+N7vwvsciCsFPZBRyCfm8i6Zdb87T80WtLZwUsGqkL0uQrHb8o0gQBstoS9rTWuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634524; c=relaxed/simple;
	bh=l++GxhCoWV0OOWZFIGWE0qxlfwrlI2IDg26amONr1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYyRh7jLyoPhY+JgZP+k87oFiayIxdaR+W3PYSqEdz4KLa00/ZkV93pTBWOm/4Bhb3HZnq4UXwKZYhYg/5YQ44YPOoztM5AtvGSbRXpnjZDiks0ZvBqDO7tPWj9iFOTdyR6z1eU68ARXICrdj180dAxeVbjwNvWPvRFbRZdgHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ktxHuUU/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ktxHuUU/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B3YexJ021223;
	Wed, 11 Jun 2025 09:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JGe5oQZBNDBJPrWPd
	p1fC211RQ3azlNy4FltbB1sLWc=; b=ktxHuUU/8j4VPw/S8Z2F3QuEVwMDpN+jd
	xVBAx3DB4d4nmrj8P+l8ReFQzm/A+Xg66B33lWQKahk51PqUl6RDBsf25+VlQGjM
	oZfhGqfpK7v38RrbOtny+L/hID3FA1hQzUWax75L+rPuwBekFY3lUkn1mpeEgOIh
	Z/DMMEqLsEs5C2Puy8d4/1LdhOqu0tRtucERgTOx/h8JxZvA73g5eARWld7adFFT
	P9TXsGqzapkqNFtTn2pFb2M3Q70fYfKhQFPGiEV8oCQfgHs9E4QFP2XZjfI/jGQX
	Omrf97HeFVn4w07WfDYheyS/n/GwlxcN3dQfV3T5Zy3fIdRvahM8w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjbnvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9ZHBF027579;
	Wed, 11 Jun 2025 09:35:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjbnvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B94xcF014912;
	Wed, 11 Jun 2025 09:35:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp703u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9ZEc934996630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F340F2004B;
	Wed, 11 Jun 2025 09:35:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE43120043;
	Wed, 11 Jun 2025 09:35:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 09/12] ext4/061: Atomic writes stress test for bigalloc using fio crc verifier
Date: Wed, 11 Jun 2025 15:04:52 +0530
Message-ID: <1fb9171017c601c3a1e1da1581d5da41746ca813.1749629233.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: AEZlrlJBBeQSwE0CoiO56tvZM59fsaW1
X-Proofpoint-GUID: sWe7KJ2anI0bGwhJLw5pNAryZBu1zKCr
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=68494dd5 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=IXpTdg1pUaTNVRSqEnEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX0dNqcb2IlM11 se80zhAr7SmhP7g+8wqrSvFsd4PJPdK7swixbVXMsb8iMpjVKDIWtMMpeiDLcI6uWP26vwONugl r9vCd2EDDVJu2PpVIePTuF4R1lJYRHIWQmy5GIgbVt0QyHELnZvAS0FUOF1vWvqeKPK7UxgWM70
 6tmHt0rMuwrdpud08fDQj8f7NUCI32s8kxye1QplTWmppHu+CmYKD4krPWcXBuN5xaGu1Of15P+ P3MyKye/6emky7asKT/Am6RbdFcNm3NJFWkDiUKmLLHpdC9WZTjmfkUryM6Au9uMo25XWzDT50B jDoXH9ddK8U2fPdWQEWLZQVbq1KIOr3hWQIkYrvHhhqNf/nUodbqAz+ykgmMdI/YuliJiO65U0E
 ZkzXGBwRN80x8uCNn6EljkG1XBlnlg1W8ZFrRx/9iz4N0FUPCe+j68qLiRkmfSjP+mjsxCFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=783
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

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
 tests/ext4/061     | 107 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |   2 +
 2 files changed, 109 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..9d656613
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,107 @@
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
+FS_MAX_CLUSTER_SIZE=$((128*1024))
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100*1024*1024))
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
+create_fio_config
+_require_fio $fio_config
+
+for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $FS_MAX_CLUSTER_SIZE; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_ext4 "$MKFS_OPTIONS" >> $seqres.full 2>&1 || continue
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

