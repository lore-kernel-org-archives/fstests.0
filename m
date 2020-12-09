Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0381C4361B
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 05:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACC623A75
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 05:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgLIFTN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Dec 2020 00:19:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24597 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbgLIFTN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2020 00:19:13 -0500
X-IronPort-AV: E=Sophos;i="5.78,404,1599494400"; 
   d="scan'208";a="102208403"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Dec 2020 13:18:36 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3B3FA4CE600B;
        Wed,  9 Dec 2020 13:18:33 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 9 Dec 2020 13:18:32 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 9 Dec 2020 13:18:32 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/2] src/multi_open_unlink: Stop using attr_set
Date:   Wed, 9 Dec 2020 12:58:02 +0800
Message-ID: <20201209045802.1239715-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209045802.1239715-1-yangx.jy@cn.fujitsu.com>
References: <20201209045802.1239715-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3B3FA4CE600B.A949A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Avoid the following warning by replacing deprecated
attr_set with setxattr:
---------------------------------------------------
warning: 'attr_set' is deprecated: Use setxattr or lsetxattr instead [-Wdeprecated-declarations]
---------------------------------------------------

Also remove unneeded flags, <attr/attributes.h> and $(LIBATTR).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/Makefile            | 2 +-
 src/multi_open_unlink.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 80f7b892..811b24e4 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 
 SUBDIRS = log-writes perf
 
-LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread -lrt
+LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
 
 ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
 LINUX_TARGETS += loggen
diff --git a/src/multi_open_unlink.c b/src/multi_open_unlink.c
index d697e5f1..c221d39e 100644
--- a/src/multi_open_unlink.c
+++ b/src/multi_open_unlink.c
@@ -12,9 +12,10 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <attr/attributes.h>
+#include <sys/xattr.h>
 
 #define MAX_EA_NAME 30
+#define MAX_VALUELEN	(64*1024)
 
 /*
  * multi_open_unlink path_prefix num_files sleep_time
@@ -40,7 +41,7 @@ main(int argc, char *argv[])
 	int sleep_time = 60;
 	int num_files = 100;
 	int num_eas = 0;
-	int value_size = ATTR_MAX_VALUELEN;
+	int value_size = MAX_VALUELEN;
 	int fd = -1;
 	int i,j,c;
 
@@ -87,7 +88,6 @@ main(int argc, char *argv[])
 			int sts;
 			char *attrvalue;
 			char attrname[MAX_EA_NAME];
-			int flags = 0;
 
 			snprintf(attrname, MAX_EA_NAME, "user.name.%d", j);
 
@@ -98,7 +98,7 @@ main(int argc, char *argv[])
 				return 1;
 			}
 
-			sts = attr_set(path, attrname, attrvalue, value_size, flags);
+			sts = setxattr(path, attrname, attrvalue, value_size, 0);
 			if (sts == -1) {
 				fprintf(stderr, "%s: failed to create EA \"%s\" of size %d on path \"%s\": %s\n",
 					prog, attrname, value_size, path, strerror(errno));
-- 
2.23.0



