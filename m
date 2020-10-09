Return-Path: <SRS0=ffIA=DQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F9C433DF
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Oct 2020 11:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B1221FD
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Oct 2020 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7JLacdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgJILmn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Oct 2020 07:42:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388199AbgJILmk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Oct 2020 07:42:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099BW8ui028485;
        Fri, 9 Oct 2020 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kMLVSPn4xnRadIRXdivtn+OA/RIu8JSPt5uJnomORjE=;
 b=e7JLacdmdBx1VmVZGje+dnnhG65FTVea61xK0vCUgG/AQa15EsUDGqs8JBXnyqDaQNAd
 ss3uOfZvUk96T4813CHCHaYeXKoYdC5e5Fw53XgelXFkIgH+k4ordq3QuFriRAT9xL3Q
 6GsgUJAAUd+Gq3dYzf37V1FBhmBr3IxgXALtOuzsvmLyYRamNvvLQ7LsQqODc6RCFwzx
 noVYm4JVjUwAIYeSnzQbMQWdkYPKJ9j2Dh9KSgP1KNXM47EAlTJVPdAadCxS+BppKIAQ
 /YKOLDgbhDEdSXEt9aIhGEQ6/PiQMncyRDNs6jZgH3cFF9QbTkVwrZk3luJmPJfS8Miw Mg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 342pt40v2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 07:42:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099Bfi3d023831;
        Fri, 9 Oct 2020 11:42:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3429hm0m1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 11:42:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099BgVZV26149310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 11:42:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67971A405C;
        Fri,  9 Oct 2020 11:42:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FDACA4060;
        Fri,  9 Oct 2020 11:42:29 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.46.138])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 11:42:29 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        aneesh.kumar@linux.ibm.com, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/1] ext4/046: Add test to verify unwritten extent conversion in buff-io
Date:   Fri,  9 Oct 2020 17:12:24 +0530
Message-Id: <5baabca9c454e09e796a5a97127ca9d73840d8bd.1602243041.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=800 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090079
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There was an issue where with with filesize > 4G, map.m_lblk
was getting overflow in buff-IO path while converting unwritten to
written extent with dioread_nolock mount option with bs < ps.
Adding a testcase for the same.
This test doesn't force any explicit mount option within the test,
as it will be set anyway along with test config, although it does
force for blocksize < pagesize config (as this test is specific to
that). Patch at [1] fixes the issue.

[1]: https://patchwork.ozlabs.org/patch/1378632

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/046     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/046.out |   2 +
 tests/ext4/group   |   1 +
 3 files changed, 104 insertions(+)
 create mode 100755 tests/ext4/046
 create mode 100644 tests/ext4/046.out

diff --git a/tests/ext4/046 b/tests/ext4/046
new file mode 100755
index 000000000000..49de6bbb2c89
--- /dev/null
+++ b/tests/ext4/046
@@ -0,0 +1,101 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test No. generic/046
+#
+# Test writes to falloc file with filesize > 4GB and make sure to verify
+# the file checksum both before and after mount.
+# This test is to check whether unwritten extents gets properly converted
+# to written extent on a filesystem with bs < ps.
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
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "falloc"
+
+# keep 4k as a blksz for 64k pagesz
+pagesz=$(getconf PAGE_SIZE)
+if [ $pagesz -eq 65536 ]; then
+	blksz=4096
+else
+	blksz=$(($pagesz/4))
+fi
+
+devsize=`blockdev --getsize64 $SCRATCH_DEV`
+if [ $devsize -lt 6442450944 ]; then
+	_notrun "Too small scratch device, need at least 6G"
+fi
+
+# Test for bs < ps
+export MKFS_OPTIONS="-F -b $blksz"
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+# check blksz
+real_blksz=$(_get_file_block_size $SCRATCH_MNT)
+test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
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
index 40351fd9ca0c..02a499a9d220 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -48,6 +48,7 @@
 043 auto quick
 044 auto quick
 045 auto dir
+046 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.26.2

