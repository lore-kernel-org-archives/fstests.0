Received: from mail.cn.fujitsu.com ([183.91.158.132]:2733 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbfBUHjM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Feb 2019 02:39:12 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 71B8A4BAD9DB
        for <fstests@vger.kernel.org>; Thu, 21 Feb 2019 15:39:01 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] src/Makefile: Link clock_gettime(2) with -lrt
Date: Thu, 21 Feb 2019 15:39:01 +0800
Message-ID: <1550734741-4375-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Compiling t_open_tmpfiles.c failed on older glibc(before glibc v2.17)
because clock_gettime(2) was not linked with -lrt, as below:
--------------------------------------------------------------------
/home/yangxiao/xfstests/src/t_open_tmpfiles.c:36: undefined reference to `clock_gettime'
--------------------------------------------------------------------

According to clock_gettime(2) manpage, we should link clock_gettime(2)
with -lrt on older glibc.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index dbba7c7..4057d7b 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 
 SUBDIRS = log-writes perf
 
-LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread
+LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread -lrt
 
 ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
 LINUX_TARGETS += loggen
-- 
1.7.1
