Return-Path: <SRS0=1u3g=ZX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21386C432C0
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F103E2073C
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 12:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfLAMxX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:53:23 -0500
Received: from snd00014.auone-net.jp ([111.86.247.14]:4225 "EHLO
        dmta0006.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726138AbfLAMxX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Dec 2019 07:53:23 -0500
Received: from ppp.dion.ne.jp by dmta0006.auone-net.jp with ESMTP
          id <20191201125322146.VFOJ.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
          for <fstests@vger.kernel.org>; Sun, 1 Dec 2019 21:53:22 +0900
Date:   Sun, 1 Dec 2019 21:53:21 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/386: Remove unnecessary strtonum
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191201125322146.VFOJ.12766.ppp.dion.ne.jp@dmta0006.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make this test pass with non-gawk.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 tests/generic/386 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/386 b/tests/generic/386
index 462c5869..ba6e654e 100755
--- a/tests/generic/386
+++ b/tests/generic/386
@@ -75,7 +75,7 @@ _filter_quota_rpt() {
 	# This function parses the human-readable values produced
 	# by xfs_quota output
 	function byte_size(value,  result) {
-		result = strtonum(value);
+		result = value;
 		unit = value;
 		gsub("[0-9][0-9]*", "", unit);
 		shift = index("KMGTPE", unit);
-- 
2.24.0

