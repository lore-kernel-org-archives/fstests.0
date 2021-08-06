Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4DC4338F
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 01:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F761186
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 01:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhHFBt6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhHFBt5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Aug 2021 21:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628214582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4TwxTNmkI1u6hc0SDZpkCBRxW9Cjpn8VsX+Str7DCYU=;
        b=KQObJYtyn4FoDPOhC9YHrbatWrqnT28brg5YUFiSSZd3MR248koLptUaNyISgzKshLHDkG
        zMzNkG7XLqUYI65H/cve+YYlvEvC5if2+yVdYWD8hoGqnWxf6HwzK/eoJqCva0JtjIpmi0
        ZMoUlrvXJXLr0WLxjdjqfjAeyPqgXzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-CpcK7TE8MzuzS27R-OuWeQ-1; Thu, 05 Aug 2021 21:49:41 -0400
X-MC-Unique: CpcK7TE8MzuzS27R-OuWeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90FE1871803
        for <fstests@vger.kernel.org>; Fri,  6 Aug 2021 01:49:40 +0000 (UTC)
Received: from localhost (unknown [10.66.61.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E645D9DE;
        Fri,  6 Aug 2021 01:49:39 +0000 (UTC)
Date:   Fri, 6 Aug 2021 09:49:38 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     fstests@vger.kernel.org
Cc:     ddouwsma@redhat.com
Subject: [PATCH] tests/xfs: check avail blocks after log recovery on ro mount
Message-ID: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

And followed by a rw mount.

Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 tests/xfs/175     | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/175.out |  2 ++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/xfs/175
 create mode 100644 tests/xfs/175.out

diff --git a/tests/xfs/175 b/tests/xfs/175
new file mode 100755
index 00000000..2a79a3d4
--- /dev/null
+++ b/tests/xfs/175
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 RedHat All Rights Reserved.
+#
+# FS QA Test 175
+#
+# Testcase for kernel commit:
+#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
+#
+# After shutdown and readonly mount, a following read-write mount would
+# get wrong number of available blocks.
+#
+. ./common/preamble
+_begin_fstest shutdown auto quick
+
+# real QA test starts here
+
+_supported_fs xfs
+_require_scratch
+
+_scratch_mkfs > $seqres.full 2>&1
+mount $SCRATCH_DEV $SCRATCH_MNT
+
+# Write test file
+ls > $SCRATCH_MNT/testfile
+df --output=avail $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Shutdown
+$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
+
+# Mount ReadOnly
+_scratch_unmount
+_scratch_mount -oro
+df --output=avail $SCRATCH_MNT >> $seqres.full 2>&1
+# Umount and mount rw
+_scratch_unmount
+_scratch_mount
+
+# Get fdblocks before repair
+fdb1=$(df --output=avail $SCRATCH_MNT | tail -1)
+_scratch_unmount
+
+# Repair
+_repair_scratch_fs >> $seqres.full 2>&1
+
+# Re-mount
+_scratch_mount
+
+# Get fdblocks after repair
+fdb2=$(df --output=avail $SCRATCH_MNT | tail -1)
+
+echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
+
+[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/xfs/175.out b/tests/xfs/175.out
new file mode 100644
index 00000000..3b4af34b
--- /dev/null
+++ b/tests/xfs/175.out
@@ -0,0 +1,2 @@
+QA output created by 175
+Silence is golden
-- 
2.20.1

