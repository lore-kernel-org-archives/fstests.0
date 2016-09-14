Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:49885 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbcINBzq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Sep 2016 21:55:46 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH v6 3/6] fstests: Add btrfs dedupe post mount hook
Date: Wed, 14 Sep 2016 09:55:24 +0800
Message-Id: <20160914015527.10274-4-quwenruo@cn.fujitsu.com>
In-Reply-To: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
References: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc: fdmanana@gmail.com, mfasheh@suse.de
List-ID: <fstests@vger.kernel.org>

Now fstests can run any test cases with btrfs inband-dedupe enabled.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/rc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 636cba6..e0da69b 100644
--- a/common/rc
+++ b/common/rc
@@ -326,10 +326,26 @@ _run_btrfs_post_mount_hook()
 	mnt_point=$1
 	for n in $ALWAYS_ENABLE_BTRFS_FEATURE; do
 		if [ $n == "quota" -o $n == "qgroup" ]; then
-			# Quota can be enabled for several times
-			# and won't cause bug
+			# Re-enable quota won't cause anything wrong
 			_run_btrfs_util_prog quota enable $mnt_point
 		fi
+		if [ $n == "dedupe" -o $n == "inband-dedupe" -o $n == "dedupe-inband" ]; then
+			# Need to check if kernel/progs support dedupe
+			_require_btrfs_fs_feature dedupe
+			_require_btrfs_subcommand dedupe
+
+			# Check if dedupe is already enabled, or we will
+			# overwrite previous on-disk backend config
+			$BTRFS_UTIL_PROG dedupe status $mnt_point | grep -q "Enabled"
+			if [ $1 -eq 0 ]; then
+				continue
+			fi
+
+			# This will enable dedupe with default options, so
+			# btrfs dedupe test cases needs to use '-f' option to
+			# override default config.
+			_run_btrfs_util_prog dedupe enable $mnt_point
+		fi
 	done
 }
 
-- 
2.7.4



