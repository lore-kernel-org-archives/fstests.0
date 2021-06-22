Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75AC2B9F4
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 03:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567366120D
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 03:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFVDaO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:30:14 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:5797 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhFVDaO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jun 2021 23:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1624332477; i=@fujitsu.com;
        bh=7Bvgo02KUPKGHHZuxniQi4ydDlFKma341LqCXbMtV2k=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UsEAAyci/pHNju/hmru10sa8eIHfcR35hAIOTuHAya6sPhwC9+Nnxgj30LUq6aPx0
         W+F2il7lZ4hpHZRwrDEgRzhbb0GabXgIcBtzhvvzlo5tZJMPqAg+wZYZebYr/xxD3V
         eS82EohIOnIchnFl7bE9oJgbU/J66Lsn0rsGAOufTozVtTy9YlC/0JRFxTT0pAP03t
         ggBYmlYiLB9BP5Qk0Jm6MCiZmjPHcQhCRmJThdVhSLi4lLdQmVAyEvfTSC+W7plsJa
         T9XMp0VHR00p7jWci6qBH07tz62OmzC+rVevUqSo5DEWijVZ/3FPDPOfLO7Jps5tnn
         11ZY8Np1uPKsw==
Received: from [100.113.7.10] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 1C/C9-38619-DB851D06; Tue, 22 Jun 2021 03:27:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRWlGSWpSXmKPExsViZ8MxVXdvxMU
  EgxeXFC1Ot+xld2D0+LxJLoAxijUzLym/IoE1Y9njFcwFO1krdi76wtTA+ICli5GLQ0igk0ni
  /e5djBDOHkaJlRvvs3YxcnKwCWhKPOtcwAxiiwjISvyfsZoJxGYWUJdYPukXmC0s4C5xZPNCN
  hCbRUBV4uX9dWC9vAKeEn9WfAaLSwgoSEx5+B5sDqeAl8Svs5PAeoWAara9OcgCUS8ocXLmEx
  aI+RISB1+8YIboVZS41PGNEcKukJgxYxvbBEb+WUhaZiFpWcDItIrRIqkoMz2jJDcxM0fX0MB
  A19DQWNdM18JcL7FKN0kvtVQ3OTWvpCgRKKmXWF6sV1yZm5yTopeXWrKJERiOKYVs4TsYz7z+
  oHeIUZKDSUmUlyvsYoIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd59IDnBotT01Iq0zBxgbMCkJ
  Th4lER4E8KB0rzFBYm5xZnpEKlTjLocl6/PW8QsxJKXn5cqJc6bAlIkAFKUUZoHNwIWp5cYZa
  WEeRkZGBiEeApSi3IzS1DlXzGKczAqCfN+BLmEJzOvBG7TK6AjmICOWMV2DuSIkkSElFQDk94
  DfyHdI3wz2lQvyBsmrQ0vKN5y43Mx31unvHN+vitcfS2d1/r9OpIkbrvgVLLV0iQP9vlTgkJT
  psq+bDiQVv6GN7adNfmZ/VeesBlvLY0vVVk/+6q05eK3RuOJ6wTWzpXxuOqUMytKLU7Jkq2Hy
  4Cz2WjLmoCUJ1FzYiZPk/nF/eTdC99uh5uvlT4rhiawr5omFs7TOCN84qQl973nv5xoHqN59n
  kXx/rv4nubfv+eEeZisunDw+NXWp57mN7axK3l+vn1u33bFzpscZ96VUw/JH250dMVPAf29fZ
  dP7Ux1H7TUg6dZZWpZmqNurt2te2N3rHTfU6PcGl5v2Xy5yursgziM0wahbdJJTRLK7EUZyQa
  ajEXFScCALt4aFhOAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-245.messagelabs.com!1624332476!115760!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14744 invoked from network); 22 Jun 2021 03:27:57 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-4.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Jun 2021 03:27:57 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 15M3RonM031084
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Tue, 22 Jun 2021 04:27:56 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Tue, 22 Jun 2021 04:27:53 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 2/2] tests/overlay/Makefile: Use the unified name rules
Date:   Tue, 22 Jun 2021 11:28:09 +0800
Message-ID: <1624332489-27616-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624332489-27616-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1624332489-27616-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since xfs/ext4 uses XFS_DIR/EXT4_DIR in Makefile(also for other filesystems),
I think we don't have any reason not to use OVERLAY_DIR in here.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/overlay/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index b07f8925..8da5b8ad 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -5,8 +5,8 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-TEST_DIR = overlay
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(TEST_DIR)
+OVERLAY_DIR = overlay
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(OVERLAY_DIR)
 
 include $(BUILDRULES)
 
-- 
2.23.0

