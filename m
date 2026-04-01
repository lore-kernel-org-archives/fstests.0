Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52539FCCF
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040062; cv=none; b=EcziLMLUFO5VQV4AbVkKAKBxLS80navLe1AByMKAFhe6mvl7zJIP5geDQsXR8Wk/8Za1Gde/qXANY/zsKfJf9tt+Ek+Nrwv1+hSkanHYCbKIaVD98ty1eI3spavJDa1k+yXk/i0kZ8y0STYLMVQ9Z7RuT7A3gDPnjjrg85wcYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040062; c=relaxed/simple;
	bh=7AIYSNtfncv+9zDaJHnwpyAvbsr+jR9YRknLhHC0vVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAamPxQqY3bfxa9pps7iNLc0w6aWDNb052fwLd3nqrU50kGZ4bxNv/1Bfe4hfEM3Eh/PsiqGGM3NiyCL/kstoPBH5KlVFfBJkLaV1y82JwLo08jK/00mKaajSReQv0mm+Pd3D4LQtMSd/HjCIZVRYRZzevwS9NAodNQDfCAMcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SP97+MN+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SP97+MN+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318ZLBF3518860;
	Wed, 1 Apr 2026 10:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=f6EMTlS7BI64BVQlW+89HjWFJXSoC8Bhwe5HjKBE4
	UE=; b=SP97+MN+rwwk4YF8oNuxAKCvtf9rnHHWW9Y573E9Nb2oeQvhX/9hiUSJi
	JvjsNKxsBBcwT6+3r/m21qyQRM7/xR8VStnutVJrOWeQQTz1NLQSQ98WOBOYAVQF
	TNwSyXAw8Midlno6fgJERJ+JS2d1AIuIsX5oepKYeBEoA06K8L2lR35RbKR2MsJx
	SnZnHxuwW19CPNUtiNfJqwHUzfgj0/OJX0ldxAfdisZnTb9TuAnipWPi1bz6HlsN
	mREYtWA2OH5gvRwWfmzxZNA5NaEFIwdps7MdrlBnEXOI3VbKuglbYerzUY+KIH3Y
	VHbDU171LFNecP9+QqmFDlYHtnCfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q37mxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:40:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6317KdhZ030995;
	Wed, 1 Apr 2026 10:40:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjw07t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:40:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631AeqPd52167070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:40:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDEE220043;
	Wed,  1 Apr 2026 10:40:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF5820040;
	Wed,  1 Apr 2026 10:40:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:40:51 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 1/4] ext4/061,062: Minor fixes and refactoring
Date: Wed,  1 Apr 2026 16:10:47 +0530
Message-ID: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NC4VuBE3uCCL1C4DHNXbx0v-qesF22NI
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ccf639 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EMZg7FHA1AfuhnRrUFkA:9
X-Proofpoint-ORIG-GUID: NC4VuBE3uCCL1C4DHNXbx0v-qesF22NI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfX48DTSpEZzPN+
 HMkZg3eJAXHNb2pIftltLKSNod2w6Pfg5JxrTfoWk9VkiYazau1LsuYo6aQWPRzUk4XXSs7P50D
 0vQf1NXKtURZzTlkRRmul1dhvIDyF//Gj6KSK5JACUelhtmCOZ4oZOuBcunmoLOEX6LxAipYFxf
 nw1hRv06wLxyMkXkcWp9PBsR0bm4hRtcjz0CYd9LaeECENmq4NYvi/ssWv7xOIcmctuH3+TdgoC
 xmeXutu9c2hSE+ZkLTVb+ICbYt+1cgnUroMbVJfPtFFbzPJV+kSNMr3qlITlFzIt/ssCXNtwJWC
 qZBbph8ycqxZtve2a6HVMeYSyNBNYZFqVJSo7Uxe74LfYO0bc0Hj1vlEJmY1O9eYG161h3mJztB
 ZWQ6ApLMscocAj2cyNAobzlQ8eahYhaMMp5R2SKd3gX/81pOZZ+KjavF7OgpFMA6j0cdZmISYrU
 jv0E2UJo5eZxmrh2rJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010094

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

