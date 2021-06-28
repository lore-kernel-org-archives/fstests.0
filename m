Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A3DC2B9F4
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931B161C2E
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhF1Izd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:55:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232282AbhF1Izc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 04:55:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8YnLl003161
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6XkPNMHLSZzuygJgNQncLdM4nCYIGweCfyDjlt8qFqg=;
 b=c24ClwxfjqWLZLN80XrZM8TS1WDfxhWvFLj9/rtEOdM5KvQQUD9udSZwLCZ34kjsisOd
 HhAfrkWO3jbBquj2ZnfAJr4Vw1370djKrPGrWFHiRG+m93/NnVzU5CZvNByRNE0Pjap7
 oYydSLxzQD3/vg7Zzf6Sp2JX+VvYLbb3igPV3fUTBbscnb5s0W34tlz7lwqSPGPd38Rd
 VJthumqDHibYUb+UTr99roYrxQOZRjjBq/vgMeDlXJesH9ivGxhOX958lb3mQBuqX0Ey
 28ixGeEbqe4BZ8+gx9nnc1cyLkYrWmrAMv2NNMFo1AjX3xNH1J4oO0j+HDgxG5RIOHjq nA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39farh0v16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 04:53:07 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S8gpjR023155
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39duv88p4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 08:53:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S8r3X433161490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:53:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 303274C112;
        Mon, 28 Jun 2021 08:53:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67BCB4C044;
        Mon, 28 Jun 2021 08:53:02 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com.com (unknown [9.77.195.70])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 08:53:02 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com
Subject: [PATCH 0/3] xfstest random fixes
Date:   Mon, 28 Jun 2021 14:22:56 +0530
Message-Id: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q2adVpp7AbQ5g7S4jxmo2O8LhMuKP2TI
X-Proofpoint-GUID: Q2adVpp7AbQ5g7S4jxmo2O8LhMuKP2TI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 mlxlogscore=993 lowpriorityscore=0
 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280059
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Below are some of xfstest fixes with 4k blocksize(ppc64) and xfs
filesystem.

Anju T Sudhakar (3):
  xfs/504: Add scratch_mount before checking for xfs_scrub unicode
    support.
  xfs/514: Check xfsprogs version for verifying the xfs_db commands
  xfs/515: Check xfsprogs version for testing xfs_quota commands

 tests/xfs/504 |  3 +++
 tests/xfs/514 | 12 +++++++++++-
 tests/xfs/515 | 15 +++++++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.31.1

