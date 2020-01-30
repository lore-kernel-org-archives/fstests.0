Return-Path: <SRS0=Nfi6=3T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4EC3F68F
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jan 2020 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9362083E
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jan 2020 20:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="a31yFaBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3Uws (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:52:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34286 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3Uwr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jan 2020 15:52:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id d10so4419554qke.1
        for <fstests@vger.kernel.org>; Thu, 30 Jan 2020 12:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO/Eq00FkiAsu/N1J2HSy3/PakzL7B2iYVK5k6B+NQ4=;
        b=a31yFaBLiHzzf4gI3Aua2M4VXRRUddamfG/wkZu67Dh/5COiZxEgGLXBmG1sZ5qdV/
         dxr79O2VJQKupP0fs+4C8haXVrBMABQXPyoOMzVwRnEGPv9rP639yAlKFwCe8hImSW+D
         S6lyluriu68IqQBV2QiBmWKjHuZAx0KI2q8imuUJg+KZm9FDMyTyI0nBSSfoCIpKuvbt
         ydNUcAkkFeYGE2HRIZp4hB+GXkJwnQCb+a6OpqpC6R1xRGn4C8WORB8MqxctCP83+IBQ
         qXeaJKMFWlS0bLJ3eoxzeH0DQE0qDmmBGvUpAL1Q4Hfx6PKFTa/+8jBIF5n8EC5Htprk
         5O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wO/Eq00FkiAsu/N1J2HSy3/PakzL7B2iYVK5k6B+NQ4=;
        b=kWwZOqTU8Q/NVvaZ2zUYXs4KW1vmJzq3JVGOfLa6EpCTnrXXnyKrSlOyFcGhCpMC31
         vCMqUSi9WR/UcQI/SQxoVvR1LkwwvpJq5bHxMYrQQUt/YPuYL2zV25/rELsybf8hDgcA
         q5Z0VnnISWuo8XO4/inGM9hAgDkBhBajvOHTxu52UXrooOzxZDD90Lj8qDNFb3FCpzM1
         G7/8CoUwRdKY5MlgkFfIpanGOoI8JoJSHBWYzPIWd6HIdNyHcvd78WaDwgYqti1KsROC
         XOnc79XI/8ouQ9URESlUIV3k4TQhnqlHcm0o0JA7e+dkG2+JjkqChcLCnlXhJUPH7NSW
         19MQ==
X-Gm-Message-State: APjAAAXCWGSHmsR5Baz2PIYYTWB8vKxzjjuYlnwaeQXlOHmf5o9KxU0Z
        K9BTvEOXqXmFxBE4Acj9tShJ9Z9CbWFRIQ==
X-Google-Smtp-Source: APXvYqzkGcXGhgknPg4bkNFP3evROn4E8d3VjFxBxyg+cfUTicMmdYBRLmjGz95y3Yw4rctUBnaZlw==
X-Received: by 2002:a37:454d:: with SMTP id s74mr7450812qka.104.1580417566548;
        Thu, 30 Jan 2020 12:52:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v2sm3745792qto.73.2020.01.30.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:52:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] xfstest: add a test for the btrfs file extent gap issue
Date:   Thu, 30 Jan 2020 15:52:44 -0500
Message-Id: <20200130205244.50551-1-josef@toxicpanda.com>
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
 tests/btrfs/172     | 74 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out |  3 ++
 tests/btrfs/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/btrfs/172
 create mode 100644 tests/btrfs/172.out

diff --git a/tests/btrfs/172 b/tests/btrfs/172
new file mode 100755
index 00000000..8c0c94d6
--- /dev/null
+++ b/tests/btrfs/172
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 172
+#
+# Validate that without no-holes we do not get an i_size that is after a gap in
+# the file extents on disk.  This is fixed by the series
+#
+#     btrfs: fix hole corruption issue with !NO_HOLES
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
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
+
+# There's not a straightforward way to commit the transaction without also
+# flushing dirty pages, so shorten the commit interval to 5 so we're sure to get
+# a commit with our broken file
+_log_writes_mount -o commit=5
+
+$XFS_IO_PROG -f -c "pwrite 0 5m" $SCRATCH_MNT/file | _filter_xfs_io
+$XFS_IO_PROG -f -c "sync_range -abw 2m 1m" $SCRATCH_MNT/file | _filter_xfs_io
+
+# Now wait for a transaction commit to happen, wait 2x just to be super sure
+sleep 10
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
index 4b64bf8b..527fbbf1 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -174,6 +174,7 @@
 169 auto quick send
 170 auto quick snapshot
 171 auto quick qgroup
+172 auto quick
 173 auto quick swap
 174 auto quick swap
 175 auto quick swap volume
-- 
2.24.1

