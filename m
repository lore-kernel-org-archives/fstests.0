Return-Path: <SRS0=DGTx=ZZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D421C432C0
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CE2206EC
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 12:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCMKt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:10:49 -0500
Received: from snd00009.auone-net.jp ([111.86.247.9]:3939 "EHLO
        dmta0009.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbfLCMKt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Dec 2019 07:10:49 -0500
Received: from ppp.dion.ne.jp by dmta0009.auone-net.jp with ESMTP
          id <20191203121047394.YXCJ.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
          for <fstests@vger.kernel.org>; Tue, 3 Dec 2019 21:10:47 +0900
Date:   Tue, 3 Dec 2019 21:10:47 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: Prevent _scale_fsstress_args from consuming -n
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191203121047394.YXCJ.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If first argument is -n, echo consumes it.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 6943f19f..7b954860 100644
--- a/common/rc
+++ b/common/rc
@@ -3433,7 +3433,7 @@ _scale_fsstress_args()
         esac
         shift
     done
-    echo $args
+    printf '%s\n' "$args"
 }
 
 #
-- 
2.24.0

