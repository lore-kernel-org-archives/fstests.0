Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A857FC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiBIW0z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiBIW0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EAE011168
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IPq384fvmvWNh0x6UNP/5npCxkU7Qylq5a+2wXkXefQ=; b=ZWJmmqpEt5Feoc1gWp8cMFg1WP
        z5cyLQHxxokBGxSDYdjdUq96HgYX82MrzhJM2H9JDPqYTtux0WLCub1lwOS/7phDztS/yr0eRycjJ
        w1pm+v49gr768JGwpxoZQj6PzKzEjnWreFGYn0L2pCsr1H5KZPhDTWNG7ektNbEOarzpi2Q0Tjrw0
        bd7NWeWd+H/+VqlX3SZw33s9FOmVc3kHPwwF4tzr1buPLRNX/Zr/SSGoe+yQHs9/hWe0j3Lfr523B
        itV2XcuBm+YnDBmNNdpJTOPRQccLde9JqyTiCkQwOSJGPMtbEp6ZspmAS4yYpF4ohzmM4AneoHbvv
        OUBD43pw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5v-Ma; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 06/25] configure.ac: run autoupdate
Date:   Wed,  9 Feb 2022 14:25:51 -0800
Message-Id: <20220209222610.438470-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There are a few deprecate things, run autoupdate to
correct these things.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 configure.ac | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/configure.ac b/configure.ac
index 14e0d32..e8b373e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,11 +1,11 @@
 dnl Process this file with autoconf to produce a configure script.
 
-AC_INIT()
-AC_PREREQ(2.52)
+AC_INIT
+AC_PREREQ([2.71])
 
 AC_MSG_NOTICE([Configuring dbench])
 
-AC_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS([config.h])
 
 dnl Checks for programs.
 AC_PROG_CC
@@ -24,7 +24,20 @@ else
 fi
 
 AC_HEADER_DIRENT
-AC_HEADER_TIME
+m4_warn([obsolete],
+[Update your code to rely only on HAVE_SYS_TIME_H,
+then remove this warning and the obsolete code below it.
+All current systems provide time.h; it need not be checked for.
+Not all systems provide sys/time.h, but those that do, all allow
+you to include it and time.h simultaneously.])dnl
+AC_CHECK_HEADERS_ONCE([sys/time.h])
+# Obsolete code to be removed.
+if test $ac_cv_header_sys_time_h = yes; then
+  AC_DEFINE([TIME_WITH_SYS_TIME],[1],[Define to 1 if you can safely include both <sys/time.h>
+	     and <time.h>.  This macro is obsolete.])
+fi
+# End of obsolete code.
+
 AC_HEADER_SYS_WAIT
 
 AC_CHECK_HEADERS(ctype.h strings.h stdlib.h string.h sys/vfs.h sys/statvfs.h stdint.h)
@@ -58,18 +71,16 @@ if test x"$ac_cv_func_fgetxattr" = x"yes" -o \
 fi
 
 AC_CACHE_CHECK([for va_copy],dbench_cv_HAVE_VA_COPY,[
-AC_TRY_LINK([#include <stdarg.h>
-va_list ap1,ap2;], [va_copy(ap1,ap2);],
-dbench_cv_HAVE_VA_COPY=yes,dbench_cv_HAVE_VA_COPY=no)])
+AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdarg.h>
+va_list ap1,ap2;]], [[va_copy(ap1,ap2);]])],[dbench_cv_HAVE_VA_COPY=yes],[dbench_cv_HAVE_VA_COPY=no])])
 if test x"$dbench_cv_HAVE_VA_COPY" = x"yes"; then
     AC_DEFINE(HAVE_VA_COPY,1,[Whether va_copy() is available])
 fi
 
 if test x"$dbench_cv_HAVE_VA_COPY" != x"yes"; then
 AC_CACHE_CHECK([for __va_copy],dbench_cv_HAVE___VA_COPY,[
-AC_TRY_LINK([#include <stdarg.h>
-va_list ap1,ap2;], [__va_copy(ap1,ap2);],
-dbench_cv_HAVE___VA_COPY=yes,dbench_cv_HAVE___VA_COPY=no)])
+AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdarg.h>
+va_list ap1,ap2;]], [[__va_copy(ap1,ap2);]])],[dbench_cv_HAVE___VA_COPY=yes],[dbench_cv_HAVE___VA_COPY=no])])
 if test x"$dbench_cv_HAVE___VA_COPY" = x"yes"; then
     AC_DEFINE(HAVE___VA_COPY,1,[Whether __va_copy() is available])
 fi
