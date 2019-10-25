Return-Path: <SRS0=ouML=YS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF4DCA9EA0
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Oct 2019 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5A52070B
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Oct 2019 09:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438428AbfJYJSz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:18:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21861 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438249AbfJYJSz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Oct 2019 05:18:55 -0400
X-IronPort-AV: E=Sophos;i="5.68,228,1569254400"; 
   d="scan'208";a="77471054"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Oct 2019 17:18:52 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 70F864B6EC86;
        Fri, 25 Oct 2019 17:10:57 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 25 Oct 2019 17:18:51 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic/{569,570}: use _filter_xfs_io_error to filter pwrite64
Date:   Fri, 25 Oct 2019 17:19:00 +0800
Message-ID: <1571995140-10915-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20191025085426.GG67926@e18g06458.et15sqa>
References: <20191025085426.GG67926@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 70F864B6EC86.AE5C0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I backport fix commits into old kernel, pwrite action will report
"pwrite64: Text file busy". Since xfsprogs without commit 2f9a125c3a39
("xfsprogs: replace pread64/pwrite64 by equivalent pread/pwrite"), it
will report pwrite64. I think these kernel patchs are simple, old kernel
with lower version xfsprogs may backport these commits. So filter it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/569 | 4 ++--
 tests/generic/570 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/569 b/tests/generic/569
index 02fd8574..4573be5a 100755
--- a/tests/generic/569
+++ b/tests/generic/569
@@ -52,8 +52,8 @@ done
 swapon $testfile 2>&1 | _filter_scratch
 
 # Can we write to it?
-$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $testfile
-$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $testfile
+$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $testfile 2>&1 | _filter_xfs_io_error
+$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $testfile 2>&1 | _filter_xfs_io_error
 $XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $testfile
 
 # Can we change the file size?
diff --git a/tests/generic/570 b/tests/generic/570
index 1c5f39f1..d574f4b7 100755
--- a/tests/generic/570
+++ b/tests/generic/570
@@ -47,8 +47,8 @@ done
 swapon $SCRATCH_DEV 2>&1 | _filter_scratch
 
 # Can we write to it?
-$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $SCRATCH_DEV
-$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $SCRATCH_DEV
+$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $SCRATCH_DEV 2>&1 | _filter_xfs_io_error
+$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $SCRATCH_DEV 2>&1 | _filter_xfs_io_error
 $XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $SCRATCH_DEV
 
 # success, all done
-- 
2.18.0



