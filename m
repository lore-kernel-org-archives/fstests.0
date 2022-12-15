Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6D6C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Dec 2022 03:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLODUo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Dec 2022 22:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLODUm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Dec 2022 22:20:42 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F09D6165
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 19:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1671074437; i=@fujitsu.com;
        bh=TAJK6VnJiRAmPh4tnEFbphOh+wsifPCs7q03yKNMzGs=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Iq+YbtY+nXHHaDkQYu9UFq4qPoPP53dzoScSsRhdNoy8KkPgUhK0nWBPK68GVDgms
         Amp4Ma8DKCuy6L0/T72n2B35J7UB6nELLeYfn/kyDDBpMEB9IxtH5E2+913agBBCQF
         bqX3c08Lm5tzcbsqwVw89neB6CiXDfxNTUbH9OcpmS+ZLnHE9pyf7ah3LGdpnYyklY
         Ghc1q2av43pu5RklE7MtngrNaoc0YFNp78kmfI4qyBtXj68CqXK5DmPtLTDVIiRpLg
         86AaJlEha4HAqfsVtyYNEFYoBaVMaxkd+QgcsZx7+SeokncSgUmagujgTJG9EqXS4U
         B4cFg9vw/QRKQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRWlGSWpSXmKPExsViZ8ORqNsyaVa
  ywaLlVhanW/ayOzB6fN4kF8AYxZqZl5RfkcCaseBJQME59oo9Fy+zNTDOZ+ti5OIQErjEKNF1
  s40ZwjnKJDF/0kkWCGcPo8Ti/pXsXYycHGwCmhLPOhcwg9giArIS/2esZgKxmQXUJZZP+gVmC
  wv4SBxtnwhWzyKgKnFlyWZGEJtXwFNi/9TdLCC2hICCxJSH75kh4oISJ2c+YYGYIyFx8MULZo
  gaRYlLHd8YIewKiVmz2pggbDWJq+c2MU9g5J+FpH0WkvYFjEyrGM2KU4vKUot0DU30kooy0zN
  KchMzc/QSq3QT9VJLdctTi0t0DfUSy4v1UouL9Yorc5NzUvTyUks2MQJDMaWYbdUOxl/L/ugd
  YpTkYFIS5Z2nOStZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTvil6gnGBRanpqRVpmDjAuYNISH
  DxKIryPQdK8xQWJucWZ6RCpU4y6HFNn/9vPLMSSl5+XKiXOKzsRqEgApCijNA9uBCxGLzHKSg
  nzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5p0/AWgKT2ZeCdymV0BHMAEdIXNvJsgRJYkIKakGJm7
  BgzOTk7SvGs0qvqV47e2N1YpF6qeS2Wc+Tpjb80fI2WDj+xlbnO4539PjUL61iu2BhufsPrWX
  Nbl9py8IF9SFxm+9tfjrspO1Kw8fClOwbV9fJGWqvrq84+LNHH291eoZqtL8Oz2slRg/t/s93
  MeguGj2mhk/ZsyaV8HMHrlpV46USUjfq47zAU8eLOw/8d1P4NmG3l37Lxrop1rmMN1af75EYA
  vTqvW2Nlu6Q2TVkhTMtDpPrLvK3ep/PzjvfshnZbUjXZeOTNbrObqjSEqDWcS/rtP/k+uUW+q
  795xbu3nH55+f0lUEzdVXbg9fJGWU4esxe2XscRnh58f+5pSrWlXvCGZUzZHPTHHjVGIpzkg0
  1GIuKk4EAFUJF4NMAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-23.tower-585.messagelabs.com!1671074436!160389!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6385 invoked from network); 15 Dec 2022 03:20:36 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-23.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Dec 2022 03:20:36 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 91D2310018D
        for <fstests@vger.kernel.org>; Thu, 15 Dec 2022 03:20:36 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 862F5100043
        for <fstests@vger.kernel.org>; Thu, 15 Dec 2022 03:20:36 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 15 Dec 2022 03:20:34 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1] src/vfs/utils: Reset errno to zero when detect O_TMPFILE
Date:   Thu, 15 Dec 2022 12:21:41 +0800
Message-ID: <1671078101-15585-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For some filesystem that doesn't support O_TMPFILE, it will pass
ENOTSUP errno to upper layer. so it will report the following error:
QA output created by 696
vfstest.c: 1818: setgid_create_umask - Success - failure: is_setgid
vfstest.c: 2421: run_test - Operation not supported - failure...

To fix this, just reset errno before return.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/vfs/utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 6db7a11d..8b000506 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -921,10 +921,12 @@ bool openat_tmpfile_supported(int dirfd)
 
 	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
 	if (fd == -1) {
-		if (errno == ENOTSUP)
+		if (errno == ENOTSUP) {
+			errno = 0; /* Don't report misleading errno. */
 			return false;
-		else
+		} else {
 			return log_errno(false, "failure: create");
+		}
 	}
 
 	if (close(fd))
-- 
2.27.0

