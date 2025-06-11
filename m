Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E148264630
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634516; cv=none; b=KOb185JuXQel79eyA+mkM7uPUqo6jRq8d5aqR6+LNIOz+2AM4EwEsyv7eN9ulBfGyp5gpON4okU2qqKg4QQrEbMN30KpXro4JQ8s8DgrtU40/BI29hPva/af7mWSfGmMFKxk1FQ8+9jcEoOAWKOZuolTRpkHmPuJBOzWz8pjnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634516; c=relaxed/simple;
	bh=PMDncpNaGGOknOaVQFq8oQ8Gokn8EN81vQvPkh9GCtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHy7jF70ZYSDJvFK7cI7XoGjEKBYhExDaMFD0zPap/bLKzSe/THuM8AO0+yEKy3Tlx/QEgZt8PufVKxeMCa+n9r6nv5H7MKkepMHgva74rAjsjslLEUXZjCqXp9AFb0o+EeYfOzctJTPY7PbrUlfZmwLhC/BNZwatJEzsgPP8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EncwsP/O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EncwsP/O"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7nTpL021947;
	Wed, 11 Jun 2025 09:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KGkehMrvLjoPCUUGb
	W+6i5utVcRrejOaDtd2ENyPDFk=; b=EncwsP/Orr0HxRzSKycciVJR9qcTBPhNy
	tMz7ZybLXnuLNfn55K4V/wp8dZ1tNU7HIPutpANs3Ygm5Ka2hEu19GF1207JdJkk
	9Xzb4Hs4xKj0Yz6erq3DuSEQqgUFl7m0EHl34PzuU5gb77I6v5T6HMc3PaRSecIr
	rPyCwGqPJ5la7U7MDy5qG67aiDuVoSMs+tv7TAwZJ/BBejfQHYWcSGWEpV30i6lB
	6mU1YJbu4dHeHS0on/INgIp6RjJyxVVEUB7fidVy/ChphnqKaCu0zV3YZRCVkqJm
	yMxIIsal7DZ+AFf93Ba9TDdYPGYp3aMtQFpKfPlLcszjpBWAAWyZg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3jdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B98xPA001963;
	Wed, 11 Jun 2025 09:35:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup3jdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B84Kfs015168;
	Wed, 11 Jun 2025 09:35:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtf8ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9Z7OK34996620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E329E2004B;
	Wed, 11 Jun 2025 09:35:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60E4520043;
	Wed, 11 Jun 2025 09:35:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:05 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 05/12] generic/769: Add atomic write test using fio verify on file mixed mappings
Date: Wed, 11 Jun 2025 15:04:48 +0530
Message-ID: <15c49ab581996987e060ee44cda4c58c4ceac1f8.1749629233.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68494dcd cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=wXib8i2b86_I58z0EYYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX8NigBjmo8DIt sYEIs/ce1CPE+DP3pXSB29EEa1umYWX0t/BnWlqwlSMf5R83QYAl+xaXxSH3NWmd7N/KDnRJh+8 5l8sU3wqXAyzUGQPhDkcHXnJTOJnaCyZsHGrR8XN6Yb+eLkJvkbiD1xPMRJM4qn7pY0jiF+NToV
 iTm+azKNGhU3xbMs/tbrfQR7O2HtJYha/Ldjyb9uDdRqvHZrtHYyu0G0e3RUkR9HbzGz7R9F7iP nr/lN1zZQgZAOPXtJZtLAiJ7J09b2HmDNBO7hR38QQeA0vWO+OX42Kg8gEV+hY75tFoYQQLAPpW J4lX8/VAbIV4JVJdxHyifad1ACuT1ApwjIrbcHUqS9ZnH2MII9xVXL1co4dKd8cIgeDmBw/SUQZ
 IrCYwXB6h8FLOCpJMmQDyuOvksBkPBwzrdmpGQj1jFE2bi6KSc87t85qekEGuEbDwecyIcOL
X-Proofpoint-GUID: gDFblWAVZnqmh179K-41AssKhRKZckDE
X-Proofpoint-ORIG-GUID: -scv-J1g5ss_gSBw933-Ro2uTgS1lYP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=978 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This tests uses fio to first create a file with mixed mappings. Then it
does atomic writes using aio dio with parallel jobs to the same file
with mixed mappings. This forces the filesystem allocator to allocate
extents over mixed mapping regions to stress FS block allocators.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/769     | 101 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/769.out |   2 +
 2 files changed, 103 insertions(+)
 create mode 100755 tests/generic/769
 create mode 100644 tests/generic/769.out

diff --git a/tests/generic/769 b/tests/generic/769
new file mode 100755
index 00000000..469d6344
--- /dev/null
+++ b/tests/generic/769
@@ -0,0 +1,101 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 769
+#
+# Validate FS atomic write using fio crc check verifier on mixed mappings
+# of a file.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
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
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+aw_bsize=$(max "$awu_min_write" "$((awu_max_write/4))")
+
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((128 * 1024 * 1024))
+
+cat >$fio_config <<EOF
+[global]
+ioengine=libaio
+fallocate=none
+filename=$SCRATCH_MNT/test-file
+filesize=$SIZE
+bs=$fsbsize
+direct=1
+verify=0
+group_reporting=1
+
+# Create written extents
+[written_blocks]
+stonewall
+ioengine=libaio
+rw=randwrite
+io_size=$((SIZE/3))
+random_generator=lfsr
+
+# Create unwritten extents
+[unwritten_blocks]
+stonewall
+ioengine=falloc
+rw=randwrite
+io_size=$((SIZE/3))
+random_generator=lfsr
+
+# atomic write to mixed mappings of written/unwritten/holes
+[atomic_write_aio_dio_job]
+stonewall
+direct=1
+ioengine=libaio
+rw=randwrite
+bs=$aw_bsize
+iodepth=$FIO_LOAD
+numjobs=$FIO_LOAD
+size=$SIZE
+random_generator=lfsr
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
diff --git a/tests/generic/769.out b/tests/generic/769.out
new file mode 100644
index 00000000..1512b439
--- /dev/null
+++ b/tests/generic/769.out
@@ -0,0 +1,2 @@
+QA output created by 769
+Silence is golden
-- 
2.49.0

