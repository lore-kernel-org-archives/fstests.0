Received: from mail.cn.fujitsu.com ([183.91.158.132]:45803 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752035AbeF0KTG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 06:19:06 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C79844B34D40
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 18:18:59 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH 2/3] src/t_immutable: use sys/xattr.h instead of attr/xattr.h
Date: Wed, 27 Jun 2018 18:18:53 +0800
Message-ID: <20180627101854.13158-3-lufq.fnst@cn.fujitsu.com>
In-Reply-To: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
References: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since attr v2.4.48 has removed <attr/xattr.h>, use <sys/xattr.h>
provided by glibc.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 src/t_immutable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/t_immutable.c b/src/t_immutable.c
index 9a4e0169ec60..eadef78f9cbb 100644
--- a/src/t_immutable.c
+++ b/src/t_immutable.c
@@ -23,7 +23,7 @@
 #include <grp.h>
 #include <libgen.h>
 #include <sys/acl.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include <linux/fs.h>
 #include <linux/magic.h>
 #include <xfs/xfs.h>
-- 
2.18.0



