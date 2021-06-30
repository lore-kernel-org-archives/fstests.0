Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82510C11F69
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 01:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D2D61D85
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 01:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhF3Byb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Jun 2021 21:54:31 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:57706 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbhF3Byb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Jun 2021 21:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1625017922; i=@fujitsu.com;
        bh=Ns4MdJkD7H1YhhCA/74iYi1/XnyhPPlhGwMIGZk6t4M=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=NDJMSMvPYjUumE3G5pUj0MXmIr/sqQkRp0t/1tP6PU33SnHwKqILTy2FHXSXzYGBO
         B0rjAz8lNkjY7WB79LDOke4ZnC0RQcJ461iTBl1yCyEHOUeA7D+lXDRnNpv7vSXHrb
         twYtuOmXnsCRnNGFl+6fJ/BNFroEn+1gI8ZHo0agZ06luciiTCX9OVQNubvwjGoolI
         jznP9dDRZfe8q9+pjMNEa9G2iHud/NVHfYugaaGdbu6Qfr3957ouAB44RDeJKN2QVG
         IJx68UemLHo5EFdR2M4UrWsAR+Y9Ctl2I1wQokfEAfj7WKrlYpELlPMCLjgjgYbO50
         MPccRgF3ylEow==
Received: from [100.113.1.143] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id D6/34-07685-14ECBD06; Wed, 30 Jun 2021 01:52:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRWlGSWpSXmKPExsViZ8MxVdfx3O0
  Eg91dvBanW/ayW2xfcZTZgclj56y77B6fN8kFMEWxZuYl5VcksGacmzqXteAda8WWexfYGhgn
  snYxcnEICbxmlJgx+QcLhLOHUeLwua1sXYycHGwCmhLPOhcwg9giAhIS0/YuZQexmQWcJOasO
  8XUxcjBISzgJbFxVjVImEVAVWL5vVtg5bwCnhK//vaBlUsIKEhMefgeLM4JVL74/CJmiF0djB
  Lflv5gg2gQlDg58wkLxHwJiYMvXjBDNCtKXOr4xghhV0jMmLGNbQIj/ywkLbOQtCxgZFrFaJl
  UlJmeUZKbmJmja2hgoGtoaKxrqGtkbKaXWKWbqJdaqpucmldSlAiU1UssL9YrrsxNzknRy0st
  2cQIDNKUQsY3Oxi/vv6gd4hRkoNJSZQ36+jtBCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvA1ng
  HKCRanpqRVpmTnAiIFJS3DwKInwFh4HSvMWFyTmFmemQ6ROMepyXL4+bxGzEEtefl6qlDjv/r
  NARQIgRRmleXAjYNF7iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwLwfIFJ7MvBK4Ta+AjmA
  COmLRk5sgR5QkIqSkGphas5lO/bA6vdJt4zPhVTcVgsJe8N00tq6U6s4141A+37jtadaeD3l9
  tzrMIiVYVmhwmR3ZoPbo067DN93m3N11Yu/TmaxbVy53ENpdyH15ZbWc/IrbjyTLzZt31ehdT
  nD5csT3rTD/oY8y9xi3en68fdFc2+iFuai54sM7r61WzK0+8pFl78x17e1GttIh/XxCrImvLb
  fZi5yceX0u45yrk87c/7lFOSJpRz3X2vsbJ716nHzDjcXrz8UXJfVfQ9fN2Ru0RvFwS9oB6Tb
  1LoWnCx4Vacr9kLTqMN9myln7r3YLV/iLVUcOHxbfVHq4QeyGDPPcOTezt8RGs5+uy/JZ27Bz
  SpTiOwubByLz4n7vU2Ipzkg01GIuKk4EAKcK4ZlZAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-226.messagelabs.com!1625017920!25884!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3787 invoked from network); 30 Jun 2021 01:52:01 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-12.tower-226.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Jun 2021 01:52:01 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 15U1ptEc031831
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 30 Jun 2021 02:52:00 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Wed, 30 Jun 2021 02:51:57 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 2/2] tests/overlay/Makefile: Use the unified name rules
Date:   Wed, 30 Jun 2021 09:52:06 +0800
Message-ID: <1625017926-18844-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625017926-18844-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1624332489-27616-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <1625017926-18844-1-git-send-email-xuyang2018.jy@fujitsu.com>
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
index de3203c2..2785b94d 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -6,8 +6,8 @@ TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 include $(TOPDIR)/include/buildgrouplist
 
-TEST_DIR = overlay
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(TEST_DIR)
+OVERLAY_DIR = overlay
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(OVERLAY_DIR)
 DIRT = group.list
 
 default: $(DIRT)
-- 
2.23.0

