Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF99CC49EA7
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B3961C17
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhF1Ize (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:55:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232282AbhF1Ize (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 04:55:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8Ym3g003114
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wZva2NHUmR0fD3rkD2bGLIrcCgUScbeeYIySC+dKnOs=;
 b=em8/Jsl3ngJfWbGDuh1M/RVhS7KoyApSbki8eccZRSc9jz/aeZL/4FigIJKg1HOH1TTA
 HxYPjkNUcjDNR5z7Bcmv51xkvecJEBMcmbYH9AyZQIDnmVgbSSnrPcXo8otZm2mq3KVW
 CKR3hMRT/TM25qZjz/vMeY73kgl6sLl9A8G1JrQ6H5qSVXTWc0honXny8mJz8t6TOrrq
 i4QNXjyzv5L4RwMoBlds4SPeWJaoQLBc6HeLQHqfdJHWj2k8qFyDUQsYoyXWbQyNvVX0
 xwoZ3BkYbhMG4MHsmxMzFv6HD3/NFw2CR4lqxDEHCT4dcjB+QKR2oWoJmytTGg/ykNFI 5w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39farh0v1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S8q2ZQ011390
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 39dughgpdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S8r48230998934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:53:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7381F4C082;
        Mon, 28 Jun 2021 08:53:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB3594C0EA;
        Mon, 28 Jun 2021 08:53:03 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.77.195.70])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 08:53:03 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 1/3] xfs/504: Add scratch_mount before checking for xfs_scrub unicode support.
Date:   Mon, 28 Jun 2021 14:22:57 +0530
Message-Id: <20210628085259.120666-2-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hvpWhBfuxfRGfDEozjpu1Jwl9cjq8UC7
X-Proofpoint-GUID: hvpWhBfuxfRGfDEozjpu1Jwl9cjq8UC7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280059
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We may not detect the error `Inappropriate ioctl for device`, while running
`$XFS_IO_PROG -c "scrub probe" "$mountpoint"`, if scratch device is not
mounted before invoking _check_xfs_scrub_does_unicode(). So do
_scratch_mount before checking for xfs_scrub support.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 tests/xfs/504 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/xfs/504 b/tests/xfs/504
index 40318314..291ee4e4 100755
--- a/tests/xfs/504
+++ b/tests/xfs/504
@@ -21,8 +21,11 @@ _require_xfs_io_command 'label'
 
 echo "Silence is golden."
 
+_scratch_mkfs > /dev/null
+_scratch_mount
 want_scrub=
 _check_xfs_scrub_does_unicode "$SCRATCH_MNT" "$SCRATCH_DEV" && want_scrub=yes
+_scratch_unmount
 
 filter_scrub() {
 	grep 'Unicode' | sed -e 's/^.*Duplicate/Duplicate/g'
-- 
2.31.1

