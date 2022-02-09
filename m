Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C2BC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiBIW0Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiBIW0N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A469E011175
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zMqx0fKuRkjkOWzyP4uW0KRJpZSn1f0pA3xVUSk4KDg=; b=0sEOImsrwaQxlGAm2dywAQT71S
        C3VRtfkvuqb7Gk54Tg1uOpxCks9Wc25KRw2RW45GPPmbJvQn8ArOSqPcKnpuoAto/CdynEIqJQ7Uo
        R3kI+w7Y/mTFUaPvKT+6Ppwx6MRcJHP1GAnCLjlckHWzAJx3R6hawbSFEbCFO1isn9ioDJAJFkLae
        LA04SCC61SKBKbvMN8ULthaDusTz84DJoWu23JfTsSNCdtEjbeIpRFjs0t68HjV2eP8W8klQxeIDu
        Wlz/PkobfReZqqzWyLl8y+ICEu33Ambqx3r1+tWiZ07YacUY6mS8njtQAQPPVK3mezi46Jt5rliNN
        yn9qze8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q65-P9; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 08/25] config.h.in: run autoconf
Date:   Wed,  9 Feb 2022 14:25:53 -0800
Message-Id: <20220209222610.438470-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 config.h.in | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/config.h.in b/config.h.in
index 82d417b..b037df5 100644
--- a/config.h.in
+++ b/config.h.in
@@ -33,10 +33,6 @@
 /* Define to 1 if you have the <ctype.h> header file. */
 #undef HAVE_CTYPE_H
 
-/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
-   */
-#undef HAVE_DIRENT_H
-
 /* Whether we have EA support */
 #undef HAVE_EA_SUPPORT
 
@@ -121,9 +117,6 @@
 /* Define to 1 if you have the `lsetxattr' function. */
 #undef HAVE_LSETXATTR
 
-/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
-#undef HAVE_NDIR_H
-
 /* Define to 1 if you have the `removexattr' function. */
 #undef HAVE_REMOVEXATTR
 
@@ -151,20 +144,12 @@
 /* Define to 1 if you have the <sys/attributes.h> header file. */
 #undef HAVE_SYS_ATTRIBUTES_H
 
-/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
-   */
-#undef HAVE_SYS_DIR_H
-
 /* Define to 1 if you have the <sys/extattr.h> header file. */
 #undef HAVE_SYS_EXTATTR_H
 
 /* Define to 1 if you have the <sys/mount.h> header file. */
 #undef HAVE_SYS_MOUNT_H
 
-/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
-   */
-#undef HAVE_SYS_NDIR_H
-
 /* Define to 1 if you have the <sys/statvfs.h> header file. */
 #undef HAVE_SYS_STATVFS_H
 
@@ -227,9 +212,5 @@
    backward compatibility; new code need not use it. */
 #undef STDC_HEADERS
 
-/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. This
-   macro is obsolete. */
-#undef TIME_WITH_SYS_TIME
-
 /* Define _GNU_SOURCE so that we get all necessary prototypes */
 #undef _GNU_SOURCE
-- 
2.34.1

