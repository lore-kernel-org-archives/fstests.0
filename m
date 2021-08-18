Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8BC4338F
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Aug 2021 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F5B6109E
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Aug 2021 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhHRImc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237883AbhHRImb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Aug 2021 04:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629276117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hbxRUBryrvJvIYL5r78lzynaZ/k1IbJVZNRv0ToEbQ8=;
        b=efTqYZGcO2mrteE+kJ+fVFAzAjxaTcJzJM7VuX3/oVpxnWNRre6evb4XfwwsqbgjmgcNS5
        IYheb31aeNGFftRCUBrEsFIQxPwLmRRjP0/AwieQf9UeT+N0+3sPBU1pkSbFFpgz9pTvEG
        waCgkyyvIcUArZ4klsNfkvmTkE5CA18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-dcUW8guZOJWJV6zoi9V3_Q-1; Wed, 18 Aug 2021 04:41:55 -0400
X-MC-Unique: dcUW8guZOJWJV6zoi9V3_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1F5107ACF5;
        Wed, 18 Aug 2021 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (bootp-73-5-251.rhts.eng.pek2.redhat.com [10.73.5.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8AE5C1D1;
        Wed, 18 Aug 2021 08:41:52 +0000 (UTC)
From:   bxue@redhat.com
To:     fstests@vger.kernel.org
Cc:     jack@suse.cz, Boyang Xue <bxue@redhat.com>
Subject: [PATCH] ext4: regression test for "tune2fs -l" after ext4 shutdown
Date:   Wed, 18 Aug 2021 16:40:56 +0800
Message-Id: <20210818084126.4167799-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Boyang Xue <bxue@redhat.com>

Regression test for:

ext4: Fix tune2fs checksum failure for mounted filesystem

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
Hi,

This is a new regression test for the patch

```
ext4: Fix tune2fs checksum failure for mounted filesystem

Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
removed checksum recalculation after updating superblock free space /
inode counters in ext4_fill_super() based on the fact that we will
recalculate the checksum on superblock writeout. That is correct
assumption but until the writeout happens (which can take a long time)
the checksum is incorrect in the buffer cache and if tune2fs is called
in that time window it will complain. So return back the checksum
recalculation and add a comment explaining the tune2fs peculiarity.

Fixes: 81414b4dd48f ("ext4: remove redundant sb checksum recomputation")
Reported-by: Boyang Xue <bxue@xxxxxxxxxx>
Signed-off-by: Jan Kara <jack@xxxxxxx>
```

It's expected to fail on kernels from the kernel-5.11-rc1 to the latest
version, where tune2fs fails with:

```
tune2fs 1.46.2 (28-Feb-2021)
tune2fs: Superblock checksum does not match superblock while trying to
open /dev/loop0
Couldn't find valid filesystem superblock.
```

Please help review this test, Thanks!

-Boyang

 tests/ext4/309     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/309.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..ae335617
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 309
+#
+# Test that tune2fs doesn't fail after ext4 shutdown
+# Regression test for commit:
+# ext4: Fix tune2fs checksum failure for mounted filesystem
+#
+. ./common/preamble
+_begin_fstest auto rw quick
+
+_cleanup()
+{
+	_scratch_unmount
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_require_scratch
+_require_scratch_shutdown
+_require_command "$TUNE2FS_PROG" tune2fs
+
+echo "Silence is golden"
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+echo "ext4/309" > $SCRATCH_MNT/309.tmp
+_scratch_shutdown
+_scratch_cycle_mount
+$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
+if [ $? -eq 0 ]; then
+	status=0
+else
+	status=1
+fi
+
+exit
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..56330d65
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,2 @@
+QA output created by 309
+Silence is golden
-- 
2.27.0

