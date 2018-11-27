Received: from mail-pf1-f195.google.com ([209.85.210.195]:34563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1Ims (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 03:42:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so9054838pfg.1
        for <fstests@vger.kernel.org>; Tue, 27 Nov 2018 13:43:32 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/3] generic: workaround device where glibc is not installed
Date: Tue, 27 Nov 2018 13:43:06 -0800
Message-Id: <20181127214308.137410-2-gwendal@chromium.org>
In-Reply-To: <20181127214308.137410-1-gwendal@chromium.org>
References: <20181127214308.137410-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Some tests needs page size and long size, provided by getconf.
On systems where getconf is not installed, guess with default values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 common/config     | 18 ++++++++++++++++++
 common/rc         |  6 ------
 tests/btrfs/053   |  2 +-
 tests/generic/205 |  2 +-
 tests/generic/206 |  2 +-
 tests/generic/216 |  2 +-
 tests/generic/217 |  2 +-
 tests/generic/218 |  2 +-
 tests/generic/220 |  2 +-
 tests/generic/222 |  2 +-
 tests/generic/227 |  2 +-
 tests/generic/229 |  2 +-
 tests/generic/238 |  2 +-
 tests/generic/349 |  6 +++---
 tests/generic/350 |  6 +++---
 tests/generic/351 |  6 +++---
 16 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/common/config b/common/config
index 8a5a6e08..e7a83c3c 100644
--- a/common/config
+++ b/common/config
@@ -718,6 +718,24 @@ get_next_config() {
 	fi
 }
 
+# Workaround systems where glibc is not installed.
+GETCONF=$(which getconf 2> /dev/null) || GETCONF=
+get_page_size() {
+	if [ -z "$GETCONF" ]; then
+		echo "4096"
+	else
+		"$GETCONF" PAGE_SIZE
+	fi
+}
+
+get_long_bit() {
+	if [ -z "$GETCONF" ]; then
+		echo "64"
+	else
+		"$GETCONF" LONG_BIT
+	fi
+}
+
 if [ -z "$CONFIG_INCLUDED" ]; then
 	get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
 	export CONFIG_INCLUDED=true
diff --git a/common/rc b/common/rc
index be1ed68c..992cb3cc 100644
--- a/common/rc
+++ b/common/rc
@@ -3686,12 +3686,6 @@ _get_block_size()
 	stat -f -c %S $1
 }
 
