Return-Path: <SRS0=Km02=CL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB11C433E2
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Sep 2020 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A663B2067C
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Sep 2020 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="MzN16LBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIBRDw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgIBRDt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Sep 2020 13:03:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F6C061244
        for <fstests@vger.kernel.org>; Wed,  2 Sep 2020 10:03:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so2558166qvb.0
        for <fstests@vger.kernel.org>; Wed, 02 Sep 2020 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+oALn4aqSmROLT+VxjsY66j3/hBoe5K1t3AGWj4s84=;
        b=MzN16LBud4anPVdSKQ91PIPcLMzBqdlzePpF1PoBodluMvaX+mRzBnGearE1eE+eCT
         BX5iblJ8VZ7d5dhaJb7wAT4HslOVPiS+w680k5jhVDF3TUk6o6mSqlxZZVD6XDbTwBVo
         xAKCPjtJJDMv+wN+a5zn+ool0Hpwerj/iqSZJe+6WIzYZ/sqSczl4aYTmdbK+Ynw34IM
         pgIYYMcBKUlTDjzooYp60tNAelqprBTNigqMB3TCZQEfmp2ilVkD26NoOz530TipT8qL
         PbRZvkq+CT/E7h/p5dc2OM5jJG4hJCgUagEQsdM3GRhr6r6UON6LIwcJXST49WD6X31u
         HVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+oALn4aqSmROLT+VxjsY66j3/hBoe5K1t3AGWj4s84=;
        b=tiZKd79VaN35ZAHOYlk2qqWAtAQuHk8FJ0jD1F4sJ7SLr1SwFvMU0VNlAyh/M1NJ3b
         seHrZp3uuCIKXJLiacXn7xaqy7p/bHenlCaculCsvfu7K1rN1ZSqmLHH7U6jMBFLZ+RY
         9mQQmat03qIPXrWabvtdaFIBqKW7Pd0JBxaJQVVAp4giy7Q2z4qaN2dP8uscQhzzl7ZC
         7WVDUff/jk4asC0Gxr6cunmmRksPxc6HtsWGyuxoxqHmJMlIy8X/VBOAQnmr8yySxOVJ
         RkVzJwcEWDrBUKLrFculQrp6mr6QxFMnIDVF4dYINeSUJ8ncXG7YGWk7AzJfYXiEIeOv
         6UbQ==
X-Gm-Message-State: AOAM533e64CdmRdQJDU0peBa3yfeXKs0CfQrVRFeIabLZh35csO5Ee3+
        z+LmsUwLcVXKLQwDkWOJxH2nbw==
X-Google-Smtp-Source: ABdhPJwW1Ft0dYscciZN7QBlQLKbhMWvOetw+1z2dblTEdZzkrdpXyfRf2UHVVFZ2f4X7+N5O0sUhw==
X-Received: by 2002:a0c:9c4d:: with SMTP id w13mr7737895qve.231.1599066228205;
        Wed, 02 Sep 2020 10:03:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x124sm138923qkd.72.2020.09.02.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 10:03:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/219 add a test for some disk caching usecases
Date:   Wed,  2 Sep 2020 13:03:45 -0400
Message-Id: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a test to check the behavior of the disk caching code inside
btrfs.  It's a regression test for the patch

  btrfs: allow single disk devices to mount with older generations

Thanks,

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/219     | 101 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 104 insertions(+)
 create mode 100755 tests/btrfs/219
 create mode 100644 tests/btrfs/219.out

diff --git a/tests/btrfs/219 b/tests/btrfs/219
new file mode 100755
index 00000000..14e2792f
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,101 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 219
+#
+# Test a variety of stale device usecases.  We cache the device and generation
+# to make sure we do not allow stale devices, which can end up with some wonky
+# behavior for loop back devices.  This was changed with
+#
+#   btrfs: allow single disk devices to mount with older generations
+#
+# But I've added a few other test cases so it's clear what we expect to happen
+# currently.
+#
+
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
+	$UMOUNT_PROG $loop_mnt
+	rm -rf $loop_mnt
+	rm -rf $loop_mnt1
+	rm -f $fs_img2 $fs_img1
+	[ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_loop
+_require_btrfs_forget_or_module_loadable
+
+loop_mnt=$TEST_DIR/$seq.mnt
+loop_mnt1=$TEST_DIR/$seq.mnt1
+fs_img1=$TEST_DIR/$seq.img1
+fs_img2=$TEST_DIR/$seq.img2
+
+mkdir $loop_mnt
+mkdir $loop_mnt1
+
+$XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
+
+_mkfs_dev $fs_img1 >>$seqres.full 2>&1
+cp $fs_img1 $fs_img2
+
+# Normal single device case, should pass just fine
+_mount -o loop $fs_img1 $loop_mnt > /dev/null  2>&1 || \
+	_fail "Couldn't do initial mount"
+$UMOUNT_PROG $loop_mnt
+
+_btrfs_forget_or_module_reload
+
+# Now mount the new version again to get the higher generation cached, umount
+# and try to mount the old version.  Mount the new version again just for good
+# measure.
+loop_dev=`_create_loop_device $fs_img1`
+
+_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+	_fail "Failed to mount the second time"
+$UMOUNT_PROG $loop_mnt
+
+_mount -o loop $fs_img2 $loop_mnt > /dev/null 2>&1 || \
+	_fail "We couldn't mount the old generation"
+$UMOUNT_PROG $loop_mnt
+
+_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+	_fail "Failed to mount the second time"
+$UMOUNT_PROG $loop_mnt
+
+# Now we definitely can't mount them at the same time, because we're still tied
+# to the limitation of one fs_devices per fsid.
+_btrfs_forget_or_module_reload
+
+_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
+	_fail "Failed to mount the third time"
+_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
+	_fail "We were allowed to mount when we should have failed"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
new file mode 100644
index 00000000..162074d3
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,2 @@
+QA output created by 219
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3295856d..660cdc25 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -221,3 +221,4 @@
 216 auto quick seed
 217 auto quick trim dangerous
 218 auto quick volume
+219 auto quick volume
-- 
2.24.1

