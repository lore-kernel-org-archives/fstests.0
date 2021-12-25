Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF5C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Dec 2021 06:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhLYGDa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Dec 2021 01:03:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36572 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhLYGD3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 25 Dec 2021 01:03:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 32EEC1F953;
        Sat, 25 Dec 2021 06:03:29 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/228: set vars for early _cleanup
Date:   Sat, 25 Dec 2021 06:03:29 +0000
Message-Id: <20211225060329.2680986-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The `core_pattern' and `ulimit_c' variables must be set to
restore their original values in case _cleanup fires early.

Signed-off-by: Eric Wong <e@80x24.org>
---
 tests/generic/228 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/228 b/tests/generic/228
index 121d43cc..92338982 100755
--- a/tests/generic/228
+++ b/tests/generic/228
@@ -19,6 +19,8 @@ _cleanup()
 }
 
 tmp=$TEST_DIR/$$
+core_pattern=`sysctl -n kernel.core_pattern`
+ulimit_c=`ulimit -c`
 _register_cleanup "_cleanup" 25
 
 # Import common functions.
@@ -39,8 +41,6 @@ avail=`df -P $TEST_DIR | awk 'END {print $4}'`
 [ "$avail" -ge 104000 ] || _notrun "Test device is too small ($avail KiB)"
 
 # Suppress core dumped messages
-core_pattern=`sysctl -n kernel.core_pattern`
-ulimit_c=`ulimit -c`
 sysctl -w kernel.core_pattern=core &>/dev/null
 ulimit -c 0
 
