Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7379C43461
	for <linux-fstests@archiver.kernel.org>; Tue, 18 May 2021 11:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C905861361
	for <linux-fstests@archiver.kernel.org>; Tue, 18 May 2021 11:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbhERLnZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 May 2021 07:43:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2970 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbhERLnY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 May 2021 07:43:24 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkvD62m0zzCtqV;
        Tue, 18 May 2021 19:39:18 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 19:42:04 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 18
 May 2021 19:42:03 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <djwong@kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/042: set size to 38M for f2fs
Date:   Tue, 18 May 2021 07:47:00 -0400
Message-ID: <20210518114700.2118225-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

25M is too small for f2fs:

Info: Disable heap-based policy
Info: Debug level = 0
Info: Label =
Info: Trim is enabled
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 51200 (25 MB)
Info: zone aligned segment0 blkaddr: 512
    Error: Device size is not sufficient for F2FS volume
    Error: Failed to prepare a super block!!!
    Error: Could not format the device!!!

So, set size to 38M for f2fs.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
I have tried from 25M, until 38M, it passed.

[root@localhost xfstests]# ./check tests/generic/042
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #3 SMP Wed Apr 21 22:29:25 EDT 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /mnt/scratch

generic/042 2s ...  2s
Ran: generic/042
Passed all 1 tests

 tests/generic/042 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/generic/042 b/tests/generic/042
index 35727bcb..ee0e4b40 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -41,10 +41,16 @@ _crashtest()
 	img=$SCRATCH_MNT/$seq.img
 	mnt=$SCRATCH_MNT/$seq.mnt
 	file=$mnt/file
+	size=25M
+
+	# 25M is too small for f2fs.
+	if [ $FSTYP == "f2fs" ]; then
+		size=38M
+	fi
 
 	# Create an fs on a small, initialized image. The pattern is written to
 	# the image to detect stale data exposure.
-	$XFS_IO_PROG -f -c "truncate 0" -c "pwrite -S 0xCD 0 25M" $img \
+	$XFS_IO_PROG -f -c "truncate 0" -c "pwrite -S 0xCD 0 $size" $img \
 		>> $seqres.full 2>&1
 	_mkfs_dev $img >> $seqres.full 2>&1
 
-- 
2.13.6

