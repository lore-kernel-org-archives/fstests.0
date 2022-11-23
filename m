Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E3C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Nov 2022 10:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiKWKiE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Nov 2022 05:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiKWKhh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Nov 2022 05:37:37 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA60B102F
        for <fstests@vger.kernel.org>; Wed, 23 Nov 2022 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669198896; i=@fujitsu.com;
        bh=ig8t6s9LIM0JhWeY92eZBda70ThoHMu/5zAFOn0k0PE=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=brnQFXbQB804x6hY6L9xAt8LFP3Cd8ib8faJYGrVqy9hnpMJuXhMktDwEQhrR3Yfq
         riQW8zS7xzdgvkTcywoNJaW0/ltBYB1ojL0fQpjG/IDyzHEl25wW+bjF+yBE4F99O5
         03sD90IV3RVEcBEXZSERapcqpHTB2sI1fqHxGRBJBzd0bqfplv/kXKJk37SqvC8WJ4
         imAdululsLVEz5ZvYKYzuG2NbYAE+8ws4dq6/YimCcTgaOQC/V01/RLnZ59DsgHgu1
         VfgjLr9Yvf8hwAuTytwmIavI7Wumnan2+XKqdOFID2o6lxL0e3FCW7GsUUes9R9SHK
         FNC8GPiurh8vQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8OxWVf/S22
  ywc05uhaXn/BZnG7Zy26x9+ROVgdmj02rOtk83u+7yubxeZNcAHMUa2ZeUn5FAmvGwQmHmAqu
  sVT8/H6GqYGxg6WLkYtDSGAjo8T+x6dZIZwlTBKrey4zQjj7GSXurljJ1sXIycEmoCaxc/pLF
  hBbREBbYu3WJ0AdHBzMAvYSm6dUgoSFBSwlZh98AFbOIqAq0ff7CjOIzSvgKHHj6AqwuISAgs
  SUh++h4oISJ2c+ARvJLCAhcfDFC2aIGkWJtiX/2CHsColZs9qYIGw1iavnNjFPYOSfhaR9FpL
  2BYxMqxhNi1OLylKLdA31kooy0zNKchMzc/QSq3QT9VJLdctTi0uAMonlxXqpxcV6xZW5yTkp
  enmpJZsYgeGaUszOuoPxxZI/eocYJTmYlER5tTbXJgvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4
  H3yCSgnWJSanlqRlpkDjB2YtAQHj5II76MPQGne4oLE3OLMdIjUKUZdjrUNB/YyC7Hk5eelSo
  nzKn8GKhIAKcoozYMbAYvjS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeTVBpvBk5pXAbXo
  FdAQT0BFqFlUgR5QkIqSkGpg6EnIs67+srl3yPz+KKfVz5/Qjc69c7/bIdd7aPvlVrtplpVsB
  WdEP3SdfXZlpusLh4pZdl2ZHNApu+GjtvO3XoZWvOJYdUG45Eqq1vSaiKvrFsxKXhFi5bxfiO
  dXTu66EBjtr1C6uznpTaOPdtCfKamOV/GOtz5YOpdODolu+B55pyz7WKhr/4ONs4VKVmHTPii
  d3SxON9dkPuRzZs0pBx9/84dqVzum7183cVZy/yOvRNbkaDecVTRcKW61+rhV83/rWVUDm3kZ
  P1S3d1/ZJ+pxZHLJyxQ8Nzs61Rz+2Zgfw5j09ZchltJE9ZLLV2fp7OfpFE6f99D2cEXj/9vGN
  K6XnXGMKN+FUE8lO3aHEUpyRaKjFXFScCACnTo5zXgMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-11.tower-585.messagelabs.com!1669198895!114939!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15675 invoked from network); 23 Nov 2022 10:21:35 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-11.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Nov 2022 10:21:35 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 5B749151;
        Wed, 23 Nov 2022 10:21:35 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 4F2B6150;
        Wed, 23 Nov 2022 10:21:35 +0000 (GMT)
Received: from 17b077ab307e.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 23 Nov 2022 10:21:32 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <djwong@kernel.org>, <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] xfs/243: add _require_scratch_delalloc()
Date:   Wed, 23 Nov 2022 10:21:23 +0000
Message-ID: <1669198883-16-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs/243 requires the delalloc feature of XFS so return [not run]
when XFS with enabled DAX doesn't support it.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/xfs/243 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/243 b/tests/xfs/243
index 8f0c5939..739efe4a 100755
--- a/tests/xfs/243
+++ b/tests/xfs/243
@@ -27,6 +27,7 @@ _begin_fstest auto quick clone punch
 _supported_fs xfs
 _require_xfs_debug
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "fpunch"
-- 
2.34.1

