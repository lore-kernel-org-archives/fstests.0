Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502F7C432BE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF461131
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbhIAMpv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:45:51 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:60054 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345383AbhIAMoL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 08:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1630500193; i=@fujitsu.com;
        bh=KL1ud68KQVVQydzZAupKAFJ9Dn+IiZslUE7Mgjoa0xw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=rY1Bt+YF51Nf6vCpdMe7hZN6OXZ5jJxrKU9woassg032e7K+M/fAT3+d0dkQxoGn6
         ABGbIfjR0nmXy8yLfYsDN0voK6Gi2sa5fRZxKrQwuoziyPoe6im9xhylYwc7iKBSh7
         0ZBnnw9Vqoo+RG8aS7I+MjBDMcOnJSw8Wcg3b2p2I7wvSyDLygduMaIC+WE26n0k1Z
         UC+GzvkA8mSNKCqmbgo0/CIIt5pMWqZpS07pzEKpj8BYw8kucAmXUqDmG+V11Z9S8h
         ltJZGi3PUYcQeaDE1miAZnuYMlLkrJ1gg22PDWJ99OWZwFfFP4SVr1SA8Ds2d2jbp5
         5aOwgvCQRXBuw==
Received: from [100.113.2.26] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 15/8F-24763-1657F216; Wed, 01 Sep 2021 12:43:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8MRqptYqp9
  ocO+UgsXplr3sDowenzfJBTBGsWbmJeVXJLBmHDj3mKXgHXfFubO97A2Mi7i6GLk4hAQ6mCRW
  rJjJCuHsZpR43n+TqYuRk4NNQFPiWecCZhBbREBW4v+M1WBxZgF1ieWTfoHZwgIFEk/WnAWzW
  QRUJC5c3sIGYvMKeEq8u3EFzJYQUJCY8vA92BxOAS+J36susYDYQkA1E9/+ZYKoF5Q4OfMJC8
  R8CYmDL14wQ/QqSlzq+MYIYVdIzJrVxjSBkX8WkpZZSFoWMDKtYrRMKspMzyjJTczM0TU0MNA
  1NDTWNdQ1NDHSS6zSTdRLLdVNTs0rKUoEyuollhfrFVfmJuek6OWllmxiBAZkSiFj3w7GiW8+
  6B1ilORgUhLlZYnUTxTiS8pPqcxILM6ILyrNSS0+xCjDwaEkwbsrAygnWJSanlqRlpkDjA6Yt
  AQHj5II75JCoDRvcUFibnFmOkTqFKMux86j8xYxC7Hk5eelSonzrisBKhIAKcoozYMbAYvUS4
  yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeWcXA03hycwrgdv0CugIJqAjeH7ogBxRkoiQkmp
  gkt/+vNOy6cIstVTf40cDom4GHmt38Sp0CN6QrbWx/uv31udc91vN7O6pdndIJB3RPLOjOSHu
  Huup5VquQfti3u5etZ7pwzfRJknt2ntLfrdI7lu0ZJ1C6PqWHas/m11eu5st4r73ogOymnO5j
  oVuWMR6dIeC5b7ruY4l8YXPmxXfT4iyXjVFJWbSfO8Hjy2W7L65+L5FzhTJ9sbGxXsaGs0EhL
  +aWjdMfvfk5XbfB67nVQ9pLPLNX2Bz1e+C6+HZutwbPnGc2Wda+utvoED/1R+HrvWIeu/S7Jd
  JWVm+rUbA41/Cv6UZfzbfm+N5j+/elQ+2XQoOGT65bz/cmOX1ceqs+mMXF9d+zs+Vf/q+8IkS
  S3FGoqEWc1FxIgAJkp/mTwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-232.messagelabs.com!1630500193!46255!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28158 invoked from network); 1 Sep 2021 12:43:13 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-5.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2021 12:43:13 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 181ChAfT006407
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 1 Sep 2021 13:43:13 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 1 Sep 2021 13:43:11 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 4/4] src/idmapped-mounts/idmapped-mounts.c: Fix build error because of undefined reallocarray
Date:   Wed, 1 Sep 2021 20:43:26 +0800
Message-ID: <1630500206-15545-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On old glibc, reallocarray was not introduced, so this case compiles failed.
We should use reallocarray if glibc supports and use realloc if glibcs doesn't
support reallocarray.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                          | 1 +
 src/idmapped-mounts/idmapped-mounts.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index 0b55455a..6e5ab397 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,6 +68,7 @@ AC_PACKAGE_WANT_LIBBTRFSUTIL
 
 AC_HAVE_COPY_FILE_RANGE
 AC_CHECK_FUNCS([renameat2])
+AC_CHECK_FUNCS([reallocarray])
 AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
 AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
 #include <stddef.h>
diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4230cb48..83b7c89a 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -9910,8 +9910,12 @@ static int append_stack(struct btrfs_iter *iter, uint64_t tree_id, size_t path_l
 	if (iter->stack_len >= iter->stack_capacity) {
 		size_t new_capacity = iter->stack_capacity * 2;
 		struct btrfs_stack *new_search_stack;
+#ifdef HAVE_REALLOCARRAY
 		new_search_stack = reallocarray(iter->search_stack, new_capacity,
 						sizeof(*iter->search_stack));
+#else
+		new_search_stack = realloc(iter->search_stack, new_capacity * sizeof(*iter->search_stack));
+#endif
 		if (!new_search_stack)
 			return -ENOMEM;
 
-- 
2.23.0

