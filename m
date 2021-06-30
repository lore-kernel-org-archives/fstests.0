Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4669CC11F67
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 01:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D8961D8A
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 01:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhF3Byb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Jun 2021 21:54:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.5]:29342 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhF3Byb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Jun 2021 21:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1625017922; i=@fujitsu.com;
        bh=O2bZvoLK/XfG69YYRweXvXJ5YZw/Ac8/kGawobWZd/g=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=JoJrGr4XHXuZPI1Okh79TLlC/PtRVvR2FLGOqM5kmOeZT4L78q1hgQ5bNjzXCpVbf
         Vjc8BxMfZOdav1d7JBqc2ePjAOIFPoRbHEjHUtitXqu8YVcZ0w6ZeJjU4hvdkdOrks
         MpM+8NDl6gHpJoLJfvi8EuDi/o6c3OXXglAeuhlobT7N1nFjLrfKFESI97sgH8RoYm
         JJSfjlyy6SUcD42Jvioi0GiLZTbLpK3FIbI6VX2Qr7xEAGl0v2VXoE3RaVNHAYugeS
         mbBs1xeddt0gqves8XZ+gp/v+UiI02e2UixVW50fKJnb0p+SrM0Xn0Y4ApAyOwtKSF
         ZJoUJKywwopmQ==
Received: from [100.112.193.7] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-west-1.aws.symcld.net id 52/91-56066-14ECBD06; Wed, 30 Jun 2021 01:52:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRWlGSWpSXmKPExsViZ8MxVdfh3O0
  Eg2sLTSxOt+xlt9i+4iizA5PHzll32T0+b5ILYIpizcxLyq9IYM04cPYYY8Eh7opvb2+zNTAe
  5uxi5OIQEnjNKPFj7gomCGcPo8THp4dYuhg5OdgENCWedS5gBrFFBCQkpu1dyg5iMws4ScxZd
  4oJxBYWiJa41XQYLM4ioCpxZNp2NhCbV8BT4u3JJrA5EgIKElMevgebwyngJfH39R+wuBBQzb
  pJJxgh6gUlTs58wgIxX0Li4IsXzBC9ihKXOr4xQtgVEjNmbGObwMg/C0nLLCQtCxiZVjFaJBV
  lpmeU5CZm5ugaGhjoGhoa6RpaArGJiV5ilW6iXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZG
  YIimFByYsINx/+sPeocYJTmYlER5s47eThDiS8pPqcxILM6ILyrNSS0+xCjDwaEkwdtwBignW
  JSanlqRlpkDjBeYtAQHj5IIb+FxoDRvcUFibnFmOkTqFKOilDjv/rNACQGQREZpHlwbLEYvMc
  pKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLm5QCZwpOZVwI3/RXQYiagxYue3ARZXJKIkJJqYBK
  WmlZ6scb/VOEi0beMVZvq5XryugKem/3vD7NkC+8JVVFzv/zvek7o3eU3w7zPXbaMmp7ZkXNx
  wavpB4u1hXfw3xOduybyzOVMD/87QYmqZTMeiwv08V+3n7Nkzcq7AuaZASdYvyy63uPnoRMwg
  8Vj4c4/6RqRKx/Irl+zcUHO4h2Pmw40dMetKp2pdyqgJu2s1paea9PO/7yrcsdi3TGdv3pnd3
  kyzz3drtHs8tozVSFpH/9jx9NVpbyXnyfsdDP50GSlWRkcfO61s/zthPaEDW/nLdYunKOvKxz
  Folj0KuBqzS6XZJdLHHkXPTYFbc/7FKL9sjN3V51e/YVJsyL1b+yXUZdLUckrvnKoVomlOCPR
  UIu5qDgRAKRUozdMAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-267.messagelabs.com!1625017920!90683!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30055 invoked from network); 30 Jun 2021 01:52:00 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-9.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Jun 2021 01:52:00 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 15U1ptEb031831
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 30 Jun 2021 02:52:00 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Wed, 30 Jun 2021 02:51:52 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 1/2] Makefile: fix bug when running make install under tests/* directory
Date:   Wed, 30 Jun 2021 09:52:05 +0800
Message-ID: <1625017926-18844-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624332489-27616-2-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1624332489-27616-2-git-send-email-xuyang2018.jy@fujitsu.com>
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