-get_page_size()
-{
-	echo $(getconf PAGE_SIZE)
-}
-
-
 run_fsx()
 {
 	echo fsx $@
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 16656fa8..2c206e2a 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -43,7 +43,7 @@ _require_attrs
 # max(16384, PAGE_SIZE) is the default leaf/node size on btrfs-progs v3.12+.
 # Older versions just use max(4096, PAGE_SIZE).
 # mkfs.btrfs can't create an fs with a leaf/node size smaller than PAGE_SIZE.
-leaf_size=$(echo -e "16384\n`getconf PAGE_SIZE`" | sort -nr | head -1)
+leaf_size=$(echo -e "16384\n`get_page_size`" | sort -nr | head -1)
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/generic/205 b/tests/generic/205
index 53aa1abb..3acd3a28 100755
--- a/tests/generic/205
+++ b/tests/generic/205
@@ -36,7 +36,7 @@ _require_scratch_reflink
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/206 b/tests/generic/206
index 9c933657..431e3320 100755
--- a/tests/generic/206
+++ b/tests/generic/206
@@ -37,7 +37,7 @@ _require_odirect
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/216 b/tests/generic/216
index abf664d6..16a48aa3 100755
--- a/tests/generic/216
+++ b/tests/generic/216
@@ -37,7 +37,7 @@ _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/217 b/tests/generic/217
index dda6ec7a..fc07c8ea 100755
--- a/tests/generic/217
+++ b/tests/generic/217
@@ -38,7 +38,7 @@ _require_odirect
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/218 b/tests/generic/218
index 7ed74724..fbba706b 100755
--- a/tests/generic/218
+++ b/tests/generic/218
@@ -37,7 +37,7 @@ _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/220 b/tests/generic/220
index fdee86d8..f6a35290 100755
--- a/tests/generic/220
+++ b/tests/generic/220
@@ -38,7 +38,7 @@ _require_odirect
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/222 b/tests/generic/222
index 06d88ff5..357f453a 100755
--- a/tests/generic/222
+++ b/tests/generic/222
@@ -37,7 +37,7 @@ _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/227 b/tests/generic/227
index 457b5a48..52b41ba2 100755
--- a/tests/generic/227
+++ b/tests/generic/227
@@ -38,7 +38,7 @@ _require_odirect
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/229 b/tests/generic/229
index 9872b295..2b099bdf 100755
--- a/tests/generic/229
+++ b/tests/generic/229
@@ -37,7 +37,7 @@ _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/238 b/tests/generic/238
index e8276cc5..fc5d3f49 100755
--- a/tests/generic/238
+++ b/tests/generic/238
@@ -38,7 +38,7 @@ _require_odirect
 
 rm -f $seqres.full
 
-pagesz=$(getconf PAGE_SIZE)
+pagesz=$(get_page_size)
 blksz=$((pagesz / 4))
 
 echo "Format and mount"
diff --git a/tests/generic/349 b/tests/generic/349
index f01f817d..9084bf56 100755
--- a/tests/generic/349
+++ b/tests/generic/349
@@ -50,15 +50,15 @@ md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
 
 echo "Zero range to MAX_LFS_FILESIZE"
 # zod = MAX_LFS_FILESIZE
-case "$(getconf LONG_BIT)" in
+case "$(get_long_bit)" in
 "32")
-	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
+	zod=$(( ($(get_page_size) << ($(get_long_bit) - 1) ) - 1))
 	;;
 "64")
 	zod=9223372036854775807
 	;;
 *)
-	_fail "sizeof(long) == $(getconf LONG_BIT)?"
+	_fail "sizeof(long) == $(get_long_bit)?"
 	;;
 esac
 $XFS_IO_PROG -c "fzero -k 0 $zod" $dev
diff --git a/tests/generic/350 b/tests/generic/350
index 0aea4c09..b4d30a57 100755
--- a/tests/generic/350
+++ b/tests/generic/350
@@ -47,15 +47,15 @@ md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
 
 echo "Punch to MAX_LFS_FILESIZE"
 # zod = MAX_LFS_FILESIZE
-case "$(getconf LONG_BIT)" in
+case "$(get_long_bit)" in
 "32")
-	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
+	zod=$(( ($(get_page_size) << ($(get_long_bit) - 1) ) - 1))
 	;;
 "64")
 	zod=9223372036854775807
 	;;
 *)
-	_fail "sizeof(long) == $(getconf LONG_BIT)?"
+	_fail "sizeof(long) == $(get_long_bit)?"
 	;;
 esac
 $XFS_IO_PROG -c "fpunch 0 $zod" $dev
diff --git a/tests/generic/351 b/tests/generic/351
index e326dca1..b86b4d58 100755
--- a/tests/generic/351
+++ b/tests/generic/351
@@ -62,15 +62,15 @@ $XFS_IO_PROG -c "fpunch 512 512" $dev
 
 echo "Zero range past MAX_LFS_FILESIZE keep size"
 # zod = MAX_LFS_FILESIZE
-case "$(getconf LONG_BIT)" in
+case "$(get_long_bit)" in
 "32")
-	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
+	zod=$(( ($(get_page_size) << ($(get_long_bit) - 1) ) - 1))
 	;;
 "64")
 	zod=9223372036854775807
 	;;
 *)
-	_fail "sizeof(long) == $(getconf LONG_BIT)?"
+	_fail "sizeof(long) == $(get_long_bit)?"
 	;;
 esac
 $XFS_IO_PROG -c "fzero -k 512k $zod" $dev
-- 
2.18.1
