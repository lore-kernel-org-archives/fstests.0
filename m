Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA3277CAD
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939182; cv=none; b=cG7GzLHVtLSJTzr7VXr/82H0Ebhq+qWRZmbx8j1wK9zqu/A09utsAJFCRBjff9bBSS1oAW/zK1JDoWgg8smXXppXMZqSzfQVm+5M8KbeRIzMW1w6tqAl9pI95mqQ4vR6g3w1ZPs0mtz6n/YHrwjItWKb3dbBjoZ3UOr9rqj4SeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939182; c=relaxed/simple;
	bh=WqXXipFPQ1tVUxnA3odb4wEvTzAaPB/Apy2RQvWokIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBVX3j3Gc1APmc2NrP2vvBzPOQp7Su1RWj0chE1eBzwC9Czz8TDIdHCTzjpk1s64RrYNKI9Zd6iK56cHs6DVJ1MzHBe2UnqRLn9xS89EWXaECrTVcB8uvjzN82Uz3mTpyVE2KJBqvd7gqY8tT4hqkNNqI6mLC/mLdOJClB7CPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s7E+np/6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s7E+np/6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AorU019612;
	Thu, 26 Jun 2025 11:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZRdoJ9TTuDQV9ijiB
	aHQiZbirmNkt1nR1KInfMDU9Ag=; b=s7E+np/6HDm6WS130CCutTjol/9lyVG3Y
	43lugzGUViReP0pydPj4B9VBl3kUFm0Xp1p6O76b6iCClWOmLWFlB81+rR0eAaPE
	7JYLfz8QsQQjjEwgpz9xtXVqPci54PEPhgwjTE6Ds4WK1Zikwa4W8LWUsYlkpVpB
	5uOEpgRCQKXgbQVyTMa/bbk6bB2HwwsPLxmJZR366371Eyo451vh7hDe6wyKb1b9
	xW2qKgLWVqPu8I12yCZWfiAq8wVMXYxhXs4PFGxfIApau3UN5KJ8RS6HCNqajnsM
	ktDAu9hvfdm0KLiXZm8vVv2UV6hswK4GTk75+VvG+nrJyOD/QuNew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3dtda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBxWVf001446;
	Thu, 26 Jun 2025 11:59:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3dtd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q82wrp015033;
	Thu, 26 Jun 2025 11:59:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72txwuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxUki53346730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 038012004E;
	Thu, 26 Jun 2025 11:59:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72AE120040;
	Thu, 26 Jun 2025 11:59:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 12/13] ext4/063: Atomic write test for extent split across leaf nodes
Date: Thu, 26 Jun 2025 17:29:03 +0530
Message-ID: <8c4ae5d71e64da3781e9deb53966352dfcd4df0d.1750924903.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685d3625 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=BtNrGSYHu5IGmLxdGZgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX78Nc36gqyhor ++zKmEcX5t8bEZEhyvjRWj4PMpr0qKRzRQbQKXooA6Wy5LO9eVJEcpV4Fsk8G9epQUdhLFaQF6S Bvucsf+UF5IgmK8tM4o2lZ7umqMOYrsQuD18SLII+Ieiaph0SAZEalXTrpPDGQoWQaKTlmF8QJg
 MP7XLPJWvYSY/BEMeUjQyXH72jCSzoJ5/na0GgmQg17sA8k/iq0AR7y2V4P35ZkYIoCA74mO8Ew i6X3eyps0gLcQSHEnwUnQPajCP5ZzDlPDNpqEPuj0qQ5IgQfSE9MyoS3wuMRIjMwv9AYvAX/diq T8OMe4Ynx1zDgjNzwBIqJPDnqsqeiZ/9QJ7EW/WSVdap15N22TJuy3mUF9EAD6MeCwQY+lSEVIB
 dURcj36YsUzcgOZ5qPvW8Rh4YgD87hjHweqA9a1hjmr9BNr3BBLh9cGG/ja9RVrMPvwdjBHy
X-Proofpoint-GUID: b-2tXDZIKi6EiQEMQ32FeUcGB9WkE8G1
X-Proofpoint-ORIG-GUID: RBgSfc2LfIstuG96FwsPpXnFaT5jm3eS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

In ext4, even if an allocated range is physically and logically
contiguous, it can still be split into 2 extents. This is because ext4
does not merge extents across leaf nodes. This is an issue for atomic
writes since even for a continuous extent the map block could (in rare
cases) return a shorter map, hence tearning the write. This test creates
such a file and ensures that the atomic write handles this case
correctly

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/063     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/063.out |   2 +
 2 files changed, 127 insertions(+)
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out

