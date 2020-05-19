Return-Path: <SRS0=WJEH=7B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BCC433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 19 May 2020 06:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9860820758
	for <linux-fstests@archiver.kernel.org>; Tue, 19 May 2020 06:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLxBZrZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgESGzs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 May 2020 02:55:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24058 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgESGzs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 May 2020 02:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589871346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=wuIvfYSdtktPzVhi/QY6YA5Y1CHyQsQPcHp0TrcxUlw=;
        b=SLxBZrZsqX1PjiBe2k4qHLa9/WgoKSbEo5NFCODFAhubWhn0oIKHztiKtszUB3rmJXnRd6
        Oo0+dJe9BUI9tdU4FLl9tL5Ory3FQqdzj1Q2EG2Khq09k6YZfT3F8HOjWiNhKM5CsWCuT6
        g2jP7ZZofpA7cyhEADXndj9WFbnUNiE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-TvqzM6oqM76xhm_uNte20g-1; Tue, 19 May 2020 02:55:41 -0400
X-MC-Unique: TvqzM6oqM76xhm_uNte20g-1
Received: by mail-pf1-f197.google.com with SMTP id i6so10426366pfg.20
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 23:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wuIvfYSdtktPzVhi/QY6YA5Y1CHyQsQPcHp0TrcxUlw=;
        b=AxaTOrts+KQF/UChs2xpQ14pORtGT/G5hipKbT0HwbpEOhj62DJAiBLScF5UD7CzZG
         xaYrLdZEXHz7Get0OS8EZNWAwNua7obGk4UpvhnYXUrvXgQepOCzyoN7rLX06KJAo0Vc
         NmrB2m1TcEQcWJhsaUKtmIPuLHsWgDDGX6aMcoDchRZxjxSZ8KrM4BkpLvs2ygFdfkK3
         SDIeLcFWEFfd7EGgIyXGO6OOQwg4Sn38Uhp962lwgC43X0LplP9py2Jt30wrwFl1cb6M
         Y9+hDkBm0EdRjzjhFD47qRmPQhJmQI+R8d04V6VBngO1Bk0K1nGIgO0KaPXjxmhFjHsp
         ZPtw==
X-Gm-Message-State: AOAM531WEVDYpi3qCiSGAKB+v+qKBEbxmAsI46BLoN+aS2EzJsIdIX3L
        klFIBrv+jPua9MMmB4Ws3oUWTkWENSSYRBTxcd6/FCiv2FNNCgiaC7WrfIel1wHxMpi/upUN0ZD
        Z9i6GVtI1470RFHdU4A==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr18582965pgb.218.1589871340379;
        Mon, 18 May 2020 23:55:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE1QvXdx1rLkvdB3I5gvUW6Hcxww7lUWwrXPac3BYXilhgaeCuzdD+gbYaOWQkL6/kZXgcSw==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr18582945pgb.218.1589871340049;
        Mon, 18 May 2020 23:55:40 -0700 (PDT)
Received: from don.com ([60.224.129.195])
        by smtp.gmail.com with ESMTPSA id y5sm5713080pge.50.2020.05.18.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 23:55:39 -0700 (PDT)
From:   Donald Douwsma <ddouwsma@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Donald Douwsma <ddouwsma@redhat.com>
Subject: [PATCH] xfstests: add test for xfs_repair progress reporting
Date:   Tue, 19 May 2020 16:55:12 +1000
Message-Id: <20200519065512.232760-1-ddouwsma@redhat.com>
X-Mailer: git-send-email 2.18.4
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs_repair's interval based progress has been broken for
some time, create a test based on dmdelay to stretch out
the time and use ag_stride to force parallelism.

Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>
---
 tests/xfs/516     | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/516.out | 15 ++++++++++
 tests/xfs/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/xfs/516
 create mode 100644 tests/xfs/516.out

diff --git a/tests/xfs/516 b/tests/xfs/516
new file mode 100755
index 00000000..5ad57fbc
--- /dev/null
+++ b/tests/xfs/516
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 516
+#
+# Test xfs_repair's progress reporting
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
+	_dmsetup_remove delay-test > /dev/null 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmdelay
+. ./common/populate
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_dm_target delay
+
+# Filter output specific to the formatters in xfs_repair/progress.c
+# Ideally we'd like to see hits on anything that matches
+# awk '/{FMT/' repair/progress.c
+_filter_repair()
+{
+	sed -ne '
+	s/[0-9]\+/#/g;
+	/#:#:#:/p
+	'
+}
+
+echo "Format and populate"
+_scratch_populate_cached nofill > $seqres.full 2>&1
+
+echo "Introduce a dmdelay"
+_init_delay
+
+# Introduce a read I/O delay
+# The default in common/dmdelay is a bit too agressive
+BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 100 $SCRATCH_DEV 0 0"
+_load_delay_table $DELAY_READ
+
+echo "Run repair"
+$XFS_REPAIR_PROG -o ag_stride=4 -t 1 $DELAY_DEV >> $seqres.full 2>&1
+cat $seqres.full | _filter_repair | sort -u
+
+_cleanup_delay
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/516.out b/tests/xfs/516.out
new file mode 100644
index 00000000..bc824d7f
--- /dev/null
+++ b/tests/xfs/516.out
@@ -0,0 +1,15 @@
+QA output created by 516
+Format and populate
+Introduce a dmdelay
+Run repair
+	- #:#:#: Phase #: #% done - estimated remaining time # minutes, # seconds
+	- #:#:#: Phase #: elapsed time # second - processed # inodes per minute
+	- #:#:#: Phase #: elapsed time # seconds - processed # inodes per minute
+        - #:#:#: check for inodes claiming duplicate blocks - # of # inodes done
+        - #:#:#: process known inodes and inode discovery - # of # inodes done
+        - #:#:#: process newly discovered inodes - # of # allocation groups done
+        - #:#:#: rebuild AG headers and trees - # of # allocation groups done
+        - #:#:#: scanning agi unlinked lists - # of # allocation groups done
+        - #:#:#: scanning filesystem freespace - # of # allocation groups done
+        - #:#:#: setting up duplicate extent list - # of # allocation groups done
+        - #:#:#: verify and correct link counts - # of # allocation groups done
diff --git a/tests/xfs/group b/tests/xfs/group
index 12eb55c9..aeeca23f 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -513,3 +513,4 @@
 513 auto mount
 514 auto quick db
 515 auto quick quota
+516 repair
-- 
2.18.4

