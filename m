Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00073C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Oct 2021 03:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81960EBB
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Oct 2021 03:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhJYD1J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 23:27:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:16109 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232008AbhJYD1J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 24 Oct 2021 23:27:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229829394"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="229829394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 20:24:41 -0700
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="496594248"
Received: from lihengzh-mobl1.ccr.corp.intel.com (HELO lkp-mouse.ccr.corp.intel.com) ([10.255.30.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 20:24:39 -0700
From:   Zhu Yifei <yifeix.zhu@intel.com>
To:     Eryu <guan@eryu.me>, fstests <fstests@vger.kernel.org>,
        Philip Li <philip.li@intel.com>
Cc:     Zhu Yifei <yifeix.zhu@intel.com>
Subject: [PATCH v2 xfstests-dev] tests/btrfs/012: check size after mounted
Date:   Mon, 25 Oct 2021 11:22:56 +0800
Message-Id: <20211025032256.61557-1-yifeix.zhu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

move '_require_fs_space'  after mounted.

==before patch==
btrfs/012       [not run] This test requires at least 0GB free on /fs/scratch to run

==after patch==
btrfs/012 189s ...  194s
Ran: btrfs/012
Passed all 1 tests

Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>
---
 tests/btrfs/012 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 3040a655..29552b14 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -31,8 +31,6 @@ _require_command "$E2FSCK_PROG" e2fsck
 # ext4 does not support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
-_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
-
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
 # Create & populate an ext4 filesystem
@@ -41,6 +39,8 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 
+_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
+
 cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
 _scratch_unmount
 
-- 
2.20.1

