Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906BEC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Nov 2021 06:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EB561B51
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Nov 2021 06:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbhKRGph (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Nov 2021 01:45:37 -0500
Received: from mail1.bemta34.messagelabs.com ([195.245.231.2]:6769 "EHLO
        mail1.bemta34.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243206AbhKRGpg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Nov 2021 01:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1637217756; i=@fujitsu.com;
        bh=zoSpptanQtT22O/vKWtSE5bM4SwdX56ozl4UzeDLgmk=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=gZRjWGnegFvSbaeeapeoUiFgIa8OE+5ql9YoJMcJjGz7WQYLkzlzzD1TX06lqxn/8
         1kFHzZf/R+zmd2KKtT7qGEx7EoB3lsuFWaBAPRaVFOAM+Ae72M120rCLSymPpX3+QM
         Lji2pEBtPxn0Rb52AJ8aPJ20+JQ5Mp8UzbdZ4tyZI2jxDpQeU7tf7HYoKyj/pDKlyU
         a33i4wsjuLRk0tHA04xflNPRTf6jYgv6eAanQJRfQE8J5miQMmO5Eq+BiDKNi+EUF6
         ufK1wXPikLCqH92GL/kIwYkM7KHJ0Hd/J8VA2FwFF5abDznMBa0RIDHU99zFnq5zU0
         1EAsCogtBBgQw==
Received: from [100.115.36.91] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id A0/E3-16121-CD5F5916; Thu, 18 Nov 2021 06:42:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRWlGSWpSXmKPExsViZ8MxSff216m
  JBofWmlucbtnL7sDo8XmTXABjFGtmXlJ+RQJrxvXGKYwFs1kqbt6byNLAeIq5i5GLQ0jgEqPE
  1jnr2SCcfUwS244uh8rsYZT4uGkRUIaTg01AU+JZ5wJmEFtEQFbi/4zVTCA2s4C6xPJJv8BsY
  QETicv/P4HVswioSjw/9IWxi5GDg1fAU+Lw/UyQsISAgsSUh+/BxvAKCEqcnPmEBWKMhMTBFy
  +YIWoUJS51fGOEsCskZs1qY4Kw1SSuntvEPIGRfxaS9llI2hcwMq1itE4qykzPKMlNzMzRNTQ
  w0DU0NNU1NgJSJnqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIFBmVKsULSD
  cc7XH3qHGCU5mJREeWddmJooxJeUn1KZkVicEV9UmpNafIhRhoNDSYJX+QtQTrAoNT21Ii0zB
  xghMGkJDh4lEV7+T0Bp3uKCxNzizHSI1ClGRSlxXhuQPgGQREZpHlwbLCovMcpKCfMyMjAwCP
  EUpBblZpagyr9iFOdgVBLmNQeZwpOZVwI3/RXQYiagxbKXJ4MsLklESEk1ME3d3f+gZnHz6v7
  fL6zyls4WvLjxQGDyqZ4DKgoH/j/cv2EGp4XC+oj3gvOZGXf0LOwVN164+aUI35fUXxeuMVVf
  57ii7rfmyrU7l1elFtv5XjF7qvCkMEz2+gSLIvltH+PtSvknqmj+4dh5aJ260hnWxmbVbSGsv
  OXHHx1fzrjBd6unQNOlLUVsDgxzTnvaK22Z5/bj9wG7po69+Tn71q1OmZ9jkfF+wfSKSSUvOJ
  Sv/88VMWua9yGqzt3G984UGUWtlGoThlO9sVPOVO7/9mS9lXai53xFW3GXnSdmrOo4XGo+8/3
  qRHsv1y0b8haaT/O+p7u8mPFftLf5D9afKgrLwo0sbwpYLvAqmi7Ja6rEUpyRaKjFXFScCADW
  skD0RQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-565.messagelabs.com!1637217755!1114876!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31160 invoked from network); 18 Nov 2021 06:42:35 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Nov 2021 06:42:35 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 860BF100475
        for <fstests@vger.kernel.org>; Thu, 18 Nov 2021 06:42:35 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 7A076100440
        for <fstests@vger.kernel.org>; Thu, 18 Nov 2021 06:42:35 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Thu, 18 Nov 2021 06:42:17 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] ext4/051: Add another kernel commit
Date:   Thu, 18 Nov 2021 14:42:23 +0800
Message-ID: <1637217743-31142-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/ext4/051 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/051 b/tests/ext4/051
index d0e01465..e4b63a32 100755
--- a/tests/ext4/051
+++ b/tests/ext4/051
@@ -6,6 +6,7 @@
 #
 # Test that tune2fs doesn't fail after ext4 shutdown
 # Regression test for kernel commit:
+# 4274f516d4bc ext4: recalucate superblock checksum after updating free blocks/inodes
 # b2bbb92f7042 ext4: fix e2fsprogs checksum failure for mounted filesystem
 #
 . ./common/preamble
-- 
2.23.0

