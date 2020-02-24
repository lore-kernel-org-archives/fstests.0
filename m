Return-Path: <SRS0=n5xI=4M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E1C38BFA
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1CB2176D
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 22:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkkTfwKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBXW31 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:29:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXW31 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Feb 2020 17:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AL9DljPGmdWRMoItUPwh7Lxmxj9UuO3tTXoc8AjHRUk=; b=JkkTfwKA90uL1Q8ZcFstMV0N9X
        VJtA3f0wIixofPqHzs8YTyO7mM80l0aKdaGNUAwzherqyn61GRiuaHYdzNoQweQ2gUO98kaCpTw4F
        9sx0QErBR6idMRdkYX5vEM7gWL/5FYgQ9hzdgPvUvfel0oK60bLSpJelafhyFtV/dRaVHQjCir65S
        YVA7KgBkKrU+n33FGRA3UOCjNqdXHEZvichbPktaHUUxyppUlFYN2oF5hsqOaD3CHvbYYTiLMQCK+
        Px4kblQqd1h4ppfX2g/A+CvryHq/KrPD+KmYx071pCE6OnNPBbcoYPncCWWi9KE3XqlmFFONFv3NT
        XABWXKwQ==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6MEB-0003j3-0t; Mon, 24 Feb 2020 22:29:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     jlayton@kernel.org
Subject: [PATCH] xfstests: remove generic/484
Date:   Mon, 24 Feb 2020 14:29:26 -0800
Message-Id: <20200224222926.694991-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generic/484 tests functionality that isn't really related to file
systems, and has failed every since it was added.  Remove it as it
serves no puropse in xfstests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/484     | 51 -------------------------------------------
 tests/generic/484.out |  2 --
 tests/generic/group   |  1 -
 3 files changed, 54 deletions(-)
 delete mode 100755 tests/generic/484
 delete mode 100644 tests/generic/484.out

diff --git a/tests/generic/484 b/tests/generic/484
deleted file mode 100755
index d83380ac..00000000
--- a/tests/generic/484
+++ /dev/null
@@ -1,51 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
-#
-# FS QA Test 484
-#
-# POSIX requires that record locks are preserved across an execve(2). But
-# there's bug that record locks are released if process is multithreaded at the
-# time that execve is called.
-#
-# Fixed by patch from Jeff Layton:
-# locks: change POSIX lock ownership on execve when files_struct is displaced
-#
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# remove previous $seqres.full before test
-rm -f $seqres.full
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux
-_require_test
-_require_test_program "t_locks_execve"
-
-# prepare a 4k testfile in TEST_DIR
-$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
-	$TEST_DIR/t_lock_execve_file >> $seqres.full 2>&1
-
-$here/src/t_locks_execve $TEST_DIR/t_lock_execve_file
-
-# success, all done
-echo "Silence is golden"
-status=0
-exit
diff --git a/tests/generic/484.out b/tests/generic/484.out
deleted file mode 100644
index 94f2f0bd..00000000
--- a/tests/generic/484.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 484
-Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index ff79a597..dc95b77b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -486,7 +486,6 @@
 481 auto quick log metadata
 482 auto metadata replay
 483 auto quick log metadata
-484 auto quick
 485 auto quick insert
 486 auto quick attr
 487 auto quick eio
-- 
2.24.1

