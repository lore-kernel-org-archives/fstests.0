Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79324C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 16:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346553AbiCKQWE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349942AbiCKQWB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 11:22:01 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ABA1D1782
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 08:20:58 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jq9so7375731qvb.0
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FuTcfwmdWgUT7WVdlgqW0bkccZCvR/l0FQLS4IzkUoU=;
        b=k6CC8b8v98iyOhD0QKBL90obp8UnlG6/vqi2Sw4pJEQdIWUs/K5h7caFhQ5ezx3MRO
         Epmijhzqp2LAKTHvPkRl0t14wDVQejU/i62eicmBuOUPEpBKewKCZCbITZs6/tnurYQ1
         NjkcW2P8ESBXb+DF/xmv+qdD/h9uqc15be75bwRUBifBKlg+spF1RykJFPvpcWFJ2RFf
         e/B5P7B6WM57mEV3KJn/pKVEl4ckBUaGgisgUnQwJINeVn/PmZ0a1CF9M8vKI9NdL7Fm
         sbv8ATIrVCE5SDrjf+3TmHyaMsNm7+sTFH16SIfdgD4hwYqEeYipi2P6Ejex5my1gaht
         LbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuTcfwmdWgUT7WVdlgqW0bkccZCvR/l0FQLS4IzkUoU=;
        b=IZRx/Ooe2iS0AvkD/5qBi9VKsxrroN9CA80Hjv21MWAJ69O8TZMTRtVJHMlcEFuDtf
         B8t7tT7bwTG67MG8U5vUDEErV1ro9WFaqGeW/nyVq8/T9JM4u96FI53GhiPtrVtIHXY2
         CUgjgvrm7Fc3gygJvcIPRk2qb4CXtxW1RqUNIeFDAI9PrXsk5ZPPAkRWLZ2BF0Sr+cOj
         p1W0OiUQam1ztdROJ7arQLT0Po+Va8giunmr99EfRnJYwSzKOO3Rtq2oRPqdoNwOqCn7
         u/t15V++zjhxyJlrZnasLjLnD4KF/FHyp4cnlG24RYoCH6oS1apIxUPMVMgIFNo2p9OH
         PxuA==
X-Gm-Message-State: AOAM532FnBPxdNnQVfkHn91uMJodZsVUSaKOkJgwQjGXDIt3/Fx1dtpc
        hsYXw0z46hsf+BGcTf4cz9EM9msqe4WkJKJQ
X-Google-Smtp-Source: ABdhPJyP3MKi2dgvzO3cXz0mASIug/kO7BtGsqKj0/C8EXVEFagm6B155dW7q26rECosN8Dawh1B/A==
X-Received: by 2002:ad4:5762:0:b0:43a:5c52:30bd with SMTP id r2-20020ad45762000000b0043a5c5230bdmr3880846qvx.131.1647015656877;
        Fri, 11 Mar 2022 08:20:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b126-20020a376784000000b0067d21404704sm4018508qkc.131.2022.03.11.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:20:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: delete the cross-vfsmount reflink tests
Date:   Fri, 11 Mar 2022 11:20:53 -0500
Message-Id: <3c6801168d8f7fd1bd2ae47f9a823d9c28a35422.1647015560.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1647015560.git.josef@toxicpanda.com>
References: <cover.1647015560.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Cross vfsmount reflink's are now allowed, the patch is in linux-next and
will go to linus soon.  Remove these tests so nobody freaks out when
they start failing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/373     | 70 -------------------------------------------
 tests/generic/373.out |  9 ------
 tests/generic/374     | 68 -----------------------------------------
 tests/generic/374.out | 10 -------
 4 files changed, 157 deletions(-)
 delete mode 100755 tests/generic/373
 delete mode 100644 tests/generic/373.out
 delete mode 100755 tests/generic/374
 delete mode 100644 tests/generic/374.out

