Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391ECC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiCKJ3N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiCKJ3L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 04:29:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D217A88A5
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 01:28:07 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFLCN6zVpzBrkB;
        Fri, 11 Mar 2022 17:26:08 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 17:28:05 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 17:28:05 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <chao@kernel.org>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <sunke32@huawei.com>,
        <david@fromorbit.com>
Subject: [PATCH v2] generic/066: attr1 is still there after log replay on f2fs
Date:   Fri, 11 Mar 2022 17:43:15 +0800
Message-ID: <20220311094315.2476774-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test fail on f2fs:
     xattr names and values after second fsync log replay:
     # file: SCRATCH_MNT/foobar
    +user.attr1="val1"
     user.attr3="val3"

attr1 is still there after log replay. f2fs doesn't support fs-op level
transaction functionality. so it have no way to persist all metadata
updates in one transaction.  We can use "fastboot" mountoption for this
case, so during last fsync on qwerty, f2fs can trigger a checkpoint
which will persist all metadata updates before fsync().

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/066 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/generic/066 b/tests/generic/066
index 105a7acd..b8465101 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -56,6 +56,14 @@ sync
 $SETFATTR_PROG -x user.attr2 $SCRATCH_MNT/foobar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
 
+# f2fs doesn't support fs-op level transaction functionality. so it have no way
+# to persist all metadata updates in one transaction.  We can use "fastboot"
+# mountoption for this case, so during last fsync on qwerty, f2fs can trigger a
+# checkpoint which will persist all metadata updates before fsync().
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fastboot"
+fi
+
 _flakey_drop_and_remount
 
 # After the fsync log is replayed, the file should have only 2 xattrs, the ones
-- 
2.13.6

