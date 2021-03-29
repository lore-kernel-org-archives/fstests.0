Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D70DC433C1
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 01:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CE46193C
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 01:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC2Bkg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 21:40:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15365 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2Bkf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 21:40:35 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F7wFx6t2Lz8wZy;
        Mon, 29 Mar 2021 09:38:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 09:40:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <guan@eryu.me>, <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] generic/629: add missing copy_range command check
Date:   Mon, 29 Mar 2021 09:40:13 +0800
Message-ID: <20210329014013.4953-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Otherwise, if xfs_io doesn't support this command, it will report
that filesystem fails on this testcase.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/629 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/629 b/tests/generic/629
index ad86ab5bb0c0..13d433a4e470 100755
--- a/tests/generic/629
+++ b/tests/generic/629
@@ -36,6 +36,7 @@ _cleanup()
 _supported_fs generic
 _require_dm_target error
 _require_xfs_io_command "chattr" "s"
+_require_xfs_io_command "copy_range"
 _require_scratch
 
 rm -f $seqres.full
-- 
2.29.2

