Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD612C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Dec 2021 00:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhLYAgv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Dec 2021 19:36:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58292 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhLYAgv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 24 Dec 2021 19:36:51 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0D1311F953
        for <fstests@vger.kernel.org>; Sat, 25 Dec 2021 00:36:51 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/647: add _require_odirect
Date:   Sat, 25 Dec 2021 00:36:50 +0000
Message-Id: <20211225003650.2476376-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The mmap-rw-fault test program used by generic/647 uses O_DIRECT
unconditionally.

Signed-off-by: Eric Wong <e@80x24.org>
---
 tests/generic/647 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/647 b/tests/generic/647
index 2e744975..fa6edadc 100755
--- a/tests/generic/647
+++ b/tests/generic/647
@@ -25,6 +25,7 @@ _cleanup()
 
 _supported_fs generic
 _require_test
+_require_odirect
 _require_test_program mmap-rw-fault
 
 echo "Silence is golden"
