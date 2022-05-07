Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429B5C4332F
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 09:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383799AbiEGJfR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381255AbiEGJfQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 05:35:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AA15A05
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 02:31:30 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KwMcm41BwzhYsV;
        Sat,  7 May 2022 17:31:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 17:31:28 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <libaokun1@huawei.com>, <zhengliang6@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC v2 2/2] common: correct overlay+tmpfs cycle_mount
Date:   Sat, 7 May 2022 17:45:24 +0800
Message-ID: <20220507094524.949615-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220507094524.949615-1-libaokun1@huawei.com>
References: <20220507094524.949615-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

overlay+tmpfs cycle_mount should be like tmpfs cycle_mount,
otherwise some test cases may have issue like "xxx: No such file or directory".

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 common/rc | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 553ae350..ca465438 100644
--- a/common/rc
+++ b/common/rc
@@ -410,10 +410,19 @@ _scratch_cycle_mount()
 {
     local opts="$1"
 
-    if [ "$FSTYP" = tmpfs ]; then
-	_scratch_remount "$opts"
-	return
-    fi
+	case "$FSTYP" in
+	tmpfs)
+		_scratch_remount "$opts"
+		return
+		;;
+	overlay)
+		if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
+			_scratch_remount "$opts"
+			return
+		fi
+		;;
+	esac
+
     if test -n "$opts"; then
 	opts="-o $opts"
     fi
@@ -522,9 +531,17 @@ _test_unmount()
 
 _test_cycle_mount()
 {
-    if [ "$FSTYP" = tmpfs ]; then
-	return
-    fi
+	case "$FSTYP" in
+	tmpfs)
+		return
+		;;
+	overlay)
+		if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
+			return
+		fi
+		;;
+	esac
+
     _test_unmount
     _test_mount
 }
-- 
2.31.1

