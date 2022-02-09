Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F1C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 02:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbiBICj0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiBICCb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 21:02:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46529C0613CB
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UGzHVTPG4dvUvX/Z2TjedHo8ijns/SaCDuVs7mCNLA0=; b=HM+ho9+fH8ccFkqKf8ERzVywu6
        KWmedZxN4vkQgCUlQ+4Nh8UjlmWz2eOLrP1AFwv/DH+snW3uJLmP+eLaIjGswxlKaNpTsLwK3O+39
        hTsFFWlL2JkhKnRePj6vsQLfSYN6LL5DwkAxVT1Shf/D0fB4CgaeaI2T2adplT/fRqCiFZJDrE8S+
        /JCs33/6FelEEUkzGeIrunwxasGG7sBIUCYb6roUezrYbASwnvgpVHuCEztRXEx8kIu4oI+H0ZkZc
        VjtzXcDragcN9ZqQXGRtImAJVhp/zMMY2yKMyG/Lwz8MamVdSjh4QWHDaEgpXUDbOG87pMoYbRLHF
        njRb4YGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHcJO-00Fxxb-4P; Wed, 09 Feb 2022 02:02:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/4] config.h.in: run autoheader and update
Date:   Tue,  8 Feb 2022 18:02:21 -0800
Message-Id: <20220209020223.3805346-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209020223.3805346-1-mcgrof@kernel.org>
References: <20220209020223.3805346-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Run autoheader and update config.h.in based on the
latest autotools.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 config.h.in | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/config.h.in b/config.h.in
index 0b8a24f..82d417b 100644
--- a/config.h.in
+++ b/config.h.in
@@ -1,4 +1,4 @@
-/* config.h.in.  Generated from configure.in by autoheader.  */
+/* config.h.in.  Generated from configure.ac by autoheader.  */
 
 /* Define to 1 if you have the `asprintf' function. */
 #undef HAVE_ASPRINTF
@@ -121,9 +121,6 @@
 /* Define to 1 if you have the `lsetxattr' function. */
 #undef HAVE_LSETXATTR
 
-/* Define to 1 if you have the <memory.h> header file. */
-#undef HAVE_MEMORY_H
-
 /* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
 #undef HAVE_NDIR_H
 
@@ -139,6 +136,9 @@
 /* Define to 1 if you have the <stdint.h> header file. */
 #undef HAVE_STDINT_H
 
+/* Define to 1 if you have the <stdio.h> header file. */
+#undef HAVE_STDIO_H
+
 /* Define to 1 if you have the <stdlib.h> header file. */
 #undef HAVE_STDLIB_H
 
@@ -171,6 +171,9 @@
 /* Define to 1 if you have the <sys/stat.h> header file. */
 #undef HAVE_SYS_STAT_H
 
+/* Define to 1 if you have the <sys/time.h> header file. */
+#undef HAVE_SYS_TIME_H
+
 /* Define to 1 if you have the <sys/types.h> header file. */
 #undef HAVE_SYS_TYPES_H
 
@@ -219,10 +222,13 @@
 /* Define to the version of this package. */
 #undef PACKAGE_VERSION
 
-/* Define to 1 if you have the ANSI C header files. */
+/* Define to 1 if all of the C90 standard headers exist (not just the ones
+   required in a freestanding environment). This macro is provided for
+   backward compatibility; new code need not use it. */
 #undef STDC_HEADERS
 
-/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
+/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. This
+   macro is obsolete. */
 #undef TIME_WITH_SYS_TIME
 
 /* Define _GNU_SOURCE so that we get all necessary prototypes */
-- 
2.34.1

