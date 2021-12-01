Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42117C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Dec 2021 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbhLASW7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbhLASW6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Dec 2021 13:22:58 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CAC061574
        for <fstests@vger.kernel.org>; Wed,  1 Dec 2021 10:19:37 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id i9so32018441qki.3
        for <fstests@vger.kernel.org>; Wed, 01 Dec 2021 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0lBOZH/ykE0QBS/IwJ/ImCYun6/fSjujlA/SZPDuFI=;
        b=GJXtwkhFw2B5NcsY17R33ISWXGYJys2PRMvVcZ2m6GNDe6HadbZWU7QP7iKrj8LgtX
         IYJm74+gdx3rYgXd1dXpLLI7hnYrKLAwITXF5sXfpSLbIW2+XDlDsqf9bLpcpNVtahEp
         Rz7lJXupgUk2UMm76zKmBWJZ7pgkEEofqFoom+tqI4vE82CpjYS4AX/4ki245mpkRtAG
         DcJL7R/h/oGOnYxwHZ1tAnoMsPCEPHWwruuVlSIiIAjTNryUjFMOPx+3X+61auZ8cJuK
         L9Gms4hPHV2dEi4/Aqbg+ghgDPiyBAuT5g/j5hAsQL/VrZ0Tnh4qkPfnnPAkjObITm7g
         UKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0lBOZH/ykE0QBS/IwJ/ImCYun6/fSjujlA/SZPDuFI=;
        b=2s00qMvB5NdDEO+7PrU048UxcsXMYoiKRTHVlnQUIaLsgQtb3/TICNGi42UGhgGhR8
         XYrdgytoBc8NtPsUL0vNSOvI7C0MdhJniFOogtqYoYgHTAsSez7ixOXLeuFAVppyxL1k
         3wjv/cHBB64BPpFyQ94FmsKsu7ln/YKcT32chY9dDaYHOhYz/6eUa8tyk4uJw+MuTg2e
         78+IiGxGljeraN85g8SQDnygsVBI1ADSY4ushqtcDZAxkR4J7Oe+F+xy5m8h40GwY1gS
         lFGXwJdBg3/ylf2rZAaN42GBSGjvWrWXDCgKrVw0qz59DDwdAXnEOEIi8mwbRgXy18P0
         zQpA==
X-Gm-Message-State: AOAM530SMwUY3QIJQdECaejL32vH5eUVLPNrGAbhHn1AUeuPMHKMBefI
        oi79lxO5Vf+YVsYQsaqOfqMAHA==
X-Google-Smtp-Source: ABdhPJxpuZuP1yAHMnyLzQxqvoo13ixQCIiPHM8SK6W3femfRNGWhnuatwZh/aZ0GBF2f3nz6EeRyg==
X-Received: by 2002:a05:620a:f05:: with SMTP id v5mr7852232qkl.46.1638382776810;
        Wed, 01 Dec 2021 10:19:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 73sm233474qkm.94.2021.12.01.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:19:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: btrfs/011 increase the runtime for replace cancel
Date:   Wed,  1 Dec 2021 13:19:35 -0500
Message-Id: <01796d6bcec40ae80b5af3269e60a66cd4b89262.1638382763.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test exercises the btrfs replace cancel path, but in order to do
this we have to have enough work to do in order to successfully cancel
the balance, otherwise the test fails because the operation has
completed before we're able to cancel.  This test has a very low pass
rate because we do not generate a large enough file system for replace
to have enough work, passing around 5% of the time.  Increase the time
spent to 10x the time we wait for the replace to start its work before
we cancel, this allows us to consistently pass this test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/011 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index b4673341..78e58a38 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -59,6 +59,7 @@ wait_time=1
 fill_scratch()
 {
 	local fssize=$1
+	local with_cancel=$2
 	local filler_pid
 
 	# Fill inline extents.
@@ -87,7 +88,11 @@ fill_scratch()
 	$XFS_IO_PROG -f -d -c "pwrite -b 64k 0 1E" "$SCRATCH_MNT/t_filler" &>\
 		$tmp.filler_result &
 	filler_pid=$!
-	sleep $((2 * $wait_time))
+	if [ "${with_cancel}" = "cancel" ]; then
+		sleep $((10 * $wait_time))
+	else
+		sleep $((2 * $wait_time))
+	fi
 	kill -KILL $filler_pid &> /dev/null
 	wait $filler_pid &> /dev/null
 
@@ -124,7 +129,7 @@ workout()
 	_scratch_mount
 	_require_fs_space $SCRATCH_MNT $((2 * 512 * 1024)) #2.5G
 
-	fill_scratch $fssize
+	fill_scratch $fssize $with_cancel
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 
 	echo -e "Replace from $source_dev to $SPARE_DEV\\n" >> $seqres.full
-- 
2.26.3

