Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F6C2B9F4
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D25461C2E
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhF1Izg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:55:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhF1Izg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 04:55:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8XH6e005979
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KVsB0fec4swtdD6jYvrabiqwwgz8SJNUtgVidY9WAZ8=;
 b=gTUlZo6Pwuer2VorHOSDtEk0krurfl1DXGh2F3qld44XA8a3ZgJzykQh43Vs2FiZpr5Z
 2TObXdhoRgTRQ7RIAVaABnVGPx6muWN7kKRsJrThewiFHLbgWFLwOzaEg2lkEXvEd2/d
 V+u6/IFJsSld3nhB/w+suoBkp29gAaqEzzqewf0YGqUtkjhIgvUgavgYFT5TExlYdOZa
 HTDcavPRzCG3CNbMB4mzin+Yedav9Ryb7oDkyknHPQYcIYoNowUJQ1FdiVW6YHX0OxE3
 1iC+tmQekWboFBgZ3/X/Lnw/YxWNLSeFgjR+RL3JB+8fznoCqCZ9OxAXMYrldWI+sNA6 GQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f9m32x5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:10 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S8iG2b016896
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 39duv8gbsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S8r5al33358202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:53:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D7D54C0EE;
        Mon, 28 Jun 2021 08:53:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9FE54C0EA;
        Mon, 28 Jun 2021 08:53:04 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.77.195.70])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 08:53:04 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 2/3] xfs/514: Check xfsprogs version for verifying the xfs_db commands
Date:   Mon, 28 Jun 2021 14:22:58 +0530
Message-Id: <20210628085259.120666-3-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5wfDEMC8aYAX6PyCComzMzkR4ahO2iP2
X-Proofpoint-GUID: 5wfDEMC8aYAX6PyCComzMzkR4ahO2iP2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280059
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs_db commands like `attr_remove, attr_set, btheight, and logformat`,
are documented only in xfsprogs version v5.5 and later. So skip checking
for these commands in xfs_db manpage,if the test is running with
xfsprogs version less than v5.5.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
Query: The reason to add this check is, while running xfstest with an         
older version of xfsprogs, this test case flags as failure, though         
xfs_db is not expected to have those commands. Otherwise upon failure we   
should ask the user to use the latest version of xfsprogs.                 
OR is there any better solution for this?     

 tests/xfs/514 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/514 b/tests/xfs/514
index a9c67645..8da66f41 100755
--- a/tests/xfs/514
+++ b/tests/xfs/514
@@ -27,6 +27,11 @@ _require_test
 echo "Silence is golden"
 
 MANPAGE=$($MAN_PROG --path xfs_db)
+# xfs_db commands - attr_remove, attr_set, btheight, and logformat
+# are documented in 5.5.0 and later versions only. So skip checking for
+# those commands if the version is less than 5.5.0.
+command_list="attr_set attr_remove btheight logformat"
+req_version=$($XFS_DB_PROG -V | cut -d" " -f3)
 
 case "$MANPAGE" in
 *.gz|*.z\|*.Z)	CAT=zcat;;
@@ -41,7 +46,12 @@ truncate -s 128m $file
 $MKFS_XFS_PROG $file >> /dev/null
 
 for COMMAND in `$XFS_DB_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
-  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
+	if [ "$req_version" \< "5.5.0" ]; then
+		if (echo $command_list | tr ' ' '\n' | grep -F -x -q "$COMMAND");then
+			continue
+		fi
+	fi
+	$CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
 	echo "$COMMAND not documented in the xfs_db manpage"
 done
 
-- 
2.31.1

