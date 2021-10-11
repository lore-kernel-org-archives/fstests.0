Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59595C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1260EFE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 07:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhJKH6J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:58:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234728AbhJKH6H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 03:58:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B7gHoS019971
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wnyVlPcydmIqcXs0NtzFS12yE7TQGutmR5JQJszW/0Y=;
 b=oQs5xb3egU9YRUFLLTlXqm96mfYftlZASmLUIAf+nsGyy8afHvYo4za9LNi0l+io27cW
 IMckKFOjIBrZekid60dePT18v52uj/WFG1T6KNBD/WozuhrpjL+2qGFCXv2LGNcXoqtQ
 IvcMBP5+hBZYJN+w5x8M5ocC0RqvEWGtQz0QUmfYQlb3P/IX4I5JCOR0v6ELFA891Ory
 USM7i97inN44gNkFZOkFRcxU+FxkjarC7fevKqwpr2zqGPn6pmV+UseEaNZhK7PidjP4
 9hstMOtFsA1rza00bB1j8sP3TVY/M6gU2TToCTPgyp6BzN+n5J0cf3c2JbTPL3iJJJFq OA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmh3s084x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 03:56:07 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19B7rIsK016618
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q93ah4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 07:56:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19B7u1Oq46334402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 07:56:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2066AA4064;
        Mon, 11 Oct 2021 07:56:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80F7AA4060;
        Mon, 11 Oct 2021 07:55:59 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.43.35.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 07:55:59 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 2/4] generic/594: Fix test failure for xfs on older quota-tools
Date:   Mon, 11 Oct 2021 13:25:50 +0530
Message-Id: <20211011075552.196688-3-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cZZCaD7PBlkCSr567BozsesVmHQTkKsJ
X-Proofpoint-ORIG-GUID: cZZCaD7PBlkCSr567BozsesVmHQTkKsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110043
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For xfs we need the quota-tools containing commit fdd774bf08e568
("quota-tools: pass quota type to QCMD for Q_XFS_GETQSTAT")to run this
test. Otherwise this test will fail on xfs, as the grace time is not set
correctly. So check for the quota-tool with the required commit before
running this test on xfs.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 tests/generic/594 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/594 b/tests/generic/594
index 88f9a0dc..668c1fae 100755
--- a/tests/generic/594
+++ b/tests/generic/594
@@ -6,6 +6,8 @@
 #
 # Test per-type(user, group and project) filesystem quota timers, make sure
 # each of grace time can be set/get properly.
+# For xfs, you need a quota-tools containing commit fdd774bf08e568 for this
+# test to run properly- v4.06 should do.
 #
 . ./common/preamble
 _begin_fstest auto quick quota
@@ -18,9 +20,13 @@ _begin_fstest auto quick quota
 _supported_fs generic
 _require_scratch
 _require_setquota_project
+version=$(setquota -V | head -n1 | cut -d" " -f4)
 # V4 XFS doesn't support to mount project and group quota together
 if [ "$FSTYP" = "xfs" ];then
 	_require_scratch_xfs_crc
+	if [ "$version" \< "4.06" ];then
+		_notrun "This test requires quota-tools 4.06 or greater"
+	fi
 fi
 _require_quota
 
-- 
2.24.1

