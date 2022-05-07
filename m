Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C1C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 12:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446313AbiEGMJ7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352692AbiEGMJ6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 08:09:58 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30484167D3;
        Sat,  7 May 2022 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1651925170; i=@fujitsu.com;
        bh=rCYDHPnlJF3M5DqqB0GRSQufn8n+/6vsz5EEKAwvAeg=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Ayow6u2aBuOf4/RA2tNJ7ximkKO6W9IA2ZDEP+wAH1PE0FaUp3yGDnHoSTFnBNc2v
         zBFsxb/slk2DsoVkKxlB6mvE0RK5y7ryFKMCwVg3QI05BFhcSqzGO8sDZlyK63qmW9
         y8RMdf88J7KmW5zgZhs9pcprlUTtYksV6uQX/1dTyMbSgfNqKFShuHSjPD+krssajR
         5gWeg5s0yb5kJs3J/jIdTONGsEtMNPvMxZM/ZgL+D/XyXtNL2prBUENi88YhWuvanL
         qnx1Fgfsu5TgJCUaABxT9SPrKpqm+Oc076D7MOn3+D66tMEeRnJT0X8u0iGFF3B4Q8
         uaFP3d+85cxBQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRWlGSWpSXmKPExsViZ8MxRXdjQlm
  SQcN+TYvXhz8xWmw5do/R4vITPovTLXvZLfbsPcniwOpxapGEx6ZVnWwenzfJBTBHsWbmJeVX
  JLBm9P9sYC74y14x+eBapgbGj2xdjFwcQgKvGCXuvGxlhnB2M0qsXXmHqYuRk4NNQFPiWecCZ
  hBbRMBF4tv+v2wgNrNAjkTD7h9gNcICPhLbNkxhBbFZBFQkpj76zNLFyMHBK+Ah8bbDHSQsIa
  AgMeXhe7AxvAKCEidnPmGBGCMhcfDFC2aIGkWJSx3fGCHsColZs9qYJjDyzkLSMgtJywJGplW
  MtklFmekZJbmJmTm6hgYGuoaGprpmJrrGJnqJVbqJeqmlusmpeSVFiUBZvcTyYr3U4mK94src
  5JwUvbzUkk2MwPBMKXZQ2sF4tu+n3iFGSQ4mJVHeFpvSJCG+pPyUyozE4oz4otKc1OJDjDIcH
  EoSvB9jy5KEBItS01Mr0jJzgLECk5bg4FES4WWOBkrzFhck5hZnpkOkTjEqSonzGsUDJQRAEh
  mleXBtsPi8xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYVxVkCk9mXgncdGC8Ad0swvsxoBR
  kcUkiQkqqgalJ9Lcyk/POgh8GZdpV+rOuaYeJmdXWnso0+vngk2ltV+avyS9tD4vE/3ebFyB8
  be1L3lJHo0eRB/vW89UsYjhsHrZBQyRdw3DuhiuHRVyvTpsQvoZv3XK/vFg51YIVBXpBH1uiB
  Fo26qV6TY76YrxA69rtdXvyslays7bGn4kKM7/1LFtvsUoz79vonvA05UMrWVI0MxbxNJlENA
  gF7fs2adpk3l/Mbe2f2pdcWbbYJGbL0kuR/jeDTPqsX4U9bg54ncm2VSV/2vLE85Fykw7z/01
  9bOqdW59exFXHrr9VUq0ttilSd/9Kxi/X30fbtr6ebh75M+bpOZvl3pFxqV8Yk46djXxTpaFQ
  k5qtxFKckWioxVxUnAgA71VVzEoDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-528.messagelabs.com!1651925169!27289!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2900 invoked from network); 7 May 2022 12:06:09 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-19.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 May 2022 12:06:09 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 247C5u6R005941
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 7 May 2022 13:06:04 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 7 May 2022 13:05:54 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 1/3] idmapped-mounts: Reset errno to zero before run_test
Date:   Sat, 7 May 2022 21:05:24 +0800
Message-ID: <1651928726-2263-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If we run case on old kernel that doesn't support mount_setattr and
then fail on our own function before call is_setgid/is_setuid function
to reset errno, run_test will print "Function not implement" error.

We also check whether system support user namespace, so reset errno to
zero after userns check.

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v3->v4: move this reset step after sys_has_usersn()
 src/idmapped-mounts/idmapped-mounts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index ce3f73be..2e94bf71 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14232,6 +14232,8 @@ int main(int argc, char *argv[])
 		exit(EXIT_SUCCESS);
 	}
 	t_has_userns = sys_has_userns();
+	/* don't copy ENOSYS errno to child process on older kernel */
+	errno = 0;
 
 	stash_overflowuid();
 	stash_overflowgid();
-- 
2.31.1

