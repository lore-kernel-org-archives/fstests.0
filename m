Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7BC5479D
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAKRxf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjAKRx0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 12:53:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9AE13E01
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 09:53:25 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BHLXoY008106;
        Wed, 11 Jan 2023 17:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9n79trDeFwoTLvpqQbyIi9dj08Tb7P1i7Nil7yXyVag=;
 b=PDOdpQuwbA/6rjDnXOZ8jmS4oo4D2acB1ngM1agviG1rX6m2H2cETydjjFTHGu3MYA4R
 DP7PipS+dFrU4m6ql4BMLV2cFKmYA0ci35pBVKIrwgLhll/2X1+pKhJ3jbMvdukxcCLg
 G9bOBgmqmYNK++E9a0NC+iUcgZFzij1Tm6CazSig9neEJRERNZTzCsY0YPZ9+zVHmixo
 AztqMuWLXq+8k6eWiQx/aaKgIwUsZGEGTGJpl+TfBhwjYzkqIHQPMnGs4YXCObxxTmMp
 emQ0vhQzzF8qF0e5CBaNHeqOVPiRGEwnX7JlZrJvwamKh9CRZ8R7xBS6t7aWZ+5awosR HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n21ep8pg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 17:53:23 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30BHMUxM015496;
        Wed, 11 Jan 2023 17:53:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n21ep8pfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 17:53:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30BDAjrL025782;
        Wed, 11 Jan 2023 17:53:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n1kv7s7uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 17:53:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30BHrHK851773910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 17:53:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A770F20040;
        Wed, 11 Jan 2023 17:53:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A12DF20043;
        Wed, 11 Jan 2023 17:53:16 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.27.69])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jan 2023 17:53:16 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/692: Generalize the test for non-4k merkle tree block sizes
Date:   Wed, 11 Jan 2023 23:23:14 +0530
Message-Id: <20230111175314.73346-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xNXXVnBTmOnDLsheSW7DuQKA0JyIALza
X-Proofpoint-GUID: uNqAudOcVZXF3vv4ouUSr1DCazfP1Yqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=961 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110128
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Due to the assumtion of Merkle tree block size being 4k, the size calculated
for second test was taking way too long to hit EFBIG in case of bigger block
sizes like 64k. Fix this by genralizing the calculation.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/692 | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/generic/692 b/tests/generic/692
index d6da734b..0a354802 100755
--- a/tests/generic/692
+++ b/tests/generic/692
@@ -54,15 +54,24 @@ _fsv_enable $fsv_file |& _filter_scratch
 # (MAX) to be in the middle of L0 -- ideally near the beginning of L0 so that we
 # don't have to write many blocks before getting an error.
 #
-# With SHA-256 and 4K blocks, there are 128 hashes per block.  Thus, ignoring
-# padding, L0 is 1/128 of the file size while the other levels in total are
-# 1/128**2 + 1/128**3 + 1/128**4 + ... = 1/16256 of the file size.  So still
+# For example, with SHA-256 and 4K blocks, there are 128 hashes per block. Thus,
+# ignoring padding, L0 is 1/128 of the file size while the other levels in total
+# are 1/128**2 + 1/128**3 + 1/128**4 + ... = 1/16256 of the file size. So still
 # ignoring padding, for L0 start exactly at MAX, the file size must be s such
-# that s + s/16256 = MAX, i.e. s = MAX * (16256/16257).  Then to get a file size
+# that s + s/16256 = MAX, i.e. s = MAX * (16256/16257). Then to get a file size
 # where MAX occurs *near* the start of L0 rather than *at* the start, we can
 # just subtract an overestimate of the padding: 64K after the file contents,
-# then 4K per level, where the consideration of 8 levels is sufficient.
-sz=$(echo "scale=20; $max_sz * (16256/16257) - 65536 - 4096*8" | $BC -q | cut -d. -f1)
+# then 4K per level, where the consideration of 8 levels is sufficient. Below
+# code generalizes this logic for all merkle tree sizes.
+bs=$FSV_BLOCK_SIZE
+hash_size=32   # SHA-256
+hash_per_block=$(echo "scale=20; $bs/($hash_size)" | $BC -q)
+a=$(echo "scale=20; 1/($hash_per_block^2)" | $BC -q)
+r=$(echo "scale=20; 1/$hash_per_block" | $BC -q)
+treesize_without_l1=$(echo "scale=20; $a/(1-$r)" | $BC -q)
+sz=$(echo "scale=20; $max_sz/(1+$treesize_without_l1)" | $BC -q)
+# adjust $sz so we are more likely to hit EFBIG while building level 1
+sz=$(echo "scale=20; $sz - 65536 - $bs*8" | $BC -q | cut -d. -f1)
 _fsv_scratch_begin_subtest "still too big: fail on first invalid merkle block"
 truncate -s $sz $fsv_file
 _fsv_enable $fsv_file |& _filter_scratch
-- 
2.31.1

