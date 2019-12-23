Return-Path: <SRS0=A77W=2N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21FCC2D0C0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51F32073A
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 05:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de2zFEDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfLWFQc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Dec 2019 00:16:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32942 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfLWFQc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Dec 2019 00:16:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so8229492pgk.0
        for <fstests@vger.kernel.org>; Sun, 22 Dec 2019 21:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LBWkJ7isWZaPTfyfHLf3fdbxARBYL15UFlaJzmle34U=;
        b=de2zFEDWizFEnIV7hMR/eXtPAC2goymrOpilforLtrq/AVQw3Shva31Fydb58DEQHs
         or2wBaeQetFW+xSJHiQzOtalQKUIvbJAcGoQXxAiWxMgzJ3XukHIIcLEBV17ZVPBfomf
         eRYGuW5B/cMh3hYRpPAO6JT99wV8p2MbhC4RWGZ4nmw91NL2WVnszfIXC8EsVGSTVMzc
         jrbgKT2S7O6XuSvS47NKspzwOX5pyKFdm8BkZ6kwt0YtNGDCzaMD/IK1b6RCQRkhNGAI
         nmEdkxlg6PBeokL7+mDu2YAplmKXzi9PKOnCCtwZw0S4qwPGySEOfRYUOzS7EzbS7c7S
         TztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LBWkJ7isWZaPTfyfHLf3fdbxARBYL15UFlaJzmle34U=;
        b=tQ610G7+gdU6L7manmZJqOy+ccLwc/6EQqMvyzRh0X9Jq1ZZW4B2WNkT1L6+rGZchf
         Ml/APOYQfq7KZp2xRKHUbaBQ65UnTBnu9VxdrVIasqOoSMoR1e9yVgUXhPyfjM4l9szt
         6lUvWFNoDAfbHRfG+3t8IZ/o98/XGqM8ek6D2ewH1gUIfMM4GPF9h+0JFUFRMeopvv24
         WWlydIFvt90E8euwA8bqG47DNn6UhQhmwKSShypL2xei+6wPrNTpzNVNz0i+T9FguzLs
         e8GjH97F5Ghw3uyDzw7LA8FVMPw3PSI3Rv7yQ2rpP69VZQx92j0wKUaIJIvSKK6u8pEq
         XBRA==
X-Gm-Message-State: APjAAAW/IUylCxVAuhdK+MVqDA/eDJEf3tE3s6bYsqibFtBR4cDEvje0
        WkyWYmibIO43hvXDR8YRpmSs7FgT
X-Google-Smtp-Source: APXvYqzgxgZbY1/TLXuS22u7FkAfoSHSqVz6Uv/r5HWiFkIvivqt9vD38iZRZE+KmhG+DtSjNtu6Pw==
X-Received: by 2002:a63:1f5c:: with SMTP id q28mr27365938pgm.404.1577078191167;
        Sun, 22 Dec 2019 21:16:31 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id fa5sm18664961pjb.2.2019.12.22.21.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 21:16:30 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     amir73il@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        guaneryu@gmail.com, sashal@kernel.org, y2038@lists.linaro.org
Subject: [PATCH] generic/402: Make timestamp range check conditional
Date:   Sun, 22 Dec 2019 21:16:22 -0800
Message-Id: <20191223051622.7975-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABeXuvq+37-WO8KH5en-1LaSGOLbw9zziC4eAqGvpJwe85kudQ@mail.gmail.com>
References: <CABeXuvq+37-WO8KH5en-1LaSGOLbw9zziC4eAqGvpJwe85kudQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Addition of fs-specific timestamp range checking was added
in 188d20bcd1eb ("vfs: Add file timestamp range support").

Add a check for whether the kernel supports the limits check
before running the associated test.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 common/rc         | 11 +++++++++++
 tests/generic/402 |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index 816588d6..472db995 100644
--- a/common/rc
+++ b/common/rc
@@ -1981,6 +1981,17 @@ _run_aiodio()
     return $status
 }
 
+_require_kernel_timestamp_range()
+{
+	# 128-byte inodes do not have room for extended timestamp
+	MKFS_OPTIONS=-I128 _scratch_mkfs_ext4 &>> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
+
+	mount -t ext4 ${SCRATCH_DEV} ${SCRATCH_MNT}
+	_check_dmesg_for "ext4 filesystem being mounted at ${SCRATCH_MNT} supports timestamps until 2038" || \
+		_notrun "Kernel does not support timestamp limits"
+	umount ${SCRATCH_MNT}
+}
+
 _require_timestamp_range()
 {
 	local device=${1:-$TEST_DEV}
diff --git a/tests/generic/402 b/tests/generic/402
index 0392c258..2be94c54 100755
--- a/tests/generic/402
+++ b/tests/generic/402
@@ -30,6 +30,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_check_dmesg
 _require_xfs_io_command utimes
 
 # Compare file timestamps obtained from stat
@@ -79,6 +80,8 @@ run_test()
 	done
 }
 
+_require_kernel_timestamp_range
+
 _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_timestamp_range $SCRATCH_DEV
 
-- 
2.17.1