diff --git a/tests/generic/373 b/tests/generic/373
deleted file mode 100755
index 2f68b24f..00000000
--- a/tests/generic/373
+++ /dev/null
@@ -1,70 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2016 Oracle, Inc.  All Rights Reserved.
-#
-# FS QA Test No. 373
-#
-# Check that cross-mountpoint reflink doesn't work.
-#
-. ./common/preamble
-_begin_fstest auto quick clone
-
-_register_cleanup "_cleanup" BUS
-
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -rf $tmp.*
-	wait
-}
-
-# Import common functions.
-. ./common/filter
-. ./common/reflink
-
-# real QA test starts here
-_supported_fs generic
-_require_scratch_reflink
-_require_cp_reflink
-
-echo "Format and mount"
-_scratch_mkfs > $seqres.full 2>&1
-_scratch_mount >> $seqres.full 2>&1
-
-testdir=$SCRATCH_MNT/test-$seq
-mkdir $testdir
-otherdir=/tmp/m.$seq
-othertestdir=$otherdir/test-$seq
-rm -rf $otherdir
-mkdir $otherdir
-
-blocks=1
-blksz=65536
-sz=$((blksz * blocks))
-
-echo "Mount otherdir"
-$MOUNT_PROG --bind $SCRATCH_MNT $otherdir
-
-echo "Create file"
-_pwrite_byte 0x61 0 $sz $testdir/file >> $seqres.full
-
-filter_md5()
-{
-	_filter_scratch | sed -e "s,$otherdir,OTHER_DIR,g"
-}
-
-echo "Reflink one file to another"
-_cp_reflink $testdir/file $othertestdir/otherfiles 2>&1 | filter_md5
-
-echo "Check output"
-md5sum $testdir/file | _filter_scratch
-test -e $othertestdir/otherfile && echo "otherfile should not exist"
-
-echo "Unmount otherdir"
-$UMOUNT_PROG $otherdir
-rm -rf $otherdir
-
-# success, all done
-status=0
-exit
diff --git a/tests/generic/373.out b/tests/generic/373.out
deleted file mode 100644
index 60f280fc..00000000
--- a/tests/generic/373.out
+++ /dev/null
@@ -1,9 +0,0 @@
-QA output created by 373
-Format and mount
-Mount otherdir
-Create file
-Reflink one file to another
-cp: failed to clone 'OTHER_DIR/test-373/otherfiles' from 'SCRATCH_MNT/test-373/file': Invalid cross-device link
-Check output
-2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-373/file
-Unmount otherdir
diff --git a/tests/generic/374 b/tests/generic/374
deleted file mode 100755
index d9f33bc3..00000000
--- a/tests/generic/374
+++ /dev/null
@@ -1,68 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2016 Oracle, Inc.  All Rights Reserved.
-#
-# FS QA Test No. 374
-#
-# Check that cross-mountpoint dedupe doesn't work.
-#
-. ./common/preamble
-_begin_fstest auto quick clone dedupe
-
-_register_cleanup "_cleanup" BUS
-
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -rf $tmp.*
-	wait
-}
-
-# Import common functions.
-. ./common/filter
-. ./common/reflink
-
-# real QA test starts here
-_supported_fs generic
-_require_scratch_dedupe
-
-echo "Format and mount"
-_scratch_mkfs > $seqres.full 2>&1
-_scratch_mount >> $seqres.full 2>&1
-
-testdir=$SCRATCH_MNT/test-$seq
-mkdir $testdir
-otherdir=/tmp/m.$seq
-othertestdir=$otherdir/test-$seq
-rm -rf $otherdir
-mkdir $otherdir
-
-blocks=1
-blksz=65536
-sz=$((blocks * blksz))
-
-echo "Mount otherdir"
-$MOUNT_PROG --bind $SCRATCH_MNT $otherdir
-
-echo "Create file"
-_pwrite_byte 0x61 0 $sz $testdir/file >> $seqres.full
-_pwrite_byte 0x61 0 $sz $testdir/otherfile >> $seqres.full
-
-echo "Dedupe one file to another"
-_dedupe_range $testdir/file 0 $othertestdir/otherfile 0 $sz 2>&1 | _filter_dedupe_error
-
-filter_md5()
-{
-	_filter_scratch | sed -e "s,$otherdir,OTHER_DIR,g"
-}
-echo "Check output"
-md5sum $testdir/file $othertestdir/otherfile | filter_md5
-
-echo "Unmount otherdir"
-$UMOUNT_PROG $otherdir
-rm -rf $otherdir
-
-# success, all done
-status=0
-exit
diff --git a/tests/generic/374.out b/tests/generic/374.out
deleted file mode 100644
index 3243ad3d..00000000
--- a/tests/generic/374.out
+++ /dev/null
@@ -1,10 +0,0 @@
-QA output created by 374
-Format and mount
-Mount otherdir
-Create file
-Dedupe one file to another
-XFS_IOC_FILE_EXTENT_SAME: Invalid cross-device link
-Check output
-2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-374/file
-2d61aa54b58c2e94403fb092c3dbc027  OTHER_DIR/test-374/otherfile
-Unmount otherdir
-- 
2.26.3

