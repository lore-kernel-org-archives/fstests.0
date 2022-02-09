Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D6C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiBIW0w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiBIW0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B4E011150
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cjyCBPfvPoudeBaY7sbUSz+Hv9Wr8fCNP+jYWjSJYQI=; b=KnVYvd3qfcRIbuEXHM8GAX+dxq
        CzLwn/32pWJMFLbqgUYX5+eNQWYPEPxReX9+pOLtOh8eolMVT/fon1W325jbWSPPKQz6u1xFeHW6a
        OhYrQq980lOflcgbP2qTVpJtVzwjOYDWG2mTub9SQSnrL6p5nQ3VNh3eIB58RhLqwB/t5Cus44gAp
        ByPDAa3O6L5Ca5d3Rgxo5fKwmONGH0mG4WJGuUoSiuqlgDBNpn/DO1TttBZkCrx70gXC4LjWNZ+Ih
        V2YgrJv/h+8MOUFHudPb191zyx1MPdBm/7Fa68A5KUax5cRaQFLkys4H49UhwgctYQ4ncgUp88yAs
        FIk7Xiww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5z-O8; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 07/25] dbench: update use of time.h or sys/time.h
Date:   Wed,  9 Feb 2022 14:25:52 -0800
Message-Id: <20220209222610.438470-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

autoconf complains about the deprecated use of including
just sys/time.h. Fix this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 configure.ac | 16 +---------------
 dbench.h     | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index e8b373e..b8c26fe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,27 +23,13 @@ else
 	CFLAGS="$CFLAGS -O"
 fi
 
-AC_HEADER_DIRENT
-m4_warn([obsolete],
-[Update your code to rely only on HAVE_SYS_TIME_H,
-then remove this warning and the obsolete code below it.
-All current systems provide time.h; it need not be checked for.
-Not all systems provide sys/time.h, but those that do, all allow
-you to include it and time.h simultaneously.])dnl
-AC_CHECK_HEADERS_ONCE([sys/time.h])
-# Obsolete code to be removed.
-if test $ac_cv_header_sys_time_h = yes; then
-  AC_DEFINE([TIME_WITH_SYS_TIME],[1],[Define to 1 if you can safely include both <sys/time.h>
-	     and <time.h>.  This macro is obsolete.])
-fi
-# End of obsolete code.
-
 AC_HEADER_SYS_WAIT
 
 AC_CHECK_HEADERS(ctype.h strings.h stdlib.h string.h sys/vfs.h sys/statvfs.h stdint.h)
 
 AC_CHECK_HEADERS(sys/attributes.h attr/xattr.h sys/xattr.h sys/extattr.h sys/uio.h)
 AC_CHECK_HEADERS(sys/mount.h)
+AC_CHECK_HEADERS([sys/time.h])
 
 AC_CHECK_FUNCS(fdatasync)
 # Check if we have libattr
diff --git a/dbench.h b/dbench.h
index 465cf3b..1fecd1a 100644
--- a/dbench.h
+++ b/dbench.h
@@ -27,7 +27,18 @@
 #include <ctype.h>
 #include <dirent.h>
 #include <sys/stat.h>
-#include <sys/time.h>
+
+#ifdef TIME_WITH_SYS_TIME
+# include <sys/time.h>
+# include <time.h>
+#else
+# ifdef HAVE_SYS_TIME_H
+#  include <sys/time.h>
+# else
+#  include <time.h>
+# endif
+#endif
+
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-- 
2.34.1

