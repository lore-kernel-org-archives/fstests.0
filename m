Return-Path: <SRS0=1u3g=ZX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF8DC432C0
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93CA2073C
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLAMxu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:53:50 -0500
Received: from snd00004.auone-net.jp ([111.86.247.4]:65249 "EHLO
        dmta0007.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726138AbfLAMxu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Dec 2019 07:53:50 -0500
Received: from ppp.dion.ne.jp by dmta0007.auone-net.jp with ESMTP
          id <20191201125349035.VFDN.12794.ppp.dion.ne.jp@dmta0007.auone-net.jp>
          for <fstests@vger.kernel.org>; Sun, 1 Dec 2019 21:53:49 +0900
Date:   Sun, 1 Dec 2019 21:53:48 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs/009: Remove unnecessary strtonum
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191201125349035.VFDN.12794.ppp.dion.ne.jp@dmta0007.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make this test pass with non-gawk.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 tests/xfs/009 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/009 b/tests/xfs/009
index 6a31514c..956c4772 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -66,12 +66,12 @@ _block_filter()
 
 	/CMD/ {
 		split($3, off, "=")
-		offset = strtonum(off[2])
+		offset = off[2]
 		if (offset != -1)
 			offset = offset / bsize
 
 		split($4, len, "=")
-		nr_blocks = strtonum(len[2])
+		nr_blocks = len[2]
 		if (nr_blocks != -1)
 			nr_blocks = nr_blocks / bsize
 
@@ -82,13 +82,13 @@ _block_filter()
 
 	/MAP/ {
 		split($2, off, "=")
-		offset = strtonum(off[2])
+		offset = off[2]
 		if (offset != -1)
 			offset = offset / bsize
 
 		split($3, len, "=")
 
-		nr_blocks = strtonum(len[2])
+		nr_blocks = len[2]
 
 		if (nr_blocks != -1)
 			nr_blocks = nr_blocks / bsize
@@ -100,7 +100,7 @@ _block_filter()
 
 	/TRUNCATE/ {
 		split($2, off, "=")
-		offset = strtonum(off[2]) / bsize
+		offset = off[2] / bsize
 
 		printf("    %s off=%s\n", $1, offset)
 
-- 
2.24.0

