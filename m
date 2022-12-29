Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C60C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Dec 2022 13:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL2NYQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Dec 2022 08:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiL2NYP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Dec 2022 08:24:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8065FC
        for <fstests@vger.kernel.org>; Thu, 29 Dec 2022 05:24:13 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NjTbD00cLzRqLc;
        Thu, 29 Dec 2022 21:22:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 29 Dec
 2022 21:24:10 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <jencce.kernel@gmail.com>, <hsiangkao@linux.alibaba.com>,
        <libaokun1@huawei.com>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] overlay: avoid to use NULL OVL_BASE_FSTYP for mounting
Date:   Thu, 29 Dec 2022 21:44:34 +0800
Message-ID: <20221229134434.1513212-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Generally, FSTYP is used to specify OVL_BASE_FSTYP. When we specify FSTYP
through an environment variable, it is not converted to OVL_BASE_FSTYP.
In addition, sometimes we do not even specify the file type. For example,
we only use `./check -n -overlay -g auto` to list overlay-related cases.
If OVL_BASE_FSTYP is NULL, mounting fails and the test fails.

To solve this problem, try to assign a value to OVL_BASE_FSTYP when
specifying -overlay. In addition, in the _overlay_base_mount function,
the basic file system type of the overlay is specified only when
OVL_BASE_FSTYP is not NULL.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 check          | 1 +
 common/overlay | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 1ff0f44a..22062935 100755
--- a/check
+++ b/check
@@ -283,6 +283,7 @@ while [ $# -gt 0 ]; do
 		FSTYP="${1:1}"
 		;;
 	-overlay)
+		[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
 		FSTYP=overlay
 		export OVERLAY=true
 		;;
diff --git a/common/overlay b/common/overlay
index e35419d0..20cafeb1 100644
--- a/common/overlay
+++ b/common/overlay
@@ -85,7 +85,12 @@ _overlay_base_mount()
 		return 1
 	fi
 
-	_mount -t $OVL_BASE_FSTYP $* $dev $mnt
+	if [ $OVL_BASE_FSTYP ]; then
+		_mount -t $OVL_BASE_FSTYP $* $dev $mnt
+	else
+		_mount $* $dev $mnt
+	fi
+
 	_idmapped_mount $dev $mnt
 }
 
-- 
2.31.1

