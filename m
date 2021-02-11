Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB35C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6D764EBB
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhBKDcn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:32:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229477AbhBKDcm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 22:32:42 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11B3MxBh038245;
        Wed, 10 Feb 2021 22:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8LI77rzrP64jLLw5InOpSliq4YITNjGD8Q+F+kBfsUA=;
 b=ngOSoL4fq5DNzkOKVTTzWuOckHVz/QNNP1O+cS+hMRHjKa2eqcmBQ0EazY6etyoRAZJL
 v5TYYUFj7r6ZHLzj9j7ad8iWre/+898q3lKoUOazi1O/MGw77w67FlJ7qVImPWDEKYct
 iM1B9diOPaYZcdPaw1GWS7ddF0+sSLy6J6ohqCIhjJsTiilUf+EzVFu1zjvqgrcWi6Jn
 v6RsAirThuL/me4ECklDYVoNDt4RU6G3WYniDIzM+vnlancXWUsjlQA0MIF7UOgn45LC
 xtO8qnEHJEpTtRRx3ai68mE1aawWgEdqIiNxMVkxcqKBnQ528CWoejUaMOGOTLoHm1KR BA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36mvmkr4dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 22:31:59 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11B3TTYv012866;
        Thu, 11 Feb 2021 03:31:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8dcq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 03:31:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11B3Vtb839453154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 03:31:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20B57A4051;
        Thu, 11 Feb 2021 03:31:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EAEAA4040;
        Thu, 11 Feb 2021 03:31:54 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.35.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 03:31:54 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 3/3] generic/{413/605}: Add _require_get_hugepagesize check
Date:   Thu, 11 Feb 2021 09:01:46 +0530
Message-Id: <854140625a994b2b38a298c25d26b010c32e9ee0.1612951443.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612951443.git.riteshh@linux.ibm.com>
References: <cover.1612951443.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_02:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=657
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110021
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This adds _require_get_hugepagesize() check at the beginning,
which seems like was the intention earlier behind function
_get_hugepagesize().

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/413 | 1 +
 tests/generic/605 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/generic/413 b/tests/generic/413
index 503c7c999d4f..7db8d756abc7 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -34,6 +34,7 @@ _require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "falloc"
+_require_get_hugepagesize

 prep_files()
 {
diff --git a/tests/generic/605 b/tests/generic/605
index 1e2d71882dd0..7620e148e4b3 100755
--- a/tests/generic/605
+++ b/tests/generic/605
@@ -34,6 +34,7 @@ _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_dax_iflag
 _require_xfs_io_command "falloc"
+_require_get_hugepagesize

 SRC_DIR=$SCRATCH_MNT/src
 SRC_FILE=$SRC_DIR/tf_s
--
	Ritesh Harjani (signature)

