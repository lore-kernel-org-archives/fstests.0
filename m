Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C33C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Nov 2022 16:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiKBQ5G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKBQ5B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2022 12:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758EB864
        for <fstests@vger.kernel.org>; Wed,  2 Nov 2022 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667408161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G0BdL5BurMpjS0mjJbHcG9qj2bbjAXUFX76zQ+NLRDw=;
        b=FwsnIOPKtTLp+QKHp0bwc26Sdhxni7BW5xQ9OQq0sYXWSwg6ITsJQticc3x8OoI2HhQ5yb
        bLEBOWXfrHBPlpmB1axyHeAiHxqF71cfNx25ECN1duZVbOH3noVz5EHqrUkXKlw2bN/Rrj
        RZlr2QLQc6XNvv1KS+erL/TEJVb0Tf4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-2-IyVSguh1MFyFivv5Sj4Cvg-1; Wed, 02 Nov 2022 12:54:24 -0400
X-MC-Unique: IyVSguh1MFyFivv5Sj4Cvg-1
Received: by mail-ej1-f69.google.com with SMTP id ga26-20020a1709070c1a00b007ad4a55d6e1so10110097ejc.6
        for <fstests@vger.kernel.org>; Wed, 02 Nov 2022 09:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0BdL5BurMpjS0mjJbHcG9qj2bbjAXUFX76zQ+NLRDw=;
        b=DhnK5+4T6SguzYSJZ+27xiiH4qtu4SSrPTCorDL3fLDqFtMlLc1j2pqnASUhQC5/Pp
         b5jNZ77QyW+9BXa3+KY8ZheM1cMuw6Wk86GeFfsXCXHKlPafKVf9WcLF6LeecqyNpSpv
         FBeu8/AvdECTUMbtDbqQXjgRYeypuvbZ6WePiXs6BZ0nF4ZQwl88ATABE8tbu73RJw7d
         38QH6t7scVSMliIq59m56X8XtrEu8iQgTkblNF7GeIPnzvTPgfcQTu2UqqLI9cunhzgB
         S4oz5X+D2MIe/l8PCBSIxqhYMRWGzaKAXXCUFbKtOZIqs1CFGdIhHDI/pbincQH/5J08
         ZEug==
X-Gm-Message-State: ACrzQf0iAkqiNH+tKbkQRlPAP3Zjcwla9Ol8nfFqLGp5vidjgh+QMtoW
        Jwb/lvandb4eqfliWLzL25+s4kMad64Ue1IsOSAPCcbmsIO7wwNGA+0E+XskzZ2Skc6yE5APmem
        0LdxJj3wiCVDNEzaPS6Sw51IqJvYZmFT/Z6KckUZJ6rcc+91stRTYAo8SKz2ZxpxSyLUW
X-Received: by 2002:a17:906:730c:b0:791:997f:d65d with SMTP id di12-20020a170906730c00b00791997fd65dmr25776502ejc.18.1667408063224;
        Wed, 02 Nov 2022 09:54:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7J0ME6AbEa3IVHH7xP+auDLadc3lHoUzPdwrVf1a92Wag8LXUQUQkgFOHCbd+kXrtU6AB2uw==
X-Received: by 2002:a17:906:730c:b0:791:997f:d65d with SMTP id di12-20020a170906730c00b00791997fd65dmr25776480ejc.18.1667408062955;
        Wed, 02 Nov 2022 09:54:22 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id gg6-20020a170906e28600b007ad2da5668csm5646501ejb.112.2022.11.02.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:54:22 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     ebiggers@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] generic/577: add missing fsverity metadata cleaning
Date:   Wed,  2 Nov 2022 17:51:34 +0100
Message-Id: <20221102165134.169135-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When fs-verity is enabled on the file, file becomes read-only. In last
check, test tries to empty the file. However, fs-verity denies
opening/writing to file.

Remove file beforehand as in other checks.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 tests/generic/577 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/577 b/tests/generic/577
index 98c3888f..916f3be3 100755
--- a/tests/generic/577
+++ b/tests/generic/577
@@ -121,6 +121,7 @@ if _fsv_have_hash_algorithm sha512 $fsv_file; then
 fi
 
 echo -e "\n# Testing empty file"
+reset_fsv_file
 echo -n > $fsv_file
 _fsv_sign $fsv_file $sigfile.emptyfile --key=$keyfile --cert=$certfile | \
 		_filter_scratch
-- 
2.31.1

