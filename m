Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F8C11F65
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 11:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9026187E
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 11:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhF3LeU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:34:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9439 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbhF3LeT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Jun 2021 07:34:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GFJy31fvjzZpDw;
        Wed, 30 Jun 2021 19:28:43 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 19:31:47 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 19:31:46 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <guan@eryu.me>,
        <chao@kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH v3 0/3] Resend the three patches
Date:   Wed, 30 Jun 2021 19:37:33 +0800
Message-ID: <20210630113736.551843-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Resend the three patches

Sun Ke (3):
  generic/042: make a bigger img for f2fs
  generic/103: special left calculation for f2fs
  generic/260: f2fs is also special

 tests/generic/042 |  6 ++++--
 tests/generic/103 | 10 +++++++++-
 tests/generic/260 | 10 ++++++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.25.4

