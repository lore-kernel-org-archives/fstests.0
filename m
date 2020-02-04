Return-Path: <SRS0=2WCJ=3Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C4BC3524D
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Feb 2020 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE662082E
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Feb 2020 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="MPm4HEgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgBDOiD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:38:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43178 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgBDOiD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Feb 2020 09:38:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id j20so18095092qka.10
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2020 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UCMkonT7Vd3ETCvM77HXTXnAy5YoDZ075AHY2GGCbU=;
        b=MPm4HEgDDG0lDuhSudsLPDRPxDLcN7nKPwrRcYAJP2NwgwgOeeac+7GQXWYUUS7q+t
         /alLIqxnVfl3xNL7HFY0wEbA9a/Kjppfr6BeGn7SXXkh8J01/LFd7xQ1xT5p5RmLxAnV
         1HaEbpLPf5Ouz2zi/UVMcO10GOgNA6FLe0941fvUkF6otQDe2klgUsgTPpFG2Pgn3cq3
         cIeHfBSymOIqPIdQVMpPuwWv6pa6n7cso6mR40xyrsBmGKqMPGnKphREdm8huBFH6M72
         mEBmFTYUZWiVmRT2pt1gI9A5/lNmc2GwBVuKrV4uriyHKLwHcnRrkEzxZKnIiejyYu8l
         lt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UCMkonT7Vd3ETCvM77HXTXnAy5YoDZ075AHY2GGCbU=;
        b=hwLJZ3Z2mNKIEnedLVml/53VJ/2IQFPl7c75D4CKe8P/0XmvZrDjY+lBv/peQfwCkn
         L5Bk0u1r6VDz7yFFLs/WjjfOpa75rRCq1Cp3TH77wWAqvYJcfwoRouaQ9nMNCwx5/Qw6
         wN2WVdNQgnP+KigpdxokXV/Um0xTh7utu+xxBNGgNRW7iAZ/k0ORi3GNFJcnu99mJoKH
         s2oVDqKE30/xWMauNowRhIz+v8bQ5GOkWcm3SsGM1F/beRnJWDw7tMCCZvgVc2s3w7hO
         eyIvp48SFw1kpNmOSG2Sl7k1N+RB2D/Ie1NSJnNcJm1LMlYu6/ybd9v32lMW/NEEW+Cs
         b84Q==
X-Gm-Message-State: APjAAAWYxmpZ4b6sqs4MObGGTXIzzcRYhBfcEAqLezB9giuBml5FuDwB
        xZNBEF/a7rhKeQ2cz1T1qfkLhg==
X-Google-Smtp-Source: APXvYqz2DyiiExpJC9uJtKJmaw3bS0mMcWpIywZgRrj/7pkXYxbHZqtrwMfTnR8oD/nfch/AMTBexA==
X-Received: by 2002:a05:620a:999:: with SMTP id x25mr28222350qkx.87.1580827081125;
        Tue, 04 Feb 2020 06:38:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 184sm11027091qkl.81.2020.02.04.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:38:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH][v2] xfstest: add a test for the btrfs file extent gap issue
Date:   Tue,  4 Feb 2020 09:37:59 -0500
Message-Id: <20200204143759.697376-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a test to validate that we're not adjusting up i_size before we
have the appropriate file extents on disk.  We had a problem where
i_size would be adjusted up without a contiguous range of file extents,
which isn't ok without a special option enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- adjusted the commit interval time to make the test shorter
- adjusted the write range so we didn't get tripped up by btrfs's delalloc
  behavior
- integrated all of Filipe's suggestions

 tests/btrfs/172     | 76 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out |  3 ++
 tests/btrfs/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/btrfs/172
 create mode 100644 tests/btrfs/172.out

diff --git a/tests/btrfs/172 b/tests/btrfs/172
new file mode 100755
index 00000000..cae5f623
--- /dev/null
+++ b/tests/btrfs/172
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 172
+#
+# Validate that without no-holes we do not get an i_size that is after a gap in
+# the file extents on disk.  This is fixed by the following patches
+#
+#     btrfs: use the file extent tree infrastructure
+#     btrfs: replace all uses of btrfs_ordered_update_i_size
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmlogwrites
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_log_writes
+_require_xfs_io_command "sync_range"
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
+
+# There's not a straightforward way to commit the transaction without also
+# flushing dirty pages, so shorten the commit interval to 1 so we're sure to get
+# a commit with our broken file
+_log_writes_mount -o commit=1
+
+$XFS_IO_PROG -f -c "pwrite 0 5m" $SCRATCH_MNT/file | _filter_xfs_io
+$XFS_IO_PROG -f -c "sync_range -abw 4m 1m" $SCRATCH_MNT/file | _filter_xfs_io
+
+# Now wait for a transaction commit to happen, wait 2x just to be super sure
+sleep 2
+
+_log_writes_unmount
+_log_writes_remove
+
+cur=$(_log_writes_find_next_fua 0)
+echo "cur=$cur" >> $seqres.full
+while [ ! -z "$cur" ]; do
+	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
+
+	# We only care about the fs consistency, so just run fsck, we don't have
+	# to mount the fs to validate it
+	_check_scratch_fs
+
+	cur=$(_log_writes_find_next_fua $(($cur + 1)))
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
new file mode 100644
index 00000000..45051739
--- /dev/null
+++ b/tests/btrfs/172.out
@@ -0,0 +1,3 @@
+QA output created by 172
+wrote 5242880/5242880 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 4b64bf8b..53cb3451 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -174,6 +174,7 @@
 169 auto quick send
 170 auto quick snapshot
 171 auto quick qgroup
+172 auto quick log replay
 173 auto quick swap
 174 auto quick swap
 175 auto quick swap volume
-- 
2.24.1

