Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B5C48BE0
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Jun 2021 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1397A608FE
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Jun 2021 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhFKLR5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:17:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5391 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhFKLR4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Jun 2021 07:17:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1dTZ67ttz6w8l;
        Fri, 11 Jun 2021 19:12:02 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 19:15:56 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 19:15:55 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH] common/rc: f2fs do not support metadata journaling
Date:   Fri, 11 Jun 2021 19:22:09 +0800
Message-ID: <20210611112211.1408767-1-sunke32@huawei.com>
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

In generic/50, touch 100 files, go down the fs immediately, Then umount
and set the disk readi-only. Try to mount it again without \-o
norecovery\, it should fail, because it can not recovery on a read-only
device. But f2fs mount successfully and the test fail.

f2fs seems do not support metadata journaling.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---

I am not very sure if f2fs do not support metadata journaling.

###
before change
###
[root@localhost xfstests-dev]# ./check tests/generic/050
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP Tue Jun 8 11:09:37 CST 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch

generic/050 4s ... - output mismatch (see /root/work/xfstests-dev/results//generic/050.out.bad)
    --- tests/generic/050.out   2021-05-31 15:37:40.000000000 +0800
    +++ /root/work/xfstests-dev/results//generic/050.out.bad    2021-06-11 16:48:19.993000000 +0800
    @@ -13,9 +13,7 @@
     setting device read-only
     mounting filesystem that needs recovery on a read-only device:
     mount: device write-protected, mounting read-only
    -mount: cannot mount device read-only
     unmounting read-only filesystem
    -umount: SCRATCH_DEV: not mounted
     mounting filesystem with -o norecovery on a read-only device:
    ...
    (Run 'diff -u /root/work/xfstests-dev/tests/generic/050.out /root/work/xfstests-dev/results//generic/050.out.bad'  to see the entire diff)
Ran: generic/050
Failures: generic/050
Failed 1 of 1 tests

###
after change
###
[root@localhost xfstests-dev]# ./check tests/generic/050
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP Tue Jun 8 11:09:37 CST 2021
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch

generic/050 4s ...  4s
Ran: generic/050
Passed all 1 tests



 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a0aa7300..428b8b80 100644
--- a/common/rc
+++ b/common/rc
@@ -3543,7 +3543,7 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf|exfat|tmpfs)
+	ext2|vfat|msdos|udf|exfat|tmpfs|f2fs)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
 		;;
-- 
2.13.6

