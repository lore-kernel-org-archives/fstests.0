Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB5C49EA7
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37AD61C2E
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhF1Izh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:55:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232415AbhF1Izh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 04:55:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8YOAX067160
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BjAzIzysDcBYD+vA/iL7gsd+UU7NHN7EO/aImrJMg+8=;
 b=i7C9JfJmperJ1MLurroU+UjWWLCG120ooVdslI/j7z+AVb72yAFtPfHSj6+j5u9CCsjR
 iaRmAUgvAhnSy4XahJ8G463/LDV2GfFanL3WrPMM80Ar9bp0nr2WHoOGmiBuVOMydiZd
 Ml014Lxaw5VYsKYbHHuBysJfXjuMxn8knkBWqFzliRaK2QLDq8ZO5N07R2nQEYH71kDU
 RYSwqG6QQ1wNXxmZZSTl5qzkl8lCtUc1KDuC09AGeO/YbOPTJLKNxMrxjBNku/H4OToZ
 Jy7qVE4XB0fRdbPLkB4sV2TGqR8s3WRTMzIROLZTAHhlXpFKFbve7RI2zLnw7vGnzq6B PA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39f8kvm7t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S8qdd3011870
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 39dughgpdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S8r7fS34799996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:53:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DE054C10E;
        Mon, 28 Jun 2021 08:53:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 585674C044;
        Mon, 28 Jun 2021 08:53:06 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.77.195.70])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 08:53:06 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 3/3] xfs/515: Check xfsprogs version for testing xfs_quota commands
Date:   Mon, 28 Jun 2021 14:22:59 +0530
Message-Id: <20210628085259.120666-4-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lSJHgPBbieZ1G9LnleHRCX6CFgt8PnVt
X-Proofpoint-ORIG-GUID: lSJHgPBbieZ1G9LnleHRCX6CFgt8PnVt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280055
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs_quota command 'limit' is reformated in xfsprogs version v5.5.0, to
make it suitable for this(xfs/515) test case. So the test case will
flag failure while running with xfsprogs version less than v5.5, even
though `limit` is documented in xfs_quota manpage. So skip this test for
xfsprogs versions less than v5.5.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 tests/xfs/515 | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/515 b/tests/xfs/515
index 32216fe6..5eb97aff 100755
--- a/tests/xfs/515
+++ b/tests/xfs/515
@@ -27,6 +27,11 @@ _require_test
 echo "Silence is golden"
 
 MANPAGE=$($MAN_PROG --path xfs_quota)
+# xfs_quota command 'limit' is reformated in xfsprogs version v5.5.0,
+# to make it suitable for this test case. For xfprogs versions less than
+# v5.5.0, this test case can not detect the command 'limit'.
+req_version=$($XFS_DB_PROG -V | cut -d" " -f3)
+req_command="limit"
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
@@ -36,8 +41,14 @@ case "$MANPAGE" in
 esac
 _require_command `which $CAT` $CAT
 
-for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
-  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
+for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`;
+do
+	if [ "$req_version" \< "5.5.0" ]; then
+		if [ "$COMMAND" == "$req_command" ];then
+			continue
+		fi
+	fi
+	$CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
 	echo "$COMMAND not documented in the xfs_quota manpage"
 done
 
-- 
2.31.1

