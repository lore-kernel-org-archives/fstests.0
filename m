Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E676C4320A
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 06:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DFE6112D
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 06:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhHSGBX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 02:01:23 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:50994 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhHSGBX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 02:01:23 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id C7E0580C516
        for <fstests@vger.kernel.org>; Thu, 19 Aug 2021 16:00:45 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mGb6a-002PLA-TB
        for fstests@vger.kernel.org; Thu, 19 Aug 2021 16:00:44 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1mGb6a-000kjE-J0
        for fstests@vger.kernel.org; Thu, 19 Aug 2021 16:00:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs/187: remove the test
Date:   Thu, 19 Aug 2021 16:00:44 +1000
Message-Id: <20210819060044.179581-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=MhDmnRu9jo8A:10 a=20KFwNOVAAAA:8 a=JV7EYWy2Mp33UQYlHVQA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Upstream changes mean that "-o noattr2" no longer removes the
on-disk ATTR2 feature bit from the superblock and so the failure
case this test exercises is no longer guaranteed to be a failure
case. Hence the test is now useless as a regression test, so remove
it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/187     | 117 ----------------------------------------------
 tests/xfs/187.out |  39 ----------------
 2 files changed, 156 deletions(-)
 delete mode 100755 tests/xfs/187
 delete mode 100644 tests/xfs/187.out

diff --git a/tests/xfs/187 b/tests/xfs/187
deleted file mode 100755
index 3f8c7ef8..00000000
--- a/tests/xfs/187
+++ /dev/null
@@ -1,117 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# FS QA Test No. 187
-#
-# To test out the noattr2 flag which is broken in pv#980021
-# Given an existing attr2 filesystem, we should be able to mount
-# as noattr2 and go back to an attr1 filesystem.
-#
-# Test the case where there are no more features2 bits on and
-# so the morebitsbit should be off.
-#
-. ./common/preamble
-_begin_fstest attr auto quick
-
-_filter_version()
-{
-	tee -a $seqres.full | tr ',' '\n' | egrep 'ATTR|MORE|LAZY'
-}
-
-# Import common functions.
-. ./common/filter
-. ./common/attr
-
-# real QA test starts here
-_supported_fs xfs
-
-_require_scratch
-_require_attrs
-_require_attr_v1
-_require_projid16bit
-
-# Reset the options so that we can control what is going on here
-export MKFS_OPTIONS=""
-export MOUNT_OPTIONS=""
-
-# lazysb, attr2 and other feature bits are held in features2 and will require
-# morebitsbit on So test with lazysb and without it to see if the morebitsbit is
-# okay etc. If the mkfs defaults change, these need to change as well.
-MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
-MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
-
-# ftype is also stored in features2, so we have to detect its presence in
-# mkfs and disable it here too.
-if _scratch_mkfs --help 2>&1 | grep -q "ftype="; then
-	MKFS_NO_LAZY="$MKFS_NO_LAZY -n ftype=0"
-	MKFS_LAZY="$MKFS_LAZY -n ftype=0"
-fi
-
-# Make sure that when we think we are testing with morebits off
-# that we really are.
-_scratch_mkfs -i attr=1 $MKFS_NO_LAZY  >/dev/null 2>&1
-_scratch_xfs_db -c version 2>&1 >$tmp.db
-if grep -i morebits $tmp.db
-then
-	echo ""
-	echo "Need to update test $seq so that initial subtests do not use features2"
-	echo ""
-	exit
-fi
-
-echo ""
-echo "*** 1. test attr2 mkfs and then noattr2 mount ***"
-echo ""
-echo "attr2 fs"
-echo ""
-_scratch_mkfs -i attr=2 $MKFS_NO_LAZY >/dev/null 2>&1
-_scratch_xfs_db -r -c version 2>&1 | _filter_version
-echo ""
-echo "noattr2 fs"
-echo ""
-_scratch_mount -o noattr2
-$UMOUNT_PROG $SCRATCH_MNT
-_scratch_xfs_db -r -c version 2>&1 | _filter_version
-
-# adding an EA will ensure the ATTR1 flag is turned on
-echo ""
-echo "*** 2. test attr2 mkfs and then noattr2 mount with 1 EA ***"
-echo ""
-echo "attr2 fs"
-echo ""
-_scratch_mkfs -i attr=2 $MKFS_NO_LAZY >/dev/null 2>&1
-_scratch_xfs_db -r -c version 2>&1 | _filter_version
-echo ""
-echo "noattr2 fs"
-echo ""
-_scratch_mount -o noattr2
-cd $SCRATCH_MNT
-touch testfile
-$SETFATTR_PROG -n user.test -v 0xbabe testfile
-_getfattr testfile
-cd $here
-$UMOUNT_PROG $SCRATCH_MNT
-_scratch_xfs_db -r -c version 2>&1 | _filter_version
-
-echo ""
-echo "*** 3. test noattr2 mount and lazy sb ***"
-echo ""
-echo ""
-echo "attr2 fs"
-echo ""
-_scratch_mkfs -i attr=2 $MKFS_LAZY >/dev/null 2>&1
-_scratch_xfs_db -r -c version 2>&1 | _filter_version
-echo ""
-echo "noattr2 fs"
-echo ""
-_scratch_mount -o noattr2
-cd $SCRATCH_MNT
-touch testfile
-cd $here
-$UMOUNT_PROG $SCRATCH_MNT
-_scratch_xfs_db -r -c version 2>&1 | _filter_version
-
-# success, all done
-status=0
-exit
diff --git a/tests/xfs/187.out b/tests/xfs/187.out
deleted file mode 100644
index e7e20212..00000000
--- a/tests/xfs/187.out
+++ /dev/null
@@ -1,39 +0,0 @@
-QA output created by 187
-
-*** 1. test attr2 mkfs and then noattr2 mount ***
-
-attr2 fs
-
-MOREBITS
-ATTR2
-
-noattr2 fs
-
-
-*** 2. test attr2 mkfs and then noattr2 mount with 1 EA ***
-
-attr2 fs
-
-MOREBITS
-ATTR2
-
-noattr2 fs
-
-# file: testfile
-user.test
-
-ATTR
-
-*** 3. test noattr2 mount and lazy sb ***
-
-
-attr2 fs
-
-MOREBITS
-ATTR2
-LAZYSBCOUNT
-
-noattr2 fs
-
-MOREBITS
-LAZYSBCOUNT
-- 
2.31.1

