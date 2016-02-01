Received: from mail-pf0-f176.google.com ([209.85.192.176]:33167 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbcBAVZe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 1 Feb 2016 16:25:34 -0500
Received: by mail-pf0-f176.google.com with SMTP id x125so90619761pfb.0
        for <fstests@vger.kernel.org>; Mon, 01 Feb 2016 13:25:34 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: xfsprogs: Add BUILD_CFLAGS for cross compilation
Date: Mon,  1 Feb 2016 13:25:09 -0800
Message-Id: <1454361909-36538-1-git-send-email-gwendal@chromium.org>
In-Reply-To: <1437913255-7524-4-git-send-email-tytso@mit.edu>
References: <1437913255-7524-4-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: hch@infradead.org, tytso@mit.edu
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

When cross compiling, CFLAGS may contains option for the cros-compiler the
host compiler can not handle.
Add BUILD_CFLAGS variable that does not include $OPTIMIZER options.

Signed-off by: Gwendal Grignou <gwendal@chromium.org>

--- a/include/builddefs.in	2016-02-01 09:44:14.636018753 -0800
+++ b/include/builddefs.in	2016-02-01 09:37:29.000000000 -0800
@@ -27,6 +27,7 @@
 LOADERFLAGS = @LDFLAGS@
 LTLDFLAGS = @LDFLAGS@
 CFLAGS = @CFLAGS@
+BUILD_CFLAGS = @BUILD_CFLAGS@
 
 LIBRT = @librt@
 LIBUUID = @libuuid@
@@ -151,7 +151,7 @@
 endif
 
 
-GCFLAGS = $(OPTIMIZER) $(DEBUG) \
+GCFLAGS = $(DEBUG) \
 	  -DVERSION=\"$(PKG_VERSION)\" -DLOCALEDIR=\"$(PKG_LOCALE_DIR)\"  \
 	  -DPACKAGE=\"$(PKG_NAME)\" -I$(TOPDIR)/include -I$(TOPDIR)/libxfs
 
@@ -160,7 +160,8 @@
 endif
 
 # First, Global, Platform, Local CFLAGS
-CFLAGS += $(FCFLAGS) $(GCFLAGS) $(PCFLAGS) $(LCFLAGS)
+BUILD_CFLAGS += $(FCFLAGS) $(GCFLAGS) $(PCFLAGS) $(LCFLAGS)
+CFLAGS += $(FCFLAGS) $(OPTIMIZER) $(GCFLAGS) $(PCFLAGS) $(LCFLAGS)
 
 include $(TOPDIR)/include/buildmacros
 
--- a/libxfs/Makefile	2016-02-01 09:44:14.644018849 -0800
+++ b/libxfs/Makefile	2016-02-01 09:37:55.000000000 -0800
@@ -111,7 +111,7 @@
 
 crc32table.h: gen_crc32table.c
 	@echo "    [CC]     gen_crc32table"
-	$(Q) $(BUILD_CC) $(CFLAGS) -o gen_crc32table $<
+	$(Q) $(BUILD_CC) $(BUILD_CFLAGS) -o gen_crc32table $<
 	@echo "    [GENERATE] $@"
 	$(Q) ./gen_crc32table > crc32table.h
 
@@ -122,7 +122,7 @@
 # disk.
 crc32selftest: gen_crc32table.c crc32table.h crc32.c
 	@echo "    [TEST]    CRC32"
-	$(Q) $(BUILD_CC) $(CFLAGS) -D CRC32_SELFTEST=1 crc32.c -o $@
+	$(Q) $(BUILD_CC) $(BUILD_CFLAGS) -D CRC32_SELFTEST=1 crc32.c -o $@
 	$(Q) ./$@
 
 # set up include/xfs header directory
--- a/configure.ac	2016-02-01 09:56:42.873010767 -0800
+++ b/configure.ac	2016-02-01 09:56:45.885047014 -0800
@@ -11,9 +11,12 @@
 AC_PROG_CC
 if test $cross_compiling = no; then
   BUILD_CC="$CC"
+  BUILD_CFLAGS="$CFLAGS"
   AC_SUBST(BUILD_CC)
 else
   AC_CHECK_PROGS(BUILD_CC, gcc cc)
+  BUILD_CFLAGS="-g"
 fi
+AC_SUBST(BUILD_CFLAGS)
 
 AC_ARG_ENABLE(shared,
 [ --enable-shared=[yes/no] Enable use of shared libraries [default=yes]],,
