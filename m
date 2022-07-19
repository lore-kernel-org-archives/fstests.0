Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF13C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 07:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiGSHbk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiGSHbY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 03:31:24 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1456732D83
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658215882; i=@fujitsu.com;
        bh=7uZO2RTEhFeq/7KJ3IMIEMm+1o8zLcwaoD0RiFUGa+4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=jfhFHZ/g1mKvEL2VXe8gPFQClquRJHTdhAJGKOBQUGuLbfRsLuKuEfKzfsvZMxTnv
         t8Dv6sA7+biszfpB2v01rs3gZ2ogGxH8J19Zabs25rMMLkEK8g2HTJpdg733385yW1
         qETsZgqrIlwwnlhRx7hPbp6I+dQ5m2kuThk9CnH46P+BfX8cOEO8zAu/kHBwMW2SOv
         /igZIv1PpHda0joqDaC1QGpt2ZNWNICwuh+3BxDiI+iB/vgS8NtkzPr/pmMfCZWKKI
         dd1YicMamwevb4mhoSFjUSB/BAoutAmGnCkZOdTLRqdRnazC4KNBWKjfzUX72qnp3H
         EYSsysKGar33A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8MxSfdU7LU
  kgzlXuC1Ot+xld2D0+LxJLoAxijUzLym/IoE1o6/1OHPBMr6KN7enMjYwTubpYuTiEBK4xCgx
  ce0KdgjnKJPE//2f2LoYOYGcPUCZ31kgNpuApsSzzgXMILaIgKzE/xmrmUBsZgF1ieWTfoHZw
  gIRElcWtjCC2CwCqhKNzy6zgNi8Ah4S+zp2gc2UEFCQmPLwPdAcDg5OAU+Js1sMIVZVSvT92M
  sMUS4ocXLmExaI8RISB1+8YIZoVZS41PGNEcKukHh9+BJUXE3i6rlNzBMYBWchaZ+FpH0BI9M
  qRqukosz0jJLcxMwcXUMDA11DQ1NdY0tdCyO9xCrdRL3UUt3y1OISXSC3vFgvtbhYr7gyNzkn
  RS8vtWQTIzCAU4rVg3YwflvxU+8QoyQHk5Io71TNa0lCfEn5KZUZicUZ8UWlOanFhxhlODiUJ
  HgTwoFygkWp6akVaZk5wGiCSUtw8CiJ8GpGAaV5iwsSc4sz0yFSpxiNOdY2HNjLzNG5v+sAsx
  BLXn5eqpQ4L280UKkASGlGaR7cIFiUX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzOsbAzS
  FJzOvBG7fK6BTmIBOmeR0BeSUkkSElFQDk3vyQt8PpX4cE86nPDq8K6hcf/IFGeaZ83uFON98
  4/j/rVRvrg3LL+/fjF+3ZHxvCAvif8K22ZV7r7v3ZaEbtT5XvRh1BBdv3OplerzP8LtraoMv8
  z2+xUqbHbnaN8WXMLT2zth3pchwdbZsaG6v2s0vM+3jOGc8usraGZfc/rNQIU6ZYS3PEp3Z3/
  IPc7pqhiRxNZhZlZ4VaRLUXbNiPltpsqZ51K97Rhzb9prJvnpad4wr3LUhZPuF/WkX5vd3SJd
  vrmU78/mwsJt+9rfWCqMe32av2an/zy24VGXHYrBn607NhOkiTRuDNAwkJ80pea1n+M2BbZ7h
  h70B+n2/a163nnD/ICrVIb/gwSMlluKMREMt5qLiRABRDnerbQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-548.messagelabs.com!1658215882!34099!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2543 invoked from network); 19 Jul 2022 07:31:22 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-17.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Jul 2022 07:31:22 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id DD1741000C1
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 08:31:21 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id D02D7100077
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 08:31:21 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Jul 2022 08:31:20 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 2/2] xfs/533: test xfs_db whether still can get corrupted field value
Date:   Tue, 19 Jul 2022 16:31:13 +0800
Message-ID: <1658219473-2310-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658219473-2310-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <20220719051310.mptogjydytz233n4@zlang-mailbox>
 <1658219473-2310-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a regression test that xfs_db code doesn't clean up the
LIBXFS_READBUF_SALVAGE call sites in set_cur so that we can't use the
return value directly and scraping it out later.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/533     | 34 ++++++++++++++++++++++++++++++++++
 tests/xfs/533.out |  5 +++++
 2 files changed, 39 insertions(+)
 create mode 100755 tests/xfs/533
 create mode 100644 tests/xfs/533.out

diff --git a/tests/xfs/533 b/tests/xfs/533
new file mode 100755
index 00000000..c0a4c0d2
--- /dev/null
+++ b/tests/xfs/533
@@ -0,0 +1,34 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+#
+# FS QA Test 533
+#
+# Regression test for xfsprogs commit
+# f4afdcb0ad11 ("xfs_db: clean up the salvage read callsites in set_cur()")
+#
+# This case test xfs_db whether can get the new magicnum field value even we
+# just have corrupted this field value.
+#
+
+. ./common/preamble
+_begin_fstest auto quick db
+
+# real QA test starts here
+_supported_fs xfs
+_fixed_by_git_commit xfsprogs f4afdcb0ad11 \
+	"xfs_db: clean up the salvage read callsites in set_cur()"
+#skip fs check because invalid superblock 1
+_require_scratch_nocheck
+
+_scratch_mkfs_xfs >>$seqres.full 2>&1
+
+# write the bad magicnum field value(0) to the superblock 1
+_scratch_xfs_set_metadata_field "magicnum" "0" "sb 1"
+
+#Even magicnum filed has been corrupted, we still can read this filed value
+_scratch_xfs_get_metadata_field "magicnum" "sb 1"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/533.out b/tests/xfs/533.out
new file mode 100644
index 00000000..7deb78a3
--- /dev/null
+++ b/tests/xfs/533.out
@@ -0,0 +1,5 @@
+QA output created by 533
+Allowing write of corrupted data with good CRC
+magicnum = 0
+bad magic number
+0
-- 
2.23.0

