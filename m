Return-Path: <SRS0=ARln=6E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1636C3815B
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E12320775
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587399706;
	bh=o7H7p9C34Zj4HiBiChZy4lv4JR1+Er9KahAD2vdeJQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ubJxtRpYa8Ox6EiMYfPDZBYogWlEOTbSiq9d4B4/P/XwguDHqhHcYnexrGB8qquYS
	 gk/UTgYsponqvkGrtbejB1Axti+Natk/YEpcLoTwiWAugQ0KD8yPhcVZNSBxe+OrDv
	 daGkHt+NmfKcaq+WZfngIaeKmhHUlNs7jadBmm/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgDTQVq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgDTQVq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 20 Apr 2020 12:21:46 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10F6206F6;
        Mon, 20 Apr 2020 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587399705;
        bh=o7H7p9C34Zj4HiBiChZy4lv4JR1+Er9KahAD2vdeJQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfYWtmsSpLORpj5tatrKtFiBIP49pq5B7A2x1EpDVfOT55ljfqqJxE3LoPBiRDnhW
         4TnvRl7xpTCfVaCpo5JZx5jNYiOdXfHQ9pdo0FREDLwIILc9fJR/I0D2qWdyiVh1zd
         a0xjmMw2g6PAmMRVpzHV/xCx6h0Ywawf+XP1fNKk=
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, guaneryu@gmail.com,
        bfoster@redhat.com, viro@zeniv.linux.org.uk
Subject: [RFC PATCH v2] generic: test reporting of wb errors via syncfs
Date:   Mon, 20 Apr 2020 12:21:43 -0400
Message-Id: <20200420162143.28170-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200414120740.293998-1-jlayton@kernel.org>
References: <20200414120740.293998-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add a test for new syncfs error reporting behavior. When an inode fails
to be written back, ensure that a subsequent call to syncfs() will also
report an error.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/999     | 79 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  8 +++++
 tests/generic/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

v2:
- update license comment
- only write a page of data
- don't bother testing for enough scratch space
- don't hold file open over test

Thanks to Brian Foster for the review! This is testing a proposed
behavior change and is dependent on this patchset being merged:

    vfs: have syncfs() return error when there are writeback errors

We'll probably want to wait until its fate is clear before merging this.

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..cdc0772d0774
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2020, Jeff Layton. All rights reserved.
+# FS QA Test No. 999
+#
+# Open a file and write to it and fsync. Then, flip the data device to throw
+# errors, write to it again and do an fdatasync. Then open an O_RDONLY fd on
+# the same file and call syncfs against it and ensure that an error is reported.
+# Then call syncfs again and ensure that no error is reported. Finally, repeat
+# the open and syncfs and ensure that there is no error reported.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_dmerror_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmerror
+
+# real QA test starts here
+_supported_os Linux
+_require_scratch_nocheck
+# This test uses "dm" without taking into account the data could be on
+# realtime subvolume, thus the test will fail with rtinherit=1
+_require_no_rtinherit
+_require_dm_target error
+
+rm -f $seqres.full
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_dmerror_init
+_dmerror_mount
+
+
+# create file
+testfile=$SCRATCH_MNT/syncfs-reports-errors
+touch $testfile
+
+# write a page of data to file, and call fsync
+datalen=$(getconf PAGE_SIZE)
+$XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
+
+# flip device to non-working mode
+_dmerror_load_error_table
+
+# rewrite the data and call fdatasync
+$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile
+
+# heal the device error
+_dmerror_load_working_table
+
+# open again and call syncfs twice
+echo "One of the following syncfs calls should fail with EIO:"
+$XFS_IO_PROG -r -c syncfs -c syncfs $testfile
+echo "done"
+
+echo "This syncfs call should succeed:"
+$XFS_IO_PROG -r -c syncfs $testfile
+echo "done"
+
+# success, all done
+_dmerror_cleanup
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..950a2ba42503
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,8 @@
+QA output created by 999
+Format and mount
+fdatasync: Input/output error
+One of the following syncfs calls should fail with EIO:
+syncfs: Input/output error
+done
+This syncfs call should succeed:
+done
diff --git a/tests/generic/group b/tests/generic/group
index 718575baeef9..9bcf296fc3dd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -598,3 +598,4 @@
 594 auto quick quota
 595 auto quick encrypt
 596 auto quick
+999 auto quick
-- 
2.25.3

