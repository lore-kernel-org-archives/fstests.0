Received: from mail.cn.fujitsu.com ([183.91.158.132]:23178 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753296AbeF0KTH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 06:19:07 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 4C63748029E8
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 18:18:59 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH v2 1/3] fsstress: remove include <attr/xattr.h>
Date: Wed, 27 Jun 2018 18:18:52 +0800
Message-ID: <20180627101854.13158-2-lufq.fnst@cn.fujitsu.com>
In-Reply-To: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
References: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since commit de6d86177ff8 ("QA test updates - fixes for pquota, extsize,
fsstress, and ensure mount options passed through to test_dev. Merge of
master-melb:xfs-cmds:24763a by kenmcd.") remove llistxattr from
fsstress, xattr.h is useless.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
v2: remove useless xattr.h
 ltp/fsstress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 1bffa115bf2d..edbb3f2f8fb9 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -10,9 +10,6 @@
 #include <stddef.h>
 #include "global.h"
 
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
-#endif
 #ifdef HAVE_ATTR_ATTRIBUTES_H
 #include <attr/attributes.h>
 #endif
-- 
2.18.0



