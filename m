Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8EC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 01:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AA664E21
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 01:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhCABri (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Feb 2021 20:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231329AbhCABrh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Feb 2021 20:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614563170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cEyMEIORvl9oiMC/vlXNb/6yfabUvcM1Y9wT0CzbG28=;
        b=feDyr7VlqI8TyefPK5BO5mqqPn28N6vSfXOL/KDjFdWFysvLpzHd5ENcX5EJlcG9Z8r/ig
        FYOAi7Z9vViyyiO2KeXcoozVyfuPJzxhnk8ayi8JMOdq6hoqj1BY7WzEW3LJfToEO8Lsk1
        ZfVt9aStVN9eYPMDGyJm1RjzHa9aWnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-5w3yxBxGMUCDt6-8h03svQ-1; Sun, 28 Feb 2021 20:46:08 -0500
X-MC-Unique: 5w3yxBxGMUCDt6-8h03svQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73CC80197A
        for <fstests@vger.kernel.org>; Mon,  1 Mar 2021 01:46:07 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF8A5C257
        for <fstests@vger.kernel.org>; Mon,  1 Mar 2021 01:46:06 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfstests: remove _require_no_rtinherit completely
Date:   Mon,  1 Mar 2021 09:46:03 +0800
Message-Id: <20210301014603.147159-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The _require_no_rtinherit has been removed by:
  0ac0d8fb ("common: remove _require_no_rtinherit")

But some cases still remain the _require_no_rtinherit, so remove
them all.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/250 | 7 ++++---
 tests/generic/252 | 6 +++---
 tests/generic/441 | 7 ++++---
 tests/generic/484 | 7 ++++---
 tests/generic/487 | 7 ++++---
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tests/generic/250 b/tests/generic/250
index eaa2f884..102bf500 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -33,12 +33,13 @@ _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
 _require_odirect
-# This test uses "dm" without taking into account the data could be on
-# realtime subvolume, thus the test will fail with rtinherit=1
-_require_no_rtinherit
 
 rm -f $seqres.full
 
+# Disable the scratch rt device to avoid test failures relating to the rt
+# bitmap consuming all the free space in our small data device.
+unset SCRATCH_RTDEV
+
 fssize=$((196 * 1048576))
 echo "Format and mount"
 $XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
diff --git a/tests/generic/252 b/tests/generic/252
index 61369759..809e8020 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -32,14 +32,14 @@ _cleanup()
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
-# This test uses "dm" without taking into account the data could be on
-# realtime subvolume, thus the test will fail with rtinherit=1
-_require_no_rtinherit
 _require_aiodio "aiocp"
 AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
 
+# Disable the scratch rt device to avoid test failures relating to the rt
+# bitmap consuming all the free space in our small data device.
+unset SCRATCH_RTDEV
 
 fssize=$((196 * 1048576))
 echo "Format and mount"
diff --git a/tests/generic/441 b/tests/generic/441
index 6ad449bb..bedbcb08 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -32,9 +32,6 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch
-# This test uses "dm" without taking into account the data could be on
-# realtime subvolume, thus the test will fail with rtinherit=1
-_require_no_rtinherit
 
 # Generally, we want to avoid journal errors on the extended testcase. Only
 # unset the -s flag if we have a logdev
@@ -57,6 +54,10 @@ _require_test_program dmerror
 
 rm -f $seqres.full
 
+# Disable the scratch rt device to avoid test failures relating to the rt
+# bitmap consuming all the free space in our small data device.
+unset SCRATCH_RTDEV
+
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init
diff --git a/tests/generic/484 b/tests/generic/484
index ad39e45b..331cd1ad 100755
--- a/tests/generic/484
+++ b/tests/generic/484
@@ -37,14 +37,15 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch_nocheck
-# This test uses "dm" without taking into account the data could be on
-# realtime subvolume, thus the test will fail with rtinherit=1
-_require_no_rtinherit
 _require_dm_target error
 _require_xfs_io_command "syncfs"
 
 rm -f $seqres.full
 
+# Disable the scratch rt device to avoid test failures relating to the rt
+# bitmap consuming all the free space in our small data device.
+unset SCRATCH_RTDEV
+
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init
diff --git a/tests/generic/487 b/tests/generic/487
index 197b2385..1aa97ada 100755
--- a/tests/generic/487
+++ b/tests/generic/487
@@ -32,9 +32,6 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch_nocheck
-# This test uses "dm" without taking into account the data could be on
-# realtime subvolume, thus the test will fail with rtinherit=1
-_require_no_rtinherit
 
 sflag='-s'
 case $FSTYP in
@@ -50,6 +47,10 @@ _require_dm_target error
 
 rm -f $seqres.full
 
+# Disable the scratch rt device to avoid test failures relating to the rt
+# bitmap consuming all the free space in our small data device.
+unset SCRATCH_RTDEV
+
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init
-- 
2.29.2

