Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED34EC05027
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 07:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjATHA2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 02:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATHA1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 02:00:27 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959CE8A68
        for <fstests@vger.kernel.org>; Thu, 19 Jan 2023 23:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1674198025; i=@fujitsu.com;
        bh=lqa5Wcjfjc0BIrst0pQ94M3ZeyGVdQrCkC6RHqjoZYA=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=YFQq83UAUvyGO/QgS4SkI5CnGpgOxCH0kO4I40ik8bNTtJhO847L7LR6V3MXTYwhs
         oe3IPn9kc9dJJHv52LcIa+lBsVAyPy9ZuMctc6SqoelMbbSDwimk8kphaJ3uZNWmPG
         yN90eK69YMgda0lSj9jjUA2J2xKKbc2N9sYIcJ7yxe3Agfzj+nQsza65JL+eTQ47x3
         iMd2RongeUueLSB5ZMMxdeQkVQLd2d8pq/K38ocoNRR9XGDB5KoyKvkO9/KeyLUBdP
         2dtNDrFF9oFJ8EoDuvSvZMOMEH7vYUAt1JuKNftDWDb7/ZKRphKx2SFyQMeGLYFBRs
         43zReZGTcCy/w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRWlGSWpSXmKPExsViZ8ORpMthcyr
  ZoG2dlsXplr3sDowenzfJBTBGsWbmJeVXJLBmrLm7galgNUvFsferGBsY7zJ3MXJxCAmcZ5TY
  17SNDcI5zCTx8ONiVghnL6PE064lQGWcHGwCmhLPOheA2SICshL/Z6xmArGZBdQllk/6BWYLC
  +hKNF1bzAhiswioSize9QOsnlfAQ2Ld5L1gNRICChJTHr6HigtKnJz5hAVijoTEwRcvmCFqFC
  X+73rGCmFXSrR++MUCYatJXD23iXkCI/8sJO2zkLQvYGRaxWhWnFpUllqka2iml1SUmZ5Rkpu
  YmaOXWKWbqJdaqlueWlyia6iXWF6sl1pcrFdcmZuck6KXl1qyiREYjCnFTM93MJ5d9kfvEKMk
  B5OSKC+n0alkIb6k/JTKjMTijPii0pzU4kOMMhwcShK8i3SBcoJFqempFWmZOcDIgElLcPAoi
  fBGWQGleYsLEnOLM9MhUqcYdTnWNhzYyyzEkpeflyolzrsbpEgApCijNA9uBCxKLzHKSgnzMj
  IwMAjxFKQW5WaWoMq/YhTnYFQS5l0CMoUnM68EbtMroCOYgI74kHES5IiSRISUVAOTyRmDtw/
  ilqi+scqtM/1pNv1j6IG7kiedLV0W/Z1QnbhV4Ef6vC4P7U19KSZi+y3FelJV3glaRDoc3bF5
  hfI0IRNWpXt2i7+vOnC/5/L7olqthbYOfOyqAhNv+AfyTZZRXRSolTrRdOGDLCeFrLtu8+ZxB
  L484fBjwyOlbTLZWz98Lu2udJffk7Hh8VSlQ0umyD/afnZL2v68NYEvjjKkrfi3a23HzDDe5Q
  wLBB79e/ajTMXulSX33fy+tUkv20p1iu9eOfZR8Nq3gGb1oo1pr72efXIJ2XaYqW2p9cL/C1Z
  LzjpmGp1uyWd+YVXGvYa+5Juxx7f9/zIr1lDOcuoZpwnfehKqtVw/s2q9yrFYp8RSnJFoqMVc
  VJwIAEcdiDZNAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-587.messagelabs.com!1674198024!164359!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31460 invoked from network); 20 Jan 2023 07:00:24 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-6.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jan 2023 07:00:24 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 4D3C71B5
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 07:00:24 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 40E6E1AE
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 07:00:24 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.99) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 20 Jan 2023 07:00:22 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/557: Use fixed commit id
Date:   Fri, 20 Jan 2023 02:00:12 -0500
Message-ID: <1674198012-3942-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.99]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/557 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/557 b/tests/xfs/557
index 425695db..acc28252 100644
--- a/tests/xfs/557
+++ b/tests/xfs/557
@@ -18,7 +18,7 @@ _require_xfs_io_command "falloc"
 _require_xfs_io_command "bulkstat_single"
 _require_scratch
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 817644fa4525 \
 	"xfs: get root inode correctly at bulkstat"
 
 # A large stripe unit will put the root inode out quite far
-- 
2.23.0

