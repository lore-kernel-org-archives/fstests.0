Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81126C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Feb 2022 01:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiBOBs5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Feb 2022 20:48:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiBOBsz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Feb 2022 20:48:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC931354A8
        for <fstests@vger.kernel.org>; Mon, 14 Feb 2022 17:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZuMQ4VZIRrOmvdAlal9tr1j1Fh0pNrCEOhzAAKHRWqM=; b=X3jwMTXnAojZmOi0Znv58epDFH
        1wUxbCnjTmsov6F/gzkI1XQ2yK/OzC9CQMHSZIzsu9Mt/WGy86yWOBLLuNUGjeZWqhyivPzwpsjgw
        wwNLP2hGHxyRsJRf08+Y9wk8zUMqJqFuJ3fn8YSW8gzqGn5LN75tX2ZRqwURz4GMq1QuSJ5Oe1rok
        Tw3pMM+25rDLSBrtW0Ncs8Ljp3TCEe2/qM+bRNUlHhfv/I7cT1kc4ALUj1wOiSuWKNJMGc1s4/bmd
        VgoeH3jnQtlgh8YuY3Pfn23xE/VeYhZ2zLcSlIZhaj2w4oIWgHjuz91//o0rdpT4R/xiM/a/KUk3I
        dlpVT9PA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJmxR-00HTRr-Vb; Tue, 15 Feb 2022 01:48:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, johannes.thumshirn@wdc.com
Cc:     a.manzanares@samsung.com, p.raghav@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 1/3] btrfs/237: adjust uuid heuristics
Date:   Mon, 14 Feb 2022 17:48:43 -0800
Message-Id: <20220215014845.4164719-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215014845.4164719-1-mcgrof@kernel.org>
References: <20220215014845.4164719-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Using $(findmnt -n -o UUID mount-directory) only works on
util-linux v2.38, not on 2.37. Even debian-testing has util-linux
v2.37, so use a mechanism which has worked for longer to fetch the
UUID.

Without this the test fails on permission failure on accessing
the file /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold as $uuid is
empty. So while at it, add a check to ensure the UUID is never
empty.

Use $AWK_PROG in case the preferred awk program is not the
preferred awk program.

Cc: Karel Zak <kzak@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/btrfs/237 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 5168777e..96940549 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -41,7 +41,14 @@ zonesize=$((zonesize << 9))
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount -o commit=1 # 1s commit time to speed up test
 
-uuid=$(findmnt -n -o UUID "$SCRATCH_MNT")
+uuid=$($BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV |grep uuid: |\
+        $AWK_PROG '{print $NF}')
+
+if [[ "$uuid" == "" ]]; then
+	echo "UUID for $SCRATCH_DEV is empty, this is not expected"
+	exit 1
+fi
+
 reclaim_threshold=75
 echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
 fill_percent=$((reclaim_threshold + 2))
-- 
2.34.1

