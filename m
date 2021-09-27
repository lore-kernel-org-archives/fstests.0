Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07092C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 07:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCED60F6D
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 07:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhI0HYr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Sep 2021 03:24:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:58612 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233191AbhI0HYr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="224479882"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="224479882"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 00:23:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="561113399"
Received: from meiyuezh-mobl.ccr.corp.intel.com (HELO mxinjiax-mobl1.ccr.corp.intel.com) ([10.255.31.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 00:23:08 -0700
From:   Ma Xinjian <xinjianx.ma@intel.com>
To:     fstests@vger.kernel.org
Cc:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        Ma Xinjian <xinjianx.ma@intel.com>
Subject: [PATCH 2/2] btrfs/091: remove noinode_cache option
Date:   Mon, 27 Sep 2021 15:20:19 +0800
Message-Id: <20210927072019.46609-2-xinjianx.ma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927072019.46609-1-xinjianx.ma@intel.com>
References: <20210927072019.46609-1-xinjianx.ma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

inode cache feature has been removed

Link: https://www.spinics.net/lists/linux-btrfs/msg107910.html
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ma Xinjian <xinjianx.ma@intel.com>
---
 tests/btrfs/091 | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/tests/btrfs/091 b/tests/btrfs/091
index 307289b1..f2cd00b2 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -23,21 +23,12 @@ _require_cp_reflink
 # use largest node/leaf size (64K) to allow the test to be run on arch with
 # page size > 4k.
 NODESIZE=65536
-SUPPORT_NOINODE_CACHE="yes"
 
 run_check _scratch_mkfs "--nodesize $NODESIZE"
 
-# inode cache will also take space in fs tree, disable them to get consistent
-# result.
 # discard error output since we will check return value manually.
 # also disable all compression, or output will mismatch with golden output
-_try_scratch_mount "-o noinode_cache,compress=no,compress-force=no" 2> /dev/null
-
-# Check for old kernel which doesn't support 'noinode_cache' mount option
-if [ $? -ne 0 ]; then
-	support_noinode_cache="no"
-	_scratch_mount
-fi
+_try_scratch_mount "-o compress=no,compress-force=no" 2> /dev/null
 
 _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv1
 _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv2
@@ -46,16 +37,6 @@ _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 
-# if we don't support noinode_cache mount option, then we should double check
-# whether inode cache is enabled before executing the real test payload.
-if [ $SUPPORT_NOINODE_CACHE == "no" ]; then
-	EMPTY_SIZE=`$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | \
-		$SED_PROG -n '/[0-9]/p' | $AWK_PROG '{print $2}' | head -n1`
-	if [ $EMPTY_SIZE != $NODESIZE ]; then
-		_notrun "Kernel doesn't support to disable inode cache"
-	fi
-fi
-
 $XFS_IO_PROG -f -c "pwrite 0 256K" $SCRATCH_MNT/subv1/file1 | _filter_xfs_io
 cp --reflink $SCRATCH_MNT/subv1/file1 $SCRATCH_MNT/subv2/file1
 cp --reflink $SCRATCH_MNT/subv1/file1 $SCRATCH_MNT/subv3/file1
-- 
2.20.1

