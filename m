Return-Path: <SRS0=Dt1E=5Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D7C2D0EA
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Apr 2020 14:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEA9206F5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Apr 2020 14:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDHOO6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:14:58 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:36692 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgDHOO5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Apr 2020 10:14:57 -0400
X-Greylist: delayed 1080 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 10:14:57 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 038Drw7Q124068;
        Wed, 8 Apr 2020 16:56:56 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 3091pn1418-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 16:56:55 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 8 Apr
 2020 16:56:55 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH 0/4] Assign a few generic tests to additional groups
Date:   Wed, 8 Apr 2020 16:56:44 +0300
Message-ID: <20200408135648.5824-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=787 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080116
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The rationale behind the proposed changes is to correct and improve
granularity of some generic tests, so it becomes possible to control
lists of run tests better, if there is given additional information
about a test environment and tested filesystems.

Vladimir Zapolskiy (4):
  Add generic/459 test to freeze group of tests
  Add generic/482 test to thin group of tests
  Add generic/529 test to acl group of tests
  Add generic/530 test to shutdown group of tests

 tests/generic/group | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

