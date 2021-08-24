Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B850C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF8C613A7
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 09:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhHXJH2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235542AbhHXJH1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 05:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629796002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnCtXVWOFiGCGJvXC5Y8CRDOKuEyemIN/avIXYRSijw=;
        b=RqWGjXfncY1Yn96WFYvzcGA/+pDne3KOR/hgRP/o8TNpXiuWR3IizjFLxsxMRJPfN+k6VF
        8MhIXpoPwyDz89V+x57tvRzZf+QP8C5Gn/cLm4QZzD7e1/y27VBz/qLggbWqx9CuUzNE30
        cCm5e4GZ4d7pxPySs0Dsj8Bd23uCg10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-ltPzacaQOpGYPkfQYeZ_zg-1; Tue, 24 Aug 2021 05:06:41 -0400
X-MC-Unique: ltPzacaQOpGYPkfQYeZ_zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7E08015C7;
        Tue, 24 Aug 2021 09:06:40 +0000 (UTC)
Received: from localhost (unknown [10.66.61.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB254399;
        Tue, 24 Aug 2021 09:06:39 +0000 (UTC)
Date:   Tue, 24 Aug 2021 17:06:38 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     Murphy Zhou <xzhou@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        ddouwsma@redhat.com, Eryu Guan <eguan@linux.alibaba.com>,
        zlang@redhat.com
Subject: [PATCH v4] tests/generic: check log recovery with readonly mount
Message-ID: <20210824090638.cfg7irh6bo55ey26@xzhoux.usersys.redhat.com>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824062354.lcbmbz2r6fv5zowo@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824062354.lcbmbz2r6fv5zowo@fedora>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

And followed by a rw mount. After log recovery by these 2 mount, the
filesystem should be in a consistent state.

Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---

Thanks Eryu and Zorro!

v2:
   Add explanation of the issue
   add xfs_force_bdev data $SCRATCH_MNT
   use DF_PROG
   Re numbered this test
v3:
   Add _require_scratch_shutdown
   Use _get_available_space
   Explain why does not use _scratch_mount
v4:
   Add to recoveryloop group
   Move to generic as there are no xfs specific operations
   Remove all operations after 2 cycle mounts, let the fsck in fstests
to check the filesystem consistency
   Use _scratch_shutdown, MOUNT_PROG
   Remove unnecessary comments

 tests/generic/999     | 45 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..9685488b
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,45 @@
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
+_begin_fstest auto quick recoveryloop shutdown
+
+# real QA test starts here
+
+_require_scratch
+_require_scratch_shutdown
+_scratch_mkfs > $seqres.full 2>&1
+
+# Don't use _scratch_mount because we need to mount without SELinux context
+# to reproduce this issue. If we mount with _scratch_mount, SELinux context
+# maybe applied and this testcase is not reproducing the original issue.
+$MOUNT_PROG $SCRATCH_DEV $SCRATCH_MNT
+_xfs_force_bdev data $SCRATCH_MNT
+
+echo Testing > $SCRATCH_MNT/testfile
+
+# -f is required to reproduce
+_scratch_shutdown -f
+
+_scratch_cycle_mount ro
+_scratch_cycle_mount
+
+# These 2 mount should have the log fully recovered. Exit here and let the
+# fsck operation to check the consistence of the tested filesystem. On the
+# buggy kernel, this testcase reports filesystem is in inconsistent state.
+# On the fixed kernel, testcase pass.
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
-- 
2.20.1

