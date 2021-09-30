Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7232DC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Sep 2021 10:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518FB6115A
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Sep 2021 10:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbhI3KJp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:09:45 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.5]:28275 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349640AbhI3KJp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Sep 2021 06:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1632996482; i=@fujitsu.com;
        bh=f4kMF5kg6rCSr1FgizYxwFyzpjdaxGSzeirzOyNtqAs=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=COfcy+LFWpnsnv4YbXDz60TZ23A1m/qXjOXNZUujBJjSqO3adNcqIixjKHpZDyER+
         2HPeY0Vj9Nt4r5C5St2FlO4n8VbXBJuhnHO3NclVeuVjhTVI4/bW1JqVcNkaY86t41
         FJ/Qo/kfANqBCu9A5T9F7ygYv1aAAiY2qETDZP0/TOkOyVZcw+fUTHQ1QkrTU9Q1Ca
         bQx0FR8kkrsfiUK9+1pSNpwvyPTS2aJ94XFlLlcbu4R6Is5w5IptGWDapNiDHG93Fn
         KbKjWUFTclxEwwG5/RYgn7SDwsLH1wHnMlAVAWo/OfS03AODF1bOeJFhXo8PDhSR23
         AYi/8UtwkdUWg==
Received: from [100.112.195.149] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-west-1.aws.symcld.net id 7D/33-01625-18C85516; Thu, 30 Sep 2021 10:08:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRWlGSWpSXmKPExsViZ8MRqtvYE5p
  o8KtV1eJ0y152B0aPz5vkAhijWDPzkvIrElgznq55yl7wlaNi+8pTbA2Md9i7GLk4hAQ6mSTW
  tf1mhHD2MEoc3PsGKMPJwSagKfGscwEziC0iICvxf8ZqJhCbWUBdYvmkX2C2sICjxPEP31lAb
  BYBVYkbp78wgti8Ah4S2+6fAbMlBBQkpjx8zwwRF5Q4OfMJC8QcCYmDL14wQ9QoSlzq+AZVXy
  Exa1Yb0wRG3llIWmYhaVnAyLSK0SKpKDM9oyQ3MTNH19DAQNfQ0EjX0NJI18jARC+xSjdRL7V
  Utzy1uETXUC+xvFivuDI3OSdFLy+1ZBMjMLxSCg6c2cF46vUHvUOMkhxMSqK8xWGhiUJ8Sfkp
  lRmJxRnxRaU5qcWHGGU4OJQkeMu6gHKCRanpqRVpmTnAUIdJS3DwKInw+ncDpXmLCxJzizPTI
  VKnGHU5Ll+ft4hZiCUvPy9VSpxXHKRIAKQoozQPbgQs7i4xykoJ8zIyMDAI8RSkFuVmlqDKv2
  IU52BUEub1BJnCk5lXArfpFdARTEBHZLWHgBxRkoiQkmpgckx+ectzU+8DZ+dbFstYC6Yt/7x
  +S2OCzZvEUFGu1+d65145Zn9/nlX15K11Mp8+ikg7MFocjpQRcmyY7tsnX+ZceFyps/jgKk1V
  5RZD1qci6T7ljWW/upTVmmxOJxzyUj35R3XTymlBvxYVbpNlvSP8Wm56rvaPr/x/NHNflLznD
  t31rm5j2L/oNYuC2PW1Vx+ftrbuf6r23zCmBU9//5k3Oe6O8PpnCxbevBfxvm63S0z12dcfCg
  0uCPoHWMfECV7S1nU2YS8IjC47amUV9Hbliz7dKbbzqzROPVys6LEu/0fPs2sa+ke3eejdkdg
  znfNBjt2dhMCZ5aGZs4NLa3hbJvpwCCxdkrHIz5lBiaU4I9FQi7moOBEAhEo4sjYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-267.messagelabs.com!1632996481!149599!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22114 invoked from network); 30 Sep 2021 10:08:01 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-5.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Sep 2021 10:08:01 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 18UA7rFo003542
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Thu, 30 Sep 2021 11:08:01 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 11:07:51 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/540: Use _scratch_xfs_set_metadata_field api
Date:   Thu, 30 Sep 2021 18:08:00 +0800
Message-ID: <1632996480-2153-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

With older xfsprogs, xfs_db write subcmd doesn't -d option. So this case fails.
Use _scratch_xfs_set_metadata_field api to avoid this.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/540 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/540 b/tests/xfs/540
index b00b9bcc..55484dd3 100755
--- a/tests/xfs/540
+++ b/tests/xfs/540
@@ -41,11 +41,11 @@ _scratch_unmount
 
 echo "Misconfigure the root directory"
 rtextsz_blks=$((rtextsz / dbsize))
-_scratch_xfs_db -x -c "inode $rootino" \
-	-c "write -d core.extsize $((rtextsz_blks + 1))" \
-	-c 'write -d core.rtinherit 1' \
-	-c 'write -d core.extszinherit 1' \
-	-c 'print' >> $seqres.full
+
+_scratch_xfs_set_metadata_field core.extsize $((rtextsz_blks + 1)) "inode $rootino" >> $seqres.full
+_scratch_xfs_set_metadata_field core.rtinherit 1 "inode $rootino" >> $seqres.full
+_scratch_xfs_set_metadata_field core.extszinherit 1 "inode $rootino" >> $seqres.full
+_scratch_xfs_db -x -c "inode $rootino" -c 'print' >> $seqres.full
 
 echo "Detect misconfigured directory"
 _scratch_xfs_repair -n >> $seqres.full 2>&1 && \
-- 
2.23.0

