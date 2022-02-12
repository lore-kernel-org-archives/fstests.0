Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8052C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Feb 2022 01:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354534AbiBLBTZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Feb 2022 20:19:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbiBLBTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Feb 2022 20:19:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53214D83
        for <fstests@vger.kernel.org>; Fri, 11 Feb 2022 17:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ipTlEBu96V9ycmbZKy6BY1L/8kfL0AkcVTkz7xyo7AU=; b=uJs66owe96O6P2s5SQ0jcJg/bd
        ZTPzfLv+C2S+IlKOMPtDj6tM/F/sc/QNw1PB0LWHR6FGmaU+qn9aGffxKwVv/Zw51/lpHoznidsuT
        MaJLF3p+glMf3GmhELr3bzcfj8kSQXlv6fbAOlYR3oRTJNbgFxMJu97d4l/IhXOrDTpfvYI+p6Oj1
        5sGtjoRlhdwOTRkNcyQy/QUIRJKMt2HKPq3gZCbuMGJ2uB7HdwjoHjEBym4/6TFO24Ks8V5sOxfmS
        z6GAO9JIKmMMUwgO1ugzHWto8sLmiJKoVq+gZuZqKlKffGY3dSWQgdSanhPhnEy9p8JnoMv8S/LME
        NOLKNa1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIh4L-009FY8-FC; Sat, 12 Feb 2022 01:19:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, johannes.thumshirn@wdc.com
Cc:     a.manzanares@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        Karel Zak <kzak@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] btrfs/237: adjust uuid heuristics
Date:   Fri, 11 Feb 2022 17:19:19 -0800
Message-Id: <20220212011919.2204685-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
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

Cc: Karel Zak <kzak@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Reported-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/btrfs/237 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 5168777e..07c07e8e 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -41,7 +41,14 @@ zonesize=$((zonesize << 9))
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount -o commit=1 # 1s commit time to speed up test
 
-uuid=$(findmnt -n -o UUID "$SCRATCH_MNT")
+uuid=$($BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV |grep uuid: |\
+        awk '{print $NF}')
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

