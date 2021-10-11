Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3750C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA54C60EDF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhJKH6M (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:58:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234720AbhJKH6M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 03:58:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B6Clmw029169
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=C/Z6RHICHT6pPiKNSaaRbrHVBpjNw2K54vUpjA9O7sw=;
 b=Uu+XtFphXWyDYh5UO1wbqtw0c6a86d8kT8Kh9UlNnvSiPBl2cNIot/iMFB5wu9YAcoXX
 /sgUg0Vme1wkGetxzD0a/6fjKHrbCo1Jc9nuJP2AD848o85jDu7K0rAsSS2t6IugU0QV
 YbXzeEMTilH7UR0NaL2pn4yKsx3EkDMMHyIPvNHXYroT80xqhV8bEznUK9JTtX/+al4o
 SPFu8RqhzFulymPFfTjyWQKb9otZlQYuGMHWwI07DIDCmo8awrt+3y7RUcdH14n83XlU
 btRqeJwsfa3bIdoCOKS8GCYfE7CFS+vlSkO+7XN+/eFsrDPk14cJHaZ6tYJEbAyWyJTn Gw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmfsu1wtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19B7qkCj019316
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2q9a9qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19B7u5en39387568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 07:56:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7270A4062;
        Mon, 11 Oct 2021 07:56:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 534CCA4068;
        Mon, 11 Oct 2021 07:56:04 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.43.35.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 07:56:03 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 4/4] generic/219: Fix test failure on 64k block size
Date:   Mon, 11 Oct 2021 13:25:52 +0530
Message-Id: <20211011075552.196688-5-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j91UgJS-bkMAYsLKsvajrHsRbFrOcFSH
X-Proofpoint-ORIG-GUID: j91UgJS-bkMAYsLKsvajrHsRbFrOcFSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=924 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110043
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Skip this test on 64k, as 4k as taken as the default block size.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
But I have a Query:
This test fails on ext4&xfs with 64k block size. Do we need to
rephrase this test to incorporate the 64k bs scenario as well?
If not we can skip this test.

 tests/generic/219 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/219 b/tests/generic/219
index d3d257f1..d38fd033 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -79,6 +79,11 @@ test_accounting()
 
 # real QA test starts here
 
+# Skip this test on 64k block size scenario
+bsize=$(_get_block_size $SCRATCH_MNT)
+if [ $bsize -ge 4096 ];then
+	_notrun "Test assumes 4k as the default block size"
+fi
 _scratch_unmount 2>/dev/null
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
-- 
2.24.1

