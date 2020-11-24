Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C23C63777
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Nov 2020 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828B72076E
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Nov 2020 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fDvpss/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgKXIhn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Nov 2020 03:37:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730517AbgKXIhm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Nov 2020 03:37:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AO8WuqT084178;
        Tue, 24 Nov 2020 03:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oaYejTJTvjVZ/b/El+q9ijAJiyr169LNIdWHN+qsbqM=;
 b=fDvpss/I/MAlTaoHfzSgDYgsk5LP5FTDoJHpvjg+k4TtI8E46VVy3d2pHkr0b5bs8QUh
 wGhVmzN1N9SKGxoEOb/N4lBkFJMWzPa9EXIadI3IjgSZ/W59d7/VjGJ0OVAJ+R6NJiLp
 fJwIKQwTpmAVA5f72mzCZGgziEnBiEDoLC1U6Jg0L+DUKrjOCGcbPcag2AHqiNFTk9lr
 3xMgjMy7myu1MaoMUY6FUl2hHWunJ1OvTFgUZpp702mJEKEPXST9qg9oVOl8BYizKMWM
 XCV2oeW5fdHjy7VGFW3mlFDXkoUNkhvFqUdDVYGx1hsp0G/fqJ0uYC2cdbo1VVUZSGgi 8g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350rb0u9ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 03:37:41 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AO8S6RR000356;
        Tue, 24 Nov 2020 08:37:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8bcc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 08:37:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AO8ba5p42336748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 08:37:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3974A4040;
        Tue, 24 Nov 2020 08:37:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B26DFA4059;
        Tue, 24 Nov 2020 08:37:35 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.51.32])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Nov 2020 08:37:35 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, anju@linux.vnet.ibm.com
Subject: [PATCH] generic/031: Modify fcollapse arguments to work on non-4k block sized fs instances
Date:   Tue, 24 Nov 2020 14:07:33 +0530
Message-Id: <20201124083733.1795978-1-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_03:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240048
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This write vs fcollapse test does a sequence of operations to create a
page which has non-contiguous mix of dirty and clean blocks. But when
running the test with 64k block size, fallocate returns with EINVAL
error, as the offset and length parameters for fcollapse are not
multiples of fs blocksize.

Modify the offset and length arguments for fcollapse in the test, to run
the test with non-4k block sized fs instances also.

Without the patch:
-------------------
# ./check generic/031
SECTION       -- ext4_test
FSTYP         -- ext4
PLATFORM      -- Linux/ppc64le localhost_ubuntu 4.15.0-15-generic
MKFS_OPTIONS  -- -b 65536 /dev/loop5
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop5 /mnt2/scratch

     QA output created by 031
    +fallocate: Invalid argument
    +fallocate: Invalid argument
     wrote 55756/55756 bytes at offset 185332
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     wrote 63394/63394 bytes at offset 133228
    ...

(Note: Same failure observed for xfs also)

With the patch:
----------------- 
v# ./check generic/031
SECTION       -- ext4_test
FSTYP         -- ext4
PLATFORM      -- Linux/ppc64le localhost_ubuntu 4.15.0-15-generic #
MKFS_OPTIONS  -- -b 65536 /dev/loop5
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop5 /mnt2/scratch

generic/031 2s ...  2s
Ran: generic/031
Passed all 1 tests

SECTION       -- ext4_test
=========================
Ran: generic/031
Passed all 1 tests

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com> 
---
 tests/generic/031     |  6 +++---
 tests/generic/031.out | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/generic/031 b/tests/generic/031
index db84031b..2b253c3c 100755
--- a/tests/generic/031
+++ b/tests/generic/031
@@ -41,9 +41,9 @@ _scratch_mount
 
 $XFS_IO_PROG -f \
 	-c "pwrite 185332 55756" \
-	-c "fcollapse 28672 40960" \
-	-c "pwrite 133228 63394" \
-	-c "fcollapse 0 4096" \
+	-c "fcollapse 65536 65536" \
+	-c "pwrite 67692 63394" \
+	-c "fcollapse 0 65536" \
 $testfile | _filter_xfs_io
 
 echo "==== Pre-Remount ==="
diff --git a/tests/generic/031.out b/tests/generic/031.out
index 194bfa45..b096694f 100644
--- a/tests/generic/031.out
+++ b/tests/generic/031.out
@@ -1,19 +1,19 @@
 QA output created by 031
 wrote 55756/55756 bytes at offset 185332
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 63394/63394 bytes at offset 133228
+wrote 63394/63394 bytes at offset 67692
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Pre-Remount ===
 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
-0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
-0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+00000860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+00000870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
 *
-0002fdc0
+0001adc0
 ==== Post-Remount ==
 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
-0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
-0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+00000860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+00000870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
 *
-0002fdc0
+0001adc0
-- 
2.15.1

