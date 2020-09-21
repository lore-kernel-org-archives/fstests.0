Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F11C43465
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532E22311D
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DES+sJzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgIUOhw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:37:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63724 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIUOhv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 10:37:51 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 10:37:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600699071; x=1632235071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hIPCgkv88milcjNzRRkd5ayi8pFW3zweK7LgZUTxAMg=;
  b=DES+sJzItdUXK0m9CgSHaEjiyKl46P/2xOCDrlNdNBuQa0dcvfcj6rrR
   zBrzfMmDrQBrxW7x36lSDx0Exw9/EhQQROimjMjXUclgv9ErF8P16Q+Ro
   KjpwIxAOjSSie1na8zYuem2Sg1OiTZez2wx4HxRqiQ+DflSkMp+5wsuFD
   35Uia65d2YPmU2CLhSAIAOc/buT/iscIEwM3WintavlgoLYYX2hGimmtQ
   VBGF+qbA7jSuvCCs+5OCYPm9VseAjIq6Fk9hvYOoXH24Za1yvnp7R8jq+
   ngFZ5ZCU3wJCz+J3BL6Z6j/0mUZlyZiyDX0X7t38KHXABjIhEFm234sna
   g==;
IronPort-SDR: HrdlCHP/a3zB4kUB2yCP9kvQsKhOmP7+rgQOq5YdmGqSCXPv0G653ViIJ6p7vsbFpc5H4ILj0l
 yMOvzbQYgNhOvOjU1jM4uCMTiPchLqEbf8WW1/MaoYp/vOm2PItm/vfjlZz60400SbCvwO+JQw
 q7v6YSSo1wVqvjZVbp8GJMitOlkLMoQG6xW7NuioXHLWvR3eh+ZqF9A2yuMJPVkLM0TSWN6diw
 4MT01MSaFWRYZm4Co9z6mb2+3lAAXRDcGPCFAVzSNZL9/xcnQUsPEy5D9MfOWhT8zvrH4pV9c5
 cdg=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147817423"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 22:30:44 +0800
IronPort-SDR: YvYMhTQUDQAHbfLCpKFjq4DvgF05FFVN2sxoMeAt7LhiZfM+kOR+aVryur/c+hcvD7+tUxiq0k
 g9RNgp5XSEdQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 07:16:53 -0700
IronPort-SDR: GY+GIzqLqM90CxrW4fcL5TNTmEV0P2OMP4B+HO30k/odRS8+c9+2h/GDdw2uJVlgioX94Ve7lz
 B36PcZDW8h/Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2020 07:30:44 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: remove stale test for alien devices from auto group
Date:   Mon, 21 Sep 2020 23:30:35 +0900
Message-Id: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

btrfs/198 is supposed to be a test for the patch
"btrfs: remove identified alien device in open_fs_devices" but this patch
was never merged in btrfs.

Remove the test from fstests' auto group, as it is constantly failing.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b5fa695a9f7..a1ec54c51631 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -199,7 +199,7 @@
 195 auto volume balance
 196 auto metadata log volume
 197 auto quick volume
-198 auto quick volume
+198 quick volume
 199 auto quick trim
 200 auto quick send clone
 201 auto quick punch log
-- 
2.26.2

