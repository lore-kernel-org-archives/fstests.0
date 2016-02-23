Received: from cn.fujitsu.com ([59.151.112.132]:32967 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755986AbcBWBgE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Feb 2016 20:36:04 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 1949342AC845
	for <fstests@vger.kernel.org>; Tue, 23 Feb 2016 09:34:05 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/135: fix standard error output from _scratch_mkfs
Date: Tue, 23 Feb 2016 09:35:25 +0800
Message-ID: <1456191325-1217-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

'mke2fs 1.42.9 (28-Dec-2013)' produces as standard error when
we run generic/135 in ext4 file system. This is a regression
bug which bring in by commit:
4a5cda8 xfstests: do not unmount tmpfs during remount
That patch remove '2>&1', so i bring that back.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/135 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/generic/135 b/tests/generic/135
index 52418f6..5aa880d 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -41,7 +41,7 @@ _supported_os Linux IRIX
 
 _require_odirect
 _require_scratch
-_scratch_mkfs >/dev/null
+_scratch_mkfs &>/dev/null
 _scratch_mount
 
 cd $SCRATCH_MNT
-- 
1.7.1



