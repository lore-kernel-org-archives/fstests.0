Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8671C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Nov 2021 14:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbhKVO4v (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbhKVO4u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Nov 2021 09:56:50 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2FEC061574
        for <fstests@vger.kernel.org>; Mon, 22 Nov 2021 06:53:44 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d2so18301705qki.12
        for <fstests@vger.kernel.org>; Mon, 22 Nov 2021 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZwAqXi4vTOsVF2XV9A3UCf4Y1PE/+4W235b9a4Nk/k=;
        b=6WD08nGmeM/uPfoSFUrT1UdbAbYYuHcbekZSOGWw/8y3EqJMZWlA93bqSIRragJFV8
         9zIwIvBpvTONlw4K3G3f7GZFqChfu2in0wy4GdF+U08fZH4YvfAZrgZe31hP6ALBXE39
         U3pej7/LW1t0bCm58s4evG+3eEM/wSUQ+rlzJkXbhiFabGBumC14LdXJD7aPKQI0JM+3
         PCzqAE3ChZNoXFhAJBkPAY0MYDJycg/SkUOIuhks4pgxnnVcvjM7b6jOh8jNea3df+TX
         K/ZA3gFQ94twybBzAdSdIGpshY4U/bHjaE4ulSFJOPrrONgCkbEwknsI2TbnfhlEs8cY
         ujxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZwAqXi4vTOsVF2XV9A3UCf4Y1PE/+4W235b9a4Nk/k=;
        b=Dz5Rf28Y0cgzwd6Po3F3Vbj6LL6yDinKd179pHu/cjmZHaedCNbB8zji9Eh4TxSJAL
         n66VNi4FO6kMF5Ee8cEd8r8grKxq+Q02fPQjCVFWUasicxK6Xh2GyXWs+BKdkTqoU/1l
         hP2Pb6+i6PWMqrZGkerOMEyfvzLXGPU864aVLLYP5WeTrqSX9JJOMJ3xZtv+VgNKng8d
         C22UGj0/YX0mJx3EBsr0SOjlueojG5IzEeyRJN1YHRh7ICLjdzEq0Ad/MQHeEf+51VRb
         LeRwseZwqphLK/lhBLRU8dhRVnZ463A6Uv9cZCzSMd0lcYzD6bUJEo6ClPxadgnPciqr
         dQIQ==
X-Gm-Message-State: AOAM531Hd5he5VLZClZ0voqI8bDpi+tqKceuN04uRV49GJpvDJTmqLXO
        Vg2mu/pA7kFDjUcExtUrn3yGCETC5kmFvg==
X-Google-Smtp-Source: ABdhPJxrt/Z2i2I4M9QF0qA3t4eclRc6+gv+sbC0vuMQytjPQu2OiuylZoscUHQa0aWdRwShHyiv/Q==
X-Received: by 2002:a05:620a:2f9:: with SMTP id a25mr50134438qko.327.1637592823369;
        Mon, 22 Nov 2021 06:53:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm4442092qtc.60.2021.11.22.06.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:53:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2] fstests: redirect device replace output to $seqres.full
Date:   Mon, 22 Nov 2021 09:53:41 -0500
Message-Id: <21ff35d62f029775ceb7051ec836413ded89cb51.1637592771.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The btrfs utils are printing a status message about TRIM'ing device on
replace and this is throwing off the golden output, redirect stdout from
'device replace start' to $seqres.full so we don't get false negatives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Had vim open in another pane for btrfs/223 and forgot to save, my bad.

 tests/btrfs/176 | 6 ++++--
 tests/btrfs/223 | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 9a833575..4cd510b6 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -53,10 +53,12 @@ swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # Again, we know the swap file is on device 1.
 $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev3" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
 # Replacing device 2 should still work.
-$BTRFS_UTIL_PROG replace start -fB "$scratch_dev2" "$scratch_dev3" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev2" "$scratch_dev3" "$SCRATCH_MNT" \
+	>> $seqres.full
 swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 # Replacing device 1 should work again after swapoff.
-$BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT" \
+	>> $seqres.full
 _scratch_unmount
 _check_scratch_fs "$scratch_dev2"
 
diff --git a/tests/btrfs/223 b/tests/btrfs/223
index af072ede..8125cdf2 100755
--- a/tests/btrfs/223
+++ b/tests/btrfs/223
@@ -33,7 +33,7 @@ _require_batched_discard $SCRATCH_MNT
 $XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Replace the first device, $dev1, with a new device.
-$BTRFS_UTIL_PROG replace start -Bf $dev1 $SPARE_DEV $SCRATCH_MNT
+$BTRFS_UTIL_PROG replace start -Bf $dev1 $SPARE_DEV $SCRATCH_MNT >> $seqres.full
 
 # Run fstrim, it should not trim/discard allocated extents in the new device.
 $FSTRIM_PROG $SCRATCH_MNT
-- 
2.26.3

