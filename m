Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50787C433C1
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2242861A1E
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCZPm0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhCZPlw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 11:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616773312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iS+YL2dRDw0JUwIkorm6P2sufQKDI5n+EM+kjcQhL3A=;
        b=ik9vTEhuGlvrKM8ePUr2U+MVIvGw/8BLdh8hyixCMMW6xboLXNeIp5jJz6azoMMeBHypdd
        xCRg9jlX0Q8hDjTz0IZCvdSvyYBIjlUdsBCPvIDBVfxrPoERVOka1sLgm81lex2LU7jk0a
        xnJkjqFOA8MTStEGb8vjBhvNRQSsyEI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-0OQ_1RIOMCym_u-gv1jxeQ-1; Fri, 26 Mar 2021 11:41:40 -0400
X-MC-Unique: 0OQ_1RIOMCym_u-gv1jxeQ-1
Received: by mail-ej1-f72.google.com with SMTP id gn30so4255758ejc.3
        for <fstests@vger.kernel.org>; Fri, 26 Mar 2021 08:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iS+YL2dRDw0JUwIkorm6P2sufQKDI5n+EM+kjcQhL3A=;
        b=d6ZSs+I0FxdaCPdZn4DyBmGUtPemz72/2hJI2CM+qmtiZFiNq42y3Wrwde2dM2pkf3
         Uma27dPBTGWnu8gqkzP+t+aTkhGPBhpCd88nffxzfGiYjgZKLABIQfum5FoYDJXfoRK9
         BeX11pRcqoC9oYQb5nmRmBedaEQG9s9cYK+KhoadmNs/blOqe0b8sHL65QzTgDaiO/Gh
         XrOYhC14v9IdkLdtq62QqLdLG7YLgihqJxCxZtqfjTMvaJXKGTw21M2rkppaDYPiCi/3
         ffvhVhaD6K0HXYsgXGSkCmjGRRHnAl7tTNMmBcQ/fboiljsC5W6XVcHT+BFHVNt1v/++
         O8wA==
X-Gm-Message-State: AOAM532WWN3563OMt9wWkH3FNMSSGThhN9IANy3fbXgxjwla4zFRN6kr
        AmIg/V0EkwElWe/rwYv/EWQGhVVi3cYr9843RNt08dInWrKjLQtzxf8V+NugcJBeRBojEM486Df
        6hRgJSJxcufvZ6WCNFJ4Zkjpy2FGArLeqiZwdd5BxNRVvFA/XyVYUg+NHM2+8cfgdoRNZ
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr16207002edt.231.1616773298860;
        Fri, 26 Mar 2021 08:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd6SMjkesngkbM2G06dhIGF680U/uFDpvwsL5Rvh3393xlAvR4VeFCdlqDs46GKKn7Exju2g==
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr16206982edt.231.1616773298673;
        Fri, 26 Mar 2021 08:41:38 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p9sm4389791eds.66.2021.03.26.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:41:38 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, xzhou@redhat.com
Subject: [PATCH 3/5] common: hide permision warning from mkswap for exfat
Date:   Fri, 26 Mar 2021 16:41:32 +0100
Message-Id: <20210326154134.309159-4-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326154134.309159-1-preichl@redhat.com>
References: <20210326154134.309159-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

exfat does not support posix file permisions, so warning from mkswap is
inavitable. This patch hides the warning message so the test won't fail.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b18d37fd..9977b264 100644
--- a/common/rc
+++ b/common/rc
@@ -2383,7 +2383,13 @@ _format_swapfile() {
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
-	$MKSWAP_PROG "$fname" >> $seqres.full
+	if [ "$FSTYP" = "exfat" ]; then
+		# exfat does not support posix file permisions, so warning is
+		# to be expected
+		$MKSWAP_PROG "$fname" 2>&1 | grep -v 'insecure permission' >> $seqres.full
+	else
+		$MKSWAP_PROG "$fname" >> $seqres.full
+	fi
 }
 
 # Check that the filesystem supports swapfiles
-- 
2.30.2

