Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F198C4338F
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FEB60FDA
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 12:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHTMLn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:11:43 -0400
Received: from mail.synology.com ([211.23.38.101]:52772 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238179AbhHTMLn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Aug 2021 08:11:43 -0400
Received: from localhost.localdomain (unknown [10.17.33.24])
        by synology.com (Postfix) with ESMTPA id D55AF3894A68;
        Fri, 20 Aug 2021 20:11:04 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1629461464; bh=Vq7icz+CUDQPjhWaftQs8m0U1ddrvb4nDarhQ6lXHRM=;
        h=From:To:Cc:Subject:Date;
        b=kp3c8sKl8foU+xijzkbfenu9ayJ6UCp6PT1FieXq16pjtfWG+Kceb9u88nOKjckrp
         A+Jfz7NGbkKJjkaqc+XU+yVEHx+r5ZcLC6cLbaPpBgWNWX6KiATppE5Nu2oy3Tltbm
         Ov2SOv8RIsWW0pWJ2xP+eC2iVnHKVYwqWFfoyCMc=
From:   Kai-Wen Hu <kevinhu@synology.com>
To:     fstests@vger.kernel.org
Cc:     Kai-Wen Hu <kevinhu@synology.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Robbie Ko <robbieko@synology.com>
Subject: [PATCH] generic/457: post-check fs on thin-vol device instead of scratch device
Date:   Fri, 20 Aug 2021 20:10:31 +0800
Message-Id: <20210820121031.583298-1-kevinhu@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Recently, we found that this test running with btrfs didn't
pass the post-check fsck on scratch device.  This issue occured
due to the commit 5faafc77f ("dm space maps: don't reset space map
allocation cursor when committing") and the use of SSD as scratch
device.

In this test, it does not directly use the filesystem on scratch
device. It runs test on dm-thin volume tying two linear-mapping
devices, and those two linear devices are created from the scratch
device.  When the test runs, it will write data on dm-thin volume,
and dirty the underlying scratch device.

Since the commit (5faafc77f) changes the dm space allocation policy,
it may cause more dirty blocks on underlying scratch device when we
write data on thin volume.  So it makes more chance to overwrite the
position of btrfs-meta on the scratch device.  Besides, our scratch
device is SSD, so there is only one copy of btrfs meta on the scratch
device.  Once the btrfs-meta is overwritten, the btrfs volume will
crash, and cannot pass the fsck check.

Because, this test won't directly use the fs on scratch device.  We
just disable the post-check fsck on scratch device, instead, we run
post-check fsck on thin-vol device.

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: Kai-Wen Hu <kevinhu@synology.com>
---
 tests/generic/457 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/457 b/tests/generic/457
index f4fdd81d..7e0a3157 100755
--- a/tests/generic/457
+++ b/tests/generic/457
@@ -29,6 +29,8 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_log_writes
 _require_dm_target thin-pool
+# $SCRATCH_DEV won't be directly created filesystem on, so fsck isn't required
+rm -f "${RESULT_DIR}/require_scratch"
 
 check_files()
 {
@@ -114,6 +116,7 @@ for j in `seq 0 $((NUM_FILES-1))`; do
 	md5=$(_md5_checksum $SCRATCH_MNT/testfile$j)
 	[ "${md5}" != "${test_md5[$j]}" ] && _fail "testfile$j end md5sum mismatched"
 done
+_dmthin_check_fs
 
 echo "Silence is golden"
 status=0
-- 
2.25.1

