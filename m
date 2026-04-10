Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C132572F
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802983; cv=none; b=EDjCkpgSui+y3nYAv+qdxVECoGFswcZ6r3HclOWiKZSsWxkVSTN2SnpJHM63SCYDxMUtz7jvTcJqICipaLsbMcS/JCR8xzUQ+LI7DgTaViprh3qChAZBpbzotD8DjY/vJvbfnkP1qz5aPjjga648teHCqA7+glKnoVGlQ1JiPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802983; c=relaxed/simple;
	bh=L+HDodcHhyDaeYCuIMIOCIrH/beEB3sx90WXtBHoL5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXUxIhinA+CfDYKPaMc4g6Jt/OVluNLqWSyMUzoIjyLJravYA4A3Q/wlNqlsHh+qROWbWrybxOLbO7eVeM7wKWxprSIif68ypunMuHAUSMNd1xwB6jgH8pRKT1u8JGfyf1vs7RGfoxnHM8+U1R1YFcaivT5LKmgWP4D7gY9HryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdLDgh9W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdLDgh9W"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Hh8aV1449262;
	Fri, 10 Apr 2026 06:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rYfGDJTh24ROvWrDN
	aP1TgyRbTgxhjOmybkrXmXoDf8=; b=rdLDgh9WK9oAiw7W3mgBAwtqhnXs5TqIb
	5gj+vLECBWqGk5NLhghjJSsl8fwrpsxW7Yyl9sJfBzF/B08cfxDaCxrUoezpJSOP
	3wQcoUPtlvEu7+YbgQekzDIUDXb2tvKE46zoKTaXnCaPL40wS6sU8W+CArdrCgQv
	9z0ynr3cIXotz4pm8S98Fx704i5eJ6RuoptVPg818iKaOzowgo2KYwu3H+diyzMJ
	wYC3Omn5Sd3Zf6RQBwYCUSUwgn5hyzSVHV8JgKRgJFch2i1uknzn+IAbjLcadxeb
	UadP3F5uQtv1GI1lFe+NY5miUEp0usDt/Ev+TH3Ynvj2RJXuS7M6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2egp97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2F7S6007892;
	Fri, 10 Apr 2026 06:36:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2pvj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6aBfL55247188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 805952004B;
	Fri, 10 Apr 2026 06:36:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5111820040;
	Fri, 10 Apr 2026 06:36:09 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:09 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 1/6] ext4/061,062: Minor fixes and refactoring
Date: Fri, 10 Apr 2026 12:06:01 +0530
Message-ID: <a8692b9af458ffba24881fabb6ed9342ed4a6d93.1775802601.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775802601.git.ojaswin@linux.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: gmAg1ibutTDCfLeftj8Y7X5dEDyD3xIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX2ZvmXFYMGUia
 y0kasdJhN+Rrvq2zx4d+1gj0YFvYWw4OhatIWVMN5UtXUX2PZ63HK4ga2z2BuNmhHEEf+JQsewl
 A65m62JPz1ilyyQFGFJhG4pFgE1n6Xtg5NEyhf4YPbsQ7tW/OphyrZsA21QvJ3I2S3rB1qklx+H
 6oecfoU2W4EvEGYma1mHfopQ+7fwogFtzNhhxhC5m2xdYFoQICEqlq84b+/g+ZfgKZDv9GKopfR
 m0F+x5PN5UExGcwQ0NFJwxqdR6Tm4FnkvllYTJlAJa22+G7qCuoT6RIEa+ErPl/S+bbKDJUL966
 dWZflitxTCrtIRCGnNlAHkkknm6B1BJAno7UvbYgMiHRp/+jdp58uUd+OsnYMtH8Hs4K8Lw9mJ3
 9U3kXvQQnfWCIRnQwRRWZ43elx6S9tZCq4eWhNw2FOCysXZZ5gPwGXpxN4U3aBJ0lhFuMbcSKWd
 D8LbIHvCkYKD3EhaxUg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d89a60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=EMZg7FHA1AfuhnRrUFkA:9
X-Proofpoint-GUID: eZeRepnd-fBhgkCcKGz5ES74es9OltJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

Fix 2 issues in the tests:

1. Use fs atomic write limits instead of bdev's

The tests use block device's limits instead of limits advertised
by filesystem. This can cause failures because block device might
advertise a higher maximum than the FS.  Fix the tests to use
filesystem's limits instead.

2. Fix the test loop range

Fix the test loop start and end so that our calculations for
blocksize, clustersize and iosize are correct.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/061 | 28 ++++++++++++++++++++--------
 tests/ext4/062 | 26 +++++++++++++++++++-------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/tests/ext4/061 b/tests/ext4/061
