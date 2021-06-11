Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF66C48BD1
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Jun 2021 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A586B613C8
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Jun 2021 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFKLR6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:17:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5392 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhFKLR4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Jun 2021 07:17:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1dTb19Dmz6w8x;
        Fri, 11 Jun 2021 19:12:03 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 19:15:57 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 19:15:56 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/103: leave more space for f2fs
Date:   Fri, 11 Jun 2021 19:22:10 +0800
Message-ID: <20210611112211.1408767-2-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210611112211.1408767-1-sunke32@huawei.com>
References: <20210611112211.1408767-1-sunke32@huawei.com>
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

It failed on f2fs:
     QA output created by 103
    +fallocate: No space left on device
     Silence is golden.
    ...

Try to leave ~512KB, but during the fallocate, f2fs will be filled.
Provide error prompt: "fallocate: No space left on device".

Leave more space for f2fs.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
I add some test code
	+       df
			avail=`_get_available_space $SCRATCH_MNT`
	+       echo "avail = ${avail}"
			filesizekb=$((avail / 1024 - 512))
	+       echo "filesizekb = ${filesizekb}"
			$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
	+       df
	}

f2fs:
	QA output created by 103
	+Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	+/dev/sdb          12580864     553292    12027572   5% /mnt/scratch
	+avail = 12316233728
	+filesizekb = 12027060
	+fallocate: No space left on device
	+Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	+/dev/sdb          12580864   12580864           0 100% /mnt/scratch
	Silence is golden.

xfs:
	QA output created by 103
	+Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	+/dev/sdb          12572672     120828    12451844   1% /mnt/scratch
	+avail = 12750688256
	+filesizekb = 12451332
	+Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	+/dev/sdb          12572672   12572160         512 100% /mnt/scratch
	Silence is golden.

f2fs:
	QA output created by 103
	+Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	+/dev/sdb          12319880      41048    11633304   1% /mnt/scratch
	+avail = 11912503296
	+filesizekb = 11632792
	+Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	+/dev/sdb          12319880   11673844         508 100% /mnt/scratch
	Silence is golden.

after change (f2fs)
	QA output created by 103
	Filesystem       1K-blocks       Used   Available Use% Mounted on
	...
	/dev/sdb          12580864   12580396         468 100% /tmp/scratch
	Silence is golden.

 tests/generic/103 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/generic/103 b/tests/generic/103
index b22b0159623e..dfce3870781c 100755
--- a/tests/generic/103
+++ b/tests/generic/103
@@ -40,10 +40,18 @@ rm -f $seqres.full
 _consume_freesp()
 {
 	file=$1
+	leave=512
+
+	# Try to leave ~512KB, but during the fallocate, f2fs will be filled.
+	# Provide error prompt: "fallocate: No space left on device". Leave
+	# more space for f2fs.
+	if [ $FSTYP == "f2fs" ]; then
+		leave=12288
+	fi
 
 	# consume nearly all available space (leave ~512kB)
 	avail=`_get_available_space $SCRATCH_MNT`
-	filesizekb=$((avail / 1024 - 512))
+	filesizekb=$((avail / 1024 - $leave))
 	$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
 }
 
-- 
2.25.4

