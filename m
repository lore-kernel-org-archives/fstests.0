Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E63C433E6
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1864EBC
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBKDcm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:32:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25304 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhBKDck (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 22:32:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11B32gNd144049;
        Wed, 10 Feb 2021 22:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=OUPFVZmkWk/5V2rAioBXHwo+h1qawCZwSLXlJvliHoI=;
 b=JXWU7oMoj2dAx4enHIGw2J00WAHVJL0wy2yuM8j6RfT8I7QkqdcStPRMVWutEFknsfjr
 WSBfYaT7shkXVpkwmiRvbwbdsIws5x/3lDldHznCNgBPRSm82iivivum3I2AJezFcUzM
 CI9pfyct2LwLNFZAfxQj0sb9SbY1Qdaw9BH/2uOHCUdKyjpnlTfmHygEFpao/ye+18f5
 w6l60ZSaYBlb1WR49u6/RaKYq3s+TKshV85OaiTQMJQQqlJcxvw/aUzkWOHwA+PbT/EO
 W+cyn1vTkW6YnZWaEJRjkOwATTE6GPya9us4bYF2GjYESTdRESb9n59pT5QrzNgligZx uQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mv528qe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 22:31:55 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11B3TIpr012481;
        Thu, 11 Feb 2021 03:31:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8dcq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 03:31:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11B3VpIa35193338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 03:31:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7290AA4057;
        Thu, 11 Feb 2021 03:31:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F8CFA404D;
        Thu, 11 Feb 2021 03:31:50 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.35.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 03:31:50 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/3] fstests: -I <n> CLI option and some random fixes
Date:   Thu, 11 Feb 2021 09:01:43 +0530
Message-Id: <cover.1612951443.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_11:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=464 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110016
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Patch-1: is a v2 with comments addressed from Eryu.
Patch-{2,3}: are random fixes found during testing.

Ritesh Harjani (3):
  check: add CLI option to repeat and stop tests in case of failure
  common/rc: Add _require_get_hugepagesize and fix
    _require_label_get_max
  generic/{413/605}: Add _require_get_hugepagesize check

 check             | 8 ++++++++
 common/rc         | 8 +++++++-
 tests/generic/413 | 1 +
 tests/generic/605 | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

--
