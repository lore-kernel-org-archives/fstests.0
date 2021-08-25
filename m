Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECEEC4338F
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 03:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DAF61247
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 03:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhHYD1q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 23:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237168AbhHYD1q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 23:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629861996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4gIdoGoOsQeUDwW1YWLqQn2h7kEVMQwGGwyoKRqW0zU=;
        b=Bn+VQl/pQwwB5eGWclT3K7NX2PIVmOINmtdCIweLnZdc9VvLAF5UpASpKRhbSXxrzhS7O0
        +ov8/1hC2I1oSqfeRvUpcZlKdWKEoLp2aXTyeG0XsAQjKDRZ/hZ3zAE23jqXksj9LW6HHg
        QZAvIMmfD5ZQ6RT4LsqcCOuo3cEaVlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-UlxcEAVVPAymGw3C0IAXDQ-1; Tue, 24 Aug 2021 23:26:33 -0400
X-MC-Unique: UlxcEAVVPAymGw3C0IAXDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F7AF801A92;
        Wed, 25 Aug 2021 03:26:32 +0000 (UTC)
Received: from localhost (unknown [10.66.61.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A73075DF21;
        Wed, 25 Aug 2021 03:26:31 +0000 (UTC)
Date:   Wed, 25 Aug 2021 11:26:30 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Donald Douwsma <ddouwsma@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com,
        Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH v5] tests/generic: check log recovery with readonly mount
Message-ID: <20210825032630.gezd2jvkd4oczzsx@xzhoux.usersys.redhat.com>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824062354.lcbmbz2r6fv5zowo@fedora>
 <3628adee-a6f1-6621-2988-786334fb6284@redhat.com>
 <a5d58dab-5f4b-884f-d29e-e531e536fc24@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d58dab-5f4b-884f-d29e-e531e536fc24@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

And followed by a rw mount. After log recovery by these 2 mounts, the
filesystem should be in a consistent state.

Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---

Thanks for reviewing! It seems my last several replies from gmail got
rejected by the list.

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
   Move to generic as there is no xfs specific operations
   Remove all operations after 2 cycle mounts, let the fsck in fstests to check the filesystem consistency
   Use _scratch_shutdown, MOUNT_PROG
   Remove unnecessary comments
v5:
   Make _xfs_force_bdev xfs only
   Use _scratch_mount, it's still reproducible


 tests/generic/999     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..60e0ce59
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,42 @@
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
+_scratch_mount
+[ "$FSTYP" == "xfs" ] && _xfs_force_bdev data $SCRATCH_MNT
+
+echo Testing > $SCRATCH_MNT/testfile
+
+# -f is required to reproduce the original issue
+_scratch_shutdown -f
+
+_scratch_cycle_mount ro
+_scratch_cycle_mount
+
+# These two mounts should have the log fully recovered. Exit here and let the
+# fsck operation of xfstests to check the consistence of the tested filesystem.
+# On the buggy kernel, this testcase reports filesystem is inconsistent.
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

