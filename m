Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DCBC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 05:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AF6124B
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 05:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhHXFF0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 01:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhHXFFZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 01:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629781481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p/ok7xsqxf+BSr2QNXfHMYGwhoJdb3dve7L8zR788MA=;
        b=MMKgZ4iCYL32giNaza0A187U/4Msg4IqdexJ986wd96BniLnG9B9hX9sz7GH9aYzfnnOA7
        EE/zBli/bPfE6Q9/vEfWOXXAkkqSpRY4dg5TxT39wgclW20KcK7Ry/QoIgdjuYDtTRCNdO
        GoJahNzrulxKSR0UDH/zJRfptbkAMXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-YUbbqmQiPfeQ-opWKyUUYw-1; Tue, 24 Aug 2021 01:04:39 -0400
X-MC-Unique: YUbbqmQiPfeQ-opWKyUUYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B44F802923;
        Tue, 24 Aug 2021 05:04:38 +0000 (UTC)
Received: from localhost (unknown [10.66.61.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FDB85C1D5;
        Tue, 24 Aug 2021 05:04:37 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:04:36 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        ddouwsma@redhat.com
Subject: [PATCH v3] tests/xfs: check available blocks after log recovery on
 ro mount
Message-ID: <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823174316.GE12612@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

And followed by a rw mount.

Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---

Thanks Darrick very much for reviewing!

v2:
   Add explaination of the issue
   add xfs_force_bdev data $SCRATCH_MNT
   use DF_PROG
   Re numbered this test
v3:
   Add _require_scratch_shutdown
   Use _get_available_space
   Explain why does not use _scratch_mount

 tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |  2 ++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 00000000..0ce9989b
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 RedHat All Rights Reserved.
+#
+# FS QA Test 999
+#
+# Testcase for kernel commit:
+#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
+#
+# After shutdown and readonly mount, a following read-write mount would
+# get wrong number of available blocks. This is caused by unmounting the log
+# on a readonly filesystem doesn't log the sb counters.
+#
+. ./common/preamble
+_begin_fstest shutdown auto quick
+
+# real QA test starts here
+
+_supported_fs xfs
+_require_scratch
+_require_scratch_shutdown
+
+_scratch_mkfs > $seqres.full 2>&1
+# Don't use _scratch_mount because we need to mount without SELinux context
+# to reproduce this issue. If we mount with SELinux context, this testcase
+# is not reproducing the original issue.
+mount $SCRATCH_DEV $SCRATCH_MNT
+_xfs_force_bdev data $SCRATCH_MNT
+
+# Write test file
+ls > $SCRATCH_MNT/testfile
+$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Shutdown
+$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
+
+# Mount ReadOnly
+_scratch_unmount
+_scratch_mount -oro
+$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
+# Umount and mount rw
+_scratch_unmount
+_scratch_mount
+
+# Get fdblocks before repair
+fdb1=$(_get_available_space $SCRATCH_MNT)
+_scratch_unmount
+
+# Repair
+_repair_scratch_fs >> $seqres.full 2>&1
+
+# Re-mount
+_scratch_mount
+
+# Get fdblocks after repair
+fdb2=$(_get_available_space $SCRATCH_MNT)
+
+echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
+
+[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
-- 
2.20.1

