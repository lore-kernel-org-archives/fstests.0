Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5EC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 03:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE62C60FA0
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Nov 2021 03:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhKJDXt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Nov 2021 22:23:49 -0500
Received: from mail1.bemta34.messagelabs.com ([195.245.231.3]:10204 "EHLO
        mail1.bemta34.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhKJDXt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Nov 2021 22:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1636514461; i=@fujitsu.com;
        bh=C6V232v0grE5gJcQuKaUK7OdgbIz87k71k71/VblZX4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=f5AZ4vbj35j3VmImDsf5zxicBk4ub0vy6FuMLuE9y+Rd+p4V4YFrAawkG114853sZ
         o7X81ltygkTSK89oiUo9jLspLxlDqqL0dV6s79zZ2sfr4b/eLEHbTIdISJMMWr2DXo
         o16sQuHf9nw45bHAiiXzvq2Z1AC8+HMv6FNPBtf1z+aFdF9BjsuZ9ibb8D6ko51vIg
         PamIu4PFd2n8ge7Zmhmc2V+XCcK69uSq6S9EYfmnMP0WhjUVeg6kwYAMF/A2cZmgUL
         Rg8thivRG3+lBPnUPxxy7KivZLPKPD/op64kQeLregJ3+idngzEeL2M6fSUn1y75Iv
         JJYy7wnZ1+BoA==
Received: from [100.115.35.109] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-2.aws.ess.symcld.net id 67/2F-01854-C9A3B816; Wed, 10 Nov 2021 03:21:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRWlGSWpSXmKPExsViZ8MRqjvHqjv
  R4GWzrsXplr3sDowenzfJBTBGsWbmJeVXJLBmNHbuYi64xV7RMXcnSwPjMbYuRi4OIYF2Jok/
  324yQTh7GCVu75jH3sXIycEmoCnxrHMBM4gtIiAr8X/GaiYQm1lAXWL5pF9gtrCAgcSNyVPAb
  BYBVYmjLdPBbF4BD4nzH6eA9UoIKEhMefieGSIuKHFy5hMWiDkSEgdfvICqUZS41PGNEcKukJ
  g1q41pAiPvLCQts5C0LGBkWsVonVSUmZ5RkpuYmaNraGCga2hoqmtsqmtkYKKXWKWbqJdaqlu
  eWlyia6SXWF6sl1pcrFdcmZuck6KXl1qyiREYZCnFymd2MH669E3vEKMkB5OSKO8Boe5EIb6k
  /JTKjMTijPii0pzU4kOMMhwcShK8GyyAcoJFqempFWmZOcCAh0lLcPAoifBWg6R5iwsSc4sz0
  yFSpxh1Od79XLyIWYglLz8vVUqcV98SqEgApCijNA9uBCz6LjHKSgnzMjIwMAjxFKQW5WaWoM
  q/YhTnYFQS5o0GmcKTmVcCt+kV0BFMQEcc/NIOckRJIkJKqoHpwJTSlxsDN1X/a9y+zf29RO7
  397tywvX99N815FfVssqb9PAu/9K188z2GT1MtrO6We8+e8D5tDZn1Xbmy1w5gRP+xnl9i927
  bPed1ac41ukVPZnyaOJf2dvvXj7cxfK2q2fKV6EZt0UXq/07uEnkjIb+ptlCZdnBt747f75az
  PWj7Vmz4Pk7d/74aB2RW56r8MZ36Y2n27x2nldV1rP7+SSrm/uF0M5PTdmXxPec6Yr+7bdSad
  GCo9JSqp+vtbZ3fPs4M2lJwo3AOW7XX5zeczb7vNqN8F8Pr3vIuQefP5C9m4kjzFxMgWXzkXD
  tZEEh+W2XRBi7uCRals3kXJ2fwH5L0GLf+uf223fIry9SYldiKc5INNRiLipOBADmLNg1OQMA
  AA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-565.messagelabs.com!1636514460!411521!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9758 invoked from network); 10 Nov 2021 03:21:00 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-13.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2021 03:21:00 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1AA3KtZn008634
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 10 Nov 2021 03:21:00 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 10 Nov 2021 03:20:53 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] ext4/051: correct kernel commit
Date:   Wed, 10 Nov 2021 11:21:13 +0800
Message-ID: <1636514473-2107-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

ext4/051 fails on my test machine, but I can't find commit in e2fsprogs
according to commit log that said it is a e2fsprog regression test.
Actually, it is a kernel regression test.
So remind user it is a kernel regression test and use correct fix kernel
commit[1].

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2bbb92f

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/ext4/051 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/051 b/tests/ext4/051
index b4f56b08..d0e01465 100755
--- a/tests/ext4/051
+++ b/tests/ext4/051
@@ -5,8 +5,8 @@
 # FS QA Test No. 051
 #
 # Test that tune2fs doesn't fail after ext4 shutdown
-# Regression test for commit:
-# e905fbe3fd0f ext4: Fix tune2fs checksum failure for mounted filesystem
+# Regression test for kernel commit:
+# b2bbb92f7042 ext4: fix e2fsprogs checksum failure for mounted filesystem
 #
 . ./common/preamble
 _begin_fstest auto rw quick
-- 
2.23.0