diff --git a/tests/ext4/063 b/tests/ext4/063
new file mode 100755
index 00000000..25b5693d
--- /dev/null
+++ b/tests/ext4/063
@@ -0,0 +1,125 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# In ext4, even if an allocated range is physically and logically contiguous,
+# it can still be split into 2 extents. This is because ext4 does not merge
+# extents across leaf nodes. This is an issue for atomic writes since even for
+# a continuous extent the map block could (in rare cases) return a shorter map,
+# hence tearning the write. This test creates such a file and ensures that the
+# atomic write handles this case correctly
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+_require_command "$DEBUGFS_PROG" debugfs
+
+prep() {
+	local bs=`_get_block_size $SCRATCH_MNT`
+	local ex_hdr_bytes=12
+	local ex_entry_bytes=12
+	local entries_per_blk=$(( (bs - ex_hdr_bytes) / ex_entry_bytes ))
+
+	# fill the extent tree leaf which bs len extents at alternate offsets. For example,
+	# for 4k bs the tree should look as follows
+	#
+	#                  +---------+---------+
+	#                  | index 1 | index 2 |
+	#                  +-----+---+-----+---+
+	#               +--------+         +-------+
+	#               |                          |
+	#    +----------+--------------+     +-----+-----+
+	#    | ex 1 | ex 2 |... | ex n |     |  ex n + 1 |
+	#    +-------------------------+     +-----------+
+	#    0      2            680          682
+	for i in $(seq 0 $entries_per_blk)
+	do
+		$XFS_IO_PROG -fc "pwrite -b $bs $((i * 2 * bs)) $bs" $testfile > /dev/null
+	done
+	sync $testfile
+
+	echo >> $seqres.full
+	echo "Create file with extents spanning 2 leaves. Extents:">> $seqres.full
+	echo "...">> $seqres.full
+	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
+
+	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1). Since
+	# this is a new FS the allocator would find continuous blocks such that
+	# ex(n) ex(new) ex(n+1) are physically(and logically) contiguous. However,
+	# since we dont merge extents across leaf we will end up with a tree as:
+	#
+	#                  +---------+---------+
+	#                  | index 1 | index 2 |
+	#                  +-----+---+-----+---+
+	#               +--------+         +-------+
+	#               |                          |
+	#    +----------+--------------+     +-----+-----+
+	#    | ex 1 | ex 2 |... | ex n |     | ex merged |
+	#    +-------------------------+     +-----------+
+	#    0      2            680          681  682  684
+	#
+	echo >> $seqres.full
+	torn_ex_offset=$((((entries_per_blk * 2) - 1) * bs))
+	$XFS_IO_PROG -c "pwrite $torn_ex_offset $bs" $testfile >> /dev/null
+	sync $testfile
+
+	echo >> $seqres.full
+	echo "Perform 1 block write at $torn_ex_offset to create torn extent. Extents:">> $seqres.full
+	echo "...">> $seqres.full
+	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
+
+	_scratch_cycle_mount
+}
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+awu_max=$(_get_atomic_write_unit_max $testfile)
+
+echo >> $seqres.full
+echo "# Prepping the file" >> $seqres.full
+prep
+
+torn_aw_offset=$((torn_ex_offset - (torn_ex_offset % awu_max)))
+
+echo >> $seqres.full
+echo "# Performing atomic IO on the torn extent range. Command: " >> $seqres.full
+echo $XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
+$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
+
+echo >> $seqres.full
+echo "Extent state after atomic write:">> $seqres.full
+echo "...">> $seqres.full
+$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
+
+echo >> $seqres.full
+echo "# Checking data integrity" >> $seqres.full
+
+# create a dummy file with expected data
+$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp >> /dev/null
+expected_data=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp)
+
+# We ensure that the data after atomic writes should match the expected data
+actual_data=$(od -An -t x1 -j $torn_aw_offset -N $awu_max $testfile)
+if [[ "$actual_data" != "$expected_data" ]]
+then
+	echo "Checksum match failed at off: $torn_aw_offset size: $awu_max"
+	echo
+	echo "Expected: "
+	echo "$expected_data"
+	echo
+	echo "Actual contents: "
+	echo "$actual_data"
+
+	_fail
+fi
+
+echo -n "Data verification at offset $torn_aw_offset suceeded!" >> $seqres.full
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/063.out b/tests/ext4/063.out
new file mode 100644
index 00000000..de35fc52
--- /dev/null
+++ b/tests/ext4/063.out
@@ -0,0 +1,2 @@
+QA output created by 063
+Silence is golden
-- 
2.49.0

