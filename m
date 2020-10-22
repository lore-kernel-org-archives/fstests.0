Return-Path: <SRS0=0eua=D5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE0DC388F2
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Oct 2020 12:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E92223BF
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Oct 2020 12:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OduVbq1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898001AbgJVMQu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Oct 2020 08:16:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2898000AbgJVMQu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Oct 2020 08:16:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MCAlNR067435;
        Thu, 22 Oct 2020 08:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=q9Pvc3QCiuxx8fHnxoAhn5RLk8n4ipW4vbOVALG1wgY=;
 b=OduVbq1/8VfTz/PbVr2bYMJMYDIhka4NSn/o1evmN+pfjtm/rSRXZnHBZyxWTTnQhia+
 WPJy1e4n40rw3XxR5zi85IjcVHz/jATfNUdSQvqc39Q4lQblhelTuI0eoVUOJY4mE/Lg
 J/GmBIrORDA8Iqw6Lra4oquSQeF6BQgefnCNsikITYZsoHk5G02WxAHWN2C5ZE+awslE
 5k/g7oxTY/uPLgnlmALdzDzTWNbQjoc7NsqkkO0oUh1YJVOrRjU/n0xE5WLL7BNxQOHk
 qm2RwEQni0Pfq2LX6JPYbZ2L6LzFCLDRkqNqKOPhYpR4EP3kb9DW2azDhoSONJC949rc fg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34b0wnpb2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 08:16:41 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MCD6ep004599;
        Thu, 22 Oct 2020 12:16:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 347r882t9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 12:16:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09MCGas620906316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 12:16:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8AC4AE055;
        Thu, 22 Oct 2020 12:16:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEFD9AE045;
        Thu, 22 Oct 2020 12:16:34 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.40.6])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Oct 2020 12:16:34 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        aneesh.kumar@linux.ibm.com, guan@eryu.me,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/1] ext4/046: Add test to verify unwritten extent conversion in buff-io
Date:   Thu, 22 Oct 2020 17:46:32 +0530
Message-Id: <be872186537a7272bb8b6d215786a25d64b43791.1603368465.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_06:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=821 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220085
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There was an issue where with filesize > 4G, map.m_lblk
was getting overflow in buff-IO path while converting unwritten to
written extent with dioread_nolock mount option with bs < ps.

Adding a testcase to test for such regressions with dioread_nolock
mount option. To reproduce the same regression w/o the fix
in the kernel, test with bs < ps config.
Patch at [1] fixes the issue in linux.

[1]: https://patchwork.ozlabs.org/patch/1378632

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v1 -> v2:-
Addressed review comments from Eryu. 

 tests/ext4/046     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/046.out |  2 ++
 tests/ext4/group   |  1 +
 3 files changed, 89 insertions(+)
 create mode 100755 tests/ext4/046
 create mode 100644 tests/ext4/046.out

diff --git a/tests/ext4/046 b/tests/ext4/046
new file mode 100755
index 000000000000..a66a301af5ba
--- /dev/null
+++ b/tests/ext4/046
@@ -0,0 +1,86 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test No. ext4/046
+#
+# Test writes to falloc file with filesize > 4GB and make sure to verify
+# the file checksum both before and after mount.
+# This test is to check whether unwritten extents gets properly converted
+# to written extent on a filesystem with bs < ps with dioread_nolock.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_scratch
+_require_xfs_io_command "falloc"
+_require_scratch_size $((6 * 1024 * 1024)) #kB
+
+# Test for bs < ps
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount "-o dioread_nolock" >> $seqres.full 2>&1
+
+# Get blksz
+blksz=$(_get_file_block_size $SCRATCH_MNT)
+
+testfile=$SCRATCH_MNT/testfile-$seq
+
+# Fallocate testfile with size > 4G
+fsize=$((5 * 1024 * 1024 * 1024))
+$XFS_IO_PROG -f -c "falloc 0 $fsize" $testfile >> $seqres.full 2>&1
+
+# First write at offset < 4G (at few alternative blks)
+off=$((3 * 1024 * 1024 * 1024))
+for i in 1 2 3 4; do
+	$XFS_IO_PROG -f \
+		-c "pwrite $off $blksz" \
+		$testfile >> $seqres.full 2>&1
+	off=$(($off + (2*$blksz)))
+done
+
+# Then write at offset > 4G (at few alternative blks) to check
+# any 32bit overflow case in map.m_lblk
+off=$((4 * 1024 * 1024 * 1024))
+for i in 1 2 3 4; do
+	$XFS_IO_PROG -f \
+		-c "pwrite $off $blksz" \
+		$testfile >> $seqres.full 2>&1
+	off=$(($off + (2*$blksz)))
+done
+
+# ==== Pre-Remount ===
+md5_pre=`md5sum $testfile | cut -d' ' -f1`
+echo "Pre-Remount md5sum of $testfile = $md5_pre" >> $seqres.full
+
+_scratch_cycle_mount
+
+# ==== Post-Remount ===
+md5_post=`md5sum $testfile | cut -d' ' -f1`
+echo "Post-Remount md5sum of $testfile = $md5_post" >> $seqres.full
+test $md5_pre != $md5_post && echo "md5sum mismatch"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/046.out b/tests/ext4/046.out
new file mode 100644
index 000000000000..52c445eb70bb
--- /dev/null
+++ b/tests/ext4/046.out
@@ -0,0 +1,2 @@
+QA output created by 046
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index 40351fd9ca0c..70c0bca64cb8 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -48,6 +48,7 @@
 043 auto quick
 044 auto quick
 045 auto dir
+046 auto prealloc quick
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.26.2

