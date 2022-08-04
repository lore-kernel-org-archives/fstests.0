Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4AC00144
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Aug 2022 05:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiHDFSX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Aug 2022 01:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiHDFSX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Aug 2022 01:18:23 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC42229B
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659590295; i=@fujitsu.com;
        bh=smDnGogQPyx6jg8pHQLP5FA+2kDlGJgu6asaFgaq3ec=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ejVicccLTMAoAjt+LitSdxiqr3thZZL0cxr042WmsdYGkaHxmZP7nLNAaUjjhw/Wa
         B0rkofFsnybjbYRmYQXlFK261MRKSArnPxaueF8/E8/3WAlwuxjM3QInbU6PsmQ1Dp
         8jT5S5oG7cGOOg5NaniK4DUxH7Aw9kKts3Dp6ZHhkPsjinoG+VuSFy6+gU74vPnmAL
         B/Bx4D1yUTMPCUg02Yjt4qdX92xCCzEZmqbMOO2cezo1KnuX9yiCsUs4ugHaErsNEW
         YNM2LrLmg4PAIr1Vlfx9qf86m1ozmKdXLVDHFSNo1BS4iuGgulvZRKTst/k3+aN/hT
         MTE0QV+JvUqng==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8OxWXd62Os
  kg4NzBS1Ot+xld2D0+LxJLoAxijUzLym/IoE1Y+HVo4wFm9kqHr97zdzAuIy1i5GLQ0jgHKPE
  ty8X2CGcg0wS1+5OgXJ2M0psaD7N2MXIycEmoCnxrHMBM4gtIiAr8X/GaiYQm1lAXWL5pF9gt
  rCAucTEM7PZQWwWARWJD8s/gdXzCnhIPNn7D6xGQkBBYsrD91BxQYmTM5+wQMyRkDj44gUzRI
  2ixKWOb4wQdoXE68OXoOJqElfPbWKewMg/C0n7LCTtCxiZVjFaJRVlpmeU5CZm5ugaGhjoGhq
  a6hpb6loY6SVW6SbqpZbqlqcWl+gCueXFeqnFxXrFlbnJOSl6eaklmxiBQZlSrB60g/Hbip96
  hxglOZiURHll3V4nCfEl5adUZiQWZ8QXleakFh9ilOHgUJLgNQsBygkWpaanVqRl5gAjBCYtw
  cGjJMIb6wuU5i0uSMwtzkyHSJ1i1OWYOvvffmYhlrz8vFQpcd76UKAiAZCijNI8uBGwaL3EKC
  slzMvIwMAgxFOQWpSbWYIq/4pRnINRSZi3BuQSnsy8ErhNr4COYAI6QofrBcgRJYkIKakGJiX
  h9N4Skfi7juu0rp/0tP/A0/5jdZd1+Y+jx6UF/0lOvPMt6sy+xZs120su5+4u/mgQJd+imrBw
  47oX642TBZmmGP/3mWUwc07bZH2GUibDDhXr5PD98+oWRE2pWLNRVNEgcucyx7iQr4unJf6a2
  hBx4+ye5qzKQAPZ/tlMk4z2eHevy4g67fDy/dwVtmv+qMyxcT37ZXNB+aIfLn2TLn/hjGlbv/
  nr8m+ffysHsfS+09LL/f/gx0zhvOPnhbMk3+W2CF8PmZv7uI7hQcara0k76rSnlDZoTDBxbW7
  RjypLY72c/m/VKptOy78hH0L489wlRDtZGKS4a6+w//S4Kv/3xcyCi19MDqvMVSz4o8RSnJFo
  qMVcVJwIABjV2W1RAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-571.messagelabs.com!1659590295!74686!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28416 invoked from network); 4 Aug 2022 05:18:15 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-2.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Aug 2022 05:18:15 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 033A57B
        for <fstests@vger.kernel.org>; Thu,  4 Aug 2022 06:18:15 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id EB34675
        for <fstests@vger.kernel.org>; Thu,  4 Aug 2022 06:18:14 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 4 Aug 2022 06:18:13 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] src/t_ofd_locks.c: Reset errno to zero
Date:   Thu, 4 Aug 2022 14:18:52 +0800
Message-ID: <1659593932-4158-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It seems I met libcap errno bug again when using libcap-2.48-4.el8.x86_64.
But this time, errno is EINVAL if c program link with lcap.
Lastest upstream libcap doesn't have bug and it should be backport bug.

generic/478 will become not run because of this. To fix this that only
exists on some distributions, reset errno to zero.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/t_ofd_locks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index e3b15ddc..e77f2659 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -187,6 +187,8 @@ int main(int argc, char **argv)
 	struct sembuf sop;
 	int opt, ret, retry;
 
+	//avoid libcap errno bug
+	errno = 0;
 	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFd")) != -1) {
 		switch(opt) {
 		case 's':
-- 
2.27.0

