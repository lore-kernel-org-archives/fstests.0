Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CABC19F2B
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jul 2022 03:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiG1DgR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiG1Dfw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jul 2022 23:35:52 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C930193
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 20:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658979349; i=@fujitsu.com;
        bh=1hSMzNvfmvzzeRpAUVooAQJtHRqNfwd5KYSpdMPfYZg=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=WaVkzRI+xDdv/OtmnWpchjmXbMILz+HqC1Wo/SfNpL/w0XKh6Rg3fkJH4a0Ny4pTN
         hKywcpVTNQWeObKPPzZL2hyLKfkVFCJjsrDac4vBcyYtH+mIxUiZLwYQyAxDFSBBSe
         gFcyERkPH1RGOsdqy4hRBx9FknXHbwcv4bTyOebHlNWNu8PhCDRzkTrJZSIveC7I7q
         EaMr1oGiH7WfLaYp5XVbdZa6F+JnEHrn8VMaOzcJ8xSJcWfpWFDit75Q3sWJx/o/Ao
         8cRLvk8/R7/38ipaNoeZrZ8Dozjb+KOp8IRpnhwMQeOB9u+QpRyZmNa8rsp1AbObeX
         iUvtEbS4ZsN0Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8ORpCvC8ij
  J4O9RS4vLT/gsTrfsZXdg8ti0qpPN4/MmuQCmKNbMvKT8igTWjAW9VxgLFnNW/D59g7mB8QN7
  FyMXh5DARkaJ/o0LoZwlTBLfLh1j6mLkBHL2MEpMbzIBsdkENCWedS5gBrFFBGQl/s9YDVbDL
  GAjcWjuFDYQW1jAVOLP9i2sIDaLgKrEqm2H2UFsXgEPiS3tf8HiEgIKElMevmeGiAtKnJz5hA
  VijoTEwRcvmCFqFCUudXxjhLArJF4fvgQVV5O4em4T8wRG/llI2mchaV/AyLSK0TKpKDM9oyQ
  3MTNH19DAQNfQ0FTXWNfCTC+xSjdRL7VUtzy1uETXUC+xvFgvtbhYr7gyNzknRS8vtWQTIzBE
  U4qZw3Yw/un9qXeIUZKDSUmUd+bCh0lCfEn5KZUZicUZ8UWlOanFhxhlODiUJHitmB4lCQkWp
  aanVqRl5gDjBSYtwcGjJMLLB5LmLS5IzC3OTIdInWLU5VjbcGAvsxBLXn5eqpQ4bwhIkQBIUU
  ZpHtwIWOxeYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM+5IRaApPZl4J3KZXQEcwAR2xReE
  ByBEliQgpqQYmxsdJtdnRwdff1lxujTfwnH/xOIP2Mn7Xpom3TTO+Lr9vVJUrUu74K2LOHzce
  5cRlIjtZZXsr2D5ofP11rnhbcOv84pWv+Rb8UZxWaS6lkr3tiXroslkPPh4R/XhjD/uljMm+1
  2olltxaXNOj7FN9pcneS3pr7NEpkytmMrezOp3V5omPeLT7n/Th6oTG0IN3vr/4WWHQax76wU
  Hp+58pb15c5/mRFOy3dJ3Ml2tpLPVf9K7Yfq/QLL158aFWvTCf8Jk8zsQsP/XzPRIbvVJeXip
  2eOxQ9+n4A9YHazo+JWzo/73hvdiqd19Zz2yLO9Bg+qbSWMlg4YPDU1zSvksc23Ys1VHor+nn
  56Ufjl4tV2Ipzkg01GIuKk4EAJ1LkSFYAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-591.messagelabs.com!1658979348!1259653!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4638 invoked from network); 28 Jul 2022 03:35:48 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-13.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Jul 2022 03:35:48 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 8F3521AC;
        Thu, 28 Jul 2022 04:35:48 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 8429C1AB;
        Thu, 28 Jul 2022 04:35:48 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 28 Jul 2022 04:35:46 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <djwong@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/191: Add missing xfsprogs commit
Date:   Thu, 28 Jul 2022 12:36:31 +0800
Message-ID: <1658982991-3860-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

xfs_repair also needs to think empty xattr leaf block isn't corruption, so
case can pass.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/191 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/191 b/tests/xfs/191
index c568f90e..a10077fe 100755
--- a/tests/xfs/191
+++ b/tests/xfs/191
@@ -11,9 +11,11 @@
 # operations don't stumble over them, and that xfs_repair will offer to remove
 # the entire xattr fork if the root xattr leaf block is empty.
 #
-# Regression test for kernel commit:
-#
+# Regression test for
+# kernel commit:
 # 7be3bd8856fb ("xfs: empty xattr leaf header blocks are not corruption")
+# xfsprogs commit:
+# f50d3462c654 ("xfs_repair: ignore empty xattr leaf blocks")
 #
 . ./common/preamble
 _begin_fstest auto quick attr
@@ -28,6 +30,7 @@ _supported_fs xfs
 _require_scratch
 _require_scratch_xfs_crc # V4 is deprecated
 _fixed_by_kernel_commit 7be3bd8856fb "xfs: empty xattr leaf header blocks are not corruption"
+_fixed_by_git_commit xfsprogs f50d3462c654 "xfs_repair: ignore empty xattr leaf blocks"
 
 _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 cat $tmp.mkfs >> $seqres.full
-- 
2.23.0

