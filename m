Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA68C48BDF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 03:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40F36120D
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 03:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhFVDaP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:30:15 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:32974 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhFVDaO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jun 2021 23:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1624332477; i=@fujitsu.com;
        bh=O2bZvoLK/XfG69YYRweXvXJ5YZw/Ac8/kGawobWZd/g=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=vkpy2InIQfG4hxDa7o77gOvCTbArZUyJiRgPZp+mE0g2XpabY5DkGF4QkawghduZD
         BBoCUpp9iwnajEGkVvTuogpm2nCPdaZjKIjzG5OAFU3jDCI1wwzzf9wwPJc6G+NyCu
         L/8lBZuxIorTcaiHzcnR6Gl2uDYsw7fsaL5WuXcgJe1alQU8uvciDschXd2sr7WkMs
         YU4ZhXBMNa6rWKFvneXONTHbDjakZNRr2WEE16rhDlc56D9VkIFTVo1yVqGD+7WbD4
         CXGXaE27jtLsbGH+TFaPOCEBrbdHm3SjY+CP7LzLfQBtZ1Nmly9UVdUgvmynCqwjqD
         TykXmiotL+mKw==
Received: from [100.113.7.10] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id E4/E0-50909-DB851D06; Tue, 22 Jun 2021 03:27:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRWlGSWpSXmKPExsViZ8MxVXdvxMU
  Eg3nTZC1Ot+xld2D0+LxJLoAxijUzLym/IoE148DZY4wFh7grvr29zdbAeJizi5GLQ0igk0mi
  q2s3I4Szh1Fiw4cf7F2MnBxsApoSzzoXMIPYIgKyEv9nrGYCsZkF1CWWT/oFZgsLREicfdEAZ
  rMIqEr0bTsAVM/BwSvgKTHzsy5IWEJAQWLKw/dgY3gFBCVOznzCAjFGQuLgixfMEDWKEpc6vj
  FC2BUSM2ZsY5vAyDsLScssJC0LGJlWMVomFWWmZ5TkJmbm6BoaGOgaGhrrmukaWpjpJVbpJum
  lluomp+aVFCUCZfUSy4v1iitzk3NS9PJSSzYxAsMrpZBt1w7Gz68/6B1ilORgUhLl5Qq7mCDE
  l5SfUpmRWJwRX1Sak1p8iFGGg0NJgncfSE6wKDU9tSItMwcY6jBpCQ4eJRHehHCgNG9xQWJuc
  WY6ROoUo6KUOG8KSEIAJJFRmgfXBouvS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeT+CbO
  fJzCuBm/4KaDET0OJVbOdAFpckIqSkGpgkvPYn2i5rEH5fzPL6bHaSUd1WhxzOF0muFWstpWp
  np+iELHWqnX1mzZ78wlLF18s652h46nDZXfi62uPE05QtjmseTJ+qu0Gi6/SGlWy5PorcU3q6
  gj7svMaXwb3G9+aslb9j5nxP5PKxSGY8mTszn38T9727PCt1p68/Jx2tebHD+OOpD76LC+Wm/
  UyKevPs292Lu95aW3M9qFDZV7J4s3G2OOPvtU4Fc2WYdjEKfbtwW/xga6rBK/E7jHpLztSkF2
  0OO6CQ1302kntb/7yKqtpLkV6LQ06o8q771Rz1iIUnaOrlo5975PXkJl2evEAx/q4xvzaz6Iz
  m+evmnXixQLKC0WZ/j79HWscC9yYlluKMREMt5qLiRADYG1V7KgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-248.messagelabs.com!1624332476!103454!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29717 invoked from network); 22 Jun 2021 03:27:57 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-2.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Jun 2021 03:27:57 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 15M3RonL031084
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Tue, 22 Jun 2021 04:27:56 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Tue, 22 Jun 2021 04:27:48 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 1/2] Makefile: fix bug when running make install under tests/* directory
Date:   Tue, 22 Jun 2021 11:28:08 +0800
Message-ID: <1624332489-27616-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The TESTS_DIR value is defined in TOPDIR makefile, it is empty here.
So running make install on ext4 directory will get the following info:

../../install-sh -o root -g root -m 755 -d /var/lib/xfstests//ext4

We can see they aren't installed under /var/lib/xfstests/tests/ext4 directory.
Fix this by moving TESTS_DIR definition to include/builddefs.in file.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 Makefile             | 3 ++-
 include/builddefs.in | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 86a2d399..f6f91a4d 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,8 @@ HAVE_BUILDDEFS = $(shell test -f $(TOPDIR)/include/builddefs && echo yes || echo
 
 ifeq ($(HAVE_BUILDDEFS), yes)
 include $(TOPDIR)/include/builddefs
+else
+export TESTS_DIR = tests
 endif
 
 SRCTAR = $(PKG_NAME)-$(PKG_VERSION).tar.gz
@@ -40,7 +42,6 @@ endif
 LIB_SUBDIRS = include lib
 TOOL_SUBDIRS = ltp src m4 common
 
-export TESTS_DIR = tests
 SUBDIRS = $(LIB_SUBDIRS) $(TOOL_SUBDIRS) $(TESTS_DIR)
 
 default: include/builddefs
diff --git a/include/builddefs.in b/include/builddefs.in
index f762a433..6641209f 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -35,7 +35,7 @@ PKG_VERSION     = @pkg_version@
 PKG_PLATFORM    = @pkg_platform@
 PKG_DISTRIBUTION= @pkg_distribution@
 PKG_LIB_DIR     = $(DESTDIR)@exec_prefix@/@pkg_name@
-
+TESTS_DIR	= tests
 
 CC              = @cc@
 AWK             = @awk@
-- 
2.23.0

