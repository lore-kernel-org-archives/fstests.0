Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25917C001B0
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Jul 2023 04:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGWEuY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Jul 2023 00:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWEuX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jul 2023 00:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82215E7A
        for <fstests@vger.kernel.org>; Sat, 22 Jul 2023 21:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D002E60B87
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 04:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691B6C433C7;
        Sun, 23 Jul 2023 04:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690087821;
        bh=aFA4Rr0LTnO+kZe93zwJP0S7MHkIuufcT4HgSRJR7CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4HyM2XPzedzOO4MvbQ7vCr/wsxMVpBrj4SFP2MTEbrnj9I0FOJLiYxcjvTfmoY26
         DqslWnnSqnr+F8xA1CHT7WGQp9KsO6oqjLUPwcVACriHGK+sDrU3haDtzbJlZ6E7Ao
         FB/qZvsu9oJ01/j1ufHnUxbqT+m/8xhCcGYmy+MHlrazeZ0MpFv5k0Yd6wmW9Xe1bd
         1hrGM42Lv3dl3Y4LbcRJLvfdRkuX7qWscRXEebPrZFWT/ufQrZa0jIOGqLi5ZPEl+U
         NoJhN7lE/3JXStwgbnNfZxezfMRvqhJB2Rp3aVi1MQYtYNHUWIFQQ8VZkf24cE88mI
         sb+Rc4yiGrRQQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCH] generic: add a test for device removal with dirty data
Date:   Sun, 23 Jul 2023 12:50:17 +0800
Message-Id: <20230723045017.1706370-1-zlang@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711100931.175680-2-hch@lst.de>
References: <20230711100931.175680-2-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Test the removal of the underlying device when the file system still
has dirty data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Hi Christoph,

I'd like to help this patchset to catch this or next fstests release. So I
changed this patch a bit, if you feel good, I'll merge this patch as below.
(Same to the 2nd patch).

Change logs:
1) Replace SCRATCH_DEV with TEST_DEV, replace SCRATCH_MNT with SCSI_DEBUG_MNT
   which is a directory in TEST_DIR, due to we don't call _require_scratch
   in this case.
2) Call _fail if _mkfs_dev or _mount fails

Thanks,
Zorro

 tests/generic/730     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/730.out |  2 ++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/generic/730
 create mode 100644 tests/generic/730.out

diff --git a/tests/generic/730 b/tests/generic/730
new file mode 100755
index 00000000..7886b38d
--- /dev/null
+++ b/tests/generic/730
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
+# Copyright (c) 2023 Christoph Hellwig
+#
+# Test proper file system shut down when the block device is removed underneath
+# and there is dirty data.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $SCSI_DEBUG_MNT >>$seqres.full 2>&1
+	_put_scsi_debug_dev
+	rm -r -f $tmp.*
+}
+
+. ./common/filter
+. ./common/scsi_debug
+
+_supported_fs generic
+
+# We don't actually use the test device, but we need a block based fs
+_require_test
+_require_block_device $TEST_DEV
+_require_scsi_debug
+
+physical=`blockdev --getpbsz $TEST_DEV`
+logical=`blockdev --getss $TEST_DEV`
+
+SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
+test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
+echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
+
+_mkfs_dev $SCSI_DEBUG_DEV || _fail "make $FSTYP on $SCSI_DEBUG_DEV"
+SCSI_DEBUG_MNT="$TEST_DIR/scsi_debug_$seq"
+rm -rf $SCSI_DEBUG_MNT
+mkdir $SCSI_DEBUG_MNT
+run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
+
+# create a test file
+$XFS_IO_PROG -f -c "pwrite 0 1M" $SCSI_DEBUG_MNT/testfile >>$seqres.full
+
+# open a file descriptor for reading the file
+exec 3< $SCSI_DEBUG_MNT/testfile
+
+# delete the scsi debug device while it still has dirty data
+echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
+
+# try to read from the file, which should give us -EIO
+cat <&3 > /dev/null
+
+# close the file descriptor to not block unmount
+exec 3<&-
+
+status=0
+exit
diff --git a/tests/generic/730.out b/tests/generic/730.out
new file mode 100644
index 00000000..79e96db8
--- /dev/null
+++ b/tests/generic/730.out
@@ -0,0 +1,2 @@
+QA output created by 730
+cat: -: Input/output error
-- 
2.40.1

