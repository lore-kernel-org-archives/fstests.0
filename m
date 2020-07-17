Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A880CC433E7
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879B320578
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 08:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgGQIh6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:37:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbgGQIh5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Jul 2020 04:37:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 96FDA56DE92D73F511B7;
        Fri, 17 Jul 2020 16:37:56 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 16:37:45 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <guaneryu@gmail.com>, Richard Weinberger <richard@nod.at>
CC:     <fstests@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH 0/2] add tests for race between xattr read and write
Date:   Fri, 17 Jul 2020 16:44:45 +0800
Message-ID: <20200717084447.66402-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

These two test cases are reproducers for xattr bugs [1] on ubifs.
Although these bugs are ubifs specific, I still place these test cases
under generic directory, because we can ensure other filesystems implement
concurrent xattr read and write op correctly.

Comments are welcome.

Regards,
Tao

[1]: https://lore.kernel.org/linux-mtd/20200630130438.141649-1-houtao1@huawei.com/

Hou Tao (2):
  generic: add test for race between listxattr and setxatr
  generic: add test for race between getxattr and setxattr

 tests/generic/998     | 64 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/998.out |  2 ++
 tests/generic/999     | 68 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  2 ++
 tests/generic/group   |  2 ++
 5 files changed, 138 insertions(+)
 create mode 100644 tests/generic/998
 create mode 100644 tests/generic/998.out
 create mode 100644 tests/generic/999
 create mode 100644 tests/generic/999.out

-- 
2.25.0.4.g0ad7144999

