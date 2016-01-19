Received: from cn.fujitsu.com ([59.151.112.132]:24259 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757321AbcASIBO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 19 Jan 2016 03:01:14 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id AD73D41896F4
	for <fstests@vger.kernel.org>; Tue, 19 Jan 2016 16:00:31 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] fsx.c: Add header file stdbool.h
Date: Tue, 19 Jan 2016 16:00:28 +0800
Message-ID: <1453190428-7379-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Compilation failed on RHEL6.7GA because stdbool.h is not included in
xfs/platform_defs-x86_64.h or xfs/linux.h on RHEL6.7GA, so fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 ltp/fsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 28f109c..a7b36c1 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -20,6 +20,7 @@
 #include <strings.h>
 #include <sys/file.h>
 #include <sys/mman.h>
+#include <stdbool.h>
 #ifdef HAVE_ERR_H
 #include <err.h>
 #endif
-- 
1.8.3.1



