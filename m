Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5B0C43334
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jun 2022 13:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiFSNrP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiFSNrL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jun 2022 09:47:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5C637B
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so11337020wra.4
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIvvzvn8xZt2i6sbhS0mz++42KdKRJVzXAa3AW0thPQ=;
        b=Scf4Kf12BMV2XgmTDLxOe0ySkl0pX2SmaGr41okqJcit4G11HlP3Gbf6dpTFrgTIe1
         49yZdnWTxYOVlqLVoWOOc7su/Py4tkv3XYqav1pmuccmM/bPoqza8dlLjzNFpyS60Mou
         gyYP58cxTHP4ufxhBuUrT4WHgxqCsCB5lbm4DMXUVUss9ccmKePMayrFZgh33vtagAM6
         13RW3SrDanxPGQg/V9DRZXPtHH5hkIYYKa8siBiwBw3FGHVz9jR3UqvuTrjQCCLJ8Gg4
         ELq2JdSVHHsMhVj74wXp4n9A+b9PxQFUGwg5N/K9aLe3lzEDmjkzMHDJi4V+E4cHUkpT
         Wh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIvvzvn8xZt2i6sbhS0mz++42KdKRJVzXAa3AW0thPQ=;
        b=E1Jw9qCAvHXrvNQGYdyLkUPZ1VebJhHVVoLiaAmFglvA0aACxONwE8Sz+qkppzVr7v
         /GzRVPlqpyhf2eRnhLmvh2g/MUeHuA6le+fIuXsi0/BKVEWuiFGDp9M+AYQpaCfRweac
         MS8ATwhGglB/l2OzVzlK4eAgkqGGw6UvUuMAHQrwOs/CJ+scZov5gyzKZrngiq1pJzIb
         jSNiD5QHGPoLqtM2U9nNANPrSH5EY09Hs2f9xzdKoshwh9hZ19AU35Qb1ZzgkFPmfWWd
         Lk5jEE010x9RMRZieF+TUVs8SEZ40Fm4qb+TXjqlg7Fq+fI2frcek4bR3cKGdLLT+kTp
         H6dg==
X-Gm-Message-State: AJIora/mOdyFODiwTANuFYIeiD4Bfr90MeQCT3vRM4+JDGxSWucGroC7
        E8JMNtkD1ttVMnFJUZuMnzA=
X-Google-Smtp-Source: AGRyM1tv4H5lr8t7BY5bdVziokMBXLP316yjiApUc9t5YEbzC+BXxkq01y+3muyLVRVoCvhyWNY5jg==
X-Received: by 2002:a5d:5941:0:b0:21a:342d:510f with SMTP id e1-20020a5d5941000000b0021a342d510fmr16375097wri.700.1655646429251;
        Sun, 19 Jun 2022 06:47:09 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00219e77e489fsm5240927wrj.17.2022.06.19.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:47:08 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
Date:   Sun, 19 Jun 2022 16:46:56 +0300
Message-Id: <20220619134657.1846292-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220619134657.1846292-1-amir73il@gmail.com>
References: <20220619134657.1846292-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Those tests failed to cleanup background jobs after test
is interrupted.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/xfs/422 | 8 ++++++++
 tests/xfs/517 | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tests/xfs/422 b/tests/xfs/422
index a83a66df..8e9a3576 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
 
 _register_cleanup "_cleanup" BUS
 
+# Override the default cleanup function.
+_cleanup()
+{
+	$KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
+	cd /
+	rm -rf $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
diff --git a/tests/xfs/517 b/tests/xfs/517
index 961668e3..18404248 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
 # Override the default cleanup function.
 _cleanup()
 {
+	$KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
 	cd /
 	rm -rf $tmp.*
 }
-- 
2.25.1

