Received: from imap.thunk.org ([74.207.234.97]:38794 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbdHMRcb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 13 Aug 2017 13:32:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [xfstests-bld PATCH 2/2] Make the build and creation of xfstests.tar.gz to be reproducible
Date: Sun, 13 Aug 2017 13:32:24 -0400
Message-Id: <20170813173224.28900-2-tytso@mit.edu>
In-Reply-To: <20170813173224.28900-1-tytso@mit.edu>
References: <20170813173224.28900-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Use techniques from https://reproducible-builds.org so the builds will
be reproducible, assuming a fixed build environment.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 build-all                             |  6 ++++++
 gen-tarball                           | 10 ++++++++--
 kvm-xfstests/test-appliance/gen-image | 12 +++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/build-all b/build-all
index 6ff5a48..570006e 100755
--- a/build-all
+++ b/build-all
@@ -148,6 +148,12 @@ else
     LCF="-g -O2"
 fi
 
+# To make the build more reproducible...
+export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
+export BUILD_PATH_PREFIX_MAP="xfstests-bld=$(pwd)"
+# GCC doesn't yet understand BUILD_PATH_PREFIX_MAP
+LCF="$LCF -fdebug-prefix-map=$(pwd)=xfstests-bld -gno-record-gcc-switches"
+
 if test -z "$SKIP_E2FSLIBS" ; then
     build_start "e2fslibs"
     (cd e2fsprogs-libs; \
diff --git a/gen-tarball b/gen-tarball
index 5f7230d..5aa0142 100755
--- a/gen-tarball
+++ b/gen-tarball
@@ -32,6 +32,10 @@ done
 
 which pigz &>/dev/null && GZIP=pigz || GZIP=gzip
 
+if test -z "$SOURCE_DATE_EPOCH" ; then
+    export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
+fi
+
 echo "GEN xfstests"
 rm -rf xfstests
 if test "$fast" = "yes"
@@ -47,6 +51,7 @@ cat *.ver > xfstests/git-versions
 mkdir -p xfstests/bin xfstests/lib
 cp bld/bin/* bld/sbin/* bld/usr/bin/* xfstests/bin
 cp bld/lib/client.txt xfstests/lib
+rm xfstests/bin/compile_et xfstests/bin/mk_cmds
 for i in ltp/fsstress ltp/fsx ltp/aio-stress src/godown
 do
     ln -s ../$i xfstests/bin
@@ -54,5 +59,6 @@ done
 echo "STRIP xfstests/*"
 find xfstests -mindepth 2 -type f -perm /0111 | xargs $STRIP 2> /dev/null
 echo "TAR xfstests"
-tar c --owner=root --group=root --mode=go+u-w xfstests | \
-	$GZIP -9 > xfstests.tar.gz
+find xfstests -print0 | LC_ALL=C sort -z | \
+    tar c --owner=0 --group=0 --numeric-owner --mtime="@${SOURCE_DATE_EPOCH}" \
+    --mode=go+u-w --null --no-recursion -T - | $GZIP -9n > xfstests.tar.gz
diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
index e7bdb35..2701353 100755
--- a/kvm-xfstests/test-appliance/gen-image
+++ b/kvm-xfstests/test-appliance/gen-image
@@ -66,6 +66,10 @@ while [ "$1" != "" ]; do
   shift
 done
 
+if test -z "$SOURCE_DATE_EPOCH" ; then
+    export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
+fi
+
 if test -n "$DO_LOG" ; then
     if test -z "$GEN_IMAGE_LOG" ; then
 	export GEN_IMAGE_LOG="$DO_LOG"
@@ -312,11 +316,13 @@ if test -n "$OUT_TAR"; then
     rmdir $ROOTDIR/debs
     rmdir $ROOTDIR/imgdir
     case "$OUT_TAR" in
-	*.gz)	ZFLAG="-z" ;;
-	*)	ZFLAG="" ;
+	*.gz)	ZCMD="gzip -9n" ;;
+	*)	ZCMD="cat" ;
     esac
     fix_symlinks
-    tar -C $ROOTDIR -c $ZFLAG -f "$OUT_TAR" .
+    (cd "$ROOTDIR" ; find . -print0 | LC_ALL=C sort -z |
+	 tar -c --null --no-recursion -T - --numeric-owner \
+	     --mtime="@${SOURCE_DATE_EPOCH}" -f - | $ZCMD > "$OUT_TAR")
     cleanup_rootdir
     exit 0
 fi
-- 
2.11.0.rc0.7.gbe5a750

