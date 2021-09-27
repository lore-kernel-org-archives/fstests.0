Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A72C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523E160F6D
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 07:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhI0HYq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Sep 2021 03:24:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:58612 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233191AbhI0HYq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="224479879"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="224479879"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 00:23:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="561113391"
Received: from meiyuezh-mobl.ccr.corp.intel.com (HELO mxinjiax-mobl1.ccr.corp.intel.com) ([10.255.31.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 00:23:06 -0700
From:   Ma Xinjian <xinjianx.ma@intel.com>
To:     fstests@vger.kernel.org
Cc:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        Ma Xinjian <xinjianx.ma@intel.com>
Subject: [PATCH 1/2] btrfs/049: remove the test
Date:   Mon, 27 Sep 2021 15:20:18 +0800
Message-Id: <20210927072019.46609-1-xinjianx.ma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

inode_cache is deprecated and will never appear in mount
options; remove it entirely

Link: https://www.spinics.net/lists/linux-btrfs/msg107910.html
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ma Xinjian <xinjianx.ma@intel.com>
---
 tests/btrfs/049 | 85 -------------------------------------------------
 1 file changed, 85 deletions(-)
 delete mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
deleted file mode 100755
index 87c205ca..00000000
--- a/tests/btrfs/049
+++ /dev/null
@@ -1,85 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2014 Fujitsu.  All Rights Reserved.
-#
-# FS QA Test No. btrfs/049
-#
-# Regression test for btrfs inode caching vs tree log which was
-# addressed by the following kernel patch.
-#
-# Btrfs: fix inode caching vs tree log
-#
-. ./common/preamble
-_begin_fstest auto quick
-
-# Override the default cleanup function.
-_cleanup()
-{
-	_cleanup_flakey
-	rm -rf $tmp
-}
-
-# Import common functions.
-. ./common/filter
-. ./common/dmflakey
-
-# real QA test starts here
-_supported_fs btrfs
-_require_scratch
-_require_dm_target flakey
-# Zoned btrfs does not support inode cache
-_require_non_zoned_device "$SCRATCH_DEV"
-
-_scratch_mkfs >> $seqres.full 2>&1
-
-SAVE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
-MOUNT_OPTIONS="$MOUNT_OPTIONS -o inode_cache,commit=100"
-
-# create a basic flakey device that will never error out
-_init_flakey
-_mount_flakey
-
-_get_inode_id()
-{
-	local inode_id
-	inode_id=`stat $1 | grep Inode: | $AWK_PROG '{print $4}'`
-	echo $inode_id
-}
-
-$XFS_IO_PROG -f -c "pwrite 0 10M" -c "fsync" \
-	$SCRATCH_MNT/data >& /dev/null
-
-inode_id=`_get_inode_id "$SCRATCH_MNT/data"`
-rm -f $SCRATCH_MNT/data
-
-for i in `seq 1 5`;
-do
-	mkdir $SCRATCH_MNT/dir_$i
-	new_inode_id=`_get_inode_id $SCRATCH_MNT/dir_$i`
-	if [ $new_inode_id -eq $inode_id ]
-	then
-		$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" \
-			$SCRATCH_MNT/dir_$i/data1 >& /dev/null
-		_load_flakey_table 1
-		_unmount_flakey
-		need_umount=1
-		break
-	fi
-	sleep 1
-done
-
-# restore previous mount options
-export MOUNT_OPTIONS="$SAVE_MOUNT_OPTIONS"
-
-# ok mount so that any recovery that needs to happen is done
-if [ $new_inode_id -eq $inode_id ];then
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
-	_unmount_flakey
-fi
-
-# make sure we got a valid fs after replay
-_check_scratch_fs $FLAKEY_DEV
-
-status=0
-exit
-- 
2.20.1

