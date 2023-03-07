Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E5C678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjCGMGe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjCGMGd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:06:33 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF33E630
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:06:31 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 11:45:42 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 09/11] vfs: Add DIR0 constant
Date:   Tue,  7 Mar 2023 12:45:05 +0100
Message-Id: <20230307114507.332309-10-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This will be used by tests that call other tests within themselves.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/utils.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git src/vfs/utils.h src/vfs/utils.h
index 4c796559..c52a0738 100644
--- src/vfs/utils.h
+++ src/vfs/utils.h
@@ -45,6 +45,8 @@
 #define DIR2 "dir2"
 #define DIR3 "dir3"
 #define DIR1_RENAME "dir1_rename"
+// This directory may be used by tests that call another test.
+#define DIR0 "dir0"
 #define HARDLINK1 "hardlink1"
 #define SYMLINK1 "symlink1"
 #define SYMLINK_USER1 "symlink_user1"
-- 
2.39.2

