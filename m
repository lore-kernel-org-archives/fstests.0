Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1695EC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB7E60E9C
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 13:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhJLNvR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:51:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbhJLNvR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Oct 2021 09:51:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F243F200AC
        for <fstests@vger.kernel.org>; Tue, 12 Oct 2021 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634046554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z6s2ry0/rtwB2OWwRk9J5Suf0f80xA0Dal+R7ep6oAQ=;
        b=oQ9ooyDj1qilyujVENPTAmdHctUJ7ep/LEhLV5T7lavp3WifYtmd9jsHGj6Wd4UArieMpi
        HcBK2+jLcHjvJzFr8iDjGZDe1KyJLH9N2OSZrUmkMwuMwqtSSSVJlnKmkkEpLhGbQTyZ5d
        xyDxyfSofdAZgq+jhLN7Ifbr1VBuOzE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0EE513B6F
        for <fstests@vger.kernel.org>; Tue, 12 Oct 2021 13:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ouuuNlqSZWGWcgAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Tue, 12 Oct 2021 13:49:14 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] build: remove unused AC_PACKAGE_NEED_OPEN_BY_FSHANDLE macro
Date:   Tue, 12 Oct 2021 15:50:57 +0200
Message-Id: <20211012135057.25689-1-ailiop@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit 5868405dce1d ("Sync up different copies of the m4 macros, noop
change for this package.") introduced this macro, by the function was
never really used by any test, remove it.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 m4/package_xfslibs.m4 | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
index 9be56e1103ac..1bfd955479b8 100644
--- a/m4/package_xfslibs.m4
+++ b/m4/package_xfslibs.m4
@@ -64,20 +64,6 @@ AC_DEFUN([AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS],
     AC_SUBST(libxfs)
   ])
 
-AC_DEFUN([AC_PACKAGE_NEED_OPEN_BY_FSHANDLE],
-  [ AC_CHECK_LIB(handle, open_by_fshandle,, [
-        echo
-        echo 'FATAL ERROR: could not find a current XFS handle library.'
-        echo 'Install or upgrade the XFS library package.'
-        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
-        exit 1
-    ])
-    libhdl="-lhandle"
-    test -f ${libexecdir}${libdirsuffix}/libhandle.la && \
-	libhdl="${libexecdir}${libdirsuffix}/libhandle.la"
-    AC_SUBST(libhdl)
-  ])
-
 AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
   [ AC_CHECK_LIB(handle, attr_list_by_handle,, [
         echo
-- 
2.33.0

