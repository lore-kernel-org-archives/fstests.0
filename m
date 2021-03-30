Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD4C433E3
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563F1619DE
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhC3WAc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232880AbhC3WAO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Mar 2021 18:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617141613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nw5o5wizmXgcbuighDLLe6l7zhsYKiO7skt1BP/rbus=;
        b=OAtMxlKEdsRmeZCDmrQubtkv9JbIOB7hlzSh12aHfTqmZEroaXlaJ+EtvnQ9clG+bt5fIH
        ILgUSV6O7fI8dXlatLXoM5Y2zNsA344Tq4xJRFXSMsgIiT4HrmARUIGPzN9zd5oW8VvERB
        lv5s9P4y2kkqRQieYMG3sBHHFzFx12U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-de4VHfa1Pf--_qJj4raC9g-1; Tue, 30 Mar 2021 18:00:11 -0400
X-MC-Unique: de4VHfa1Pf--_qJj4raC9g-1
Received: by mail-wr1-f72.google.com with SMTP id a15so9173751wrf.19
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 15:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw5o5wizmXgcbuighDLLe6l7zhsYKiO7skt1BP/rbus=;
        b=siX2QmkFfoiyxJqFbL4dWoQ+YM9iBrhVbL+FlMR1efoBOm9FZZtAOcB00kcIfW1491
         a7yUMWTdAjBjeCScDFuBdFMFOczrXeB3YdvBtRf4Ft4GJLbKpZ7iBNHaq4h78P9+BSQb
         Ng0zxdW440A2t3Or8oA9uOOkUr0QC2aOk4eiyH9Yr3i89vcQP81fFwfmxxfVL/Jd+4AN
         7+5HOQJks/71WhK00CDv4N+IZHkb/OMsR1AaNgjLuNFFRhssqL2lws/ih0mReoO0469n
         kTmX1r/MzSXuZpGrl2AxX4V1XfXENTen0zWsYIvTOOqSMN8Ng3u9qAqaU+4sIRteqYXk
         mqAQ==
X-Gm-Message-State: AOAM533FgzfUW9/vI9y6/PE9An6Z6n2C1qkLCcU/Dp0FxMAvV+E15trm
        ZnQUE1oDHUXxi1yb+XoW/eUYuuMt21ywfsCezkYWuFM06vr2O7M2jCpOzexyx5oVNNPdMEo7W8H
        Dx/a2eEOlbgtf3+scYrXg+0tnsvuAQjtlzusIiXK4QFlrfbS/9EktKjvQjgGp+O2wg5+v
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr103136wrw.247.1617141610349;
        Tue, 30 Mar 2021 15:00:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3p4NooMCPuNTzCJZB5ItmfPhb1T3PhcG/kWaeg0BA0qZ/YaMIMZcKSPNVsGtk8RW0H90nDg==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr103115wrw.247.1617141610100;
        Tue, 30 Mar 2021 15:00:10 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z2sm522894wrm.0.2021.03.30.15.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:00:09 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
Subject: [PATCH v2 3/4] generic/554: hide permision warning on exfat
Date:   Wed, 31 Mar 2021 00:00:04 +0200
Message-Id: <20210330220005.56019-4-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330220005.56019-1-preichl@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 13 +++++++++++++
 tests/generic/554 |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 2d658711..379140ea 100644
--- a/common/rc
+++ b/common/rc
@@ -2401,6 +2401,19 @@ _format_swapfile() {
 	fi
 }
 
+_format_swapon_file() {
+	local fname="$1"
+
+	if [ "$FSTYP" = "exfat" ]; then
+		# exfat does not support posix file permisions, so warning is
+		# to be expected
+		swapon "$fname" |& grep -v "insecure permissions"
+	else
+		swapon "$fname"
+	fi
+
+}
+
 # Check that the filesystem supports swapfiles
 _require_scratch_swapfile()
 {
diff --git a/tests/generic/554 b/tests/generic/554
index fa4f97d2..c2f9eee8 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -46,7 +46,8 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&
 
 echo swap files return ETXTBUSY
 _format_swapfile $SCRATCH_MNT/swapfile 16m
-swapon $SCRATCH_MNT/swapfile
+_format_swapon_file $SCRATCH_MNT/swapfile
+
 $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
 swapoff $SCRATCH_MNT/swapfile
 
-- 
2.30.2

