Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7ADC83F01
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Aug 2023 22:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbjH3Wq7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344137AbjH3WoG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Aug 2023 18:44:06 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A1B0
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2023 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Yq2fIhuvXE1I2lxFZLFlu+AnhErD0kbQ7Gc5/oX1ZQQ=; b=Yhhe4z0t/AJlv70CxPd62HPkFW
        /NVevKLa0zXgeqIJIiGjB9vl8bDERXYccBVd+Wfp3d/icFwV6KS/p33m59sWsIB7K1FW/IHzuBRN/
        +tg9orVhVvS0zNXscpo9pwFiKDk2RN/p2lrtIlLw/CjBWUw2l+VgRTAG8oKtfFcTh3HFd83qgKqoe
        Hz1qbjwuhLhZEIIkdvMvNDsh/27qyF8l1yJqwshPLpGCR6dcYrlPO59/JwXD2mM0YU47gxJ52WAY8
        z0uZsIz5na/AxR16r0yzdu+6Spvr9L1NG+wuIWvWo1C1g77dJPpZiK5RlCpUJOgr6MDyVX6CbQE0I
        nDYQan6w==;
Received: from [187.116.122.196] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qbTXS-00HaHX-Ql; Thu, 31 Aug 2023 00:19:51 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     fstests@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, kernel@gpiccoli.net,
        kernel-dev@igalia.com, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] btrfs: Add test for the single-dev feature
Date:   Wed, 30 Aug 2023 19:17:04 -0300
Message-ID: <20230830221943.3375955-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The SINGLE_DEV btrfs feature allows to mount the same filesystem
multiple times, at the same time. This is the fstests counter-part,
which checks both mkfs/btrfstune (by mounting the FS twice), and
also unsupported scenarios, like device replace / remove.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Hi folks, this test was a suggestion by Josef for the SINGLE_DEV feature
we're trying to introduce in the kernel [0].

Some design decisions:

(a) The number 300 was selected since seems we already skipped 298 in
the code base, given that the test btrfs/298 is being worked upstream.

(b) About mounting twice the same filesystem - how to accomplish that
in a proper fashion? I went with the naive / trivial approach, just created
temporary directories on top of $SCRATCH_MNT, but I'm not sure if that is
the way to go. Is it guaranteed that $SCRATCH_MNT is writable prior to
any mount command?

(c) The way to be sure we have two different devices holding the same
image was using SCRATCH_DEV_POOL and dd'ing the first device to the 2nd
one - is there any better alternative than this one?

Suggestions / reviews much appreciated!
Cheers,

Guilherme

[0] https://lore.kernel.org/linux-btrfs/20230803154453.1488248-1-gpiccoli@igalia.com/


 tests/btrfs/300     | 107 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/300.out |   5 +++
 2 files changed, 112 insertions(+)
 create mode 100755 tests/btrfs/300
 create mode 100644 tests/btrfs/300.out

diff --git a/tests/btrfs/300 b/tests/btrfs/300
new file mode 100755
index 000000000000..120e790906ea
--- /dev/null
+++ b/tests/btrfs/300
@@ -0,0 +1,107 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Guilherme G. Piccoli (Igalia S.L.).  All Rights Reserved.
+#
+# FS QA Test 300
+#
+# Test for the btrfs single-dev feature - both mkfs and btrfstune are
+# validated, as well as explicitly unsupported commands, like device
+# removal / replacement.
+#
+. ./common/preamble
+_begin_fstest auto mkfs quick
+. ./common/filter
+_supported_fs btrfs
+
+_require_btrfs_mkfs_feature single-dev
+_require_btrfs_fs_feature single_dev
+
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_command "$WIPEFS_PROG" wipefs
+
+# Used random hash to avoid name collision.
+DIR_a="563b01de1f_a"
+DIR_b="563b01de1f_b"
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	rm -rf $SCRATCH_MNT/$DIR_a
+	rm -rf $SCRATCH_MNT/$DIR_b
+}
+
+# Helper to mount a btrfs fs
+# Arg 1: device
+# Arg 2: mount point
+mount_btrfs()
+{
+	$MOUNT_PROG -t btrfs $1 $2
+	[ $? -ne 0 ] && _fail "mounting $1 on $2 failed"
+}
+
+mkdir $SCRATCH_MNT/$DIR_a
+mkdir $SCRATCH_MNT/$DIR_b
+
+DEV1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+DEV2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')
+
+
+# Part 1
+# First test involves a mkfs with single-dev feature enabled.
+# If it succeeds and mounting that FS *twice* also succeeds,
+# we're good and continue.
+$WIPEFS_PROG -a $DEV1 >> $seqres.full 2>&1
+$WIPEFS_PROG -a $DEV2 >> $seqres.full 2>&1
+
+$MKFS_BTRFS_PROG -O single-dev $DEV1 >>$seqres.full 2>&1
+dd if=$DEV1 of=$DEV2 bs=64M conv=fsync >> $seqres.full 2>&1
+
+mount_btrfs $DEV1 $SCRATCH_MNT/$DIR_a
+mount_btrfs $DEV2 $SCRATCH_MNT/$DIR_b
+
+$UMOUNT_PROG $SCRATCH_MNT/$DIR_b
+$UMOUNT_PROG $SCRATCH_MNT/$DIR_a
+
+
+# Part 2
+# Second test is similar to the first with the difference we
+# run mkfs with no single-dev mention, and make use of btrfstune
+# to set such feature.
+$WIPEFS_PROG -a $DEV1 >> $seqres.full 2>&1
+$WIPEFS_PROG -a $DEV2 >> $seqres.full 2>&1
+
+$MKFS_BTRFS_PROG $DEV1 >>$seqres.full 2>&1
+$BTRFS_TUNE_PROG --convert-to-single-device $DEV1
+dd if=$DEV1 of=$DEV2 bs=64M conv=fsync >> $seqres.full 2>&1
+
+mount_btrfs $DEV1 $SCRATCH_MNT/$DIR_a
+mount_btrfs $DEV2 $SCRATCH_MNT/$DIR_b
+
+$UMOUNT_PROG $SCRATCH_MNT/$DIR_b
+$UMOUNT_PROG $SCRATCH_MNT/$DIR_a
+
+
+# Part 3
+# Final part attempts to run some single-dev unsupported commands,
+# like device replace/remove - it they fail, test succeeds!
+mount_btrfs $DEV1 $SCRATCH_MNT
+
+$BTRFS_UTIL_PROG device replace start $DEV1 $DEV1 $SCRATCH_MNT 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG device remove $DEV1 $SCRATCH_MNT 2>&1 \
+	| sed -e "s,\B$DEV1,DEV1,g"
+
+$UMOUNT_PROG $SCRATCH_MNT
+_scratch_dev_pool_put 2
+
+# success, all done
+status=0
+echo "Finished"
+
+exit
diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
new file mode 100644
index 000000000000..5f13cfb228fb
--- /dev/null
+++ b/tests/btrfs/300.out
@@ -0,0 +1,5 @@
+QA output created by 300
+ERROR: ioctl(DEV_REPLACE_STATUS) failed on "SCRATCH_MNT": Invalid argument
+
+ERROR: error removing device 'DEV1': Invalid argument
+Finished
-- 
2.41.0

