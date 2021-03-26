Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3480C433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B120561A1E
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCZPlx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhCZPlp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 11:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616773305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgYyA8E04umfgr33cgrQ4FyX0gHPN3lDzm6K/C5W2tU=;
        b=OuEvLnF/N8WVDsjgpnLsa3bVsOvqlsWWUGyGp1A6BbBTMFmf6jnP6+blkJdpe1lheEoCvl
        OP8F8iGfacOzX0kmRu8tbzM9B79VbG59yItk0uUjn4xW9X5KZK2Juz2Bjz8aoCrPpASVzy
        XNq6O6xD3YPYsYdlEmju+9jYi73EkJw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-rTw4JjHYOlyI1kAre_sSsg-1; Fri, 26 Mar 2021 11:41:42 -0400
X-MC-Unique: rTw4JjHYOlyI1kAre_sSsg-1
Received: by mail-ed1-f69.google.com with SMTP id r6so1131879edh.7
        for <fstests@vger.kernel.org>; Fri, 26 Mar 2021 08:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgYyA8E04umfgr33cgrQ4FyX0gHPN3lDzm6K/C5W2tU=;
        b=JvztUqZPP+yeav8+fXVzNAUrSUCwliSyeiCE6a4WQrZ9f/tMd4xzgBLABPKcc8YxqJ
         eP5TDGVqv3rNU5bPmHh4grkgAaszP4yoQXqp9+laMf3fSByYSBSlS65n3wo0x29eKqg8
         RfjlsGN4OJx511czzchMucY07PE6rfPg8EkFoV3RBEq1EyorV2xQjIjt5y6uglb2KvW7
         Tv5G0EIfBu4N6DqEXS2c3RXVKknrmUNdChx6F/P61JkMixvIhRQ/CvJ7tzwzIX53sWdc
         M7DmXvgvgy4Ym7nVx4Qnf0ydHhGP4Q23pz+DivhXIZjrup+2a5keJ8kdxlpeyTbaDveO
         6LBQ==
X-Gm-Message-State: AOAM530fiDfU/PRXdOyPWhlWPOirbpIo6ORTsC3SMH4VQxZ307bdo1sV
        EEa9zjvcdEvRB5+BGQRP3V7/35OwPkN/EkJn5Nr8apEv09LDQzuqECHM4G7jDSnajwjVcnqr1lH
        Pz/f9hld7JhzW0mkijp+wA9viqpqtCfL6t930akCzc02ImpkMptwKjpLrI+3KbORFwEqK
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr15961113ejb.147.1616773299990;
        Fri, 26 Mar 2021 08:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwThHwRlqqAY/a9QvNlBqD86j8aJFvvhdQHotP9caHD+JEqtuOmwbjzklVaVT4VuJ81rWMAWQ==
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr15961084ejb.147.1616773299753;
        Fri, 26 Mar 2021 08:41:39 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p9sm4389791eds.66.2021.03.26.08.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:41:39 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, xzhou@redhat.com
Subject: [PATCH 4/5] generic/554: hide permision warning on exfat
Date:   Fri, 26 Mar 2021 16:41:33 +0100
Message-Id: <20210326154134.309159-5-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326154134.309159-1-preichl@redhat.com>
References: <20210326154134.309159-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/554 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/generic/554 b/tests/generic/554
index fa4f97d2..365628e2 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -46,7 +46,15 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&
 
 echo swap files return ETXTBUSY
 _format_swapfile $SCRATCH_MNT/swapfile 16m
-swapon $SCRATCH_MNT/swapfile
+if [ "$FSTYP" = "exfat" ]; then
+	# exfat does not support posix file permisions, so warning is
+	# to be expected
+	swapon $SCRATCH_MNT/swapfile 2>&1 |\
+		grep -v 'insecure permission' >> $seqres.full
+else
+	swapon $SCRATCH_MNT/swapfile
+fi
+
 $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
 swapoff $SCRATCH_MNT/swapfile
 
-- 
2.30.2

