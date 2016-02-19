Received: from cn.fujitsu.com ([59.151.112.132]:21076 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753034AbcBVDjU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 21 Feb 2016 22:39:20 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 60DF34219191
	for <fstests@vger.kernel.org>; Mon, 22 Feb 2016 11:37:17 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/135: fix standard error output from _scratch_mkfs
Date: Fri, 19 Feb 2016 21:46:03 +0800
Message-ID: <1455889563-12724-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

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



