Received: from mail.cn.fujitsu.com ([183.91.158.132]:12919 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751567AbeFEJdy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Jun 2018 05:33:54 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/rc: Fix mismatched output from standard mkswap
Date: Tue, 5 Jun 2018 17:21:45 +0800
Message-ID: <1528190505-20483-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: osandov@fb.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Running generic/495 with EXT4 on RHEL6 got the following output:
----------------------------------------------------------------
...
+mkswap: /mnt/xfstests/scratch/swap: warning: don't erase bootbits sectors
+        on whole disk. Use -f to force.
+mkswap: unable to relabel /mnt/xfstests/scratch/swap to system_u:object_r:swapfile_t:s0: Operation not supported
...
----------------------------------------------------------------

Before commit c1f1b30 of util-linux, mkswap didn't zap bootbits sectors
and printed a warning until force option(i.e. -f) was given, so we add
the force option.

Before commit d97dc0e of util-linux, mkswap failed to relabel SELinux
labeling when the underlying filesystem didn't support it.  We avoid
default fs-wide context set in xfstests by mounting manually.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 9273ff7..6a20454 100644
--- a/common/rc
+++ b/common/rc
@@ -2216,7 +2216,7 @@ _format_swapfile() {
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
-	mkswap "$fname" >> $seqres.full
+	mkswap -f "$fname" >> $seqres.full
 }
 
 # Check that the filesystem supports swapfiles
@@ -2225,7 +2225,7 @@ _require_scratch_swapfile()
 	_require_scratch
 
 	_scratch_mkfs >/dev/null
-	_scratch_mount
+	_mount $SCRATCH_DEV $SCRATCH_MNT
 
 	# Minimum size for mkswap is 10 pages
 	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
-- 
1.8.3.1



