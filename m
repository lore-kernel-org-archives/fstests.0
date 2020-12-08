Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E01C4361B
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 07:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD2B23A6C
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 07:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLHHBs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Dec 2020 02:01:48 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62514 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgLHHBs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2020 02:01:48 -0500
X-IronPort-AV: E=Sophos;i="5.78,401,1599494400"; 
   d="scan'208";a="102168462"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Dec 2020 15:00:36 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 787724CE6000;
        Tue,  8 Dec 2020 15:00:34 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 8 Dec 2020 15:00:33 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 8 Dec 2020 15:00:33 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 2/2] src/dmiperf: Stop using attr_setf
Date:   Tue, 8 Dec 2020 14:40:05 +0800
Message-ID: <20201208064005.1187031-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208064005.1187031-1-yangx.jy@cn.fujitsu.com>
References: <20201208064005.1187031-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 787724CE6000.A6D83
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Avoid the following warning by replacing deprecated
attr_setf with fsetxattr:
---------------------------------------------------
dmiperf.c:192:2: warning: 'attr_setf' is deprecated: Use fsetxattr instead [-Wdeprecated-declarations]
---------------------------------------------------

Also remove unneeded <attr/attributes.h> and $(LIBATTR).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/Makefile  | 2 +-
 src/dmiperf.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 32940142..c0688520 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 
 SUBDIRS = log-writes perf
 
-LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread -lrt
+LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
 
 ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
 LINUX_TARGETS += loggen
diff --git a/src/dmiperf.c b/src/dmiperf.c
index 4026dcfb..f9415953 100644
--- a/src/dmiperf.c
+++ b/src/dmiperf.c
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <attr/attributes.h>
+#include <sys/xattr.h>
 
 typedef unsigned int uint_t;
 
@@ -189,8 +189,8 @@ mkfile(char *name, char *attr)
 		perror("open");
 		exit(1);
 	}
-	if (attr_setf(fd, DMFATTRNAME, attr, DMFATTRLEN, ATTR_ROOT) < 0) {
-		perror("attr_setf");
+	if (fsetxattr(fd, DMFATTRNAME, attr, DMFATTRLEN, 0) < 0) {
+		perror("fsetxattr");
 		exit(1);
 	}
 	while (bytes > 0) {
-- 
2.23.0



