Received: from mail.cn.fujitsu.com ([183.91.158.132]:47210 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbeLNIg2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Dec 2018 03:36:28 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/rc: Fix mismatched output from standard mkswap
Date: Fri, 14 Dec 2018 15:57:27 +0800
Message-ID: <1544774247-14706-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180607095207.GH2861@desktop>
References: <20180607095207.GH2861@desktop>
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

1) Before commit c1f1b30 of util-linux, mkswap didn't zap bootbits sectors
   and printed a warning until force option(i.e. -f) was given.  We try to
   add the force option.

2) With mounting default SELinux context(e.g. system_u:object_r:root_t:s0),
   standard mkswap tried to reset the type of default context to swapfile_t
   if it is not swapfile_t, and then it failed and returned ENOTSUP expectedly
   as we don't want to create any SELinux attr on purpose.  standard mkswap
   ignored this relabel error by commit d97dc0e of util-linux, but it still
   reported the error before commit d97dc0e.  We try to skip the reset step
   in standard mkswap by mounting swapfile context.

Note:
We just mount swapfile context in related tests, and keep default context
in the rest of tests.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index e5da648..4bdb870 100644
--- a/common/rc
+++ b/common/rc
@@ -2210,7 +2210,7 @@ _format_swapfile() {
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
-	mkswap "$fname" >> $seqres.full
+	mkswap -f "$fname" >> $seqres.full
 }
 
 # Check that the filesystem supports swapfiles
@@ -2219,6 +2219,8 @@ _require_scratch_swapfile()
 	_require_scratch
 
 	_scratch_mkfs >/dev/null
+	[ -n "$SELINUX_MOUNT_OPTIONS" ] && export \
+		SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
 	_scratch_mount
 
 	# Minimum size for mkswap is 10 pages
-- 
1.8.3.1
