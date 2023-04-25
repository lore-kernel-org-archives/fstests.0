Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D9C6FD18
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 05:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDYFeS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjDYFeM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 01:34:12 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036917AA1
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 22:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682400849; i=@fujitsu.com;
        bh=7Pm62J5w8ZsEeFanzWReY857BGNbCSgRlwg/4VOowAs=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=rvDsrJK2/7eu3gqGqzpbU2AgmdZ1zpZa4Xqp+J5juK0OX0z9MHHeiTcoGmvp6T4O/
         LCWXqJW+LjvUIdVV9R7t2sgAGNQMiMC29uSztqFnPQoRRiDy1KNhz+hEiD3kKPYdlA
         XdbjywMHtkHKVtcDl1XxTdEsbnj8DnFUzjg7xSxluuIaTk+E4hYjFNwOASBAZuTPgQ
         bbx8bSJOVfun3PBO3Qh4VcaXxTD05uNgd7Lv3oh2Jv6Z+v2e9ME4poS9XRA8LKGMjI
         Q5sIGUw70lzRyJJOHB4CFfoq0Rz+lIzKkMlL7NG7U1lOGLr8CRc/puicj555lYk3eh
         Wfxl/2XzCGYiA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8OxWTcgzT3
  FYMdOdovXhz8xWpxu2ctucf7wAkaL9qeTGB1YPDat6mTz2PnQ0uPzJrkA5ijWzLyk/IoE1oxd
  mxsZC17yVfT8L2tgPMnTxcjFISSwkVGiu3sDE4SzhEli/8d3rBDOPkaJrltfgBxODjYBTYlnn
  QuYQWwRAVmJ/zNWM4HYzAJ1Em1Lv7F0MXJwCAs4SzzuFgcJswioSpx81wTWyivgKbFz4zJGEF
  tCQEFiysP3zBBxQYmTM5+wQIyRkDj44gUzRI2SRFvrFVYIu1Ki9cMvFghbTeLquU3MExj5ZyF
  pn4WkfQEj0ypGs+LUorLUIl0TvaSizPSMktzEzBy9xCrdRL3UUt28/KKSDF1DvcTyYr3U4mK9
  4src5JwUvbzUkk2MwMBNKU74sYPx5s6/eocYJTmYlER5ucLcUoT4kvJTKjMSizPii0pzUosPM
  cpwcChJ8AqluqcICRalpqdWpGXmAKMIJi3BwaMkwrszHijNW1yQmFucmQ6ROsWoy7FpX9cBZi
  GWvPy8VClx3jUpQEUCIEUZpXlwI2ARfYlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO8lkCk
  8mXklcJteAR3BBHTELm4XkCNKEhFSUg1MM964/pwccXL+0rxoJeb04HdzjhqeXflf5J7czxy9
  ndMWPto7YfrdGUzxV0V0SjY0TUu47ffD2uLoeTN/3onR2+oK9rSJ+iv3JYbvMMsKcpBtSzjMt
  lLGOW0Ly+cdytmvxKSYPYUer/8vdS2u0rRnxcOH0cvfHX4t7rBzziPTwO0dkaEqlzZr3ytber
  xxNrPAy5qff3ZrfVs0t0jiq9+Ugwv5Vb7kzuXILi88HV2hdH3lzs7Mo0bdhR0T5H2+mkms0Xj
  z7nwar+Wi//vq2It2RJyWWHpsgspZ1c1yb8IVbbdM+vG7e9q8b52NQg0Fkw0sgv4/9q8Lyijm
  kNdZECyxMG3yrxW3s54UGj4qV9y5WYmlOCPRUIu5qDgRAG3cCxZjAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-745.messagelabs.com!1682400847!387720!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31176 invoked from network); 25 Apr 2023 05:34:08 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-11.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2023 05:34:08 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 8DDCF142;
        Tue, 25 Apr 2023 06:34:07 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 81C937B;
        Tue, 25 Apr 2023 06:34:07 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 06:34:05 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <hsiangkao@linux.alibaba.com>, <brauner@kernel.org>,
        <ZiyangZhang@linux.alibaba.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] src/detached_mounts_propagation: Fix compile error
Date:   Tue, 25 Apr 2023 13:33:54 +0800
Message-ID: <1682400834-16985-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
in addition to <linux/mount.h>(we also include this kernel header when using
global.h).

Usually we should use glibc header instead of kernel header.
But now mount.h is a special case because both new glibc header and
kernel header all define "struct mount_attr'. They also define MS*
macro.

Since we have some syscall wrapper in vfs/missing.h, we can use
<linux.mount.h> directly instead of <sys/mount.h>.

In fact, newer glibc(2.37-1)[1] has sloved conflict problem between
<sys/mount.h> and <linux/mount.h>. In the future(maybe ten years),
we can remove this kernel header and use glibc header.

[1]https://sourceware.org/git/?p=glibc.git;a=commit;h=774058d72942249f71d74e7f2b639f77184160a6

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/detached_mounts_propagation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
index 17db2c02..dd11f7be 100644
--- a/src/detached_mounts_propagation.c
+++ b/src/detached_mounts_propagation.c
@@ -20,7 +20,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -127,7 +126,7 @@ int main(int argc, char *argv[])
 	if (ret < 0)
 		exit_log("%m - Failed to create new mount namespace");
 
-	ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
+	ret = sys_mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
 	if (ret < 0)
 		exit_log("%m - Failed to make base_dir shared mountpoint");
 
@@ -174,7 +173,7 @@ int main(int argc, char *argv[])
 		}
 		close(fd_tree);
 
-		ret = umount2(target, MNT_DETACH);
+		ret = sys_umount2(target, MNT_DETACH);
 		if (ret < 0) {
 			fprintf(stderr, "%m - Failed to unmount %s", target);
 			exit_code = EXIT_FAILURE;
-- 
2.39.1

