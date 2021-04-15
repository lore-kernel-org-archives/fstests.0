Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1FC433B4
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47BA61166
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhDOJtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231766AbhDOJte (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618480151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7ohePm8V3EbpXOSXLfjDWDt4deCIcUZRMbI6KyN1lU=;
        b=F5Foiaw11iEyYWXNXNGymHiXHxGqOmnbDdMHkhSoMEa9Gr896/iS5M7TBxVWhOv/qenl8n
        8ARwX0/Z/u4JwkhEq1fhpMmbwG6qWVwqkbhu4U+9+rIooXvbWvrW5/AxSZOu+n5Uu1tAjb
        SFnLPKy+HKLb6EcNfF/SfWSWgMrqI/w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-nmiA2BEfMqaxC_vRFY8g2g-1; Thu, 15 Apr 2021 05:49:09 -0400
X-MC-Unique: nmiA2BEfMqaxC_vRFY8g2g-1
Received: by mail-wr1-f72.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so2490479wrl.15
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7ohePm8V3EbpXOSXLfjDWDt4deCIcUZRMbI6KyN1lU=;
        b=K3m+vQNHqAXLHdSUQwpB1d4L/2gTRT8DydhiSLKadSZ9DQ6/Dac90JTLfgeYauemev
         tGibIPDHXZ96j+B3XupiK0ODtje09hG0MfTUKDc6F/ldzVMr6FUKBq4vXDA51sCw02Lh
         oElu3jCHvcfCTaOyhqC3r7lbi06HDlroM8kb8rnORyZGedrVFQUqbtQtsn1TZ4ssoeHz
         FWT590NlDTDovgonGdR9clvmdT+3XPxykpIYJytxY5LY5+a6DRJFq84qt1Aj8FRnOOi3
         gBibGwSUkSNgx4poeJig2bqXui9WlX01is7myzTyoCIjaDnJCN8ch0syBqZ5CWhoJC0b
         T9Sg==
X-Gm-Message-State: AOAM531m/uPiE/NSjx7Qy5yr1Ni/vpZvHkcd8nn+VDwi5SZkTPXZOk/H
        UCEmlFe874AT5Id8Z0FfVsO6apm0YNKbqL5qf1+nksia4zbapz1ZPx/lFBmRv3JRsSw9MsIs+xo
        3XhRNyLIt4PwJU1Zqpz1O5xu8BPi/vJKfVJphmhLAbd+HNGdqkg+GZRU9fzVnzxmFgz2C
X-Received: by 2002:a1c:c246:: with SMTP id s67mr2217708wmf.86.1618480147860;
        Thu, 15 Apr 2021 02:49:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvf8IrGxqqKnZv6SyhscjxcPSq3llsUd8hPufL9Myl9IdjZQaj8D2JM6ZXYFm5A/ckUG9NPg==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr2217696wmf.86.1618480147732;
        Thu, 15 Apr 2021 02:49:07 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v4sm2427278wrf.36.2021.04.15.02.49.06
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:49:07 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 2/4] common: hide permision warning from mkswap for exfat
Date:   Thu, 15 Apr 2021 11:49:03 +0200
Message-Id: <20210415094905.61853-3-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210415094905.61853-1-preichl@redhat.com>
References: <20210415094905.61853-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

exfat does not support posix file permisions, so warning from mkswap is
inavitable. This patch hides the warning message so the test won't fail.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index be292aaf..47098b55 100644
--- a/common/rc
+++ b/common/rc
@@ -2374,7 +2374,8 @@ _format_swapfile() {
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
-	$MKSWAP_PROG "$fname" >> $seqres.full
+	# Ignore permission complaints on filesystems that don't support perms
+	$MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
 }
 
 # Check that the filesystem supports swapfiles
-- 
2.30.2

