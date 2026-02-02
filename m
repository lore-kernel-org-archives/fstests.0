Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E10367F3C
	for <fstests@vger.kernel.org>; Mon,  2 Feb 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038862; cv=none; b=iIPeDU+/O/scVEK2kIjtgAi4tE8qW3/CWI0BJ47ajOKR6AUnccpP204tzLdP+KiWDtnwtGJJ+RsAhr1jmht1OdC9ed8P+vuVO46PO88s1CiBFy70BzzRhrT8o9rsxl0GfW+cSuVrv0ODPNd0JtnYqPn263tO4SZpBNhdoyM8gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038862; c=relaxed/simple;
	bh=7sjYTtNFyA3vIvwYkstb7/hU3eI/5rKeaXv9D7u/fPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KG7G30jNCk1WNN9GYljr41mHZfyqmeSsMhytxCgEdd97D60O/LhWI/UV4zuuG3b1tDc4lMaazTYWSoc+NG57/TIVmCZ85lXweTEr5X8P8XE6aVYJToa9trT7NiETPqQ8bnUoSFSWzvx7Vo3rRAHR6artDaPT6byVODk+NPjKoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mqtvv0c4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mqtvv0c4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6123vtEa005951;
	Mon, 2 Feb 2026 13:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fASrgzOyfARbw24Q2y82yk3vTE2iI8xLvIQYxObDw
	jQ=; b=Mqtvv0c4HdllrhOJrXoPAewbwZGhzaN4nYV8xiqhCgU0x9VafGv0mZerO
	IxxFfNsnx1Uh7WmdEIVxKnylmbjcn8DgDYhQy+sFEWLInnkbohoAycAnWGB9iM3c
	sB6MZFSodeW+jr1TzNlMNIBjEWTLl2NHH4Qb3DhBjhGLzNHZcAkvxNu9D2owdw9z
	9cE/+NXBIqRkNQSu2pyfl9ucutt6rjxKSTDYIpQ8S3cQSPbmAAQvtTOJhIm6ziLA
	nSHosak8Xb1PNWKweYNI/zKip46MpgxnGue83YOfhHVcdHDS6LoVd3Vz44XS5OXz
	8hYP+4EL4otPVwcMPm/SeGgoQvPLg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt0g0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:27:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6128Zpas029108;
	Mon, 2 Feb 2026 13:27:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2s59dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:27:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 612DRX9d44368202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 13:27:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E51E2004B;
	Mon,  2 Feb 2026 13:27:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E2C920043;
	Mon,  2 Feb 2026 13:27:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Feb 2026 13:27:31 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k bs
Date: Mon,  2 Feb 2026 18:57:30 +0530
Message-ID: <20260202132730.589621-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEwNSBTYWx0ZWRfXxNmQsC8d/A+i
 fb1ptiev+FPlMmHJ15ms5MobcgqoB53CT0GooWqTF3mwzeon6zvXrgYYUeqM7fwFyezSffcrHb7
 CH/EvzaBEYOzF/m41EsjhLCfTTd8Fin5GrFHoC3Inv9dYNIFvze3Tea88mnDM42a8L+snbQqF3c
 xg6fgjPHhG7f2riwPKYeeVNoaAWfh7P1Qjzd/NBdudZhqFvUi73UHJNEeHQgWnub3i333/JMNJJ
 NWTU/oHV4Xkr1H6wN4Sdgt4wJkwuJw7sEhZ0ISvpG+tOglossgRiUW04NbT4GA1a5NCPTlWnw00
 GBJyybfXILm6ih/RY2W8YMPEnKIb7I0ITUSOcANyOjh6HVecwpRE7lTXMOAs5p/5ZV3ALYZ+w24
 sYQhQO+5WQLCFsF9kZ+cL33UwV27nkHMrKByQEI7fIzHvnDsIqL8XwK4ZzeWOtQ2yPnVgVo4BYE
 MKj65oYM8VOszpNxsxQ==
X-Proofpoint-GUID: KwANHXCgUHdlhVyWCjORAErwJ-y2nHhT
X-Proofpoint-ORIG-GUID: KwANHXCgUHdlhVyWCjORAErwJ-y2nHhT
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=6980a64a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=_bD-LUeH2DtTKjRXdH4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602020105

Hard coding donor size to 250M causes the following failure in e4compat

e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
./common/rc: line 4616: 1583182 Aborted                 (core dumped)

The issue is that e4compat asserts that the stat.st_size of all files
combined shouldn't be more than that of the donor file. In case of 64k
blocksize, fsstress often creates sparse files which have >3G size even
though their disk utilization is <100M. Since donor file is not big
enough, this trips e4compat causing the failure.

Fix this by dynamically calculating the donor file size based on the
size of all files. Also, make some changes to avoid future ENOSPC like
reducing the -n passed to fsstress to keep the size around 2G and making
sure we use the whole SCRATCH disk instead of 500M.

While we are at it, add some new lines to make the code bit more
readable.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/307 | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tests/ext4/307 b/tests/ext4/307
index 1f0e42ca..7e7fb9c8 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -12,24 +12,57 @@ _begin_fstest auto ioctl rw defrag prealloc
 # Import common functions.
 . ./common/filter
 . ./common/defrag
+
+# Get the total of stat.st_size of each file to determine the
+# size of donor file. We use st_size here instead of blocks used
+# because thats what e4compat.c checks against.
+get_bytes_used() {
+	local filelist="$1"
+	local total=0
+	local blksz=$(_get_block_size $SCRATCH_MNT)
+
+	while IFS= read -r f; do
+		echo -n "File: $f: " >> $seqres.full
+		[[ -z "$f" ]] && continue
+
+		if [[ -f "$f" ]]; then
+			local bytes
+			bytes=$(stat -c %s "$f")
+			total=$((total + bytes))
+			echo $bytes >> $seqres.full
+		fi
+	done < "$filelist"
+
+	echo "Total bytes: $total" >> $seqres.full
+	echo $total
+}
+
 # Disable all sync operations to get higher load
 FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
 _workout()
 {
+	local blksz=$(_get_block_size $SCRATCH_MNT)
+
 	echo ""
 	echo "Run fsstress"
 	out=$SCRATCH_MNT/fsstress.$$
-	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
+	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
 	echo "fsstress $args" >> $seqres.full
 	_run_fsstress $args
+
 	find $out -type f > $out.list
 	cat $out.list | xargs  md5sum > $out.md5sum
-	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
+
+	bytes=`get_bytes_used $out.list`
+	echo "Total bytes used: $bytes" >> $seqres.full
+
 	echo "Allocate donor file"
-	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
+	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
+
 	echo "Perform compacting"
 	cat $out.list | run_check $here/src/e4compact \
 		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
+
 	echo "Check data"
 	run_check md5sum -c $out.md5sum
 }
@@ -41,7 +74,7 @@ _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
 
-_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
 _workout
-- 
2.52.0

