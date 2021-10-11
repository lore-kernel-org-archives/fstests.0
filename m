Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0002C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8855160EFE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhJKH6F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:58:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234713AbhJKH6E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 03:58:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B5fgEq021849
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wUDswhOVAFUyb941kjzi8aq6fvU3ASAsgkCffk41MQw=;
 b=VT/MNKZsHBE7/eRRwkp3/8ihWVoDOkm2fRfaIrwPlwb2TfbYB0j6ESf1ss7afR1u+YEz
 7f8dBjl+XxErBqQWc5A8TPlvZJMQ1NLITicI3Q/U+h1G0AvIWWO7fXS74/N06cXyP4K0
 cXwHywkIqB5zcRnXsN6QWt3wR+6IWHlc+QYfFR1ui97w5khWJdfMPxmnoiz3lwZaPtq1
 VPPWHQnRREOMjjVnx6WTmyBlV5MzVwERIWzc2chS2MdR/igplzlUzwjA61cwrZQSJJ2G
 AbsWHjqwIwySr7gGa4e7RPk3+dAakWhL1qD1TWh3byL/3WrDe6rFJWSO2MpRamKsPtF0 mw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmfbfafmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19B7rIsG016618
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q93agt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19B7twXW65012044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 07:55:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE638A4068;
        Mon, 11 Oct 2021 07:55:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0BFA4054;
        Mon, 11 Oct 2021 07:55:56 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.43.35.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 07:55:56 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 1/4] xfs/432: Skip this test for dax config and pagesize not equal to the specified block size
Date:   Mon, 11 Oct 2021 13:25:49 +0530
Message-Id: <20211011075552.196688-2-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SC6-zICaCMAPFnCo5FHASNroFe-abHPm
X-Proofpoint-ORIG-GUID: SC6-zICaCMAPFnCo5FHASNroFe-abHPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110043
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test case passes 1k as the block size(to keep that as minimum),
and hence it fails to mount with "-o dax" option on platforms where
pageszie not equal to the specified block size. This leads to test
case reported as "failed" with dax config.

So skip this test when dax is enabled.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 tests/xfs/432 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/xfs/432 b/tests/xfs/432
index 40cb2474..9022af69 100755
--- a/tests/xfs/432
+++ b/tests/xfs/432
@@ -32,6 +32,10 @@ _require_scratch
 
 rm -f "$seqres.full"
 
+# Skip this test, if pagesize !=1k and dax is enabled.
+if [[ $(get_page_size) -ne 1024 ]]; then
+	_exclude_scratch_mount_option dax
+fi
 echo "Format and mount"
 # We need to create a directory with a huuuge extent record.  Normally
 # a rapidly expanding directory gets its blocks allocated in lockstep --
-- 
2.24.1

