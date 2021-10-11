Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82957C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C35E60D42
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhJKH6K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:58:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234738AbhJKH6J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 03:58:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B7RMng025996
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8V4zCCMvhFS+0sH5P9lOVnUqJYJ1OGIiODACJcvcd9M=;
 b=E2xfAVXSK3EA21Ix3MdgVb6zBBMt1hUV5o/FxK5JihXUENhRtbBu99fhE9eoXPz6MrsK
 ijJDiJ9Mf9gPO6uQVJqEspD9ruqmJz76lBuvkV61B+QrPTpgp6MwjnVwyutZz7KLv3QR
 +xl/LWB6yTSVd7Uf5lWJIBHx8UICXstBQqOSJwzDXWNknB+fUChQATUsTlxNZu5OKavm
 Tz05aiUjdhwj2ki62S+jyzDY1HF/B4+D+rL8u1NpLK0Ro2/gsar9RwpzHjTnhbvI+L77
 7CvWUzUFbkg+t6NlbHBUBVv+4CkFkWtM9qSABcwXTuS16B5AkmlBHQsE+BKuA6Sh9uPI Bg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bmefauegb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19B7rIwA007709
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2q9kag5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19B7oXZg60555682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 07:50:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FF5CA4060;
        Mon, 11 Oct 2021 07:56:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F383AA4054;
        Mon, 11 Oct 2021 07:56:01 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.43.35.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 07:56:01 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 3/4] generic/600: Fix this test on xfs with older quota-tools
Date:   Mon, 11 Oct 2021 13:25:51 +0530
Message-Id: <20211011075552.196688-4-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aDUATYSigyEBauX4diXOx46VWmEulIUQ
X-Proofpoint-GUID: aDUATYSigyEBauX4diXOx46VWmEulIUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxlogscore=883 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110043
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For xfs, we need quota-tools containing commit be96da2353669d ("quota-tools:
Set FS_DQ_TIMER_MASK for individual xfs grace times"), to run this test.
Otherwise the test fails on xfs. Check the quota-tools before running
the test.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 tests/generic/600 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/generic/600 b/tests/generic/600
index a4233ecc..c8dc1bd5 100755
--- a/tests/generic/600
+++ b/tests/generic/600
@@ -10,6 +10,9 @@
 # This test only exercises user quota because it's not known whether the
 # filesystem can set individual grace timers for each quota type
 #
+# For xfs, you need a quota-tools containing commit be96da2353669d to
+# run this test properly- 4.06 should do.
+
 . ./common/preamble
 _begin_fstest auto quick quota
 
@@ -24,6 +27,11 @@ _require_quota
 _require_user
 _require_setquota_project
 
+version=$(setquota -V | head -n1 | cut -d" " -f4)
+if [ "$FSTYP" = "xfs" ] && [ "$version" \< "4.06" ];then
+	_notrun "This test requires quota-tools 4.06 or greater"
+fi
+
 _scratch_mkfs >$seqres.full 2>&1
 _qmount_option "usrquota"
 _qmount
-- 
2.24.1