@@ -83,7 +94,7 @@ ac_save_CFLAGS="$CFLAGS"
 ac_save_LIBS="$LIBS"
 CFLAGS="$CFLAGS $GLIB_CFLAGS"
 LIBS="$GLIB_LIBS $LIBS -lpopt"
-AC_TRY_RUN([
+AC_RUN_IFELSE([AC_LANG_SOURCE([[
 /*
  * Just see if we can compile/link with popt
  */
@@ -98,8 +109,7 @@ int main(int argc, const char *argv[])
 
 	return 0;
 }
-], ac_cv_have_popt=yes, ac_cv_have_popt=no,
-   [echo $ac_n "compile with POPT. Assuming OK... $ac_c"
+]])],[ac_cv_have_popt=yes],[ac_cv_have_popt=no],[echo $ac_n "compile with POPT. Assuming OK... $ac_c"
     ac_cv_have_popt=yes])
 CFLAGS="$ac_save_CFLAGS"
 LIBS="$ac_save_LIBS"
@@ -119,7 +129,7 @@ ac_save_CFLAGS="$CFLAGS"
 ac_save_LIBS="$LIBS"
 CFLAGS="$CFLAGS $GLIB_CFLAGS"
 LIBS="$GLIB_LIBS $LIBS -lsmbclient"
-AC_TRY_RUN([
+AC_RUN_IFELSE([AC_LANG_SOURCE([[
 #include <stdio.h>
 #include <libsmbclient.h>
 
@@ -137,8 +147,7 @@ int main(int argc, char *argv[])
 
 	return 0;
 }
-], ac_cv_have_libsmbclient=yes, ac_cv_have_libsmbclient=no,
-   [echo $ac_n "compile with LIBSMBCLIENT. Assuming OK... $ac_c"
+]])],[ac_cv_have_libsmbclient=yes],[ac_cv_have_libsmbclient=no],[echo $ac_n "compile with LIBSMBCLIENT. Assuming OK... $ac_c"
     ac_cv_have_libsmbclient=yes])
 CFLAGS="$ac_save_CFLAGS"
 LIBS="$ac_save_LIBS"
@@ -162,7 +171,7 @@ ac_save_CFLAGS="$CFLAGS"
 ac_save_LIBS="$LIBS"
 CFLAGS="$CFLAGS $GLIB_CFLAGS"
 LIBS="$GLIB_LIBS $LIBS -liscsi"
-AC_TRY_RUN([
+AC_RUN_IFELSE([AC_LANG_SOURCE([[
 #include <stdio.h>
 #include <iscsi/iscsi.h>
 
@@ -180,8 +189,7 @@ int main(int argc, char *argv[])
 
 	return 0;
 }
-], ac_cv_have_libiscsi=yes, ac_cv_have_libiscsi=no,
-   [echo $ac_n "compile with LIBISCSI. Assuming OK... $ac_c"
+]])],[ac_cv_have_libiscsi=yes],[ac_cv_have_libiscsi=no],[echo $ac_n "compile with LIBISCSI. Assuming OK... $ac_c"
     ac_cv_have_libiscsi=yes])
 CFLAGS="$ac_save_CFLAGS"
 LIBS="$ac_save_LIBS"
@@ -203,7 +211,7 @@ ac_save_CFLAGS="$CFLAGS"
 ac_save_LIBS="$LIBS"
 CFLAGS="$CFLAGS $GLIB_CFLAGS"
 LIBS="$GLIB_LIBS $LIBS"
-AC_TRY_RUN([
+AC_RUN_IFELSE([AC_LANG_SOURCE([[
 /* We can only check that this program compiles. We cant check whether the
    actual ioctl works since opening the device and doing i/o can only be
    done by root.
@@ -229,8 +237,7 @@ int main(int argc, char *argv[])
 
 	return 0;
 }
-], ac_cv_linux_scsi_sg=yes, ac_cv_linux_scsi_sg=no,
-   [echo $ac_n "cross compiling; assumed OK... $ac_c"
+]])],[ac_cv_linux_scsi_sg=yes],[ac_cv_linux_scsi_sg=no],[echo $ac_n "cross compiling; assumed OK... $ac_c"
     ac_cv_linux_scsi_sg=yes])
 CFLAGS="$ac_save_CFLAGS"
 LIBS="$ac_save_LIBS"
-- 
2.34.1

