Received: from mail.cn.fujitsu.com ([183.91.158.132]:34774 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727387AbeLUKMG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Dec 2018 05:12:06 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] common: Fix mismatched output from standard mkswap
Date: Fri, 21 Dec 2018 17:33:28 +0800
Message-ID: <1545384808-14304-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20181215122910.GU3889@desktop>
References: <20181215122910.GU3889@desktop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, osandov@fb.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

With older util-linux(e.g. v2.17.2), running some tests(e.g. generic/472,
generic/495) got the following output:
-------------------------------------------------------
+mkswap: /mnt/xfstests/scratch/swap: warning: don't erase bootbits sectors
+        on whole disk. Use -f to force.
+mkswap: unable to relabel /mnt/xfstests/scratch/swap to system_u:object_r:swapfile_t:s0: Operation not supported
-------------------------------------------------------

1) Before commit c1f1b30 of util-linux, standard mkswap didn't zap bootbits
   sectors and printed a warning until force option(i.e. -f) was given.  We
   define "mkswap -f" as MKSWAP_PROG and replace all standard mkswap with
   $MKSWAP_PROG.

2) With mounting default SELinux context(e.g. system_u:object_r:root_t:s0),
   standard mkswap tried to reset the type of default context to swapfile_t
   if it is not swapfile_t, and then it failed and returned ENOTSUP expectedly
   as we don't want to create any SELinux attr on purpose.  standard mkswap
   ignored this relabel error by commit d97dc0e of util-linux, but it still
   reported the error before commit d97dc0e.  We try to skip the reset step
   in standard mkswap by mounting swapfile context directly.

Note:
We just mount swapfile context in related tests, and keep default context
in the rest of tests.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/config   |  4 ++++
 common/rc       | 14 +++++++++++++-
 tests/btrfs/173 |  2 +-
 tests/xfs/419   |  2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index a87cb4a..2fd23b8 100644
--- a/common/config
+++ b/common/config
@@ -132,6 +132,10 @@ export DF_PROG="$(type -P df)"
 export XFS_IO_PROG="$(type -P xfs_io)"
 [ "$XFS_IO_PROG" = "" ] && _fatal "xfs_io not found"
 
+export MKSWAP_PROG="$(type -P mkswap)"
+[ "$MKSWAP_PROG" = "" ] && _fatal "mkswap not found"
+MKSWAP_PROG="$MKSWAP_PROG -f"
+
 export XFS_LOGPRINT_PROG="$(type -P xfs_logprint)"
 export XFS_REPAIR_PROG="$(type -P xfs_repair)"
 export XFS_DB_PROG="$(type -P xfs_db)"
diff --git a/common/rc b/common/rc
index e5da648..9110c99 100644
--- a/common/rc
+++ b/common/rc
@@ -2210,7 +2210,7 @@ _format_swapfile() {
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
-	mkswap "$fname" >> $seqres.full
+	$MKSWAP_PROG "$fname" >> $seqres.full
 }
 
 # Check that the filesystem supports swapfiles
@@ -2219,6 +2219,18 @@ _require_scratch_swapfile()
 	_require_scratch
 
 	_scratch_mkfs >/dev/null
+
+	# With mounting SELinux context(e.g. system_u:object_r:root_t:s0),
+	# standard mkswap tried to reset the type of default context to
+	# swapfile_t if it's not swapfile_t, and then it failed and returned
+	# ENOTSUP expectedly as we don't want to create any SELinux attr on
+	# purpose.  standard mkswap ignored this relabel error by commit
+	# d97dc0e of util-linux, but it still reported the error before
+	# commit d97dc0e.  We mount swapfile context directly to skip the
+	# reset step.
+	[ -n "$SELINUX_MOUNT_OPTIONS" ] && export \
+		SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
+
 	_scratch_mount
 
 	# Minimum size for mkswap is 10 pages
diff --git a/tests/btrfs/173 b/tests/btrfs/173
index 76d4407..515d8cf 100755
--- a/tests/btrfs/173
+++ b/tests/btrfs/173
@@ -41,7 +41,7 @@ rm -f "$SCRATCH_MNT/swap"
 touch "$SCRATCH_MNT/swap"
 chmod 0600 "$SCRATCH_MNT/swap"
 _pwrite_byte 0x61 0 $(($(get_page_size) * 10)) "$SCRATCH_MNT/swap" >> $seqres.full
-mkswap "$SCRATCH_MNT/swap" >> $seqres.full
+$MKSWAP_PROG "$SCRATCH_MNT/swap" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 
diff --git a/tests/xfs/419 b/tests/xfs/419
index 33d2d0d..6865201 100755
--- a/tests/xfs/419
+++ b/tests/xfs/419
@@ -47,7 +47,7 @@ $XFS_IO_PROG -c "open -f -R $testdir/dummy" $testdir >> $seqres.full
 echo moo >> $testdir/dummy
 $XFS_IO_PROG -c "open -f -R $testdir/file1" $testdir >> $seqres.full
 _pwrite_byte 0x61 0 $((blocks * blksz)) $testdir/file1 >> $seqres.full
-mkswap -U 27376b42-ff65-42ca-919f-6c9b62292a5c $testdir/file1 >> $seqres.full
+$MKSWAP_PROG -U 27376b42-ff65-42ca-919f-6c9b62292a5c $testdir/file1 >> $seqres.full
 
 echo "Try to swapon"
 swapon $testdir/file1 2>&1 | _filter_scratch
-- 
1.8.3.1
