Received: from mail-pf0-f194.google.com ([209.85.192.194]:34331 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036634AbdEYT1I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:27:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so41051791pfk.1
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:27:08 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 7/7] xfstests-bld: optionally build keyctl
Date: Thu, 25 May 2017 12:25:49 -0700
Message-Id: <20170525192549.138518-8-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add support for optionally including the keyctl program in the xfstests
tarball built by xfstests-bld.  keyctl is used by the filesystem
encryption tests.  Although keyctl is already included in the test
appliances, including it in the xfstests tarball can be useful in cases
where the tarball is being used on its own, without being contained in a
dedicated test appliance.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .gitignore                         |  1 +
 Documentation/building-xfstests.md |  4 ++++
 Makefile                           |  1 +
 build-all                          | 28 ++++++++++++++++++++++++----
 config                             |  5 +++++
 get-all                            |  1 +
 6 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index db604f8..6831ef0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,7 @@ MAKELOG
 /e2fsprogs-libs/lib/blkid/blkid.h
 /e2fsprogs-libs/lib/uuid/uuid.h
 /fio/
+/keyutils/
 /popt/.deps/
 /popt/Doxyfile
 /popt/Makefile
diff --git a/Documentation/building-xfstests.md b/Documentation/building-xfstests.md
index 4ec3042..fc1c783 100644
--- a/Documentation/building-xfstests.md
+++ b/Documentation/building-xfstests.md
@@ -32,6 +32,10 @@ be free to make local changes or update it with "git pull" as desired.
 the fio tree have caused test regressions in the past, so it may be
 preferable to let things be as far as the fio repo is concerned.)
 
+The build also supports some optional repositories which are only
+included when their URLs are uncommented in the config file; see the
+config file for a full list.
+
 ## Installing the necessary packages to build xfstests
 
 In order to build xfstests, a number of prerequisite packages are
diff --git a/Makefile b/Makefile
index ced32b2..9d505f3 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,7 @@
 #
 
 REPOS =		fio \
+		keyutils \
 		quota \
 		stress-ng \
 		xfsprogs-dev \
diff --git a/build-all b/build-all
index b41c51a..c3392ad 100755
--- a/build-all
+++ b/build-all
@@ -24,6 +24,7 @@ case "$CROSS_COMPILE" in
 	SKIP_QUOTA=yes
 	SKIP_FIO=yes
 	SKIP_DBENCH=yes
+	SKIP_KEYUTILS=yes
 	;;
 esac
 
@@ -43,13 +44,13 @@ function set_skip_all () {
     SKIP_XFSTESTS=yes
     SKIP_QUOTA=yes
     SKIP_KVM_UTILS=yes
+    SKIP_KEYUTILS=yes
     SKIP_STRESS_NG=yes
 }
 
-if test ! -d stress-ng
-then
-    SKIP_STRESS_NG=yes
-fi
+# Optional components
+[ -d keyutils ] || SKIP_KEYUTILS=yes
+[ -d stress-ng ] || SKIP_STRESS_NG=yes
 
 
 while [ "$1" != "" ]; do
@@ -88,6 +89,10 @@ while [ "$1" != "" ]; do
 	    set_skip_all
 	    unset SKIP_FIO
 	    ;;
+	--keyutils-only)
+	    set_skip_all
+	    unset SKIP_KEYUTILS
+	    ;;
 	--quota-only)
 	    set_skip_all
 	    unset SKIP_QUOTA
@@ -182,6 +187,21 @@ if test -z "$SKIP_AIO" ; then
     rm $DESTDIR/lib/libaio.so*
 fi
 
+if test -z "$SKIP_KEYUTILS" ; then
+    build_start "keyutils"
+    (cd keyutils ;
+     ver=$(git describe --always --dirty); echo "keyutils	$ver ($(git log -1 --pretty=%cD))" > ../keyutils.ver ;
+
+     # For now we only care about keyctl, not libkeyutils.  Therefore, specify
+     # NO_SOLIB=1 so that libkeyutils is only built as a static library.  Then
+     # keyctl will be statically linked to it, and we won't have to install
+     # libkeyutils.so.
+     make $J NO_SOLIB=1 CFLAGS="$LCF" LDFLAGS="$EXEC_LDFLAGS" keyctl ;
+
+     install -D -m 0755 keyctl $DESTDIR/bin/keyctl ;
+    )
+fi
+
 if test -z "$SKIP_STRESS_NG" ; then
     build_start "stress-ng"
     mkdir -p $DESTDIR/lib
diff --git a/config b/config
index 0703829..5b21803 100644
--- a/config
+++ b/config
@@ -7,6 +7,11 @@ XFSPROGS_GIT=git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
 FIO_GIT=git://git.kernel.dk/fio.git
 QUOTA_GIT=git://git.kernel.org/pub/scm/utils/quota/quota-tools.git
 
+# Optional repositories, uncomment only if needed
+#
+# KEYUTILS_GIT=git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
+# STRESS_NG_GIT=https://github.com/ColinIanKing/stress-ng
+
 FIO_COMMIT=fio-2.19
 QUOTA_COMMIT=e0b6335
 XFSPROGS_COMMIT=v4.11.0-rc1
diff --git a/get-all b/get-all
index bb1cd4c..45f6c57 100755
--- a/get-all
+++ b/get-all
@@ -107,6 +107,7 @@ setup_repo xfsprogs-dev		XFSPROGS_GIT	XFSPROGS_COMMIT		true
 setup_repo xfstests-dev		XFSTESTS_GIT	XFSTESTS_COMMIT		true
 
 # optional repositories
+setup_repo keyutils		KEYUTILS_GIT	KEYUTILS_COMMIT		false
 setup_repo stress-ng		STRESS_NG_GIT	STRESS_NG_COMMIT	false
 
 # Make sure acl doesn't try regenerate these files because of the
-- 
2.13.0.219.gdb65acc882-goog