index 1d61c8b0..69ddeaca 100755
--- a/tests/ext4/061
+++ b/tests/ext4/061
@@ -31,10 +31,19 @@ _require_aiodio
 FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
 SIZE=$((100*1024*1024))
 
-# Calculate fsblocksize as per bdev atomic write units.
-bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
-bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
-bs=$(_max 4096 "$bdev_awu_min")
+_scratch_mkfs > /dev/null 2>&1 || \
+	_notrun "mkfs failed"
+_try_scratch_mount || \
+	_notrun "mount failed"
+
+touch $SCRATCH_MNT/f
+
+fs_awu_min=$(_get_atomic_write_unit_min $SCRATCH_MNT/f)
+fs_awu_max=$(_get_atomic_write_unit_max $SCRATCH_MNT/f)
+bs=$(_max 4096 "$fs_awu_min")
+ps=$(_get_page_size)
+
+_scratch_unmount
 
 function create_fio_configs()
 {
@@ -97,10 +106,11 @@ run_test_one() {
 	local cs=$2
 	local iosize=$3
 
+	echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
+
 	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
 	_scratch_mkfs_ext4  >> $seqres.full 2>&1 || return
 	if _try_scratch_mount >> $seqres.full 2>&1; then
-		echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
 
 		touch $SCRATCH_MNT/f1
 		create_fio_configs $iosize
@@ -127,7 +137,7 @@ run_test() {
 	# cluster sizes above 16 x blocksize are experimental so avoid them
 	# Also, cap cluster size at 128kb to keep it reasonable for large
 	# blocks size
-	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
+	max_cs=$(_min $((16 * bs)) "$fs_awu_max" $((128 * 1024)))
 
 	# Fuzz for combinations of blocksize, clustersize and
 	# iosize that cover most of the cases
@@ -145,8 +155,10 @@ fio_out=$tmp.fio.out
 create_fio_configs $bs
 _require_fio $fio_aw_config
 
-for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
-	run_test $bs
+echo "Awu min: $fs_awu_min Awu max: $fs_awu_max" >> $seqres.full
+
+for ((bs=$fs_awu_min; bs <= $(_min ps fs_awu_max); bs = $bs << 1)); do
+	run_test $bs $cs $iosize
 done
 
 # success, all done
diff --git a/tests/ext4/062 b/tests/ext4/062
index 05cce696..56bf080c 100755
--- a/tests/ext4/062
+++ b/tests/ext4/062
@@ -33,10 +33,19 @@ _require_aiodio
 FSSIZE=$((360*1024*1024))
 FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
 
-# Calculate bs as per bdev atomic write units.
-bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
-bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
-bs=$(_max 4096 "$bdev_awu_min")
+_scratch_mkfs > /dev/null 2>&1 || \
+	_notrun "mkfs failed"
+_try_scratch_mount || \
+	_notrun "mount failed"
+
+touch $SCRATCH_MNT/f
+
+fs_awu_min=$(_get_atomic_write_unit_min $SCRATCH_MNT/f)
+fs_awu_max=$(_get_atomic_write_unit_max $SCRATCH_MNT/f)
+bs=$(_max 4096 "$fs_awu_min")
+ps=$(_get_page_size)
+
+_scratch_unmount
 
 function create_fio_configs()
 {
@@ -146,10 +155,11 @@ run_test_one() {
 	local cs=$2
 	local iosize=$3
 
+	echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
+
 	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
 	_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || return
 	if _try_scratch_mount >> $seqres.full 2>&1; then
-		echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
 
 		touch $SCRATCH_MNT/f1
 		create_fio_configs $iosize
@@ -175,7 +185,7 @@ run_test() {
 	# cluster sizes above 16 x blocksize are experimental so avoid them
 	# Also, cap cluster size at 128kb to keep it reasonable for large
 	# blocks size
-	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
+	max_cs=$(_min $((16 * bs)) "$fs_awu_max" $((128 * 1024)))
 
 	# Fuzz for combinations of blocksize, clustersize and
 	# iosize that cover most of the cases
@@ -193,7 +203,9 @@ fio_out=$tmp.fio.out
 create_fio_configs $bs
 _require_fio $fio_aw_config
 
-for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
+echo "Awu min: $fs_awu_min Awu max: $fs_awu_max" >> $seqres.full
+
+for ((bs=$fs_awu_min; bs <= $(_min ps fs_awu_max); bs = $bs << 1)); do
 	run_test $bs $cs $iosize
 done
 
-- 
2.53.0

