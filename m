Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F9C04A6A
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jul 2023 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGXP3a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jul 2023 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGXP33 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2023 11:29:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CEE5A
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=aPI8T9C0EGuHaTUYooPEW1Zr7hx5O/cEtjB6CHx/XvE=; b=fU1v7ib6VpE/Eo1CMQHaFSV7sk
        WE6cjkMfM+BNuYUYghDMrTThA635GcvAjampsKI+DBYQcq11EfDyC1DP1NfpOlggdu50Dyo5WtugO
        pbdw8HRwIu9HsyQYJgV5S2pTqkwvFKrezlT/yPI/XBJWEY4WoWooseTYGfDyN1rU4iD8Yvw3hqcgd
        2sOW1/RBempkidb3NBjtH8VSyAcbKU04Lti3aIgvOtv33GSoyPYP9euqLRCvF7yAkubZXlh0qberZ
        Rdm3HKwbTMVhOF9fojVDI7WvhdfdNMd7Tp00nGak3hkTaEzjLHGk5uhMe5h4eTvSdDPyaptgTn+Kg
        Kh1ydH+g==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNxV2-004k4z-1Y
        for fstests@vger.kernel.org;
        Mon, 24 Jul 2023 15:29:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/2] generic: add a test for device removal without dirty data
Date:   Mon, 24 Jul 2023 08:29:27 -0700
Message-Id: <20230724152927.33094-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724152927.33094-1-hch@lst.de>
References: <20230724152927.33094-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test the removal of the underlying device when the file system still
does not have dirty data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/731     | 58 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/731.out |  2 ++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/generic/731
 create mode 100644 tests/generic/731.out

diff --git a/tests/generic/731 b/tests/generic/731
new file mode 100755
index 00000000..e1400d06
--- /dev/null
+++ b/tests/generic/731
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
+# Copyright (c) 2023 Christoph Hellwig
+#
+# Test proper file system shut down when the block device is removed underneath
+# and it has no dirty data.
+#
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $SCSI_DEBUG_MNT >>$seqres.full 2>&1
+	_put_scsi_debug_dev
+	rm -f $tmp.*
+}
+
+. ./common/filter
+. ./common/scsi_debug
+
+# We don't actually use the test device, but we need a block based fs
+_require_test
+_require_block_device $TEST_DEV
+_supported_fs generic
+_require_scsi_debug
+
+SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 256`
+test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
+echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
+
+run_check _mkfs_dev $SCSI_DEBUG_DEV
+
+SCSI_DEBUG_MNT="$TEST_DIR/scsi_debug_$seq"
+rm -rf $SCSI_DEBUG_MNT
+mkdir $SCSI_DEBUG_MNT
+run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
+
+# create a test file
+$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $SCSI_DEBUG_MNT/testfile >>$seqres.full
+
+# open a file descriptor for reading the file
+exec 3< $SCSI_DEBUG_MNT/testfile
+
+# drop all caches and delete the scsi debug device
+echo 3 > /proc/sys/vm/drop_caches
+echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
+
+# try to read from the file, which should give us -EIO
+cat <&3 > /dev/null
+
+# close the file descriptor to not block unmount
+exec 3<&-
+
+status=0
+exit
diff --git a/tests/generic/731.out b/tests/generic/731.out
new file mode 100644
index 00000000..102c0522
--- /dev/null
+++ b/tests/generic/731.out
@@ -0,0 +1,2 @@
+QA output created by 731
+cat: -: Input/output error
-- 
2.39.2

