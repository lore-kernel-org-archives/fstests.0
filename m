Received: from mail.cn.fujitsu.com ([183.91.158.132]:4889 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933589AbeF0ItY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:49:24 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 172044B43D24
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 16:49:18 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH 1/3] fsstress: use sys/xattr.h instead of attr/xattr.h
Date: Wed, 27 Jun 2018 16:49:11 +0800
Message-ID: <20180627084913.4730-2-lufq.fnst@cn.fujitsu.com>
In-Reply-To: <20180627084913.4730-1-lufq.fnst@cn.fujitsu.com>
References: <20180627084913.4730-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since attr v2.4.48 has removed <attr/xattr.h>, use <sys/xattr.h>
provided by glibc.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 ltp/fsstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 1bffa115bf2d..c1f28e7c4567 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -11,7 +11,7 @@
 #include "global.h"
 
 #ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #endif
 #ifdef HAVE_ATTR_ATTRIBUTES_H
 #include <attr/attributes.h>
-- 
2.18.0



