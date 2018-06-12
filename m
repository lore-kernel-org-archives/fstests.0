Received: from szxga04-in.huawei.com ([45.249.212.190]:8664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754343AbeFLMmc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Jun 2018 08:42:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 115D252C5CFE
        for <fstests@vger.kernel.org>; Tue, 12 Jun 2018 20:42:19 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH] ltp/fsx: output the seed value after logid is initialized
Date: Tue, 12 Jun 2018 20:43:30 +0800
Message-ID: <20180612124330.47796-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

When running multiple fsx processes simultaneously (e.g. generic/455),
it is difficult to tell the seed value for one fsx process if the
seed value is needed to reproduce a log-replay failure.

Fix it by outputting the seed value after logid is initialized.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 ltp/fsx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 65f1a3bb..f8cedb24 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2070,8 +2070,6 @@ main(int argc, char **argv)
 				seed = time(0) % 10000;
 				seed += (int)getpid();
 			}
-			if (!quiet)
-				prt("Seed set to %d\n", seed);
 			if (seed < 0)
 				usage();
 			break;
@@ -2138,6 +2136,8 @@ main(int argc, char **argv)
 	signal(SIGUSR1,	cleanup);
 	signal(SIGUSR2,	cleanup);
 
+	if (!quiet && seed)
+		prt("Seed set to %d\n", seed);
 	srandom(seed);
 	fd = open(fname, o_flags, 0666);
 	if (fd < 0) {
-- 
2.16.2.dirty

