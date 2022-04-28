Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4DC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348744AbiD1PIV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348758AbiD1PIU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:08:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36ED6D
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:05:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a22so726345qkl.5
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzuCeYxyya6x4wpzNCZrzjYh+Mor3eERyTscfoNqBJg=;
        b=4T6hUe1apeLViIBSvt97zzAu+OYDXvw1cy6hPnuMkl0BB+PI9TJdpQePd598XvgZj5
         iPIxM9lwm0/CwmwkRGqL0NRaNUatulq/W4pW5MqXohDarSwzHCh4gMx+Un7fgIpsAqlK
         mGbnL6Z4SlTfW2rxDRQdzA8rei0akz7sbsnSawzZj2a/gh66vARmp15MF1vKBt/8Gb1k
         5wg8r9Lw/3dZEi64y8934WEd+8CF0V8eh4I1f4geJ3kG29I4XGbAj/s0tNOeZsXle17E
         zueHKp5OEdgtvnbrkZqIvVPvn8jvz7+w+qdIhlwusZNgogw8HVKv5SRpApvbMhNFSUKr
         HZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzuCeYxyya6x4wpzNCZrzjYh+Mor3eERyTscfoNqBJg=;
        b=yXCineWFokRyQlzlrJkKZzRpalfEX32nqg1RdB8j/OJyzqrqelS7Q1E4BboZe6wIa6
         QZy64Mb/aA0hKgxsZ5y5rN1zd201Y7bcwdD/vM7ozZ7ON7IaHJzEnaDawznaoqa4z4zp
         3xh1vI/Wrp54l3Sg/WurAWWG7rNEwh9rkTNAMwDnhRdsTHNlIQQcLjSynwQR7dM3BjwQ
         xzjROnO/dDFdlAgSS5KASwUIw326oxtTjI4aGrcMsEKZ2ZJaNHAKF9SQcxukKGiEjPiu
         v/8GflXwuFtst9NIF9dK5YjW7Jx4+5HmJHHIAGKbE7Xp7xKljOzcu4uoWS5epvDPjxGn
         AjRg==
X-Gm-Message-State: AOAM532uFMbn0sXDqdqLT3wX7ZmrmKuV8cvHsKqJgnS2l0hogZS3UpsG
        065N3ul0903m3ct8CDD7svXso3R3I/iwxQ==
X-Google-Smtp-Source: ABdhPJzlkbU2JeZEl0arGlORIYMWz9iq+NLwIBVcvF6ArQ9op9HFh+JBmoSPbEz6RYMlE8GEiAEf4w==
X-Received: by 2002:a05:620a:2805:b0:67d:5c7e:c43a with SMTP id f5-20020a05620a280500b0067d5c7ec43amr20214618qkp.84.1651158302131;
        Thu, 28 Apr 2022 08:05:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8-20020a37de08000000b0069f81dafbbdsm76520qkj.88.2022.04.28.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:05:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: add some missing _require_loop's
Date:   Thu, 28 Apr 2022 11:05:00 -0400
Message-Id: <bd80e5861da3f901428ea66f271f8c4f267c4c23.1651158291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Got a new box running overnight fstests and noticed a couple of failures
because I forgot to enable loop device support.  Fix these two tests to
have _require_loop so they don't fail if there's no loop device support.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/012   | 1 +
 tests/generic/648 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 29552b14..60461a34 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -30,6 +30,7 @@ _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
 # ext4 does not support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
+_require_loop
 
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
diff --git a/tests/generic/648 b/tests/generic/648
index e5c743c5..d7bf5697 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -39,6 +39,7 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
 _require_command "$KILLALL_PROG" "killall"
+_require_loop
 
 echo "Silence is golden."
 
-- 
2.26.3

